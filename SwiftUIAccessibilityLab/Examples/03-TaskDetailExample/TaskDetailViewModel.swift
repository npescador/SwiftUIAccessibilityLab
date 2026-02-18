import Foundation
import Observation

@Observable
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

    func startEditing() {
        isEditing = true
        resetEditState()
    }

    func saveChanges() {
        task.title = editTitle
        task.details = editDetails.isEmpty ? nil : editDetails
        task.priority = editPriority
        task.dueDate = hasDueDate ? editDueDate : nil

        isEditing = false
        hasUnsavedChanges = false

        AccessibilityHelpers.announce("Changes saved")
    }

    func cancelEditing() {
        isEditing = false
        hasUnsavedChanges = false
        resetEditState()

        AccessibilityHelpers.announce("Editing canceled")
    }

    func toggleCompletion() {
        task.isComplete.toggle()
        let status = task.isComplete ? "completed" : "not completed"
        AccessibilityHelpers.announce("Task marked as \(status)")
    }

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
