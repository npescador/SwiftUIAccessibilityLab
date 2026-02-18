import SwiftUI

struct TaskDetailView_Accessible: View {
    @State private var viewModel = TaskDetailViewModel()

    var body: some View {
        Form {
            Section {
                if viewModel.isEditing {
                    TextField("Task title", text: $viewModel.editTitle)
                        .accessibilityIdentifier("taskdetail.title.field")
                        .accessibilityLabel("Task title")
                        .accessibilityValue(viewModel.editTitle)
                        .onChange(of: viewModel.editTitle) { _, _ in
                            viewModel.updateEditState()
                        }
                } else {
                    Text(viewModel.task.title)
                        .accessibilityIdentifier("taskdetail.title.text")
                        .accessibilityLabel("Task title: \(viewModel.task.title)")
                }
            } header: {
                Text("Details")
                    .accessibilityAddTraits(.isHeader)
            }

            Section {
                if viewModel.isEditing {
                    TextEditor(text: $viewModel.editDetails)
                        .frame(minHeight: 80)
                        .accessibilityIdentifier("taskdetail.description.editor")
                        .accessibilityLabel("Task description")
                        .accessibilityValue(viewModel.editDetails.isEmpty ? "Empty" : viewModel.editDetails)
                        .onChange(of: viewModel.editDetails) { _, _ in
                            viewModel.updateEditState()
                        }
                } else {
                    Text(viewModel.task.details ?? "No description")
                        .accessibilityLabel("Task description")
                        .accessibilityValue(viewModel.task.details ?? "Empty")
                }
            } header: {
                Text("Description")
                    .accessibilityAddTraits(.isHeader)
            }

            Section {
                Picker("Priority", selection: $viewModel.editPriority) {
                    ForEach(Priority.allCases) { priority in
                        Text(priority.rawValue).tag(priority)
                    }
                }
                .disabled(!viewModel.isEditing)
                .accessibilityIdentifier("taskdetail.priority.picker")
                .accessibilityLabel("Priority")
                .accessibilityValue(viewModel.editPriority.rawValue)
                .accessibilityHint("Double-tap to change priority")
                .onChange(of: viewModel.editPriority) { _, _ in
                    viewModel.updateEditState()
                }

                Toggle("Due date", isOn: $viewModel.hasDueDate)
                    .disabled(!viewModel.isEditing)
                    .accessibilityIdentifier("taskdetail.duedate.toggle")
                    .accessibilityHint("Toggle to add or remove a due date")
                    .onChange(of: viewModel.hasDueDate) { _, _ in
                        viewModel.updateEditState()
                    }

                if viewModel.hasDueDate {
                    DatePicker(
                        "",
                        selection: $viewModel.editDueDate,
                        displayedComponents: [.date, .hourAndMinute]
                    )
                    .labelsHidden()
                    .disabled(!viewModel.isEditing)
                    .accessibilityIdentifier("taskdetail.duedate.picker")
                    .accessibilityLabel("Due date")
                    .accessibilityValue(viewModel.editDueDate.formatted(date: .long, time: .shortened))
                    .accessibilityHint("Double-tap to change")
                    .onChange(of: viewModel.editDueDate) { _, _ in
                        viewModel.updateEditState()
                    }
                }
            } header: {
                Text("Schedule")
                    .accessibilityAddTraits(.isHeader)
            }

            Section {
                Toggle("Completed", isOn: Binding(
                    get: { viewModel.task.isComplete },
                    set: { _ in viewModel.toggleCompletion() }
                ))
                .accessibilityIdentifier("taskdetail.completed.toggle")
                .accessibilityValue(viewModel.task.isComplete ? "Completed" : "Not completed")
            } header: {
                Text("Status")
                    .accessibilityAddTraits(.isHeader)
            }
        }
        .navigationTitle("Task Detail")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                if viewModel.isEditing {
                    Button("Save") {
                        viewModel.saveChanges()
                    }
                    .disabled(!viewModel.hasUnsavedChanges)
                    .accessibilityIdentifier("taskdetail.save.button")
                    .accessibilityHint("Saves your changes")
                } else {
                    Button("Edit") {
                        viewModel.startEditing()
                    }
                    .accessibilityIdentifier("taskdetail.edit.button")
                    .accessibilityHint("Enters edit mode")
                }
            }
            ToolbarItem(placement: .topBarLeading) {
                if viewModel.isEditing {
                    Button("Cancel") {
                        viewModel.cancelEditing()
                    }
                    .accessibilityIdentifier("taskdetail.cancel.button")
                    .accessibilityHint("Discards your changes")
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        TaskDetailView_Accessible()
    }
}
