import UIKit

@MainActor
enum AccessibilityHelpers {
    static func announce(_ message: String) {
        UIAccessibility.post(notification: .announcement, argument: message)
    }

    static func layoutChanged() {
        UIAccessibility.post(notification: .layoutChanged, argument: nil)
    }

    static var isVoiceOverRunning: Bool {
        UIAccessibility.isVoiceOverRunning
    }

    static var isReduceMotionEnabled: Bool {
        UIAccessibility.isReduceMotionEnabled
    }
}
