import Foundation
import Observation

@Observable
final class LoginViewModel {
    var email = ""
    var password = ""
    var isLoading = false
    var errorMessage: String?
    var showPassword = false

    var isFormValid: Bool {
        !email.isEmpty && !password.isEmpty && email.contains("@")
    }

    func togglePasswordVisibility() {
        showPassword.toggle()
    }

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
