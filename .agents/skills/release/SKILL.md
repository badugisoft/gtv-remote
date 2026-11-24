---
name: release
description: >-
  End-to-end release workflow for GTV Remote: version bump, CHANGELOG.md
  finalization, local build verification, tagging, and monitoring the notarized
  GitHub Actions release.
---

# Release Workflow

Follow this procedure when preparing and publishing a new release (`vX.Y.Z`) of **GTV Remote**.

## 1. Pre-flight Checks
- Ensure `main` is up to date (`git fetch --tags && git status -sb`) and the working tree is clean.
- Confirm the target version follows `AGENTS.md` versioning policy (`X.0.0` Major, `0.X.0` Minor, `0.0.X` Patch).

## 2. Bump Version
- Update `Resources/Info.plist`:
  - `CFBundleShortVersionString` → `X.Y.Z`
  - `CFBundleVersion` → increment integer build number by 1

## 3. Finalize `CHANGELOG.md`
- Add or finalize the `## [X.Y.Z] - YYYY-MM-DD` section at the top of `CHANGELOG.md` (with `### What's New` / `### Bug Fixes` bullets).
- Note: `.github/workflows/release.yml` automatically extracts the `## [X.Y.Z]` section from `CHANGELOG.md` as the GitHub Release notes.

## 4. Local Build & Verification
- Run `make install` (or `make package`) and verify:
  - Release build compiles cleanly (`swift build -c release`).
  - `GTV Remote.app` installs to `/Applications/GTV Remote.app` and launches cleanly.

## 5. Ask for Confirmation (Mandatory)
- **NEVER commit, tag, or push without explicit user approval.**
- Present the modified files (`Resources/Info.plist`, `CHANGELOG.md`), proposed commit message (`chore: bump version to X.Y.Z`), tag (`vX.Y.Z`), and release notes, then wait for confirmation.

## 6. Commit, Tag, and Push
- After approval:
  ```bash
  git add Resources/Info.plist CHANGELOG.md
  git commit -m "chore: bump version to X.Y.Z"
  git tag vX.Y.Z
  git push origin main --tags
  ```

## 7. Monitor GitHub Actions Release
- Pushing `vX.Y.Z` triggers `.github/workflows/release.yml`, which:
  1. Installs `create-dmg` and imports `MACOS_CERTIFICATE`.
  2. Runs `make package` to build and sign `dist/GTV Remote.app`, `.dmg`, and `.zip`.
  3. Notarizes (`xcrun notarytool`) and staples `.app` and `.dmg`, then prepares `dist/GTV-Remote-vX.Y.Z.dmg` and `dist/GTV-Remote-vX.Y.Z.zip`.
  4. Extracts release notes from `CHANGELOG.md` and publishes the GitHub Release.
- Monitor the workflow with `gh run list --workflow=release.yml` / `gh run watch` and verify the published release assets and notes.
