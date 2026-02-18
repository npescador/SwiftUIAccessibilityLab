import SwiftUI

struct TaskDetailExampleContainer: View {
    var body: some View {
        ExampleContainer(
            metadata: TaskDetailExampleMetadata.value,
            accessibleView: { TaskDetailView_Accessible() },
            inaccessibleView: { TaskDetailView_Inaccessible() }
        )
    }
}

#Preview {
    NavigationStack {
        TaskDetailExampleContainer()
    }
}
