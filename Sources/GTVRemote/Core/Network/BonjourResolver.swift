import Foundation
import Network

/// Resolves a Bonjour NWEndpoint into host/IP using Apple's native NetService API.
/// Perfectly handles Unicode and Korean device names without any external CLI process.
public final class BonjourResolver: NSObject, NetServiceDelegate, @unchecked Sendable {
    private var netService: NetService?
    private var completion: ((String?) -> Void)?
    private let lock = NSLock()
    private var isDone = false
    
    @MainActor private static var activeResolvers: [BonjourResolver] = []
    
    public static func resolveHost(from endpoint: NWEndpoint, completion: @escaping @Sendable (String?) -> Void) {
        if case let .service(name, type, domain, _) = endpoint {
            DispatchQueue.main.async {
                let resolver = BonjourResolver()
                activeResolvers.append(resolver)
                
                resolver.resolve(name: name, type: type, domain: domain) { result in
                    activeResolvers.removeAll(where: { $0 === resolver })
                    completion(result)
                }
            }
        } else if case let .hostPort(host, _) = endpoint {
            switch host {
            case .name(let name, _):
                completion(name)
            case .ipv4(let addr):
                completion("\(addr)")
            case .ipv6(let addr):
                completion("\(addr)")
            @unknown default:
                completion(nil)
            }
        } else {
            completion(nil)
        }
    }
    
    private func resolve(name: String, type: String, domain: String, completion: @escaping (String?) -> Void) {
        self.completion = completion
        
        var cleanType = type
        if !cleanType.hasSuffix(".") { cleanType += "." }
        let cleanDomain = domain.isEmpty ? "local." : (domain.hasSuffix(".") ? domain : domain + ".")
        
        print("[BonjourResolver] Resolving NetService name='\(name)', type='\(cleanType)', domain='\(cleanDomain)'")
        let service = NetService(domain: cleanDomain, type: cleanType, name: name)
        self.netService = service
        service.delegate = self
        service.resolve(withTimeout: 4.0)
        
        // Timeout safeguard
        DispatchQueue.main.asyncAfter(deadline: .now() + 4.5) { [weak self] in
            self?.finish(with: nil)
        }
    }
    
    public func netServiceDidResolveAddress(_ sender: NetService) {
        var resolvedHost: String? = sender.hostName
        
        // Prefer IPv4 address from socket addresses if available
        if let addresses = sender.addresses {
            for addressData in addresses {
                let address: String? = addressData.withUnsafeBytes { rawBuffer in
                    guard let sockaddrPtr = rawBuffer.baseAddress?.assumingMemoryBound(to: sockaddr.self) else { return nil }
                    if sockaddrPtr.pointee.sa_family == sa_family_t(AF_INET) {
                        var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                        if getnameinfo(sockaddrPtr, socklen_t(addressData.count), &hostname, socklen_t(hostname.count), nil, 0, NI_NUMERICHOST) == 0 {
                            let nullIdx = hostname.firstIndex(of: 0) ?? hostname.endIndex
                            return String(decoding: hostname[..<nullIdx].map { UInt8(bitPattern: $0) }, as: UTF8.self)
                        }
                    }
                    return nil
                }
                if let ip = address {
                    resolvedHost = ip
                    break
                }
            }
        }
        
        let finalHost = resolvedHost?.trimmingCharacters(in: CharacterSet(charactersIn: "."))
        finish(with: finalHost)
    }
    
    public func netService(_ sender: NetService, didNotResolve errorDict: [String : NSNumber]) {
        print("[BonjourResolver] NetService resolve failed: \(errorDict)")
        finish(with: nil)
    }
    
    private func finish(with host: String?) {
        lock.lock()
        defer { lock.unlock() }
        guard !isDone else { return }
        isDone = true
        
        netService?.stop()
        netService?.delegate = nil
        netService = nil
        
        let cb = completion
        completion = nil
        cb?(host)
    }
}
