import Testing
@testable import SwiftUIAccessibilityLab

@MainActor
@Suite("TaskDetailViewModel")
struct TaskDetailViewModelTests {
    @Test("Starts in non-editing mode")
    func initialState() {
        let viewModel = TaskDetailViewModel(announcer: TestAccessibilityAnnouncer())

        #expect(viewModel.isEditing == false)
        #expect(viewModel.hasUnsavedChanges == false)
    }

    @Test("Start editing enables edit mode")
    func startEditing() {
        let viewModel = TaskDetailViewModel(announcer: TestAccessibilityAnnouncer())

        viewModel.startEditing()

        #expect(viewModel.isEditing)
    }

    @Test("Save changes updates task")
    func saveChanges() {
        let announcer = TestAccessibilityAnnouncer()
        let seed = TaskItem(title: "Old", details: nil, priority: .low)
        let viewModel = TaskDetailViewModel(task: seed, announcer: announcer)
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
        #expect(announcer.messages == ["Changes saved"])
    }

    @Test("Cancel editing resets unsaved state")
    func cancelEditing() {
        let announcer = TestAccessibilityAnnouncer()
        let viewModel = TaskDetailViewModel(announcer: announcer)
        viewModel.startEditing()
        viewModel.editTitle = "Changed"
        viewModel.updateEditState()

        viewModel.cancelEditing()

        #expect(viewModel.isEditing == false)
        #expect(viewModel.hasUnsavedChanges == false)
        #expect(announcer.messages == ["Editing canceled"])
    }

    @Test("Toggle completion announces updated state")
    func toggleCompletion() {
        let announcer = TestAccessibilityAnnouncer()
        let viewModel = TaskDetailViewModel(announcer: announcer)

        viewModel.toggleCompletion()

        #expect(viewModel.task.isComplete == true)
        #expect(announcer.messages == ["Task marked as completed"])
    }
}
