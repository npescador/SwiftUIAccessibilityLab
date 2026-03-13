import UIKit

@MainActor
/// Centralized accessibility utilities used by examples and view models.
enum AccessibilityHelpers {
    private static let announcer: any AccessibilityAnnouncing = SystemAccessibilityAnnouncer()

    /// Announces a short message to assistive technologies.
    static func announce(_ message: String) {
        announcer.announce(message)
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
