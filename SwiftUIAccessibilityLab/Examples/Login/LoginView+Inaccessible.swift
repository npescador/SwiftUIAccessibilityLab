import SwiftUI

struct LoginView_Inaccessible: View {
    @State private var viewModel = LoginViewModel(announcesErrors: false)

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Welcome back")
                .font(.title2)
                .fontWeight(.semibold)

            TextField("Email", text: $viewModel.email)
                .textInputAutocapitalization(.never)
                .keyboardType(.emailAddress)
                .textContentType(.emailAddress)
                .autocorrectionDisabled()
                .font(.title3.weight(.medium))
                .labFieldChrome()
            // Missing: explicit accessibility label and hint.

            SecureField("Password", text: $viewModel.password)
                .textContentType(.password)
                .font(.title3.weight(.medium))
                .labFieldChrome()
            // Missing: password visibility state.

            Button("Show") {
                viewModel.togglePasswordVisibility()
            }
            .font(.body.weight(.semibold))
            .labSecondaryButtonChrome()
            // Missing: clear label and hint.

            Button {
                Task { await viewModel.login() }
            } label: {
                if viewModel.isLoading {
                    ProgressView()
                } else {
                    Text("Log in")
                }
            }
            .font(.body.weight(.semibold))
            .labPrimaryButtonChrome(isEnabled: viewModel.isFormValid && !viewModel.isLoading)
            .disabled(!viewModel.isFormValid || viewModel.isLoading)
            // Missing: context-specific label and hint.

            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundStyle(.red)
                // Missing: VoiceOver announcement for errors.
            }

            Button("Forgot password?") {
            }
            .buttonStyle(.plain)
            // Missing: hint about navigation.
        }
        .padding()
    }
}

#Preview {
    LoginView_Inaccessible()
}
