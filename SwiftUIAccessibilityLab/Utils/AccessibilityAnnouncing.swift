import UIKit

protocol AccessibilityAnnouncing {
    @MainActor
    func announce(_ message: String)
}

struct SystemAccessibilityAnnouncer: AccessibilityAnnouncing {
    @MainActor
    func announce(_ message: String) {
        UIAccessibility.post(notification: .announcement, argument: message)
    }
}
