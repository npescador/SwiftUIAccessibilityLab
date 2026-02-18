import Foundation
import Observation

@Observable
final class TaskListViewModel {
    var tasks: [Task] = []
    var searchText = ""
    var isLoading = false
    var errorMessage: String?

    var filteredTasks: [Task] {
        guard !searchText.isEmpty else { return tasks }
        return tasks.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
    }

    func loadTasks() async {
        isLoading = true
        defer { isLoading = false }

        try? await Task.sleep(for: .seconds(1))
        tasks = MockData.sampleTasks

        AccessibilityHelpers.announce("\(tasks.count) tasks loaded")
    }

    func toggleCompletion(_ task: Task) {
        guard let index = tasks.firstIndex(where: { $0.id == task.id }) else { return }
        tasks[index].isComplete.toggle()
        let status = tasks[index].isComplete ? "completed" : "not completed"
        AccessibilityHelpers.announce("Task \(status)")
    }

    func deleteTask(_ task: Task) {
        tasks.removeAll { $0.id == task.id }
        AccessibilityHelpers.announce("Task deleted")
    }

    func addTask(title: String, priority: Priority) {
        let newTask = Task(title: title, priority: priority)
        tasks.append(newTask)
        AccessibilityHelpers.announce("Task added")
    }
}
