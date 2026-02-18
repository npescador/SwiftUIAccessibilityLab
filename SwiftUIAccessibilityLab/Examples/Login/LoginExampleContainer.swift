import SwiftUI

struct LoginExampleContainer: View {
    var body: some View {
        ExampleContainer(
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
