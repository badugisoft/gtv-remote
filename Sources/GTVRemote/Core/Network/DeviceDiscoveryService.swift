import Foundation
import Network
import Combine

public final class DeviceDiscoveryService: ObservableObject, @unchecked Sendable {
    @Published public private(set) var discoveredDevices: [DiscoveredDevice] = []
    @Published public private(set) var isSearching: Bool = false
    
    private var browser: NWBrowser?
    private let queue = DispatchQueue(label: "com.badugisoft.gtvremote.discovery", qos: .userInitiated)
    
    public init() {
        self.discoveredDevices = []
    }
    
    public func startDiscovery() {
        guard browser == nil else { return }
        
        let descriptor = NWBrowser.Descriptor.bonjour(type: "_androidtvremote2._tcp", domain: "local.")
        let parameters = NWParameters()
        parameters.includePeerToPeer = true
        
        let nwBrowser = NWBrowser(for: descriptor, using: parameters)
        self.browser = nwBrowser
        
        DispatchQueue.main.async {
            self.isSearching = true
        }
        
        nwBrowser.browseResultsChangedHandler = { [weak self] results, changes in
            guard let self = self else { return }
            var devices: [DiscoveredDevice] = []
            
            for result in results {
                if case let .service(name, _, _, _) = result.endpoint {
                    let device = DiscoveredDevice(
                        id: name,
                        name: name,
                        host: name,
                        port: 6466,
                        endpoint: result.endpoint
                    )
                    devices.append(device)
                }
            }
            
            DispatchQueue.main.async {
                self.discoveredDevices = devices
                print("[Discovery] Found devices: \(devices.map { $0.name })")
            }
        }
        
        nwBrowser.stateUpdateHandler = { [weak self] state in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch state {
                case .ready:
                    self.isSearching = true
                case .failed(let error):
                    print("[mDNS Discovery] NWBrowser failed: \(error)")
                    self.isSearching = false
                case .cancelled:
                    self.isSearching = false
                default:
                    break
                }
            }
        }
        
        nwBrowser.start(queue: queue)
    }
    
    public func addManualDevice(host: String, name: String = "Google TV") {
        let cleanHost = host.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !cleanHost.isEmpty else { return }
        let dev = DiscoveredDevice(
            id: cleanHost,
            name: name == "Google TV" ? "TV (\(cleanHost))" : name,
            host: cleanHost,
            port: 6466,
            endpoint: nil
        )
        DispatchQueue.main.async {
            if !self.discoveredDevices.contains(where: { $0.host == cleanHost }) {
                self.discoveredDevices.append(dev)
            }
        }
    }
    
    public func stopDiscovery() {
        browser?.cancel()
        browser = nil
        DispatchQueue.main.async {
            self.isSearching = false
        }
    }
}
