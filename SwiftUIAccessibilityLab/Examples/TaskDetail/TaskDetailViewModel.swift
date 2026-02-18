import Foundation
import Observation

@Observable
/// Manages edit state and persistence behavior for task details.
final class TaskDetailViewModel {
    var task: TaskItem
    var isEditing = false
    var hasUnsavedChanges = false

    var editTitle = ""
    var editDetails = ""
    var editPriority: Priority = .medium
    var editDueDate = Date()
    var hasDueDate = false

    init(task: TaskItem = MockData.sampleTasks.first ?? TaskItem(title: "New Task", priority: .medium)) {
        self.task = task
        resetEditState()
    }

    /// Enters edit mode and syncs temporary edit fields from the task.
    func startEditing() {
        isEditing = true
        resetEditState()
    }

    /// Applies edited values to the task and exits edit mode.
    func saveChanges() {
        task.title = editTitle
        task.details = editDetails.isEmpty ? nil : editDetails
        task.priority = editPriority
        task.dueDate = hasDueDate ? editDueDate : nil

        isEditing = false
        hasUnsavedChanges = false

        AccessibilityHelpers.announce("Changes saved")
    }

    /// Discards pending edits and exits edit mode.
    func cancelEditing() {
        isEditing = false
        hasUnsavedChanges = false
        resetEditState()

        AccessibilityHelpers.announce("Editing canceled")
    }

    /// Toggles the completion state of the current task.
    func toggleCompletion() {
        task.isComplete.toggle()
        let status = task.isComplete ? "completed" : "not completed"
        AccessibilityHelpers.announce("Task marked as \(status)")
    }

    /// Recomputes unsaved changes status using edit fields vs. task values.
    func updateEditState() {
        hasUnsavedChanges = editTitle != task.title
            || editDetails != (task.details ?? "")
            || editPriority != task.priority
            || hasDueDate != (task.dueDate != nil)
            || (hasDueDate && editDueDate != (task.dueDate ?? editDueDate))
    }

    private func resetEditState() {
        editTitle = task.title
        editDetails = task.details ?? ""
        editPriority = task.priority
        if let dueDate = task.dueDate {
            editDueDate = dueDate
            hasDueDate = true
        } else {
            editDueDate = Date()
            hasDueDate = false
        }
    }
}
