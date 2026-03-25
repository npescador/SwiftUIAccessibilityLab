# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

**SwiftUI Accessibility Lab** is an educational iOS app teaching accessibility through interactive side-by-side comparisons of intentionally broken vs. correctly implemented SwiftUI code. Every example ships two variants — `Accessible` and `Inaccessible` — so users can toggle between them and understand what correct accessibility looks like.

- **Requirements:** Xcode 26+, Swift 6, iOS 18.0+, macOS 15.0+
- **Zero external dependencies**

## Build & Test Commands

**Build/Run:** Open `SwiftUIAccessibilityLab.xcodeproj` in Xcode, select the `SwiftUIAccessibilityLab` scheme, then `Cmd+R`.

**Run all tests:**
```bash
xcodebuild test -scheme SwiftUIAccessibilityLab \
  -destination 'platform=iOS Simulator,name=iPhone 16 Pro'
```

**Run a single test file:**
```bash
xcodebuild test -scheme SwiftUIAccessibilityLab \
  -destination 'platform=iOS Simulator,name=iPhone 16 Pro' \
  -only-testing SwiftUIAccessibilityLabTests/LoginViewModelTests
```

**Enable VoiceOver in Simulator:** `Cmd+F5`

## Architecture

### Core Pattern: Feature Folder + MVVM + Comparison Container

Each example lives in `Examples/{Feature}/` and contains exactly:

```
{Feature}ExampleContainer.swift      — Wraps both variants in ExampleContainer
{Feature}ExampleMetadata.swift       — Static metadata (title, difficulty, patterns)
{Feature}View+Accessible.swift       — Correct accessibility implementation
{Feature}View+Inaccessible.swift     — Intentionally broken implementation
{Feature}ViewModel.swift             — @MainActor @Observable ViewModel
Components/                          — Optional feature-specific components
```

The `ExampleContainer` (in `SharedComponents/`) is a generic wrapper that handles the toggle UI, metadata display, and variant switching. Every example plugs into it identically:

```swift
ExampleContainer(
    route: .login,
    metadata: LoginExampleMetadata.value,
    accessibleView: { LoginView_Accessible() },
    inaccessibleView: { LoginView_Inaccessible() }
)
```

### Catalog as Single Source of Truth

`Models/ExampleCatalog.swift` is the canonical registry for all examples. Routes, metadata, and ordering all derive from it — never drift these independently. Tests verify catalog integrity.

### Accessibility Announcement Abstraction

UIKit's `UIAccessibility` is isolated behind a protocol:

- `AccessibilityAnnouncing` protocol — abstract interface for posting announcements
- `SystemAccessibilityAnnouncer` — production implementation using UIKit
- `TestAccessibilityAnnouncer` (in tests) — spy that records announcements for assertions

ViewModels accept `any AccessibilityAnnouncing` via their initializer, defaulting to `SystemAccessibilityAnnouncer()`. This keeps UIKit out of view code and makes announcement behavior testable.

### Navigation

`ContentView` uses a `NavigationStack` with `navigationDestination(for: ExampleRoute.self)`. `ExampleRoute` is a `String`-backed enum with one case per example. `ExampleRouteView` switches on the route to render the appropriate container.

### Design System

`LabTheme` (defined in `SharedComponents/CategoryCard.swift`) owns all design tokens:
- Color tokens via `LabTheme.Color.*`
- Spacing: XS/S/M/L/XL + `shellPadding`/`contentPadding`
- Corner radius: `large`/`medium`/`small`
- Minimum touch target: `compactControlHeight` = 44pt

View extensions (`labFieldChrome()`, `labPrimaryButtonChrome()`, etc.) apply consistent styling to controls.

## Testing

Uses **Swift Testing** framework (not XCTest) for unit tests. UI tests use XCTest.

- Unit tests live in `SwiftUIAccessibilityLabTests/` — one file per ViewModel
- UI tests live in `SwiftUIAccessibilityLabUITests/`
- Use `TestAccessibilityAnnouncer` to inject into ViewModels and verify announcements were posted

## Adding a New Example

1. Add a case to `ExampleRoute` and register it in `ExampleCatalog`
2. Create `Examples/{Feature}/` with the five files above
3. Implement the ViewModel with injected `AccessibilityAnnouncing`
4. Write the accessible variant first, then copy and deliberately break it for the inaccessible variant
5. Add unit tests covering ViewModel logic and announcement behavior
6. Add UI smoke tests verifying accessibility identifiers and navigation

## Project Language

All project artifacts must be written in technical English: source code, comments, documentation, CLAUDE.md, commit messages, and branch names.

## Git Conventions

- Single-line commits using the format `type: message`
- No Claude authorship in commits (`Co-Authored-By` is forbidden)

## Key Accessibility Patterns in This Codebase

- `.accessibilityElement(children: .combine)` — group complex rows into a single element
- `.accessibilityAddTraits(.isHeader)` — mark section headers for VoiceOver navigation
- `.accessibilityAdjustableAction` — swipe up/down for adjustable controls (star rating)
- `AccessibilityHelpers.announce()` — post VoiceOver announcements for dynamic changes
- `AccessibilityHelpers.isVoiceOverRunning` — conditionally change behavior for VoiceOver
