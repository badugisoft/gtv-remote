# Agent Guidelines for GTV Remote

This document serves as the guide for AI coding assistants and developers contributing to **GTV Remote**.

---

## 1. Core Operating Principles

When assisting in this repository, always follow these fundamental rules:

1. **State Actions First**: Briefly state what action or tool call you are about to execute before doing it.
2. **Explicit Approval for Repository Actions**: NEVER commit, push, create tags, or publish releases to the Git repository without prior explicit user confirmation.
3. **Clarify Critical Decisions**: Ask the user before making substantial architectural changes or removing existing functionality.
4. **Concise & Direct Responses**: Answer only what was asked without unnecessary preamble, fluff, or excessive hypothetical examples.
5. **No Flattery**: Keep responses objective, technical, and professional without patronizing praise.

---

## 2. Project Overview & Architecture

**GTV Remote** is a native macOS application for controlling Google TV and Android TV devices over the local network via Google TV Remote Protocol v2.

- **Language / Platform**: Swift 5.10+, macOS 14.0+ (Sonoma)
- **UI Framework**: SwiftUI + AppKit integration (menu bar status item, floating HUD window)
- **Networking**: Apple Network.framework, `dnssd` (Bonjour mDNS discovery for `_androidtvremote2._tcp.local.`), SwiftNIO / NIOSSL (TLS socket bridge on ports 6466 & 6467)
- **Protocols**: Protocol Buffers via `SwiftProtobufPlugin` (`pairing.proto` and `remote.proto`)
- **Security**: Self-signed RSA-2048 client certificate generation using Security framework

---

## 3. Directory Layout

```
gtv-remote/
├── .github/workflows/        # CI/CD workflows (release.yml)
├── Makefile                  # Build, install, packaging automation
├── Package.swift             # Swift Package Manager manifest
├── protos/                   # Original Protobuf specifications
├── Resources/                # AppIcon.icns, Info.plist
├── assets/                   # README images and documentation media
└── Sources/GTVRemote/
    ├── App/                  # App delegate, window controller, status item, key monitor
    │   ├── AppDelegate.swift
    │   ├── GTVRemoteApp.swift
    │   ├── KeyboardMonitor.swift
    │   ├── MenuBarController.swift
    │   └── WindowController.swift
    ├── Core/
    │   ├── Network/          # Discovery, Bonjour resolver, TLS sockets, TV connection
    │   │   ├── BonjourResolver.swift
    │   │   ├── DeviceDiscoveryService.swift
    │   │   ├── TLSSocketBridge.swift
    │   │   └── TVConnectionManager.swift
    │   ├── Proto/            # Generated SwiftProtobuf bindings
    │   │   ├── pairing.pb.swift
    │   │   └── remote.pb.swift
    │   └── Security/         # RSA-2048 certificate generation
    │       └── CertificateManager.swift
    ├── Localization/         # Modular 7-language localization engine
    │   ├── Languages/        # Per-language string definitions
    │   │   ├── Chinese.swift
    │   │   ├── English.swift
    │   │   ├── French.swift
    │   │   ├── German.swift
    │   │   ├── Japanese.swift
    │   │   ├── Korean.swift
    │   │   └── Spanish.swift
    │   ├── L10n.swift        # MainActor-isolated proxy for SwiftUI views
    │   ├── LocalizableStrings.swift  # Protocol enforcing complete key implementation
    │   └── LocalizationManager.swift # Observable language manager
    ├── Models/               # Data structures, RemoteKey codes, App Shortcuts
    │   ├── AppShortcut.swift
    │   ├── Models.swift
    │   └── RemoteKey.swift
    ├── ViewModels/           # Observable remote business logic
    │   └── RemoteViewModel.swift
    └── Views/                # SwiftUI interfaces
        ├── Components/       # DPadView, SmartInputBar, RemoteButtonStyles
        ├── Sheets/           # PairingSheetView, ShortcutsView, AppShortcutsSettingsView
        └── RemoteControlView.swift # Main remote interface
```

---

## 4. Build & Development Commands

Always use `make` targets or SwiftPM commands from the project root:

| Command | Description |
|---|---|
| `make build` | Builds release binary using SwiftPM (`swift build -c release`). |
| `make build-debug` | Builds debug binary. |
| `make run` / `make dev` | Builds debug binary and runs immediately in foreground with terminal stdout/stderr. |
| `make install` | Builds release binary, creates `/Applications/GTV Remote.app`, ad-hoc signs, and launches. |
| `make package` | Builds release binary and packages into `dist/GTV Remote.app`, `dist/GTV Remote.dmg`, and `dist/GTV Remote.zip`. |
| `make clean` | Cleans SwiftPM artifacts and removes `dist/`. |

---

## 5. Adding a New Language

Localization uses a strict protocol-based architecture for compile-time safety. To add a new language:

1. **Update Enum**: In `Sources/GTVRemote/Localization/LocalizationManager.swift`, add a case to `AppLanguage` with its ISO code, localized name, and English name.
2. **Implement Strings**: Create `Sources/GTVRemote/Localization/Languages/<LanguageName>.swift` conforming to `LocalizableStrings`. Implement every property required by the protocol.
3. **Register Mapping**: In `LocalizationManager.strings`, add a branch to return the new language struct.

---

## 6. App Shortcuts & Deep Linking

Quick launch shortcuts work by sending deep link URLs to the Google TV Remote v2 protocol endpoint.
- Deep links must start with `https://` (e.g., `https://www.youtube.com/`, `https://tv.apple.com`).
- Default catalog apps are defined in `Sources/GTVRemote/Models/AppShortcut.swift` in `defaultCatalog`.
- Custom user apps are persisted via `UserDefaults` with name and deep link URL.
