import Foundation
import Observation

@Observable
/// Stores user preference values for the settings example and emits accessibility feedback.
final class SettingsViewModel {
    var notificationsEnabled = true
    var emailNotifications = false
    var shareAnalytics = false
    var theme: Theme = .system

    var statusMessage: String?

    /// Simulates cache cleanup and announces completion.
    func clearCache() {
        statusMessage = "Cache cleared"
        AccessibilityHelpers.announce("Cache cleared")
    }

    /// Simulates account deletion and announces completion.
    func deleteAccount() async {
        try? await Task.sleep(for: .seconds(1))
        statusMessage = "Account deleted"
        AccessibilityHelpers.announce("Account deleted")
    }
}
