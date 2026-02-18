import SwiftUI

struct CustomControlExampleContainer: View {
    var body: some View {
        ExampleContainer(
            metadata: CustomControlExampleMetadata.value,
            accessibleView: { CustomControlView_Accessible() },
            inaccessibleView: { CustomControlView_Inaccessible() }
        )
    }
}

#Preview {
    NavigationStack {
        CustomControlExampleContainer()
    }
}
