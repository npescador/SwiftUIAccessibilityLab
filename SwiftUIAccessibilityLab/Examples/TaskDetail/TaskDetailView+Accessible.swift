import SwiftUI

struct TaskDetailView_Accessible: View {
    @State private var viewModel = TaskDetailViewModel()

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                detailsSection
                descriptionSection
                scheduleSection
                statusSection
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
        }
        .scrollIndicators(.hidden)
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

    private var detailsSection: some View {
        LabSectionCard {
            VStack(alignment: .leading, spacing: 12) {
                accessibleSectionHeader("Details", subtitle: "Review or edit the task title.")

                if viewModel.isEditing {
                    TextField("Task title", text: $viewModel.editTitle)
                        .font(.body.weight(.medium))
                        .labFieldChrome()
                        .accessibilityIdentifier("taskdetail.title.field")
                        .accessibilityLabel("Task title")
                        .accessibilityValue(viewModel.editTitle)
                        .onChange(of: viewModel.editTitle) { _, _ in
                            viewModel.updateEditState()
                        }
                } else {
                    Text(viewModel.task.title)
                        .font(.title3.weight(.semibold))
                        .foregroundStyle(LabTheme.titleColor)
                        .accessibilityIdentifier("taskdetail.title.text")
                        .accessibilityLabel("Task title: \(viewModel.task.title)")
                }
            }
        }
    }

    private var descriptionSection: some View {
        LabSectionCard {
            VStack(alignment: .leading, spacing: 12) {
                accessibleSectionHeader("Description", subtitle: "Add supporting context for the task.")

                if viewModel.isEditing {
                    TextEditor(text: $viewModel.editDetails)
                        .frame(minHeight: 108)
                        .padding(10)
                        .background(editorBackground)
                        .accessibilityIdentifier("taskdetail.description.editor")
                        .accessibilityLabel("Task description")
                        .accessibilityValue(viewModel.editDetails.isEmpty ? "Empty" : viewModel.editDetails)
                        .onChange(of: viewModel.editDetails) { _, _ in
                            viewModel.updateEditState()
                        }
                } else {
                    Text(viewModel.task.details ?? "No description")
                        .font(.body)
                        .foregroundStyle(LabTheme.bodyColor)
                        .accessibilityLabel("Task description")
                        .accessibilityValue(viewModel.task.details ?? "Empty")
                }
            }
        }
    }

    private var scheduleSection: some View {
        LabSectionCard {
            VStack(alignment: .leading, spacing: 14) {
                accessibleSectionHeader("Schedule", subtitle: "Control priority and due date.")

                Menu {
                    ForEach(Priority.allCases) { priority in
                        Button {
                            viewModel.editPriority = priority
                            viewModel.updateEditState()
                        } label: {
                            if priority == viewModel.editPriority {
                                Label(priority.rawValue, systemImage: "checkmark")
                            } else {
                                Text(priority.rawValue)
                            }
                        }
                    }
                } label: {
                    HStack {
                        Text("Priority")
                        Spacer()
                        Text(viewModel.editPriority.rawValue)
                        Image(systemName: "chevron.up.chevron.down")
                            .font(.caption2.weight(.semibold))
                    }
                    .font(.body.weight(.medium))
                    .labFieldChrome()
                }
                .disabled(!viewModel.isEditing)
                .accessibilityIdentifier("taskdetail.priority.picker")
                .accessibilityLabel("Priority")
                .accessibilityValue(viewModel.editPriority.rawValue)
                .accessibilityHint("Double-tap to change priority")

                Toggle("Due date", isOn: $viewModel.hasDueDate)
                    .toggleStyle(.switch)
                    .tint(LabTheme.accent(for: .lists))
                    .disabled(!viewModel.isEditing)
                    .accessibilityIdentifier("taskdetail.duedate.toggle")
                    .accessibilityHint("Toggle to add or remove a due date")
                    .onChange(of: viewModel.hasDueDate) { _, _ in
                        viewModel.updateEditState()
                    }

                if viewModel.hasDueDate {
                    DatePicker(
                        "Due date",
                        selection: $viewModel.editDueDate,
                        displayedComponents: [.date, .hourAndMinute]
                    )
                    .datePickerStyle(.compact)
                    .tint(LabTheme.accent(for: .lists))
                    .disabled(!viewModel.isEditing)
                    .accessibilityIdentifier("taskdetail.duedate.picker")
                    .accessibilityLabel("Due date")
                    .accessibilityValue(viewModel.editDueDate.formatted(date: .long, time: .shortened))
                    .accessibilityHint("Double-tap to change")
                    .onChange(of: viewModel.editDueDate) { _, _ in
                        viewModel.updateEditState()
                    }
                }
            }
        }
    }

    private var statusSection: some View {
        LabSectionCard {
            VStack(alignment: .leading, spacing: 12) {
                accessibleSectionHeader("Status", subtitle: "Track whether the task is done.")

                Toggle("Completed", isOn: Binding(
                    get: { viewModel.task.isComplete },
                    set: { _ in viewModel.toggleCompletion() }
                ))
                .toggleStyle(.switch)
                .tint(LabTheme.accent(for: .forms))
                .accessibilityIdentifier("taskdetail.completed.toggle")
                .accessibilityValue(viewModel.task.isComplete ? "Completed" : "Not completed")
            }
        }
    }

    private func accessibleSectionHeader(_ title: String, subtitle: String) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.headline.weight(.semibold))
                .foregroundStyle(LabTheme.titleColor)
                .accessibilityAddTraits(.isHeader)

            Text(subtitle)
                .font(.subheadline)
                .foregroundStyle(LabTheme.bodyColor)
        }
    }

    private var editorBackground: some View {
        RoundedRectangle(cornerRadius: LabTheme.cornerRadiusSmall, style: .continuous)
            .fill(LabTheme.controlSurface)
            .overlay(
                RoundedRectangle(cornerRadius: LabTheme.cornerRadiusSmall, style: .continuous)
                    .stroke(LabTheme.border)
            )
    }
}

#Preview {
    NavigationStack {
        TaskDetailView_Accessible()
    }
}
