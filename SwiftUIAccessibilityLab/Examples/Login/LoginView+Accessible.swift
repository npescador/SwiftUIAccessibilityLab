import SwiftUI

struct LoginView_Accessible: View {
    @State private var viewModel = LoginViewModel(announcesErrors: true)
    @AccessibilityFocusState private var isErrorFocused: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Welcome back")
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundStyle(LabTheme.titleColor)
                .accessibilityAddTraits(.isHeader)

            emailField
            passwordField
            showPasswordButton

            loginButton

            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundStyle(LabTheme.dangerColor)
                    .accessibilityIdentifier("login.error.message")
                    .accessibilityLabel("Error: \(errorMessage)")
                    .accessibilityFocused($isErrorFocused)
            }

            Button("Forgot password?") {
            }
            .buttonStyle(.plain)
            .foregroundStyle(LabTheme.titleColor)
            .accessibilityIdentifier("login.forgot.button")
            .accessibilityHint("Opens password recovery")
        }
        .padding()
        .tint(LabTheme.titleColor)
        .onChange(of: viewModel.errorMessage) { _, newValue in
            if newValue != nil {
                isErrorFocused = true
            }
        }
    }

    private var emailField: some View {
        TextField("Email", text: $viewModel.email)
            .textInputAutocapitalization(.never)
            .keyboardType(.emailAddress)
            .textContentType(.emailAddress)
            .autocorrectionDisabled()
            .font(.title3.weight(.medium))
            .labFieldChrome()
            .accessibilityIdentifier("login.email.field")
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
        .font(.title3.weight(.medium))
        .labFieldChrome()
        .accessibilityIdentifier("login.password.field")
        .accessibilityLabel("Password")
        .accessibilityValue(viewModel.showPassword ? "Visible" : "Hidden")
        .accessibilityHint("Enter your password")
    }

    private var showPasswordButton: some View {
        Button(viewModel.showPassword ? "Hide password" : "Show password") {
            viewModel.togglePasswordVisibility()
        }
        .font(.body.weight(.semibold))
        .labSecondaryButtonChrome()
        .accessibilityIdentifier("login.password.visibility.button")
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
        .font(.body.weight(.semibold))
        .labPrimaryButtonChrome(isEnabled: viewModel.isFormValid && !viewModel.isLoading)
        .disabled(!viewModel.isFormValid || viewModel.isLoading)
        .accessibilityIdentifier("login.submit.button")
        .accessibilityLabel("Log in")
        .accessibilityHint("Logs you into your account")
        .accessibilityValue(viewModel.isFormValid ? "Ready" : "Missing required fields")
    }
}

#Preview {
    LoginView_Accessible()
}
