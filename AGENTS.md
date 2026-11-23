# Agent Guidelines for GTV Remote

Guide for AI coding assistants and contributors working on **GTV Remote**.

## 1. Core Operating Principles

1. **State Actions First**: Briefly state what action or tool call you are about to execute before doing it.
2. **Explicit Approval for Repo Actions**: NEVER commit, push, create tags, or publish releases without prior explicit user confirmation.
3. **Clarify Critical Decisions**: Ask before making substantial architectural changes, deleting files, or removing functionality.
4. **Concise & Direct**: Answer only what was asked; no preamble, fluff, or flattery.
5. **Versioning Policy**:
   - `X.0.0` (Major): Major architectural redesigns or breaking changes.
   - `0.X.0` (Minor): New features or substantial feature modifications.
   - `0.0.X` (Patch): Bug fixes, corrections, and minor maintenance.
6. **Verify & Launch**: After local code edits, run `make install` to build, install, and launch the app for immediate testing.

## 2. Project & Documentation Map

**GTV Remote** is a native macOS (14.0+, Swift 5.10+) SwiftUI/AppKit app controlling Google TV / Android TV over local mTLS (Google TV Remote Protocol v2).

For details, refer to the dedicated docs instead of duplicating them here:
- **Features, Shortcuts & FAQ**: [README.md](README.md)
- **Build Commands, Localization & PR Workflow**: [CONTRIBUTING.md](CONTRIBUTING.md)
- **Tech Stack, Directory Layout & Protocol/Deep-Link Notes**: [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md)
- **Privacy & Local-Only Data Flow**: [SECURITY.md](SECURITY.md)
