import SwiftUI

struct DynamicTypeExampleContainer: View {
    var body: some View {
        ExampleContainer(
            route: .dynamicType,
            metadata: DynamicTypeExampleMetadata.value,
            accessibleView: { DynamicTypeView_Accessible() },
            inaccessibleView: { DynamicTypeView_Inaccessible() }
        )
    }
}

#Preview {
    NavigationStack {
        DynamicTypeExampleContainer()
    }
}
