import Testing
@testable import SwiftUIAccessibilityLab

@MainActor
@Suite("SettingsViewModel")
struct SettingsViewModelTests {
    @Test("Default values are set")
    func defaults() {
        let viewModel = SettingsViewModel(announcer: TestAccessibilityAnnouncer())

        #expect(viewModel.notificationsEnabled)
        #expect(viewModel.emailNotifications == false)
        #expect(viewModel.shareAnalytics == false)
        #expect(viewModel.theme == .system)
    }

    @Test("Clear cache updates status message")
    func clearCache() {
        let announcer = TestAccessibilityAnnouncer()
        let viewModel = SettingsViewModel(announcer: announcer)

        viewModel.clearCache()

        #expect(viewModel.statusMessage == "Cache cleared")
        #expect(announcer.messages == ["Cache cleared"])
    }

    @Test("Delete account updates status message")
    func deleteAccount() async {
        let announcer = TestAccessibilityAnnouncer()
        let viewModel = SettingsViewModel(announcer: announcer)

        await viewModel.deleteAccount()

        #expect(viewModel.statusMessage == "Account deleted")
        #expect(announcer.messages == ["Account deleted"])
    }
}
