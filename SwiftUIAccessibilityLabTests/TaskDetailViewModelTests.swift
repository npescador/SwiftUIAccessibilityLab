import Testing
@testable import SwiftUIAccessibilityLab

@Suite("TaskDetailViewModel")
struct TaskDetailViewModelTests {
    @Test("Starts in non-editing mode")
    func initialState() {
        let viewModel = TaskDetailViewModel()

        #expect(viewModel.isEditing == false)
        #expect(viewModel.hasUnsavedChanges == false)
    }

    @Test("Start editing enables edit mode")
    func startEditing() {
        let viewModel = TaskDetailViewModel()

        viewModel.startEditing()

        #expect(viewModel.isEditing)
    }

    @Test("Save changes updates task")
    @MainActor
    func saveChanges() {
        let seed = TaskItem(title: "Old", details: nil, priority: .low)
        let viewModel = TaskDetailViewModel(task: seed)
        viewModel.startEditing()
        viewModel.editTitle = "New"
        viewModel.editDetails = "Notes"
        viewModel.editPriority = .high
        viewModel.hasDueDate = false
        viewModel.updateEditState()

        viewModel.saveChanges()

        #expect(viewModel.task.title == "New")
        #expect(viewModel.task.details == "Notes")
        #expect(viewModel.task.priority == .high)
        #expect(viewModel.isEditing == false)
    }

    @Test("Cancel editing resets unsaved state")
    @MainActor
    func cancelEditing() {
        let viewModel = TaskDetailViewModel()
        viewModel.startEditing()
        viewModel.editTitle = "Changed"
        viewModel.updateEditState()

        viewModel.cancelEditing()

        #expect(viewModel.isEditing == false)
        #expect(viewModel.hasUnsavedChanges == false)
    }
}
