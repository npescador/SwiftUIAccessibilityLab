import SwiftUI

struct TaskListExampleContainer: View {
    var body: some View {
        ExampleContainer(
            route: .taskList,
            metadata: TaskListExampleMetadata.value,
            accessibleView: { TaskListView_Accessible() },
            inaccessibleView: { TaskListView_Inaccessible() }
        )
    }
}

#Preview {
    NavigationStack {
        TaskListExampleContainer()
    }
}
