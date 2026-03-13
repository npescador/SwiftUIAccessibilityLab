import Foundation
import Observation
import OSLog

@MainActor
@Observable
/// Stores user preference values for the settings example and emits accessibility feedback.
final class SettingsViewModel {
    private let announcer: any AccessibilityAnnouncing

    var notificationsEnabled = true
    var emailNotifications = false
    var shareAnalytics = false
    var theme: Theme = .system

    var statusMessage: String?

    init(announcer: any AccessibilityAnnouncing = SystemAccessibilityAnnouncer()) {
        self.announcer = announcer
    }

    /// Simulates cache cleanup and announces completion.
    func clearCache() {
        statusMessage = "Cache cleared"
        AppLogger.settings.debug("clearCache")
        announcer.announce("Cache cleared")
    }

    /// Simulates account deletion and announces completion.
    func deleteAccount() async {
        AppLogger.settings.debug("deleteAccount started")
        do {
            try await Task.sleep(for: .seconds(1))
            try Task.checkCancellation()
        } catch {
            AppLogger.settings.debug("deleteAccount cancelled")
            return
        }

        statusMessage = "Account deleted"
        AppLogger.settings.debug("deleteAccount completed")
        announcer.announce("Account deleted")
    }
}
