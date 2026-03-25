import SwiftUI

struct QuantityControlExampleContainer: View {
    var body: some View {
        ExampleContainer(
            route: .quantityControl,
            metadata: QuantityControlExampleMetadata.value,
            accessibleView: { QuantityControlView_Accessible() },
            inaccessibleView: { QuantityControlView_Inaccessible() }
        )
    }
}

#Preview {
    NavigationStack {
        QuantityControlExampleContainer()
    }
}
