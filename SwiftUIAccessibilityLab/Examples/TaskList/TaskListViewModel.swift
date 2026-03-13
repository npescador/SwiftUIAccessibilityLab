import Foundation
import Observation
import OSLog

@MainActor
@Observable
/// Manages task list state, filtering, and task actions.
final class TaskListViewModel {
    private let announcer: any AccessibilityAnnouncing

    var tasks: [TaskItem] = []
    var searchText = ""
    var isLoading = false
    var errorMessage: String?

    init(announcer: any AccessibilityAnnouncing = SystemAccessibilityAnnouncer()) {
        self.announcer = announcer
    }

    var filteredTasks: [TaskItem] {
        guard !searchText.isEmpty else { return tasks }
        return tasks.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
    }

    /// Loads sample tasks to simulate an async data source.
    func loadTasks() async {
        AppLogger.taskList.debug("loadTasks started")
        isLoading = true
        defer { isLoading = false }

        do {
            try await Task.sleep(for: .seconds(1))
            try Task.checkCancellation()
        } catch {
            AppLogger.taskList.debug("loadTasks cancelled")
            return
        }

        tasks = MockData.sampleTasks
        AppLogger.taskList.debug("loadTasks completed count=\(self.tasks.count)")

        announcer.announce("\(tasks.count) tasks loaded")
    }

    func toggleCompletion(_ task: TaskItem) {
        guard let index = tasks.firstIndex(where: { $0.id == task.id }) else { return }
        tasks[index].isComplete.toggle()
        let status = tasks[index].isComplete ? "completed" : "not completed"
        AppLogger.taskList.debug("toggleCompletion task=\(task.id.uuidString, privacy: .public) status=\(status, privacy: .public)")
        announcer.announce("Task \(status)")
    }

    func deleteTask(_ task: TaskItem) {
        tasks.removeAll { $0.id == task.id }
        AppLogger.taskList.debug("deleteTask task=\(task.id.uuidString, privacy: .public)")
        announcer.announce("Task deleted")
    }

    /// Appends a new task using the currently selected priority.
    func addTask(title: String, priority: Priority) {
        let newTask = TaskItem(title: title, priority: priority)
        tasks.append(newTask)
        AppLogger.taskList.debug("addTask task=\(newTask.id.uuidString, privacy: .public) priority=\(priority.rawValue, privacy: .public)")
        announcer.announce("Task added")
    }
}
