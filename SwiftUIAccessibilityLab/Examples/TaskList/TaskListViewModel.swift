import Foundation
import Observation

@Observable
/// Manages task list state, filtering, and task actions.
final class TaskListViewModel {
    var tasks: [TaskItem] = []
    var searchText = ""
    var isLoading = false
    var errorMessage: String?

    var filteredTasks: [TaskItem] {
        guard !searchText.isEmpty else { return tasks }
        return tasks.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
    }

    /// Loads sample tasks to simulate an async data source.
    func loadTasks() async {
        isLoading = true
        defer { isLoading = false }

        try? await Task.sleep(for: .seconds(1))
        tasks = MockData.sampleTasks

        AccessibilityHelpers.announce("\(tasks.count) tasks loaded")
    }

    func toggleCompletion(_ task: TaskItem) {
        guard let index = tasks.firstIndex(where: { $0.id == task.id }) else { return }
        tasks[index].isComplete.toggle()
        let status = tasks[index].isComplete ? "completed" : "not completed"
        AccessibilityHelpers.announce("Task \(status)")
    }

    func deleteTask(_ task: TaskItem) {
        tasks.removeAll { $0.id == task.id }
        AccessibilityHelpers.announce("Task deleted")
    }

    /// Appends a new task using the currently selected priority.
    func addTask(title: String, priority: Priority) {
        let newTask = TaskItem(title: title, priority: priority)
        tasks.append(newTask)
        AccessibilityHelpers.announce("Task added")
    }
}
