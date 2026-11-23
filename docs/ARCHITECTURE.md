# GTV Remote Architecture

Technical overview for **GTV Remote** (native macOS remote control for Google TV / Android TV via Google TV Remote Protocol v2).

---

## Tech Stack & Core Components

- **Platform**: Swift 5.10+, macOS 14.0+ (Sonoma), SwiftUI + AppKit (`NSVisualEffectView` HUD window, menu bar status item).
- **Networking**: Apple `Network.framework`, `dnssd` / `NetService` (Bonjour mDNS discovery for `_androidtvremote2._tcp.local.` with dynamic IP tracking and safe reconnection bounds), SwiftNIO / NIOSSL (mutual TLS on ports `6466` pairing & `6467` remote).
- **Protocols**: Protocol Buffers via `SwiftProtobufPlugin` (`protos/pairing.proto`, `protos/remote.proto`).
  - *Polo Pairing Note*: Pairing secret computation requires stripping leading null bytes from the RSA modulus and exponent per the Polo specification.
- **Security**: Locally generated self-signed RSA-2048 client certificate via `Security.framework` (see [SECURITY.md](../SECURITY.md) for privacy architecture).

---

## Directory Layout

```
gtv-remote/
├── .github/                  # Issue/PR templates and CI/CD workflows (release, pages)
├── Resources/                # AppIcon.icns, Info.plist
├── docs/                     # Localized READMEs & technical docs
├── protos/                   # Original Protobuf specifications
├── site/                     # GitHub Pages website
└── Sources/GTVRemote/
    ├── App/                  # AppDelegate, WindowController, MenuBarController, KeyboardMonitor
    ├── Core/
    │   ├── Network/          # DeviceDiscoveryService, BonjourResolver, TLSSocketBridge, TVConnectionManager
    │   ├── Proto/            # Generated SwiftProtobuf bindings (pairing.pb.swift, remote.pb.swift)
    │   └── Security/         # CertificateManager (RSA-2048)
    ├── Localization/         # LocalizationManager, LocalizableStrings protocol, L10n, Languages/ (7 langs)
    ├── Models/               # Models, RemoteKey, AppShortcut
    ├── ViewModels/           # RemoteViewModel
    └── Views/                # RemoteControlView, Components/, Sheets/
```

---

## Localization & App Shortcuts

- **7-Language Localization**: Enforced at compile time via `LocalizableStrings` in `Sources/GTVRemote/Localization/LocalizableStrings.swift`. See [CONTRIBUTING.md](../CONTRIBUTING.md) for steps to add or update strings.
  - To add a new language: add a case to `AppLanguage` in `LocalizationManager.swift`, implement `LocalizableStrings` in `Languages/<Language>.swift`, and register it in `LocalizationManager.strings`.
- **App Shortcuts & Deep Linking**: Quick launch sends deep link URLs (`https://` or `app://`) to the Google TV Remote v2 endpoint.
  - Default presets live in `defaultCatalog` inside `Sources/GTVRemote/Models/AppShortcut.swift`.
  - User-customized apps and ordering are persisted in `UserDefaults`.
