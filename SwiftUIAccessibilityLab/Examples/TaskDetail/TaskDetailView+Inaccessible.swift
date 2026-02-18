import SwiftUI

struct TaskDetailView_Inaccessible: View {
    @State private var viewModel = TaskDetailViewModel()

    var body: some View {
        Form {
            Section {
                if viewModel.isEditing {
                    TextField("Task title", text: $viewModel.editTitle)
                        .onChange(of: viewModel.editTitle) { _, _ in
                            viewModel.updateEditState()
                        }
                } else {
                    Text(viewModel.task.title)
                }
            } header: {
                Text("Details")
                // Missing: header trait.
            }

            Section {
                if viewModel.isEditing {
                    TextEditor(text: $viewModel.editDetails)
                        .frame(minHeight: 80)
                        .onChange(of: viewModel.editDetails) { _, _ in
                            viewModel.updateEditState()
                        }
                } else {
                    Text(viewModel.task.details ?? "No description")
                }
            } header: {
                Text("Description")
                // Missing: header trait and description value.
            }

            Section {
                Picker("Priority", selection: $viewModel.editPriority) {
                    ForEach(Priority.allCases) { priority in
                        Text(priority.rawValue).tag(priority)
                    }
                }
                .disabled(!viewModel.isEditing)
                // Missing: accessibility label and hint.

                Toggle("Due date", isOn: $viewModel.hasDueDate)
                    .disabled(!viewModel.isEditing)
                // Missing: hint and state feedback.

                if viewModel.hasDueDate {
                    DatePicker(
                        "",
                        selection: $viewModel.editDueDate,
                        displayedComponents: [.date, .hourAndMinute]
                    )
                    .labelsHidden()
                    .disabled(!viewModel.isEditing)
                    // Missing: accessibility label and value.
                }
            } header: {
                Text("Schedule")
            }

            Section {
                Toggle("Completed", isOn: Binding(
                    get: { viewModel.task.isComplete },
                    set: { _ in viewModel.toggleCompletion() }
                ))
            } header: {
                Text("Status")
            }
        }
        .navigationTitle("Task Detail")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                if viewModel.isEditing {
                    Button("Save") {
                        viewModel.saveChanges()
                    }
                    // Missing: announcement for save.
                } else {
                    Button("Edit") {
                        viewModel.startEditing()
                    }
                }
            }
            ToolbarItem(placement: .topBarLeading) {
                if viewModel.isEditing {
                    Button("Cancel") {
                        viewModel.cancelEditing()
                    }
                    // Missing: announcement for cancel.
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        TaskDetailView_Inaccessible()
    }
}
