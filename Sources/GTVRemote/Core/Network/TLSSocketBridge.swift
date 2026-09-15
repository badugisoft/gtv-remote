import Foundation
import NIOCore
import NIOPosix
import NIOTLS
import NIOSSL

public protocol TLSSocketDelegate: AnyObject, Sendable {
    func tlsSocketDidConnect()
    func tlsSocketDidDisconnect(error: Error?)
    func tlsSocketDidReceive(data: Data)
    func tlsSocketDidReceiveServerCert(derData: Data)
}

public final class TLSSocketBridge: @unchecked Sendable {
    private let group = MultiThreadedEventLoopGroup(numberOfThreads: 1)
    private var channel: Channel?
    public weak var delegate: TLSSocketDelegate?
    
    public init() {}
    
    public func connect(host: String, port: Int, certPath: String, keyPath: String) {
        let certURL = URL(fileURLWithPath: certPath)
        let keyURL = URL(fileURLWithPath: keyPath)
        
        do {
            var tlsConfig = TLSConfiguration.makeClientConfiguration()
            tlsConfig.certificateVerification = .none
            
            let certs = try NIOSSLCertificate.fromPEMFile(certURL.path)
            tlsConfig.certificateChain = certs.map { .certificate($0) }
            
            let keyBytes = try Array(Data(contentsOf: keyURL))
            let pKey = try NIOSSLPrivateKey(bytes: keyBytes, format: .pem)
            tlsConfig.privateKey = .privateKey(pKey)
            
            let sslContext = try NIOSSLContext(configuration: tlsConfig)
            
            let bootstrap = ClientBootstrap(group: group)
                .channelOption(ChannelOptions.socketOption(.so_reuseaddr), value: 1)
                .channelInitializer { [weak self] channel in
                    do {
                        let sslHandler = try NIOSSLClientHandler(context: sslContext, serverHostname: nil)
                        let handler = SocketChannelHandler(bridge: self)
                        return channel.pipeline.addHandler(sslHandler).flatMap {
                            channel.pipeline.addHandler(handler)
                        }
                    } catch {
                        return channel.eventLoop.makeFailedFuture(error)
                    }
                }
            
            bootstrap.connect(host: host, port: port).whenComplete { [weak self] result in
                switch result {
                case .success(let ch):
                    self?.channel = ch
                    print("[TLSSocketBridge] TCP Connected to \(host):\(port)")
                case .failure(let err):
                    print("[TLSSocketBridge] TCP connect error: \(err)")
                    self?.delegate?.tlsSocketDidDisconnect(error: err)
                }
            }
        } catch {
            print("[TLSSocketBridge] Init error: \(error)")
            self.delegate?.tlsSocketDidDisconnect(error: error)
        }
    }
    
    public func send(data: Data) {
        guard let channel = channel, channel.isActive else { return }
        var buffer = channel.allocator.buffer(capacity: data.count)
        buffer.writeBytes(data)
        channel.writeAndFlush(buffer, promise: nil)
    }
    
    public func disconnect() {
        channel?.close(promise: nil)
        channel = nil
    }
}

private final class SocketChannelHandler: ChannelInboundHandler, @unchecked Sendable {
    typealias InboundIn = ByteBuffer
    private weak var bridge: TLSSocketBridge?
    private var receivedData = Data()
    
    init(bridge: TLSSocketBridge?) {
        self.bridge = bridge
    }
    
    func channelActive(context: ChannelHandlerContext) {
        print("[TLSSocketBridge] Channel active. Waiting for TLS Handshake...")
    }
    
    func userInboundEventTriggered(context: ChannelHandlerContext, event: Any) {
        if let tlsEvent = event as? TLSUserEvent, case .handshakeCompleted = tlsEvent {
            print("[TLSSocketBridge] TLS Handshake Completed successfully!")
            
            context.channel.pipeline.handler(type: NIOSSLClientHandler.self).whenSuccess { [weak self] sslHandler in
                if let cert = sslHandler.peerCertificate {
                    if let der = try? cert.toDERBytes() {
                        self?.bridge?.delegate?.tlsSocketDidReceiveServerCert(derData: Data(der))
                    }
                }
            }
            
            bridge?.delegate?.tlsSocketDidConnect()
        }
        context.fireUserInboundEventTriggered(event)
    }
    
    func channelInactive(context: ChannelHandlerContext) {
        print("[TLSSocketBridge] Channel became inactive")
        bridge?.delegate?.tlsSocketDidDisconnect(error: nil)
    }
    
    func channelRead(context: ChannelHandlerContext, data: NIOAny) {
        var buffer = unwrapInboundIn(data)
        if let bytes = buffer.readBytes(length: buffer.readableBytes) {
            receivedData.append(contentsOf: bytes)
            processPackets()
        }
    }
    
    private func processPackets() {
        while !receivedData.isEmpty {
            var length: UInt32 = 0
            var shift: UInt32 = 0
            var bytesRead = 0
            var found = false
            
            for byte in receivedData {
                bytesRead += 1
                length |= UInt32(byte & 0x7F) << shift
                if (byte & 0x80) == 0 {
                    found = true
                    break
                }
                shift += 7
                if shift >= 32 {
                    receivedData.removeAll()
                    return
                }
            }
            
            guard found else { return }
            let totalNeeded = bytesRead + Int(length)
            guard receivedData.count >= totalNeeded else { return }
            
            let packetData = receivedData.subdata(in: bytesRead..<totalNeeded)
            receivedData.removeSubrange(0..<totalNeeded)
            
            bridge?.delegate?.tlsSocketDidReceive(data: packetData)
        }
    }
    
    func errorCaught(context: ChannelHandlerContext, error: Error) {
        print("[TLSSocketBridge] Socket Error: \(error)")
        bridge?.delegate?.tlsSocketDidDisconnect(error: error)
    }
}
