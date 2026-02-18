# Release Prep Runbook

This runbook prepares and publishes `v0.1.0` once you are ready to push to GitHub.

## 1. Validate Locally
- Open Xcode project: `SwiftUIAccessibilityLab.xcodeproj`
- Build app in `develop`
- Run all tests: `Cmd + U`
- Perform manual VoiceOver pass on all 5 examples
- Fill in `docs/VOICEOVER-AUDIT-v0.1.0.md`
- Confirm zero warnings in Xcode

## 2. Final Documentation Pass
- Update screenshots in `README.md` and `docs/screenshots/`
- Confirm links in `README.md` and `CONTRIBUTING.md`
- Confirm `docs/IMPLEMENTATION-CHECKLIST.md` launch section
- Review `docs/RELEASE-NOTES-v0.1.0.md`
- Attach completed `docs/VOICEOVER-AUDIT-v0.1.0.md` to release notes or PR context

## 3. Repository Setup (When Creating Remote)
- Create GitHub repository for `SwiftUIAccessibilityLab`
- Add remote and push `main`, `develop`, and feature branches as needed
- Replace placeholder URLs in:
  - `README.md`
  - `CONTRIBUTING.md`
  - `.github/ISSUE_TEMPLATE/config.yml`

## 4. Release Steps
- Merge `develop` into `main` (your preferred workflow)
- Tag release:
  - `git tag v0.1.0`
- Push tag:
  - `git push origin v0.1.0`
- Create GitHub Release using `docs/RELEASE-NOTES-v0.1.0.md`
- Attach screenshots and highlight MVP scope

## 5. Post-Release Checks
- Open release page and verify links
- Confirm issue templates and PR template load correctly
- Track first bug reports and discussion items

## 6. Suggested Follow-Up Branches
- `feature/ui-tests-coverage` (expand UI assertions)
- `feature/voiceover-manual-audit-notes` (document findings)
- `feature/readme-screenshots` (final visual polish)
