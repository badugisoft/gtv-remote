# GTV Remote

<p align="center">
  <img src="assets/app_icon.png" alt="GTV Remote Icon" width="128" height="128" />
</p>

<p align="center">
  <strong>A modern, native macOS remote control & quick launcher for Google TV / Android TV.</strong><br>
  <em>Low-latency TLS 2-way control, mDNS auto-discovery, instant text typing, quick app launchers, and keyboard hotkeys right from your Mac.</em>
</p>

<p align="center">
  <a href="https://github.com/badugisoft/gtv-remote/releases/latest"><img src="https://img.shields.io/github/v/release/badugisoft/gtv-remote?style=flat-square" alt="Latest Release" /></a>
  <a href="https://github.com/badugisoft/gtv-remote/releases"><img src="https://img.shields.io/github/downloads/badugisoft/gtv-remote/total?style=flat-square" alt="Total Downloads" /></a>
  <a href="https://badugisoft.github.io/gtv-remote/"><img src="https://img.shields.io/badge/Website-GitHub%20Pages-2563eb?style=flat-square" alt="Project Website" /></a>
  <img src="https://img.shields.io/badge/macOS-14.0%2B-black?style=flat-square&logo=apple" alt="macOS 14+" />
  <img src="https://img.shields.io/badge/Swift-6.0%2B-orange?style=flat-square&logo=swift" alt="Swift 6.0+" />
  <img src="https://img.shields.io/badge/Architecture-Apple%20Silicon-blue?style=flat-square" alt="Apple Silicon" />
  <img src="https://img.shields.io/badge/100%25-Built%20with%20Antigravity-blue?style=flat-square" alt="100% Built with Antigravity" />
  <img src="https://img.shields.io/badge/License-MIT-green?style=flat-square" alt="MIT License" />
</p>

<p align="center">
  <strong>English</strong> ·
  <a href="docs/README.ko.md">한국어</a> ·
  <a href="docs/README.zh-Hans.md">简体中文</a> ·
  <a href="docs/README.ja.md">日本語</a> ·
  <a href="docs/README.de.md">Deutsch</a> ·
  <a href="docs/README.fr.md">Français</a> ·
  <a href="docs/README.es.md">Español</a>
</p>

<p align="center">
  <a href="https://badugisoft.github.io/gtv-remote/"><strong>🌐 Project Website</strong></a> ·
  <a href="https://github.com/badugisoft/gtv-remote/releases/latest"><strong>⬇️ Download Latest Release</strong></a> ·
  <a href="#screenshots">Screenshots</a> ·
  <a href="#features">Features</a> ·
  <a href="#keyboard-shortcuts-reference">Shortcuts</a> ·
  <a href="#installation">Installation</a> ·
  <a href="#faq--troubleshooting">FAQ</a> ·
  <a href="#contributing--security">Contributing</a>
</p>

---

> [!NOTE]
> **🤖 100% Built with Google Antigravity**
>
> This entire application—including TLS socket communication, Protobuf packet serialization, mDNS auto-discovery, SwiftUI views, keyboard event monitoring, drag-and-drop quick app reordering, 7-language multi-localization, and build automation—was **100% designed, implemented, and verified pair-programming autonomously with Google Antigravity**.

---

## Screenshots

<p align="center">
  <img src="assets/remote_main.png" alt="GTV Remote Main Window" height="460" />
  <img src="assets/quick_apps_settings.png" alt="Quick Apps Settings" height="460" />
  <img src="assets/keyboard_shortcuts.png" alt="Keyboard Shortcuts" height="460" />
  <br>
  <em>GTV Remote: Native macOS Frosted Glass UI, Quick Apps Manager & Keyboard Shortcuts</em>
</p>

---

## Features

- **Native macOS Experience**:
  - Built with 100% Swift, SwiftUI, and AppKit with native `.sidebar` frosted glass material (`NSVisualEffectView`).
  - Sleek, custom 45-degree tilted remote icon in the macOS status bar for one-click access or focus toggle.
  - Window stays background-resident when closed; reopening via Dock or Menu Bar is instant without process restarting.

- **Zero-Config Network Discovery & Instant Reconnect**:
  - Automatic zero-configuration Bonjour / mDNS discovery of all Google TV and Android TV devices on your local network (`_androidtvremote2._tcp`).
  - Real-time IP address change tracking and auto-sync when TV IP is reassigned via DHCP.
  - Reconnection retry safety limit preventing infinite connecting state loops.
  - Unicode and international device name resolution.
  - Automatically remembers the last connected TV and re-establishes connection instantly upon launch.

- **Fast, Secure TLS Connection & Local Privacy**:
  - Secure two-way mutual TLS encryption with Android TV Remote v2 protocol.
  - Built-in transient RSA-2048 client certificate generation powered directly by Apple's `Security.framework` (no external `openssl` binary required).
  - **100% Local & Zero Telemetry**: All discovery and control traffic stays strictly on your local Wi-Fi/LAN with no analytics, tracking, or external servers. See [SECURITY.md](SECURITY.md) for details.

- **Full Keyboard Navigation & Visual Feedback**:
  - Navigate TV menus effortlessly with Arrow keys, `Enter`, `Esc`, `Home`, `Space`, and volume controls.
  - Real-time **0.15s button press feedback animations** that highlight on-screen buttons when triggered from your keyboard.

- **Smart Remote Text Input & Clipboard Sync**:
  - Integrated smart input bar allows you to type searches, URLs, and passwords directly into your TV.
  - 1-click clipboard paste (`Cmd + V`) sends text from your Mac clipboard straight to your TV's input field.

- **Customizable Quick Apps Launcher**:
  - Built-in presets for popular streaming platforms: **YouTube, Netflix, Disney+, Apple TV, Prime Video, Coupang Play, Max, Paramount+, YouTube TV, Tubi, Pluto TV, Google Play Store, Surfshark, Plex, Spotify, Twitch, Stremio**.
  - Unified app manager with **drag-and-drop reordering** and visibility checkboxes.
  - Support for adding, editing, and removing custom deep links (`https://` or `app://`).
  - Fixed 3-column grid maintaining consistent button dimensions.
  - Direct keyboard triggers (`1` through `9`) to launch your top quick apps instantly.

- **Multi-Language Localization (7 Languages)**:
  - Supports **English**, **한국어 (Korean)**, **简体中文 (Simplified Chinese)**, **日本語 (Japanese)**, **Deutsch (German)**, **Français (French)**, and **Español (Spanish)**.
  - Automatically respects your macOS system language preference on first launch.
  - Dedicated globe button on the header allows switching UI languages on the fly at any time.

---

## Keyboard Shortcuts Reference

When the remote window is active, the following physical hotkeys are available:

| Key | Remote Function | Description |
| :--- | :--- | :--- |
| **Arrow keys (↑ ↓ ← →)** | `DPAD_UP / DOWN / LEFT / RIGHT` | Directional navigation |
| **Return / Enter** | `DPAD_CENTER` | Select / OK |
| **Esc / Backspace** | `BACK` | Back / Exit menu |
| **H** | `HOME` | Go to TV Home screen |
| **Space** | `MEDIA_PLAY_PAUSE` | Toggle play or pause |
| **+ / =** | `VOLUME_UP` | Volume Up |
| **- / _** | `VOLUME_DOWN` | Volume Down |
| **M** | `VOLUME_MUTE` | Toggle Mute |
| **P** | `POWER` | Toggle Power On / Off |
| **A** | `ASSISTANT` | Trigger Google Assistant |
| **I** | `INPUT` | Change Video Input source |
| **1 ~ 9** | Quick App 1–9 | Launch Quick Apps 1 through 9 directly |
| **Cmd + V** | Clipboard Sync | Send current Mac clipboard text to TV |
| **Cmd + W** | Hide Window | Conceal remote window (stays active in background) |

---

## Installation

### Option 1: Download Pre-built Release (Apple Silicon, Recommended)

1. Download the latest `GTV-Remote-v*.dmg` or `GTV-Remote-v*.zip` from [GitHub Releases](https://github.com/badugisoft/gtv-remote/releases/latest).
2. Open the `.dmg` (or extract the `.zip`) and drag **GTV Remote.app** into your `/Applications` folder.
3. Launch **GTV Remote** from `/Applications`.

> **Signed & Notarized:** Official releases (`v1.0.5+`) are signed with an Apple Developer ID certificate and notarized by Apple, so they open directly without macOS Gatekeeper warnings. Pre-built releases target **Apple Silicon** Macs; Intel Mac users should use **Option 2 (Build from Source)**.

---

### Option 2: Build from Source (via Makefile)

#### Prerequisites
- macOS 14.0 (Sonoma) or later
- Xcode 16+ or Swift 6.0+ Command Line Tools

#### Build and Install

Clone the repository and run:

```bash
# Build Release binary, package into /Applications/GTV Remote.app, and launch
make install

# Package release into .app, .dmg, and .zip inside dist/
make package
```

To clean build artifacts:
```bash
make clean
```

To uninstall:
```bash
make uninstall
```

---

## FAQ & Troubleshooting

<details>
<summary><strong>Is GTV Remote signed and notarized by Apple?</strong></summary>

Yes. Official releases from `v1.0.5` onward are signed with an Apple Developer ID certificate and notarized by Apple, so they open without Gatekeeper warnings. If you are using an older version (`v1.0.4` or earlier), please update to the latest release.

</details>

<details>
<summary><strong>My Google TV / Android TV does not appear in the device list</strong></summary>

1. Verify your Mac and TV are on the same Wi-Fi network / subnet.
2. Check **System Settings → Privacy & Security → Local Network** and ensure **GTV Remote** is allowed.
3. Confirm **Android TV Remote Service** is enabled on your TV and click **Rescan Devices** in the app header.

</details>

<details>
<summary><strong>How do Quick Apps custom deep links work?</strong></summary>

Open **Quick Apps Settings** to reorder presets via drag-and-drop, toggle visibility, or add custom apps using `https://` or `app://` deep link URIs. The first 9 visible apps map directly to keyboard keys `1` through `9`.

</details>

<details>
<summary><strong>Does GTV Remote collect analytics or send data to external servers?</strong></summary>

No. All communication happens directly between your Mac and TV on your local network using mutual TLS and a locally generated RSA-2048 certificate. See [SECURITY.md](SECURITY.md).

</details>

<details>
<summary><strong>Which TVs and macOS versions are supported?</strong></summary>

Any TV or streaming device supporting Google TV / Android TV Remote v2 (Chromecast with Google TV, Sony Bravia, TCL, Hisense, Nvidia Shield, etc.) and Macs running **macOS 14.0 (Sonoma)** or later (prebuilt releases for Apple Silicon; Intel Macs via building from source).

</details>

---

## Project Structure

```
gtv-remote/
├── .github/
│   ├── ISSUE_TEMPLATE/               # Bug report, feature request & config
│   ├── PULL_REQUEST_TEMPLATE.md      # Pull request checklist template
│   └── workflows/
│       ├── pages.yml                 # Automated GitHub Pages deployment
│       └── release.yml               # Automated CI/CD release workflow
├── AGENTS.md                         # Guidelines for AI agents and developers
├── CONTRIBUTING.md                   # Contribution & build guide
├── LICENSE                           # MIT License
├── Makefile                          # Release packaging and deployment script
├── Package.swift                     # Swift Package Manager manifest
├── README.md                         # Project documentation
├── SECURITY.md                       # Privacy architecture & vulnerability reporting
├── Resources/
│   ├── AppIcon.icns                  # macOS application bundle icon
│   └── Info.plist                    # Bundle configuration and permissions
├── Sources/
│   └── GTVRemote/
│       ├── App/                      # Application entry & keyboard event monitor
│       │   ├── GTVRemote.swift
│       │   └── KeyboardMonitor.swift
│       ├── Core/
│       │   ├── Network/              # mDNS discovery & NIO TLS socket bridge
│       │   │   ├── BonjourResolver.swift
│       │   │   ├── DeviceDiscoveryService.swift
│       │   │   ├── TLSSocketBridge.swift
│       │   │   └── TVConnectionManager.swift
│       │   ├── Proto/                # Protobuf protocol bindings
│       │   │   ├── pairing.pb.swift
│       │   │   └── remote.pb.swift
│       │   └── Security/             # RSA-2048 certificate generation
│       │       └── CertificateManager.swift
│       ├── Localization/             # 7-language localization engine
│       │   ├── Languages/            # Language-specific string implementations
│       │   ├── L10n.swift
│       │   ├── LocalizableStrings.swift # Protocol defining localized string keys
│       │   └── LocalizationManager.swift
│       ├── Models/                   # Data structures & App Shortcut catalog
│       │   ├── AppShortcut.swift
│       │   ├── Models.swift
│       │   └── RemoteKey.swift
│       ├── ViewModels/               # Observable remote business logic
│       │   └── RemoteViewModel.swift
│       └── Views/                    # SwiftUI interface & Sheets
│           ├── Components/
│           │   ├── DPadView.swift
│           │   ├── RemoteButtonStyles.swift
│           │   └── SmartInputBar.swift
│           ├── Sheets/
│           │   ├── AppShortcutsSettingsView.swift
│           │   ├── PairingSheetView.swift
│           │   └── ShortcutsView.swift
│           └── RemoteControlView.swift
├── assets/                           # Screenshots and documentation media
│   ├── app_icon.png
│   ├── keyboard_shortcuts.png
│   ├── quick_apps_settings.png
│   └── remote_main.png
├── docs/                             # Localized documentation
│   ├── README.de.md                  # Deutsch
│   ├── README.es.md                  # Español
│   ├── README.fr.md                  # Français
│   ├── README.ja.md                  # 日本語
│   ├── README.ko.md                  # 한국어
│   └── README.zh-Hans.md             # 简体中文
└── site/                             # GitHub Pages promotional website
    ├── index.html
    ├── styles.css
    └── i18n.js
```

---

## Contributing & Security

- Contributions are welcome! Please read [CONTRIBUTING.md](CONTRIBUTING.md) for local build instructions, 7-language localization rules, and PR guidelines.
- To learn about our local-only privacy architecture or report a security issue, see [SECURITY.md](SECURITY.md).

---

## Open Source License

This project is licensed under the **MIT License**. See the [LICENSE](LICENSE) file for details.
