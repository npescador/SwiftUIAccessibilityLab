import Foundation
import Observation

@Observable
final class TaskListViewModel {
    var tasks: [TaskItem] = []
    var searchText = ""
    var isLoading = false
    var errorMessage: String?

    var filteredTasks: [TaskItem] {
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

    func toggleCompletion(_ task: TaskItem) {
        guard let index = tasks.firstIndex(where: { $0.id == task.id }) else { return }
        tasks[index].isComplete.toggle()
        let status = tasks[index].isComplete ? "completed" : "not completed"
        AccessibilityHelpers.announce("TaskItem \(status)")
    }

    func deleteTask(_ task: TaskItem) {
        tasks.removeAll { $0.id == task.id }
        AccessibilityHelpers.announce("TaskItem deleted")
    }

    func addTask(title: String, priority: Priority) {
        let newTask = TaskItem(title: title, priority: priority)
        tasks.append(newTask)
        AccessibilityHelpers.announce("TaskItem added")
    }
}
