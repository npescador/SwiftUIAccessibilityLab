# Task List Example

## What You Will Learn
- List row accessibility
- Swipe action alternatives
- Search field feedback
- Empty state announcements

## Accessibility Patterns Used
- accessibilityElement(children: .combine)
- accessibilityActions for swipe alternatives
- accessibilityLabel and accessibilityValue for state
- ContentUnavailableView combined labels

## Common Mistakes
- Reading each element separately
- Swipe-only actions with no VoiceOver alternative
- Missing state announcements

## VoiceOver Experience
Accessible version reads a single coherent row and exposes actions.
Inaccessible version reads separate elements and hides swipe actions.
