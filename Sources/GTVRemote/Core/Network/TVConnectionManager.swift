import Foundation
import Combine
import CryptoKit
import SwiftProtobuf

public enum TVSessionState: Sendable {
    case disconnected
    case connecting
    case pairing(prompt: String)
    case connected(deviceName: String)
    case failed(String)
}

public final class TVConnectionManager: ObservableObject, @unchecked Sendable, TLSSocketDelegate {
    public static let shared = TVConnectionManager()
    
    @Published public private(set) var state: TVSessionState = .disconnected
    @Published public private(set) var isIMEActive: Bool = false
    
    private var pairingBridge: TLSSocketBridge?
    private var remoteBridge: TLSSocketBridge?
    
    private var serverCertData: Data?
    private var clientCertData: Data?
    private var currentDevice: DiscoveredDevice?
    
    private init() {
        CertificateManager.shared.ensureCertificatesExist()
    }
    
    // MARK: - Connect & Pairing Flow
    
    public func connect(to device: DiscoveredDevice) {
        self.currentDevice = device
        
        DispatchQueue.main.async {
            self.state = .connecting
        }
        
        // If device has an endpoint, resolve to actual IP/host
        if let ep = device.endpoint {
            print("[Connection] Resolving endpoint for \(device.name)...")
            BonjourResolver.resolveHost(from: ep) { [weak self] resolvedHost in
                guard let self = self else { return }
                guard let targetHost = resolvedHost, !targetHost.isEmpty else {
                    print("[Connection] Failed to resolve host for \(device.name). Please verify device is reachable.")
                    DispatchQueue.main.async {
                        self.state = .failed("Could not resolve address for \(device.name)")
                    }
                    return
                }
                print("[Connection] Resolved host: \(targetHost)")
                var updatedDevice = device
                updatedDevice.host = targetHost
                self.currentDevice = updatedDevice
                self.startRemoteConnection(device: updatedDevice)
            }
        } else {
            startRemoteConnection(device: device)
        }
    }
    
    private func startRemoteConnection(device: DiscoveredDevice) {
        remoteBridge?.disconnect()
        pairingBridge?.disconnect()
        pairingBridge = nil
        
        let bridge = TLSSocketBridge()
        self.remoteBridge = bridge
        bridge.delegate = self
        
        let host = device.host
        print("[Remote Control] Connecting to \(host):6466 via NIOSSL...")
        bridge.connect(
            host: host,
            port: 6466,
            certPath: CertificateManager.shared.certURL.path,
            keyPath: CertificateManager.shared.keyURL.path
        )
    }
    
    public func startPairing(device: DiscoveredDevice) {
        remoteBridge?.disconnect()
        remoteBridge = nil
        pairingBridge?.disconnect()
        
        let bridge = TLSSocketBridge()
        self.pairingBridge = bridge
        bridge.delegate = self
        
        let host = device.host
        print("[Pairing] Connecting to \(host):6467 via NIOSSL...")
        bridge.connect(
            host: host,
            port: 6467,
            certPath: CertificateManager.shared.certURL.path,
            keyPath: CertificateManager.shared.keyURL.path
        )
    }
    
    public func disconnect() {
        remoteBridge?.disconnect()
        remoteBridge = nil
        pairingBridge?.disconnect()
        pairingBridge = nil
        currentDevice = nil
        DispatchQueue.main.async {
            self.state = .disconnected
        }
    }
    
    public func resetAllPairing() {
        // Clear all pairing flags
        let defaults = UserDefaults.standard
        defaults.dictionaryRepresentation().keys
            .filter { $0.hasPrefix("gtv_paired_") }
            .forEach { defaults.removeObject(forKey: $0) }
        disconnect()
        CertificateManager.shared.resetCertificates()
    }
    
    // MARK: - TLSSocketDelegate
    
    public func tlsSocketDidConnect() {
        print("[TLS] Socket connected successfully!")
        if let _ = pairingBridge {
            sendPairingRequest()
        } else if let _ = remoteBridge {
            print("[Remote Control] TLS Ready. Waiting for TV RemoteConfigure...")
        }
    }
    
    public func tlsSocketDidDisconnect(error: Error?) {
        print("[TLS] Socket disconnected: \(String(describing: error))")

        // If remote control port (6466) disconnected
        if remoteBridge != nil, let dev = currentDevice {
            remoteBridge = nil

            // If TV rejected certificate -> Clear pairing flag and re-pair
            let isCertRejected = error.map { "\($0)".contains("CERTIFICATE_UNKNOWN") } ?? false
            if isCertRejected {
                print("[TLS] TV rejected our certificate. Clearing paired flag and re-pairing...")
                UserDefaults.standard.removeObject(forKey: "gtv_paired_\(dev.host)")
                UserDefaults.standard.removeObject(forKey: "gtv_paired_\(dev.id)")
                DispatchQueue.main.async { self.startPairing(device: dev) }
                return
            }

            let lastHost = UserDefaults.standard.string(forKey: "gtv_last_host") ?? ""
            let isPaired = UserDefaults.standard.bool(forKey: "gtv_paired_\(dev.host)")
                || UserDefaults.standard.bool(forKey: "gtv_paired_\(dev.id)")
                || UserDefaults.standard.bool(forKey: "gtv_paired_\(lastHost)")
                || CertificateManager.shared.hasExistingCertificates

            if isPaired {
                // For paired device or existing certificates, retry connection on session end
                print("[TLS] Paired device disconnected. Retrying remote connection in 1.5s...")
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [weak self] in
                    guard let self, self.remoteBridge == nil else { return }
                    self.startRemoteConnection(device: dev)
                }
            } else {
                // For unpaired new device, fallback to pairing port (6467)
                print("[TLS] New un-paired device. Falling back to pairing on 6467...")
                startPairing(device: dev)
            }
            return
        }

        if let error = error {
            DispatchQueue.main.async {
                self.state = .failed("\(error)")
            }
        }
    }
    
    public func tlsSocketDidReceiveServerCert(derData: Data) {
        print("[TLS] Captured TV Server Certificate (\(derData.count) bytes)")
        self.serverCertData = derData
    }
    
    public func tlsSocketDidReceive(data: Data) {
        if pairingBridge != nil {
            handlePairingData(data)
        } else if remoteBridge != nil {
            handleRemoteData(data)
        }
    }
    
    // MARK: - Pairing Protocol Logic
    
    private func sendPairingRequest() {
        var req = Pairing_PairingRequest()
        req.serviceName = "atvremote"
        req.clientName = "GTVRemote Mac"
        
        var msg = Pairing_OuterMessage()
        msg.protocolVersion = 2
        msg.status = .ok
        msg.pairingRequest = req
        
        print("[Pairing] Sending PairingRequest: serviceName=\(req.serviceName), clientName=\(req.clientName)")
        sendPacket(msg, via: pairingBridge)
    }
    
    private func sendPairingOptions() {
        var enc = Pairing_Options.Encoding()
        enc.type = .hexadecimal
        enc.symbolLength = 6
        
        var options = Pairing_Options()
        options.preferredRole = .input
        options.inputEncodings = [enc]
        
        var msg = Pairing_OuterMessage()
        msg.protocolVersion = 2
        msg.status = .ok
        msg.options = options
        
        print("[Pairing] Sending Options (preferredRole: input, encoding: hex 6)")
        sendPacket(msg, via: pairingBridge)
    }
    
    private func sendPairingConfiguration() {
        var enc = Pairing_Options.Encoding()
        enc.type = .hexadecimal
        enc.symbolLength = 6
        
        var config = Pairing_Configuration()
        config.clientRole = .input
        config.encoding = enc
        
        var msg = Pairing_OuterMessage()
        msg.protocolVersion = 2
        msg.status = .ok
        msg.configuration = config
        
        print("[Pairing] Sending Configuration (clientRole: input, encoding: hex 6)")
        sendPacket(msg, via: pairingBridge)
    }
    
    private func handlePairingData(_ data: Data) {
        do {
            let msg = try Pairing_OuterMessage(serializedBytes: data)
            print("[Pairing] Received OuterMessage: status=\(msg.status), hasPairingRequestAck=\(msg.hasPairingRequestAck), hasOptions=\(msg.hasOptions), hasConfigurationAck=\(msg.hasConfigurationAck), hasSecretAck=\(msg.hasSecretAck)")
            
            if msg.status != .ok {
                print("[Pairing] Received non-ok status: \(msg.status)")
                DispatchQueue.main.async {
                    self.state = .failed("Pairing error status: \(msg.status)")
                }
                return
            }
            
            if msg.hasPairingRequestAck {
                print("[Pairing] Received PairingRequestAck -> Sending Options...")
                sendPairingOptions()
            } else if msg.hasOptions {
                print("[Pairing] Received Options -> Sending Configuration...")
                sendPairingConfiguration()
            } else if msg.hasConfigurationAck {
                print("[Pairing] Received ConfigurationAck! TV is now displaying 6-digit PIN code.")
                DispatchQueue.main.async {
                    self.state = .pairing(prompt: "Enter the 6-character PIN code displayed on your TV screen.")
                }
            } else if msg.hasSecretAck {
                print("[Pairing] SecretAck received! Pairing Successful!")
                if let dev = currentDevice {
                    UserDefaults.standard.set(true, forKey: "gtv_paired_\(dev.host)")
                }
                pairingBridge?.disconnect()
                pairingBridge = nil
                
                if let dev = currentDevice {
                    print("[Pairing] Now connecting to TV Remote Control on 6466...")
                    startRemoteConnection(device: dev)
                }
            } else {
                print("[Pairing] Unhandled pairing message: \(msg)")
            }
        } catch {
            print("[Pairing] Parse error: \(error)")
        }
    }
    
    public func submitSecretCode(_ code: String) {
        guard let serverCert = serverCertData else {
            print("[Pairing] Missing server certificate")
            return
        }
        
        let codeClean = code.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        guard codeClean.count == 6 else {
            print("[Pairing] Invalid code length: '\(codeClean)'. Must be 6 hex characters.")
            return
        }
        
        guard let clientModExp = CertificateManager.shared.getClientModulusAndExponent() else {
            print("[Pairing] Failed to read client modulus and exponent")
            return
        }
        guard let serverModExp = CertificateManager.shared.getModulusAndExponent(fromDerData: serverCert) else {
            print("[Pairing] Failed to read server modulus and exponent")
            return
        }
        
        let clientModHex = clientModExp.modulusHex
        let clientExpHex = clientModExp.exponentHex
        let serverModHex = serverModExp.modulusHex
        let serverExpHex = serverModExp.exponentHex
        let pinTailHex = String(codeClean.suffix(4)) // codeClean[2:]
        
        guard let clientModBytes = hexStringToData(clientModHex),
              let clientExpBytes = hexStringToData(clientExpHex),
              let serverModBytes = hexStringToData(serverModHex),
              let serverExpBytes = hexStringToData(serverExpHex),
              let pinTailBytes = hexStringToData(pinTailHex) else {
            print("[Pairing] Failed to convert hex components to bytes")
            return
        }
        
        var hasher = SHA256()
        hasher.update(data: clientModBytes)
        hasher.update(data: clientExpBytes)
        hasher.update(data: serverModBytes)
        hasher.update(data: serverExpBytes)
        hasher.update(data: pinTailBytes)
        let digest = hasher.finalize()
        let digestData = Data(digest)
        
        let pinHeadHex = String(codeClean.prefix(2))
        guard let expectedHead = UInt8(pinHeadHex, radix: 16) else {
            print("[Pairing] Failed to parse first two characters of PIN: \(pinHeadHex)")
            return
        }
        
        if digestData[0] != expectedHead {
            print("[Pairing] WARNING: Digest prefix (0x\(String(format: "%02X", digestData[0]))) does not match PIN prefix (0x\(pinHeadHex))")
        } else {
            print("[Pairing] PIN hash verified! Prefix match: 0x\(pinHeadHex)")
        }
        
        var secret = Pairing_Secret()
        secret.secret = digestData
        
        var msg = Pairing_OuterMessage()
        msg.protocolVersion = 2
        msg.status = .ok
        msg.secret = secret
        
        print("[Pairing] Sending Secret message...")
        sendPacket(msg, via: pairingBridge)
    }
    
    private func hexStringToData(_ hex: String) -> Data? {
        var hex = hex
        if hex.count % 2 != 0 { hex = "0" + hex }
        var data = Data()
        var index = hex.startIndex
        while index < hex.endIndex {
            let nextIndex = hex.index(index, offsetBy: 2)
            guard let byte = UInt8(hex[index..<nextIndex], radix: 16) else { return nil }
            data.append(byte)
            index = nextIndex
        }
        return data
    }
    
    // MARK: - Remote Control Protocol (Port 6466)
    
    private func handleRemoteData(_ data: Data) {
        do {
            let msg = try Remote_RemoteMessage(serializedBytes: data)
            print("[Remote Protocol] Received packet: hasConfigure=\(msg.hasRemoteConfigure), hasSetActive=\(msg.hasRemoteSetActive), hasPing=\(msg.hasRemotePingRequest), hasStart=\(msg.hasRemoteStart)")
            
            if msg.hasRemoteConfigure {
                print("[Remote Protocol] TV sent RemoteConfigure -> Replying with client RemoteConfigure (code1: 615)...")
                var devInfo = Remote_RemoteDeviceInfo()
                devInfo.unknown1 = 1
                devInfo.unknown2 = "1"
                devInfo.packageName = "atvremote"
                devInfo.appVersion = "1.0.0"
                
                var config = Remote_RemoteConfigure()
                config.code1 = 615
                config.deviceInfo = devInfo
                
                var reply = Remote_RemoteMessage()
                reply.remoteConfigure = config
                sendPacket(reply, via: remoteBridge)
            } else if msg.hasRemoteSetActive {
                print("[Remote Protocol] TV sent RemoteSetActive -> Replying with RemoteSetActive (active: 615)...")
                var active = Remote_RemoteSetActive()
                active.active = 615
                
                var reply = Remote_RemoteMessage()
                reply.remoteSetActive = active
                sendPacket(reply, via: remoteBridge)
            } else if msg.hasRemotePingRequest {
                print("[Remote Protocol] TV sent PingRequest (\(msg.remotePingRequest.val1)) -> Replying...")
                var resp = Remote_RemotePingResponse()
                resp.val1 = msg.remotePingRequest.val1
                
                var reply = Remote_RemoteMessage()
                reply.remotePingResponse = resp
                sendPacket(reply, via: remoteBridge)
            } else if msg.hasRemoteStart {
                print("[Remote Protocol] TV Remote Session Started: started=\(msg.remoteStart.started)")
                if let dev = self.currentDevice {
                    UserDefaults.standard.set(dev.host, forKey: "gtv_last_host")
                    UserDefaults.standard.set(dev.name, forKey: "gtv_last_name")
                }
                DispatchQueue.main.async {
                    self.state = .connected(deviceName: self.currentDevice?.name ?? "Google TV")
                }
            }
        } catch {
            print("[Remote Protocol] Packet parse error: \(error)")
        }
    }
    
    // MARK: - Key & Text Commands
    
    private var currentlyHeldKeyCode: Remote_RemoteKeyCode?
    private var keyUpWatchdogWorkItem: DispatchWorkItem?

    public func sendKey(_ key: RemoteKey) {
        guard let code = remoteKeyCode(for: key) else { return }
        sendKeyCode(code)
    }

    public func sendKeyDown(_ key: RemoteKey) {
        guard let code = remoteKeyCode(for: key) else { return }
        sendKeyDownCode(code)
    }

    public func sendKeyUp(_ key: RemoteKey) {
        guard let code = remoteKeyCode(for: key) else { return }
        sendKeyUpCode(code)
    }

    public func sendKeyLongPress(_ key: RemoteKey, duration: TimeInterval = 1.0) {
        guard let code = remoteKeyCode(for: key) else { return }
        sendKeyDownCode(code)
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) { [weak self] in
            self?.sendKeyUpCode(code)
        }
    }

    private func sendKeyDownCode(_ code: Remote_RemoteKeyCode) {
        // Release previously held key if any
        if let held = currentlyHeldKeyCode, held != code {
            sendKeyUpCode(held)
        }
        currentlyHeldKeyCode = code

        var down = Remote_RemoteKeyInject()
        down.keyCode = code
        down.direction = .startLong
        var msgDown = Remote_RemoteMessage()
        msgDown.remoteKeyInject = down
        sendPacket(msgDown, via: remoteBridge)

        // Safety watchdog: auto-release key after 5s if keyUp is missing (prevents key stuck)
        keyUpWatchdogWorkItem?.cancel()
        let watchdog = DispatchWorkItem { [weak self] in
            guard let self = self, self.currentlyHeldKeyCode == code else { return }
            print("[Remote Action] Watchdog triggered: auto-releasing held key")
            self.sendKeyUpCode(code)
        }
        keyUpWatchdogWorkItem = watchdog
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0, execute: watchdog)
    }

    private func sendKeyUpCode(_ code: Remote_RemoteKeyCode) {
        keyUpWatchdogWorkItem?.cancel()
        keyUpWatchdogWorkItem = nil
        currentlyHeldKeyCode = nil

        var up = Remote_RemoteKeyInject()
        up.keyCode = code
        up.direction = .endLong
        var msgUp = Remote_RemoteMessage()
        msgUp.remoteKeyInject = up
        sendPacket(msgUp, via: remoteBridge)
    }

    /// Sends keyDown (startLong) followed by keyUp (endLong) like a physical remote click
    private func sendKeyCode(_ code: Remote_RemoteKeyCode) {
        sendKeyDownCode(code)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) { [weak self] in
            self?.sendKeyUpCode(code)
        }
    }

    public func sendText(_ text: String) {
        guard !text.isEmpty else { return }
        let paramValue = Int32(text.count - 1)
        var imeObject = Remote_RemoteImeObject()
        imeObject.start = paramValue
        imeObject.end = paramValue
        imeObject.value = text
        
        var editInfo = Remote_RemoteEditInfo()
        editInfo.insert = 1
        editInfo.textFieldStatus = imeObject
        
        var batch = Remote_RemoteImeBatchEdit()
        batch.imeCounter = 0
        batch.fieldCounter = 0
        batch.editInfo = [editInfo]
        
        var msg = Remote_RemoteMessage()
        msg.remoteImeBatchEdit = batch
        sendPacket(msg, via: remoteBridge)
    }
    
    public func launchApp(uri: String) {
        var appReq = Remote_RemoteAppLinkLaunchRequest()
        appReq.appLink = uri
        
        var msg = Remote_RemoteMessage()
        msg.remoteAppLinkLaunchRequest = appReq
        sendPacket(msg, via: remoteBridge)
    }
    
    private func remoteKeyCode(for key: RemoteKey) -> Remote_RemoteKeyCode? {
        switch key {
        case .dpadUp: return .keycodeDpadUp
        case .dpadDown: return .keycodeDpadDown
        case .dpadLeft: return .keycodeDpadLeft
        case .dpadRight: return .keycodeDpadRight
        case .dpadCenter: return .keycodeDpadCenter
        case .back: return .keycodeBack
        case .home: return .keycodeHome
        case .power: return .keycodePower
        case .volumeUp: return .keycodeVolumeUp
        case .volumeDown: return .keycodeVolumeDown
        case .volumeMute: return .keycodeVolumeMute
        case .playPause: return .keycodeMediaPlayPause
        case .play: return .keycodeMediaPlay
        case .pause: return .keycodeMediaPause
        case .rewind: return .keycodeMediaRewind
        case .fastForward: return .keycodeMediaFastForward
        case .settings: return .keycodeSettings
        }
    }
    
    // MARK: - Wire Framing
    
    private func sendPacket(_ message: Message, via bridge: TLSSocketBridge?) {
        guard let bridge = bridge else { return }
        do {
            let data = try message.serializedData()
            var length = UInt32(data.count)
            var prefix = Data()
            while length >= 0x80 {
                prefix.append(UInt8((length & 0x7F) | 0x80))
                length >>= 7
            }
            prefix.append(UInt8(length))
            bridge.send(data: prefix + data)
        } catch {
            print("[Packet Send] Error: \(error)")
        }
    }
}
