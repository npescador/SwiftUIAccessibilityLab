import SwiftUI

struct TaskDetailView_Inaccessible: View {
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
                }
            }
        }
    }

    private var detailsSection: some View {
        LabSectionCard {
            VStack(alignment: .leading, spacing: 12) {
                sectionHeader("Details", subtitle: "Review or edit the task title.")

                if viewModel.isEditing {
                    TextField("Task title", text: $viewModel.editTitle)
                        .font(.body.weight(.medium))
                        .labFieldChrome()
                        .onChange(of: viewModel.editTitle) { _, _ in
                            viewModel.updateEditState()
                        }
                } else {
                    Text(viewModel.task.title)
                        .font(.title3.weight(.semibold))
                        .foregroundStyle(LabTheme.titleColor)
                }
            }
        }
    }

    private var descriptionSection: some View {
        LabSectionCard {
            VStack(alignment: .leading, spacing: 12) {
                sectionHeader("Description", subtitle: "Add supporting context for the task.")

                if viewModel.isEditing {
                    TextEditor(text: $viewModel.editDetails)
                        .frame(minHeight: 108)
                        .padding(10)
                        .background(editorBackground)
                        .onChange(of: viewModel.editDetails) { _, _ in
                            viewModel.updateEditState()
                        }
                } else {
                    Text(viewModel.task.details ?? "No description")
                        .font(.body)
                        .foregroundStyle(LabTheme.bodyColor)
                }
            }
        }
    }

    private var scheduleSection: some View {
        LabSectionCard {
            VStack(alignment: .leading, spacing: 14) {
                sectionHeader("Schedule", subtitle: "Control priority and due date.")

                Menu {
                    ForEach(Priority.allCases) { priority in
                        Button(priority.rawValue) {
                            viewModel.editPriority = priority
                            viewModel.updateEditState()
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

                Toggle("Due date", isOn: $viewModel.hasDueDate)
                    .toggleStyle(.switch)
                    .tint(LabTheme.accent(for: .lists))
                    .disabled(!viewModel.isEditing)
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
                sectionHeader("Status", subtitle: "Track whether the task is done.")

                Toggle("Completed", isOn: Binding(
                    get: { viewModel.task.isComplete },
                    set: { _ in viewModel.toggleCompletion() }
                ))
                .toggleStyle(.switch)
                .tint(LabTheme.accent(for: .forms))
            }
        }
    }

    private func sectionHeader(_ title: String, subtitle: String) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.headline.weight(.semibold))
                .foregroundStyle(LabTheme.titleColor)

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
        TaskDetailView_Inaccessible()
    }
}
