import SwiftUI

struct LoginView_Inaccessible: View {
    @State private var viewModel = LoginViewModel()

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
            // Missing: explicit accessibility label and hint.

            SecureField("Password", text: $viewModel.password)
                .textContentType(.password)
            // Missing: password visibility state.

            Button("Show") {
                viewModel.togglePasswordVisibility()
            }
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
            .buttonStyle(.borderedProminent)
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
