import Foundation
import Network

public struct DiscoveredDevice: Identifiable, Hashable, Sendable {
    public var id: String
    public var name: String
    public var host: String
    public var port: Int
    public var endpoint: NWEndpoint?
    
    public init(id: String = UUID().uuidString, name: String, host: String, port: Int = 6466, endpoint: NWEndpoint? = nil) {
        self.id = id
        self.name = name
        self.host = host
        self.port = port
        self.endpoint = endpoint
    }
}

public enum ConnectionState: Sendable {
    case disconnected
    case discovering
    case connecting
    case pairingRequired(codePrompt: String)
    case connected(deviceName: String)
    case error(String)
}
