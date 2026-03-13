# Technical Architecture

**Project:** SwiftUI Accessibility Lab  
**Updated:** 2026-03-10

## Purpose

This project teaches accessibility by comparing inaccessible and corrected SwiftUI implementations of the same flow. The architecture favors clarity and testability over abstraction depth.

## Core Decisions

### 1. Single catalog source of truth

`ExampleCatalog` owns the canonical list of examples:

- route
- title and metadata
- catalog order

Views, metadata wrappers, and tests read from that catalog so titles and navigation do not drift over time.

### 2. Shared example shell

`ExampleContainer` provides:

- screen title and description
- difficulty/category display
- variant switching between accessible and inaccessible implementations
- a stable screen identifier used by UI tests

Each example feature only supplies its own content.

### 3. SwiftUI + Observation

The app uses:

- SwiftUI as the UI framework
- `@Observable` for mutable presentation models
- `@State` for owning observable ViewModels inside views
- `NavigationStack` for catalog navigation

ViewModels that mutate UI-facing state are `@MainActor` to stay compatible with strict concurrency and their UI responsibilities.

### 4. Accessibility announcement boundary

Announcements are split by layer:

- `AccessibilityAnnouncing`
  Protocol used by ViewModels
- `SystemAccessibilityAnnouncer`
  UIKit-backed production implementation
- `AccessibilityHelpers`
  Convenience API for view-level actions that still need direct UI accessibility hooks

This keeps UIKit out of most business and presentation logic and makes announcement behavior testable with spies.

## Runtime Structure

### App layer

- `SwiftUIAccessibilityLabApp`
  App entry point
- `ContentView`
  Catalog screen driven by `ExampleCatalog`

### Feature layer

Each feature folder contains:

- one container view
- one accessible view
- one inaccessible view
- one ViewModel
- optional feature-specific components

### Shared layer

- `ExampleContainer`
- `ComparisonToggle`
- `DifficultyBadge`
- `CategoryCard`

### Support layer

- `ExampleCatalog`
- `MockData`
- `AccessibilityAnnouncing`
- `AccessibilityHelpers`

## Testing Strategy

### Unit tests

Swift Testing covers:

- catalog integrity
- ViewModel logic
- announcement side effects through test announcers

### UI tests

XCTest UI tests cover:

- catalog smoke navigation
- opening every MVP example
- stable accessibility identifiers
- representative accessibility contracts such as labels and values

The current test suite is designed to verify the educational promise of the app without relying on brittle implementation details.

## Current Constraints

- iOS only
- no persistence layer yet
- no localization yet
- examples are hand-authored MVP scenarios, not data-driven modules

These are conscious scope limits, not hidden architecture gaps.

## Near-Term Extension Path

New examples should be added by:

1. registering a new route + metadata entry in `ExampleCatalog`
2. adding the feature container and two variant views
3. adding ViewModel tests
4. adding at least one UI accessibility contract check

That workflow is the expected extension mechanism for the current codebase.
