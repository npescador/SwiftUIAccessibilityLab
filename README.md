# SwiftUI Accessibility Lab

SwiftUI Accessibility Lab is an educational iOS app that teaches accessibility through paired examples: each scenario includes an intentionally inaccessible version and a corrected accessible version.

## Current Status

- MVP examples implemented: `5/5`
- Shared catalog and navigation backed by a single source of truth
- SwiftUI + Observation architecture with Swift 6 settings
- Unit tests for catalog and ViewModel logic
- UI smoke tests plus accessibility contract checks for the main examples

## Technical Baseline

- Xcode 26+
- Swift 6
- iOS 18.0+
- macOS 15.0+

## Implemented Examples

1. Login
2. Task List
3. Task Detail
4. Custom Control
5. Settings

Each example is presented inside a shared container with an `Accessible` / `Inaccessible` toggle so the difference is visible in code and in runtime behavior.

## Architecture Snapshot

- `Models/ExampleCatalog.swift`
  Canonical registry for routes and metadata.
- `Examples/*`
  Feature-specific views and ViewModels for each scenario.
- `SharedComponents/ExampleContainer.swift`
  Shared shell for metadata display and variant switching.
- `Utils/AccessibilityAnnouncing.swift`
  Announcement abstraction used by ViewModels.
- `Utils/AccessibilityHelpers.swift`
  UI-layer convenience wrapper for view-driven accessibility actions.

## Testing Strategy

The project currently uses two automated layers:

- Swift Testing for catalog and ViewModel behavior
- XCTest UI tests for navigation smoke coverage and accessibility contracts

Covered contracts include representative labels, values, identifiers, and accessible navigation across the five MVP examples.

## Run the App

```bash
open SwiftUIAccessibilityLab.xcodeproj
```

In Xcode:

1. Select the `SwiftUIAccessibilityLab` scheme.
2. Choose an iOS simulator.
3. Run the app with `Cmd + R`.
4. Enable VoiceOver in the simulator with `Cmd + F5`.

## Run Tests

```bash
xcodebuild test -scheme SwiftUIAccessibilityLab \
  -destination 'platform=iOS Simulator,name=iPhone 17 Pro'
```

## Project Structure

```text
SwiftUIAccessibilityLab/
├── SwiftUIAccessibilityLab/
│   ├── App/
│   ├── Examples/
│   ├── Models/
│   ├── Resources/
│   ├── SharedComponents/
│   └── Utils/
├── SwiftUIAccessibilityLabTests/
├── SwiftUIAccessibilityLabUITests/
└── docs/
```

## Roadmap

Planned work remains documented in `docs/ROADMAP.md` and related planning docs. Those files describe future direction; the README describes only the current implemented state.
