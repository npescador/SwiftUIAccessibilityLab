import SwiftUI

struct LoginExampleContainer: View {
    var body: some View {
        ExampleContainer(
            route: .login,
            metadata: LoginExampleMetadata.value,
            accessibleView: { LoginView_Accessible() },
            inaccessibleView: { LoginView_Inaccessible() }
        )
    }
}

#Preview {
    NavigationStack {
        LoginExampleContainer()
    }
}
