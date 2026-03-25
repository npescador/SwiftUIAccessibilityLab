import Accessibility
import Foundation

protocol AccessibilityAnnouncing {
    @MainActor
    func announce(_ message: String)
}

struct SystemAccessibilityAnnouncer: AccessibilityAnnouncing {
    @MainActor
    func announce(_ message: String) {
        var announcement = AttributedString(message)
        announcement.accessibilitySpeechAnnouncementPriority = .high
        AccessibilityNotification.Announcement(announcement).post()
    }
}
