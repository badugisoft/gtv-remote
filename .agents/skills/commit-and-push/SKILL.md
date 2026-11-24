---
name: commit-and-push
description: >-
  Standardized post-task workflow for reviewing changes, verifying builds,
  updating CHANGELOG.md, getting user confirmation, and committing/pushing to
  origin in GTV Remote.
---

# Commit and Push Workflow

Follow this checklist before committing and pushing any changes in **GTV Remote**.

## 1. Review Changes
- Run `git status -sb` and `git diff --stat` to verify only intended files are modified and no temporary or build artifacts are left behind.

## 2. Run Verification
- If Swift source code or build configuration changed, run `make install` (or `make build`) to verify Release compilation, signing, `/Applications/GTV Remote.app` installation, and app launch.

## 3. Sync Changelog & Documentation
- Update `CHANGELOG.md` for any notable feature, fix, or workflow change.
- If user-facing behavior, UI, or installation steps changed, ensure `README.md`, `docs/README.<lang>.md` (`ko`, `zh-Hans`, `ja`, `de`, `fr`, `es`), `AGENTS.md`, `docs/ARCHITECTURE.md`, and `site/` are synchronized as needed.

## 4. Ask for Confirmation (Mandatory)
- **NEVER execute `git commit` or `git push` without explicit user approval.**
- Present:
  1. The list of files to be staged and committed.
  2. The proposed Conventional Commit message (e.g., `feat: ...`, `fix: ...`, `docs: ...`, `ci: ...`, `chore: ...`).
- Wait for the user to confirm.

## 5. Commit and Push
- Once approved:
  ```bash
  git add <files>
  git commit -m "<type>: <summary>"
  git push origin main
  ```
