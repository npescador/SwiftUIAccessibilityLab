import SwiftUI

struct TaskListView_Inaccessible: View {
    @State private var viewModel = TaskListViewModel()
    @State private var newTaskTitle = ""
    @State private var newTaskPriority: Priority = .medium

    var body: some View {
        VStack(spacing: 12) {
            TextField("Search tasks", text: $viewModel.searchText)
                .textFieldStyle(.roundedBorder)
            // Missing: accessibility label, value, and hint.

            HStack(spacing: 8) {
                TextField("New task", text: $newTaskTitle)
                    .textFieldStyle(.roundedBorder)
                // Missing: accessibility label and hint.

                Picker("Priority", selection: $newTaskPriority) {
                    ForEach(Priority.allCases) { priority in
                        Text(priority.rawValue).tag(priority)
                    }
                }
                .pickerStyle(.menu)
                // Missing: accessibility value.

                Button("Add") {
                    guard !newTaskTitle.isEmpty else { return }
                    viewModel.addTask(title: newTaskTitle, priority: newTaskPriority)
                    newTaskTitle = ""
                }
                .buttonStyle(.borderedProminent)
                // Missing: hint about what the button does.
            }

            if viewModel.isLoading {
                ProgressView()
            }

            if viewModel.filteredTasks.isEmpty && !viewModel.isLoading {
                ContentUnavailableView(
                    "No Tasks",
                    systemImage: "checkmark.circle",
                    description: Text("Create a task to get started")
                )
                // Missing: combined accessibility label and decorative icon handling.
            } else {
                List {
                    ForEach(viewModel.filteredTasks) { task in
                        TaskRow_Inaccessible(
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
                        // Missing: accessibility actions for swipe alternatives.
                    }
                }
                .listStyle(.plain)
            }
        }
        .padding(.horizontal)
        .task {
            await viewModel.loadTasks()
        }
    }
}

#Preview {
    TaskListView_Inaccessible()
}
