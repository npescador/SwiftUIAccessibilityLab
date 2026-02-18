import Testing
@testable import SwiftUIAccessibilityLab

@Suite("LoginViewModel")
struct LoginViewModelTests {
    @Test("Form is invalid when fields are empty")
    func invalidWhenEmpty() {
        let viewModel = LoginViewModel()

        #expect(viewModel.isFormValid == false)
    }

    @Test("Form is valid with email and password")
    func validWithCredentials() {
        let viewModel = LoginViewModel()
        viewModel.email = "test@example.com"
        viewModel.password = "password"

        #expect(viewModel.isFormValid)
    }

    @Test("Toggle password visibility")
    func togglePasswordVisibility() {
        let viewModel = LoginViewModel()

        #expect(viewModel.showPassword == false)
        viewModel.togglePasswordVisibility()
        #expect(viewModel.showPassword == true)
    }

    @Test("Login fails with invalid credentials")
    func loginFails() async {
        let viewModel = LoginViewModel()
        viewModel.email = "invalid@example.com"
        viewModel.password = "wrong"

        await viewModel.login()

        #expect(viewModel.errorMessage == "Invalid email or password.")
        #expect(viewModel.isLoading == false)
    }
}
