import Foundation
import Security

/// Manages self-signed RSA-2048 client certificates using Security.framework.
/// No external openssl binary dependency and no Keychain pollution.
public final class CertificateManager: @unchecked Sendable {
    public static let shared = CertificateManager()

    public let certURL: URL
    public let keyURL: URL

    private init() {
        let appSupport = FileManager.default.urls(
            for: .applicationSupportDirectory, in: .userDomainMask
        ).first!
        let certDir = appSupport.appendingPathComponent("GTVRemote", isDirectory: true)
        try? FileManager.default.createDirectory(at: certDir, withIntermediateDirectories: true)
        self.certURL = certDir.appendingPathComponent("client.crt")
        self.keyURL  = certDir.appendingPathComponent("client.key")
    }

    // MARK: - Public API

    public var hasExistingCertificates: Bool {
        FileManager.default.fileExists(atPath: certURL.path) && FileManager.default.fileExists(atPath: keyURL.path)
    }

    public func ensureCertificatesExist() {
        // Import external certificates if available (shared with androidtvremote CLI)
        let home = FileManager.default.homeDirectoryForCurrentUser
        let extCert = home.appendingPathComponent(".config/androidtvremote/cert.pem")
        let extKey  = home.appendingPathComponent(".config/androidtvremote/key.pem")

        if FileManager.default.fileExists(atPath: extCert.path),
           FileManager.default.fileExists(atPath: extKey.path),
           (!FileManager.default.fileExists(atPath: certURL.path) ||
            !FileManager.default.fileExists(atPath: keyURL.path)) {
            try? FileManager.default.removeItem(at: certURL)
            try? FileManager.default.removeItem(at: keyURL)
            try? FileManager.default.copyItem(at: extCert, to: certURL)
            try? FileManager.default.copyItem(at: extKey,  to: keyURL)
            print("[CertificateManager] Imported existing certificates from androidtvremote.")
            return
        }

        // If a valid RSA private key already exists, reuse it
        if let keyStr = try? String(contentsOf: keyURL),
           keyStr.contains("BEGIN RSA PRIVATE KEY"),
           FileManager.default.fileExists(atPath: certURL.path) {
            return
        }

        generateCertificate()
    }

    public func resetCertificates() {
        try? FileManager.default.removeItem(at: certURL)
        try? FileManager.default.removeItem(at: keyURL)
        UserDefaults.standard.removeObject(forKey: "gtv_last_host")
        UserDefaults.standard.removeObject(forKey: "gtv_last_name")
        ensureCertificatesExist()
    }

    // MARK: - Modulus / Exponent

    public func getClientModulusAndExponent() -> (modulusHex: String, exponentHex: String)? {
        guard let pem = try? String(contentsOf: certURL),
              let der = pemDecode(pem) else { return nil }
        return extractModExp(fromCertDER: der)
    }

    public func getModulusAndExponent(fromPemPath path: String) -> (modulusHex: String, exponentHex: String)? {
        guard let pem = try? String(contentsOfFile: path),
              let der = pemDecode(pem) else { return nil }
        return extractModExp(fromCertDER: der)
    }

    public func getModulusAndExponent(fromDerData derData: Data) -> (modulusHex: String, exponentHex: String)? {
        extractModExp(fromCertDER: derData)
    }

    // MARK: - Certificate Generation

    private func generateCertificate() {
        print("[CertificateManager] Generating RSA-2048 certificate (Security.framework)...")

        // 1. Generate RSA-2048 key pair (transient, not stored in Keychain)
        let attrs: [CFString: Any] = [
            kSecAttrKeyType:       kSecAttrKeyTypeRSA,
            kSecAttrKeySizeInBits: 2048,
            kSecAttrIsPermanent:   false
        ]
        var cfErr: Unmanaged<CFError>?
        guard let privKey = SecKeyCreateRandomKey(attrs as CFDictionary, &cfErr) else {
            print("[CertificateManager] Key generation failed: \(cfErr!.takeRetainedValue())")
            return
        }
        guard let pubKey = SecKeyCopyPublicKey(privKey) else {
            print("[CertificateManager] Failed to get public key")
            return
        }

        // 2. Export key representations as DER
        guard let privDER = SecKeyCopyExternalRepresentation(privKey, &cfErr) as Data? else {
            print("[CertificateManager] Failed to export private key")
            return
        }
        guard let pubDER = SecKeyCopyExternalRepresentation(pubKey, &cfErr) as Data? else {
            print("[CertificateManager] Failed to export public key")
            return
        }

        // 3. Build SubjectPublicKeyInfo (PKCS#1 RSAPublicKey -> SPKI)
        let spki = buildSPKI(rsaPKCS1: pubDER)

        // 4. Build TBSCertificate
        let tbs = buildTBSCertificate(spki: spki)

        // 5. Sign with SHA256withRSA
        guard let sig = SecKeyCreateSignature(
            privKey,
            .rsaSignatureMessagePKCS1v15SHA256,
            tbs as CFData,
            &cfErr
        ) as Data? else {
            print("[CertificateManager] Signing failed: \(cfErr!.takeRetainedValue())")
            return
        }

        // 6. Assemble complete Certificate DER
        let certDER = buildCertificate(tbs: tbs, signature: sig)

        // 7. Save PEM files to disk
        do {
            try pemEncode(certDER, label: "CERTIFICATE").write(
                to: certURL, atomically: true, encoding: .utf8)
            try pemEncode(privDER, label: "RSA PRIVATE KEY").write(
                to: keyURL, atomically: true, encoding: .utf8)
            print("[CertificateManager] Certificate saved to \(certURL.path)")
        } catch {
            print("[CertificateManager] Failed to write files: \(error)")
        }
    }

    // MARK: - ASN.1 DER Builders

    private func derLen(_ n: Int) -> Data {
        if n < 0x80 { return Data([UInt8(n)]) }
        if n < 0x100 { return Data([0x81, UInt8(n)]) }
        return Data([0x82, UInt8(n >> 8), UInt8(n & 0xFF)])
    }

    private func tlv(_ tag: UInt8, _ value: Data) -> Data {
        Data([tag]) + derLen(value.count) + value
    }

    private func seq(_ parts: Data...) -> Data {
        tlv(0x30, parts.reduce(Data(), +))
    }

    private func set(_ parts: Data...) -> Data {
        tlv(0x31, parts.reduce(Data(), +))
    }

    private func derInt(_ raw: Data) -> Data {
        var b = raw
        while b.count > 1 && b[b.startIndex] == 0x00 { b = b.dropFirst() }
        if b[b.startIndex] & 0x80 != 0 { b = Data([0x00]) + b }
        return tlv(0x02, b)
    }

    private func oid(_ bytes: [UInt8]) -> Data { tlv(0x06, Data(bytes)) }
    private var derNull: Data { tlv(0x05, Data()) }
    private func bitString(_ d: Data) -> Data { tlv(0x03, Data([0x00]) + d) }
    private func utf8Str(_ s: String) -> Data { tlv(0x0C, Data(s.utf8)) }

    private func utcTime(_ date: Date) -> Data {
        let f = DateFormatter()
        f.dateFormat = "yyMMddHHmmss'Z'"
        f.timeZone = TimeZone(identifier: "UTC")
        return tlv(0x17, Data(f.string(from: date).utf8))
    }

    // OIDs
    // rsaEncryption:          1.2.840.113549.1.1.1
    private var oidRSA:       Data { oid([0x2A,0x86,0x48,0x86,0xF7,0x0D,0x01,0x01,0x01]) }
    // sha256WithRSAEncryption: 1.2.840.113549.1.1.11
    private var oidSHA256RSA: Data { oid([0x2A,0x86,0x48,0x86,0xF7,0x0D,0x01,0x01,0x0B]) }
    // commonName:             2.5.4.3
    private var oidCN:        Data { oid([0x55,0x04,0x03]) }

    private var algIdRSA:       Data { seq(oidRSA,       derNull) }
    private var algIdSHA256RSA: Data { seq(oidSHA256RSA, derNull) }

    private func buildName(cn: String) -> Data {
        seq(set(seq(oidCN, utf8Str(cn))))
    }

    private func buildSPKI(rsaPKCS1: Data) -> Data {
        seq(algIdRSA, bitString(rsaPKCS1))
    }

    private func buildTBSCertificate(spki: Data) -> Data {
        // version v3 -> [0] EXPLICIT INTEGER 2
        let version = tlv(0xA0, derInt(Data([0x02])))

        // serial: random 16 bytes (positive)
        var serialBytes = Data(count: 16)
        _ = serialBytes.withUnsafeMutableBytes {
            SecRandomCopyBytes(kSecRandomDefault, 16, $0.baseAddress!)
        }
        serialBytes[serialBytes.startIndex] &= 0x7F
        let serial = derInt(serialBytes)

        let now     = Date()
        let expiry  = Date(timeIntervalSinceNow: 10 * 365.25 * 24 * 3600)
        let validity = seq(utcTime(now), utcTime(expiry))
        let name    = buildName(cn: "GTVRemoteMac")

        return seq(version, serial, algIdSHA256RSA, name, validity, name, spki)
    }

    private func buildCertificate(tbs: Data, signature: Data) -> Data {
        seq(tbs, algIdSHA256RSA, bitString(signature))
    }

    // MARK: - PEM

    private func pemEncode(_ der: Data, label: String) -> String {
        let b64 = der.base64EncodedString(options: .lineLength64Characters)
        return "-----BEGIN \(label)-----\n\(b64)\n-----END \(label)-----\n"
    }

    private func pemDecode(_ pem: String) -> Data? {
        let body = pem.components(separatedBy: "\n")
            .filter { !$0.hasPrefix("-----") && !$0.isEmpty }
            .joined()
        return Data(base64Encoded: body, options: .ignoreUnknownCharacters)
    }

    // MARK: - Modulus/Exponent extraction from Certificate DER

    private func extractModExp(fromCertDER der: Data) -> (modulusHex: String, exponentHex: String)? {
        let b = [UInt8](der)
        var p = 0

        func readLen() -> Int {
            guard p < b.count else { return 0 }
            let f = b[p]; p += 1
            if f < 0x80 { return Int(f) }
            let n = Int(f & 0x7F)
            var l = 0
            for _ in 0..<n { l = (l << 8) | Int(b[p]); p += 1 }
            return l
        }

        func skip() {            // skip one TLV
            guard p < b.count else { return }
            p += 1               // tag
            p += readLen()       // skip value
        }

        func expect(_ tag: UInt8) -> Bool {
            guard p < b.count, b[p] == tag else { return false }
            p += 1; return true
        }

        // Certificate SEQUENCE
        guard expect(0x30) else { return nil }; _ = readLen()
        // TBSCertificate SEQUENCE
        guard expect(0x30) else { return nil }; _ = readLen()

        if p < b.count && b[p] == 0xA0 { skip() }  // version [0]
        skip()  // serialNumber
        skip()  // signature AlgId
        skip()  // issuer
        skip()  // validity
        skip()  // subject

        // SubjectPublicKeyInfo
        guard expect(0x30) else { return nil }; _ = readLen()
        skip()  // AlgorithmIdentifier

        // BIT STRING
        guard expect(0x03) else { return nil }
        _ = readLen()
        p += 1  // unused bits byte (0x00)

        // RSAPublicKey SEQUENCE
        guard expect(0x30) else { return nil }; _ = readLen()

        // modulus INTEGER
        guard expect(0x02) else { return nil }
        let modLen = readLen()
        let modBytes = Array(b[p..<p+modLen]); p += modLen

        // exponent INTEGER
        guard expect(0x02) else { return nil }
        let expLen = readLen()
        let expBytes = Array(b[p..<p+expLen])

        let modHex = modBytes.map { String(format: "%02X", $0) }.joined()
        let expHex = expBytes.map { String(format: "%02X", $0) }.joined()

        return (modHex, expHex)
    }
}
