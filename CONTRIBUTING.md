# Contributing to GTV Remote

Thank you for your interest in contributing to **GTV Remote**!

## Prerequisites

- **macOS 14.0 (Sonoma)** or later
- **Xcode 16+** or **Swift 6.0+** Command Line Tools

## Development & Build Commands

Clone the repository and use the provided `Makefile` targets from the repository root:

```bash
# Build debug binary
make build-debug

# Build debug binary and run in foreground (terminal stdout/stderr)
make run

# Build release binary
make build

# Build release binary, package into /Applications/GTV Remote.app, and launch
make install

# Package .app, .dmg, and .zip into dist/
make package

# Clean build artifacts
make clean
```

## Coding & Localization Conventions

1. **Architecture**:
   - Keep networking (`Core/Network/`), protocol bindings (`Core/Proto/`), security (`Core/Security/`), view models (`ViewModels/`), and SwiftUI views (`Views/`) cleanly separated.
   - Review [AGENTS.md](AGENTS.md) for repository conventions and versioning rules.
2. **7-Language Localization**:
   - All user-facing strings must be defined in `Sources/GTVRemote/Localization/LocalizableStrings.swift` and implemented across all 7 language files in `Sources/GTVRemote/Localization/Languages/` (`English.swift`, `Korean.swift`, `Chinese.swift`, `Japanese.swift`, `German.swift`, `French.swift`, `Spanish.swift`).
   - Run `make build` to verify compile-time protocol conformance for all languages.
3. **Documentation**:
   - When adding or modifying features, update `README.md`, `docs/README.*.md`, `site/`, and `AGENTS.md` accordingly.

## Pull Request Workflow

1. Fork the repository and create a feature or fix branch from `main`.
2. Make focused, well-tested changes and verify `make build` succeeds without errors.
3. Open a Pull Request using the repository PR template and clearly describe what changed and how it was tested.
