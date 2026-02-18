import Testing
@testable import SwiftUIAccessibilityLab

@Suite("SettingsViewModel")
struct SettingsViewModelTests {
    @Test("Default values are set")
    func defaults() {
        let viewModel = SettingsViewModel()

        #expect(viewModel.notificationsEnabled)
        #expect(viewModel.emailNotifications == false)
        #expect(viewModel.shareAnalytics == false)
        #expect(viewModel.theme == .system)
    }

    @Test("Clear cache updates status message")
    @MainActor
    func clearCache() {
        let viewModel = SettingsViewModel()

        viewModel.clearCache()

        #expect(viewModel.statusMessage == "Cache cleared")
    }

    @Test("Delete account updates status message")
    @MainActor
    func deleteAccount() async {
        let viewModel = SettingsViewModel()

        await viewModel.deleteAccount()

        #expect(viewModel.statusMessage == "Account deleted")
    }
}
