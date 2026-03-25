import Foundation
import Observation

@MainActor
@Observable
/// Provides article content for the Custom Rotor lab.
final class CustomRotorViewModel {
    struct Section: Identifiable {
        let id: UUID
        let heading: String
        let body: String

        init(id: UUID = UUID(), heading: String, body: String) {
            self.id = id
            self.heading = heading
            self.body = body
        }
    }

    let articleTitle = "The iOS Accessibility Handbook"
    let articleByline = "SwiftUI Accessibility Lab"
    let articleDate = "March 2026"
    let readTime = "8 min read"

    let sections: [Section] = [
        Section(
            heading: "Introduction",
            body: "Accessibility is the practice of designing apps that work for everyone. Apple provides a rich set of frameworks and APIs that make it possible to build truly inclusive iOS experiences with relatively little extra effort."
        ),
        Section(
            heading: "VoiceOver Fundamentals",
            body: "VoiceOver is Apple's built-in screen reader. It reads aloud every element on the screen and lets users navigate with swipe gestures, a Bluetooth keyboard, or a braille display. Understanding how VoiceOver traverses your view hierarchy is the foundation of everything else."
        ),
        Section(
            heading: "Labels, Values and Traits",
            body: "Every interactive element needs a clear label describing what it is, and a value describing its current state. Traits like isHeader, isButton, or isSelected give VoiceOver semantic context that shapes how it announces and behaves."
        ),
        Section(
            heading: "Custom Controls",
            body: "When standard controls do not meet your design requirements, you can build custom ones using accessibilityAdjustableAction for step-based inputs, or accessibilityRepresentation to map your custom UI to a native control that VoiceOver already knows how to interact with."
        ),
        Section(
            heading: "Dynamic Type",
            body: "Supporting Dynamic Type means using text styles instead of fixed font sizes, and designing layouts that adapt gracefully to all size categories — including the five accessibility sizes that go well beyond the standard range."
        ),
        Section(
            heading: "Testing Your Work",
            body: "Manual testing with VoiceOver, Voice Control, Full Keyboard Access, and Switch Control is essential. Automated tests using XCUIApplication.performAccessibilityAudit() catch regressions before they reach users."
        ),
    ]
}
