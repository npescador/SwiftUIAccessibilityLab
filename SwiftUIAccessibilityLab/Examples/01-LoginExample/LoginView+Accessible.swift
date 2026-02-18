import SwiftUI

struct LoginView_Accessible: View {
    @State private var viewModel = LoginViewModel()

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Welcome back")
                .font(.title2)
                .fontWeight(.semibold)
                .accessibilityAddTraits(.isHeader)

            emailField
            passwordField
            showPasswordButton

            loginButton

            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundStyle(.red)
                    .accessibilityLabel("Error: \(errorMessage)")
                    .onAppear {
                        AccessibilityHelpers.announce("Error: \(errorMessage)")
                    }
            }

            Button("Forgot password?") {
            }
            .buttonStyle(.plain)
            .accessibilityHint("Opens password recovery")
        }
        .padding()
    }

    private var emailField: some View {
        TextField("Email", text: $viewModel.email)
            .textInputAutocapitalization(.never)
            .keyboardType(.emailAddress)
            .textContentType(.emailAddress)
            .autocorrectionDisabled()
            .accessibilityLabel("Email address")
            .accessibilityHint("Enter your email to log in")
            .accessibilityValue(viewModel.email.isEmpty ? "Empty" : viewModel.email)
    }

    private var passwordField: some View {
        Group {
            if viewModel.showPassword {
                TextField("Password", text: $viewModel.password)
            } else {
                SecureField("Password", text: $viewModel.password)
            }
        }
        .textContentType(.password)
        .accessibilityLabel("Password")
        .accessibilityValue(viewModel.showPassword ? "Visible" : "Hidden")
        .accessibilityHint("Enter your password")
    }

    private var showPasswordButton: some View {
        Button(viewModel.showPassword ? "Hide password" : "Show password") {
            viewModel.togglePasswordVisibility()
        }
        .buttonStyle(.bordered)
        .accessibilityHint("Toggles password visibility")
    }

    private var loginButton: some View {
        Button {
            Task { await viewModel.login() }
        } label: {
            if viewModel.isLoading {
                ProgressView()
                    .accessibilityLabel("Logging in")
            } else {
                Text("Log in")
            }
        }
        .buttonStyle(.borderedProminent)
        .disabled(!viewModel.isFormValid || viewModel.isLoading)
        .accessibilityLabel("Log in")
        .accessibilityHint("Logs you into your account")
        .accessibilityValue(viewModel.isFormValid ? "Ready" : "Missing required fields")
    }
}

#Preview {
    LoginView_Accessible()
}
