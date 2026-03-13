import Foundation
import Observation
import OSLog

@MainActor
@Observable
/// Manages login form state and validation for the login example.
final class LoginViewModel {
    private let announcer: any AccessibilityAnnouncing
    private let announcesErrors: Bool

    var email = ""
    var password = ""
    var isLoading = false
    var errorMessage: String?
    var showPassword = false

    init(
        announcer: any AccessibilityAnnouncing = SystemAccessibilityAnnouncer(),
        announcesErrors: Bool = true
    ) {
        self.announcer = announcer
        self.announcesErrors = announcesErrors
    }

    var isFormValid: Bool {
        !email.isEmpty && !password.isEmpty && email.contains("@")
    }

    /// Toggles whether password text is visible in the UI.
    func togglePasswordVisibility() {
        showPassword.toggle()
    }

    /// Simulates an async login request and updates error/loading state.
    func login() async {
        AppLogger.login.debug("login started formValid=\(self.isFormValid)")
        guard isFormValid else {
            errorMessage = "Please enter a valid email and password."
            if announcesErrors {
                announcer.announce("Error: Please enter a valid email and password.")
            }
            return
        }

        errorMessage = nil
        isLoading = true
        defer { isLoading = false }

        do {
            try await Task.sleep(for: .seconds(1))
            try Task.checkCancellation()
        } catch {
            AppLogger.login.debug("login cancelled")
            return
        }

        if email == "test@example.com" && password == "password" {
            errorMessage = nil
            AppLogger.login.debug("login succeeded")
        } else {
            errorMessage = "Invalid email or password."
            AppLogger.login.debug("login failed")
            if announcesErrors {
                announcer.announce("Error: Invalid email or password.")
            }
        }
    }
}
