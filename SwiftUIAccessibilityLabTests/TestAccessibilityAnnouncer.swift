@testable import SwiftUIAccessibilityLab

@MainActor
final class TestAccessibilityAnnouncer: AccessibilityAnnouncing {
    private(set) var messages: [String] = []

    func announce(_ message: String) {
        messages.append(message)
    }
}
