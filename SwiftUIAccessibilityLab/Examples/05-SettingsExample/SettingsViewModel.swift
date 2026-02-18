import Foundation
import Observation

@Observable
final class SettingsViewModel {
    var notificationsEnabled = true
    var emailNotifications = false
    var shareAnalytics = false
    var theme: Theme = .system

    var statusMessage: String?

    func clearCache() {
        statusMessage = "Cache cleared"
        AccessibilityHelpers.announce("Cache cleared")
    }

    func deleteAccount() async {
        try? await Task.sleep(for: .seconds(1))
        statusMessage = "Account deleted"
        AccessibilityHelpers.announce("Account deleted")
    }
}
