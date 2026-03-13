import Testing
@testable import SwiftUIAccessibilityLab

@MainActor
@Suite("LoginViewModel")
struct LoginViewModelTests {
    @Test("Form is invalid when fields are empty")
    func invalidWhenEmpty() {
        let viewModel = LoginViewModel(announcer: TestAccessibilityAnnouncer())

        #expect(viewModel.isFormValid == false)
    }

    @Test("Form is valid with email and password")
    func validWithCredentials() {
        let viewModel = LoginViewModel(announcer: TestAccessibilityAnnouncer())
        viewModel.email = "test@example.com"
        viewModel.password = "password"

        #expect(viewModel.isFormValid)
    }

    @Test("Toggle password visibility")
    func togglePasswordVisibility() {
        let viewModel = LoginViewModel(announcer: TestAccessibilityAnnouncer())

        #expect(viewModel.showPassword == false)
        viewModel.togglePasswordVisibility()
        #expect(viewModel.showPassword == true)
    }

    @Test("Login fails with invalid credentials")
    func loginFails() async {
        let announcer = TestAccessibilityAnnouncer()
        let viewModel = LoginViewModel(announcer: announcer)
        viewModel.email = "invalid@example.com"
        viewModel.password = "wrong"

        await viewModel.login()

        #expect(viewModel.errorMessage == "Invalid email or password.")
        #expect(viewModel.isLoading == false)
        #expect(announcer.messages == ["Error: Invalid email or password."])
    }

    @Test("Invalid form announces validation error")
    func invalidFormAnnouncement() async {
        let announcer = TestAccessibilityAnnouncer()
        let viewModel = LoginViewModel(announcer: announcer)

        await viewModel.login()

        #expect(viewModel.errorMessage == "Please enter a valid email and password.")
        #expect(announcer.messages == ["Error: Please enter a valid email and password."])
    }

    @Test("Inaccessible variant can suppress error announcements")
    func suppressedAnnouncementMode() async {
        let announcer = TestAccessibilityAnnouncer()
        let viewModel = LoginViewModel(announcer: announcer, announcesErrors: false)
        viewModel.email = "invalid@example.com"
        viewModel.password = "wrong"

        await viewModel.login()

        #expect(viewModel.errorMessage == "Invalid email or password.")
        #expect(announcer.messages.isEmpty)
    }
}
