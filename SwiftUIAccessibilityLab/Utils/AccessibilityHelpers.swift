import UIKit

@MainActor
/// Centralized accessibility utilities used by examples and view models.
enum AccessibilityHelpers {
    /// Announces a short message to assistive technologies.
    static func announce(_ message: String) {
        UIAccessibility.post(notification: .announcement, argument: message)
    }

    /// Notifies assistive technologies that the UI layout changed.
    static func layoutChanged() {
        UIAccessibility.post(notification: .layoutChanged, argument: nil)
    }

    /// Indicates if VoiceOver is currently enabled.
    static var isVoiceOverRunning: Bool {
        UIAccessibility.isVoiceOverRunning
    }

    /// Indicates if Reduce Motion is currently enabled.
    static var isReduceMotionEnabled: Bool {
        UIAccessibility.isReduceMotionEnabled
    }
}
