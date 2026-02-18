import Foundation
import Observation

@Observable
/// Manages login form state and validation for the login example.
final class LoginViewModel {
    var email = ""
    var password = ""
    var isLoading = false
    var errorMessage: String?
    var showPassword = false

    var isFormValid: Bool {
        !email.isEmpty && !password.isEmpty && email.contains("@")
    }

    /// Toggles whether password text is visible in the UI.
    func togglePasswordVisibility() {
        showPassword.toggle()
    }

    /// Simulates an async login request and updates error/loading state.
    func login() async {
        guard isFormValid else {
            errorMessage = "Please enter a valid email and password."
            return
        }

        errorMessage = nil
        isLoading = true
        defer { isLoading = false }

        try? await Task.sleep(for: .seconds(1))

        if email == "test@example.com" && password == "password" {
            errorMessage = nil
        } else {
            errorMessage = "Invalid email or password."
        }
    }
}
