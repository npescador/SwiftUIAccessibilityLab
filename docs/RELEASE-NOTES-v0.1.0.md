# SwiftUI Accessibility Lab v0.1.0

## Summary
First MVP release of SwiftUI Accessibility Lab with 5 complete accessibility comparison examples.

## Included in v0.1.0
- Login example with accessible and inaccessible variants
- Task List example with row/actions accessibility patterns
- Task Detail example with edit mode and form accessibility
- Custom Control example with adjustable rating and accessible custom interactions
- Settings example with grouped sections, toggle state feedback, and destructive action guidance

## Core Platform Work
- Shared comparison architecture with `ExampleContainer` and `ComparisonToggle`
- Centralized example metadata model and catalog routing
- Accessibility utilities for VoiceOver announcements
- Structured project layout for examples, shared components, models, and utilities

## Test Coverage Added
- Swift Testing ViewModel suites for all 5 MVP examples
- UI smoke tests for catalog navigation and example opening flow
- Stable UI test targeting through accessibility identifiers on key controls

## Known Gaps Before Public Push
- Run full local test pass in Xcode (`Cmd + U`) on your machine
- Complete manual VoiceOver validation pass on each example
- Capture and add final screenshots for README and release entry
- Replace placeholder GitHub URLs after repository creation

## Upgrade Notes
- This is the first tagged MVP release for the project.
- No migration steps are required.
