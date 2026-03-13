import SwiftUI

struct CustomControlExampleContainer: View {
    var body: some View {
        ExampleContainer(
            route: .customControl,
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
