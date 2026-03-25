import SwiftUI

struct CustomRotorExampleContainer: View {
    var body: some View {
        ExampleContainer(
            route: .customRotor,
            metadata: CustomRotorExampleMetadata.value,
            accessibleView: { CustomRotorView_Accessible() },
            inaccessibleView: { CustomRotorView_Inaccessible() }
        )
    }
}

#Preview {
    NavigationStack {
        CustomRotorExampleContainer()
    }
}
