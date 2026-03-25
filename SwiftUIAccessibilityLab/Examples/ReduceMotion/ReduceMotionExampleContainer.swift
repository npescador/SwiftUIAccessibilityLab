import SwiftUI

struct ReduceMotionExampleContainer: View {
    var body: some View {
        ExampleContainer(
            route: .reduceMotion,
            metadata: ReduceMotionExampleMetadata.value,
            accessibleView: { ReduceMotionView_Accessible() },
            inaccessibleView: { ReduceMotionView_Inaccessible() }
        )
    }
}

#Preview {
    NavigationStack {
        ReduceMotionExampleContainer()
    }
}
