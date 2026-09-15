import SwiftUI
import Combine

@MainActor
public final class RemoteViewModel: ObservableObject {
    @Published public var connectionState: ConnectionState = .disconnected
    @Published public var discoveredDevices: [DiscoveredDevice] = []
    @Published public var selectedDevice: DiscoveredDevice? = nil
    
    // Smart text input states
    @Published public var isIMEActive: Bool = false
    @Published public var inputText: String = ""
    @Published public var lastSentKey: RemoteKey? = nil
    @Published public var keyFeedbackAnimation: Bool = false
    @Published public var activePressedKey: RemoteKey? = nil
    private var keyResetWorkItem: DispatchWorkItem?
    @Published public var showDeviceList: Bool = false
    
    // Pairing PIN modal states
    @Published public var isPairingSheetPresented: Bool = false
    @Published public var pairingPrompt: String = ""
    @Published public var pairingPinCode: String = ""
    @Published public var isSearchingDevices: Bool = false
    
    private let discoveryService = DeviceDiscoveryService()
    private let connectionManager = TVConnectionManager.shared
    private var cancellables = Set<AnyCancellable>()
    
    public init() {
        bindServices()
        startDiscovery()
        attemptAutoReconnect()
    }
    
    private func bindServices() {
        discoveryService.$discoveredDevices
            .receive(on: DispatchQueue.main)
            .sink { [weak self] devices in
                guard let self = self else { return }
                self.discoveredDevices = devices
                // Only auto-connect if device matches saved last host
                if self.selectedDevice == nil,
                   let lastHost = UserDefaults.standard.string(forKey: "gtv_last_host"),
                   let savedDevice = devices.first(where: { $0.host == lastHost || $0.name == lastHost }) {
                    self.selectedDevice = savedDevice
                    print("[RemoteViewModel] Re-connecting to previously paired device: \(savedDevice.name) (\(savedDevice.host))...")
                    self.connect(to: savedDevice)
                }
            }
            .store(in: &cancellables)
        
        discoveryService.$isSearching
            .receive(on: DispatchQueue.main)
            .assign(to: &$isSearchingDevices)
        
        connectionManager.$state
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                guard let self = self else { return }
                switch state {
                case .disconnected:
                    self.connectionState = .disconnected
                case .connecting:
                    self.connectionState = .connecting
                case .pairing(let prompt):
                    self.pairingPrompt = prompt
                    self.isPairingSheetPresented = true
                    self.connectionState = .pairingRequired(codePrompt: prompt)
                case .connected(let name):
                    self.isPairingSheetPresented = false
                    self.connectionState = .connected(deviceName: name)
                case .failed(let error):
                    self.isPairingSheetPresented = false
                    self.connectionState = .error(error)
                }
            }
            .store(in: &cancellables)
        
        connectionManager.$isIMEActive
            .receive(on: DispatchQueue.main)
            .assign(to: &$isIMEActive)
    }
    
    public func startDiscovery() {
        discoveryService.startDiscovery()
    }
    
    /// Attempts instant auto-reconnect to the last paired device on launch.
    /// Connects directly using the persisted host without waiting for Bonjour discovery.
    private func attemptAutoReconnect() {
        guard let lastHost = UserDefaults.standard.string(forKey: "gtv_last_host"),
              !lastHost.isEmpty else { return }
        let lastName = UserDefaults.standard.string(forKey: "gtv_last_name") ?? lastHost
        let device = DiscoveredDevice(name: lastName, host: lastHost, port: 6466, endpoint: nil)
        print("[RemoteViewModel] Auto-reconnecting to saved device: \(lastName) (\(lastHost))")
        selectedDevice = device
        connectionManager.connect(to: device)
    }

    public func addManualDevice(host: String) {
        discoveryService.addManualDevice(host: host)
    }
    
    public func connect(to device: DiscoveredDevice) {
        selectedDevice = device
        connectionManager.connect(to: device)
    }
    
    public func resetPairing() {
        selectedDevice = nil
        connectionManager.resetAllPairing()
    }
    
    public func submitPinCode() {
        connectionManager.submitSecretCode(pairingPinCode)
        pairingPinCode = ""
    }
    
    public func sendKey(_ key: RemoteKey) {
        lastSentKey = key
        keyFeedbackAnimation.toggle()

        // Visual feedback: show key in active pressed state for 0.15s
        keyResetWorkItem?.cancel()
        activePressedKey = key
        let item = DispatchWorkItem { [weak self] in
            if self?.activePressedKey == key {
                self?.activePressedKey = nil
            }
        }
        keyResetWorkItem = item
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15, execute: item)

        connectionManager.sendKey(key)
        print("[Remote Action] Key sent: \(key.rawValue) (\(key.label))")
    }

    public func sendKeyDown(_ key: RemoteKey) {
        lastSentKey = key
        connectionManager.sendKeyDown(key)
        print("[Remote Action] Key down: \(key.rawValue) (\(key.label))")
    }

    public func sendKeyUp(_ key: RemoteKey) {
        connectionManager.sendKeyUp(key)
        print("[Remote Action] Key up: \(key.rawValue) (\(key.label))")
    }

    public func sendKeyLongPress(_ key: RemoteKey, duration: TimeInterval = 1.0) {
        lastSentKey = key
        keyFeedbackAnimation.toggle()
        connectionManager.sendKeyLongPress(key, duration: duration)
        print("[Remote Action] Key long-press: \(key.rawValue) (\(key.label)) [\(duration)s]")
    }
    
    public func sendText(_ text: String) {
        guard !text.isEmpty else { return }
        connectionManager.sendText(text)
        print("[Remote Action] Text sent: \(text)")
        inputText = ""
    }
    
    public func sendClipboardText() {
        if let pasteboard = NSPasteboard.general.string(forType: .string), !pasteboard.isEmpty {
            sendText(pasteboard)
        }
    }
    
    public func launchApp(name: String, uri: String) {
        connectionManager.launchApp(uri: uri)
        print("[Remote Action] Launching app: \(name) (\(uri))")
    }
}
