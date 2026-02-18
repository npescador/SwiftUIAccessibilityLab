import SwiftUI

struct TaskListView_Accessible: View {
    @State private var viewModel = TaskListViewModel()
    @State private var newTaskTitle = ""
    @State private var newTaskPriority: Priority = .medium

    var body: some View {
        VStack(spacing: 12) {
            searchField
            addTaskSection

            if viewModel.isLoading {
                ProgressView("Loading tasks")
                    .accessibilityIdentifier("tasklist.loading")
                    .accessibilityLabel("Loading tasks")
            }

            if viewModel.filteredTasks.isEmpty && !viewModel.isLoading {
                ContentUnavailableView(
                    "No Tasks",
                    systemImage: "checkmark.circle",
                    description: Text("Create a task to get started")
                )
                .accessibilityIdentifier("tasklist.empty.state")
                .accessibilityElement(children: .combine)
                .accessibilityLabel("No tasks. Create a task to get started.")
            } else {
                List {
                    ForEach(viewModel.filteredTasks) { task in
                        TaskRow_Accessible(
                            task: task,
                            onToggle: { viewModel.toggleCompletion(task) },
                            onDelete: { viewModel.deleteTask(task) }
                        )
                        .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                            Button(role: .destructive) {
                                viewModel.deleteTask(task)
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                    }
                }
                .listStyle(.plain)
                .accessibilityIdentifier("tasklist.list")
                .refreshable {
                    await viewModel.loadTasks()
                }
            }
        }
        .padding(.horizontal)
        .task {
            await viewModel.loadTasks()
        }
    }

    private var searchField: some View {
        TextField("Search tasks", text: $viewModel.searchText)
            .textFieldStyle(.roundedBorder)
            .accessibilityIdentifier("tasklist.search.field")
            .accessibilityLabel("Search tasks")
            .accessibilityValue(viewModel.searchText.isEmpty ? "Empty" : viewModel.searchText)
            .accessibilityHint("Enter text to filter tasks")
    }

    private var addTaskSection: some View {
        HStack(spacing: 8) {
            TextField("New task", text: $newTaskTitle)
                .textFieldStyle(.roundedBorder)
                .accessibilityIdentifier("tasklist.newtask.field")
                .accessibilityLabel("New task")
                .accessibilityHint("Enter a title for the new task")

            Picker("Priority", selection: $newTaskPriority) {
                ForEach(Priority.allCases) { priority in
                    Text(priority.rawValue).tag(priority)
                }
            }
            .pickerStyle(.menu)
            .accessibilityIdentifier("tasklist.priority.picker")
            .accessibilityLabel("Priority")
            .accessibilityValue(newTaskPriority.rawValue)

            Button("Add") {
                guard !newTaskTitle.isEmpty else { return }
                viewModel.addTask(title: newTaskTitle, priority: newTaskPriority)
                newTaskTitle = ""
                newTaskPriority = .medium
            }
            .buttonStyle(.borderedProminent)
            .accessibilityIdentifier("tasklist.add.button")
            .accessibilityHint("Adds the new task")
        }
    }
}

#Preview {
    TaskListView_Accessible()
}
