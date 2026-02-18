# Engineering Standards

This document defines the baseline engineering rules for SwiftUI Accessibility Lab.

## Architecture
- Use a pragmatic MVVM structure: `View` + `@Observable ViewModel` + `Model`.
- Keep feature code grouped under `Examples/<FeatureName>/`.
- Avoid unnecessary abstraction layers.
- Extract shared UI only when duplicated in multiple examples.

## Swift and Concurrency
- Use Swift Concurrency (`async/await`, `Task`, `TaskGroup`) for async work.
- Avoid GCD in new code.
- Keep UI mutation on the main actor when required.
- Prefer value types (`struct`) for models unless reference semantics are required.

## SwiftUI Practices
- Use `NavigationStack` for navigation.
- Avoid `AnyView` unless there is a proven need.
- Keep view bodies focused; move state transitions to ViewModels.
- Add `accessibilityIdentifier` for controls used in UI tests.

## Accessibility
- Every interactive control must expose clear labels.
- Provide `accessibilityValue` for dynamic state.
- Add hints for non-obvious actions.
- Announce meaningful state transitions (errors, saves, destructive actions).

## Documentation
- Use `///` docs for reusable/shared types and methods.
- Keep comments focused on intent and decisions.
- Keep `README` and `docs/` aligned with the implemented state.

## Testing
- Use Swift Testing for unit tests.
- Add and maintain UI smoke tests for critical navigation paths.
- Prefer deterministic test data.
- Treat failing tests as release blockers.

## Project Hygiene
- Maintain zero warnings in the app target.
- Keep release notes and release prep docs updated.
- Use feature branches prefixed with `feature/`.
- Merge changes into `develop` first.
