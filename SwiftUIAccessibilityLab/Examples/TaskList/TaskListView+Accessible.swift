import SwiftUI
import OSLog

struct TaskListView_Accessible: View {
    @State private var viewModel = TaskListViewModel()
    @State private var newTaskTitle = ""
    @State private var newTaskPriority: Priority = .medium

    var body: some View {
        VStack(spacing: 16) {
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
                        .listRowInsets(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color.clear)
                    }
                }
                .listStyle(.plain)
                .scrollContentBackground(.hidden)
                .background(Color.clear)
                .accessibilityIdentifier("tasklist.list")
                .refreshable {
                    await viewModel.loadTasks()
                }
            }
        }
        .padding(.horizontal)
        .padding(.top, 4)
        .tint(LabTheme.titleColor)
        .onAppear {
            AppLogger.taskList.debug("Accessible TaskList appeared")
        }
        .onDisappear {
            AppLogger.taskList.debug("Accessible TaskList disappeared")
        }
        .task {
            await viewModel.loadTasks()
        }
    }

    private var searchField: some View {
        TextField("Search tasks", text: $viewModel.searchText)
            .font(.body.weight(.medium))
            .labFieldChrome()
            .accessibilityIdentifier("tasklist.search.field")
            .accessibilityLabel("Search tasks")
            .accessibilityValue(viewModel.searchText.isEmpty ? "Empty" : viewModel.searchText)
            .accessibilityHint("Enter text to filter tasks")
    }

    private var addTaskSection: some View {
        ViewThatFits(in: .horizontal) {
            HStack(alignment: .center, spacing: 10) {
                newTaskField
                priorityMenu
                addButton
            }
            VStack(spacing: 10) {
                newTaskField
                HStack(spacing: 10) {
                    priorityMenu
                    addButton
                }
            }
        }
    }

    private var newTaskField: some View {
        TextField("New task", text: $newTaskTitle)
            .font(.body.weight(.medium))
            .labFieldChrome()
            .accessibilityIdentifier("tasklist.newtask.field")
            .accessibilityLabel("New task")
            .accessibilityHint("Enter a title for the new task")
    }

    private var priorityMenu: some View {
        Menu {
            ForEach(Priority.allCases) { priority in
                Button {
                    newTaskPriority = priority
                } label: {
                    if priority == newTaskPriority {
                        Label(priority.rawValue, systemImage: "checkmark")
                    } else {
                        Text(priority.rawValue)
                    }
                }
            }
        } label: {
            HStack(spacing: 6) {
                Text(newTaskPriority.rawValue)
                    .lineLimit(1)
                Image(systemName: "chevron.up.chevron.down")
                    .font(.caption.weight(.semibold))
            }
            .font(.body.weight(.medium))
            .frame(minWidth: 112, alignment: .leading)
            .labFieldChrome()
        }
        .accessibilityIdentifier("tasklist.priority.picker")
        .accessibilityLabel("Priority")
        .accessibilityValue(newTaskPriority.rawValue)
    }

    private var addButton: some View {
        Button("Add") {
            guard !newTaskTitle.isEmpty else { return }
            viewModel.addTask(title: newTaskTitle, priority: newTaskPriority)
            newTaskTitle = ""
            newTaskPriority = .medium
        }
        .font(.body.weight(.semibold))
        .labPrimaryButtonChrome()
        .accessibilityIdentifier("tasklist.add.button")
        .accessibilityHint("Adds the new task")
    }
}

#Preview {
    TaskListView_Accessible()
}
