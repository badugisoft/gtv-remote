# Security & Privacy Policy

## Supported Versions

| Version | Supported |
| :--- | :--- |
| `1.0.x` | Yes |

## Privacy & Data Flow Architecture

**GTV Remote** is designed to operate strictly on your local area network (LAN):

- **Local-Only Communication**: All device discovery (`_androidtvremote2._tcp` via Bonjour/mDNS) and remote control traffic (mutual TLS over ports `6466` and `6467`) happen directly between your Mac and your TV on the local network.
- **No Telemetry or External Servers**: GTV Remote does not collect analytics, crash telemetry, or usage data, and makes no connections to external servers.
- **Client Certificates**: Transient RSA-2048 client certificates used for Android TV Remote v2 mutual TLS pairing are generated locally via Apple's `Security.framework`.
- **Local Preferences**: Last connected device metadata, UI language selection, and custom Quick App shortcuts are stored locally via `UserDefaults`.

## Reporting a Vulnerability

If you discover a security vulnerability in **GTV Remote**:

- Please use **GitHub Private Vulnerability Reporting** on the repository's **Security** tab (`https://github.com/badugisoft/gtv-remote/security/advisories/new`) if enabled, or open an issue without disclosing sensitive exploit details and request a private channel.
- Include a clear description of the issue, affected versions, and steps to reproduce.
