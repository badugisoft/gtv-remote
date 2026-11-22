# Changelog

All notable changes to **GTV Remote** are documented in this file.

## [1.0.6] - 2026-11-23

### What's New
- **Retina DMG Installer**: Added a custom Retina-resolution (`1x`/`2x`) DMG installer background with a drag-to-`Applications` shortcut for effortless installation.
- **Updated Documentation**: Updated multi-language READMEs and website FAQs to reflect official Apple signing and notarization.

## [1.0.5] - 2026-11-23

### What's New
- **Signed & Notarized Releases**: Official `.app` and `.dmg` builds are now signed with an Apple Developer ID certificate and notarized by Apple, eliminating macOS Gatekeeper warnings.
- **Smart Local Signing**: Updated `Makefile` to automatically sign with a local `Developer ID Application` certificate when present, falling back to ad-hoc signing for contributors.
- **Website & Docs**: Added GitHub Pages promotional site and 7-language README guides.

## [1.0.4] - 2026-10-29

### Bug Fixes
- **Dynamic IP Tracking**: Automatically tracks IP address changes for paired TVs over Bonjour mDNS.
- **Certificate Rejection Handling**: Improved handling and recovery when a TV rejects a client certificate.

## [1.0.3] - 2026-10-16

### Bug Fixes
- **Pairing Secret Calculation**: Stripped leading null bytes from RSA modulus and exponent per the Polo specification to fix pairing failures on affected devices.

## [1.0.2] - 2026-09-29

### Bug Fixes
- **Pairing & Reconnection**: Resolved pairing handshake issues and preserved the auto-reconnect flag across connection state changes.
- **UI Fixes**: Fixed minor interface glitches in the remote window.

## [1.0.1] - 2026-09-15

### Bug Fixes
- **Keyboard Shortcuts**: Restored the keyboard shortcuts event monitor.

## [1.0.0] - 2026-09-15

### Initial Release
- Native macOS menu bar & floating HUD remote for Google TV / Android TV (Google TV Remote Protocol v2).
- Automatic Bonjour mDNS discovery, TLS pairing, D-pad & media controls, Quick Apps deep links, and 7-language localization.
