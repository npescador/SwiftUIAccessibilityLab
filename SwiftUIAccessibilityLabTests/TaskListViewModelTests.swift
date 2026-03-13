import Testing
@testable import SwiftUIAccessibilityLab

@MainActor
@Suite("TaskListViewModel")
struct TaskListViewModelTests {
    @Test("Load tasks populates sample data")
    func loadTasks() async {
        let announcer = TestAccessibilityAnnouncer()
        let viewModel = TaskListViewModel(announcer: announcer)

        await viewModel.loadTasks()

        #expect(viewModel.tasks.isEmpty == false)
        #expect(viewModel.isLoading == false)
        #expect(announcer.messages == ["3 tasks loaded"])
    }

    @Test("Search filters tasks")
    func searchFilters() {
        let viewModel = TaskListViewModel(announcer: TestAccessibilityAnnouncer())
        viewModel.tasks = MockData.sampleTasks
        viewModel.searchText = "groceries"

        #expect(viewModel.filteredTasks.count == 1)
        #expect(viewModel.filteredTasks.first?.title == "Buy groceries")
    }

    @Test("Toggle completion updates task state")
    func toggleCompletion() {
        let announcer = TestAccessibilityAnnouncer()
        let viewModel = TaskListViewModel(announcer: announcer)
        viewModel.tasks = MockData.sampleTasks
        let first = viewModel.tasks[0]

        viewModel.toggleCompletion(first)

        #expect(viewModel.tasks[0].isComplete == true)
        #expect(announcer.messages == ["Task completed"])
    }

    @Test("Delete task removes task")
    func deleteTask() {
        let announcer = TestAccessibilityAnnouncer()
        let viewModel = TaskListViewModel(announcer: announcer)
        viewModel.tasks = MockData.sampleTasks
        let first = viewModel.tasks[0]

        viewModel.deleteTask(first)

        #expect(viewModel.tasks.count == 2)
        #expect(announcer.messages == ["Task deleted"])
    }

    @Test("Add task appends a new task and announces")
    func addTask() {
        let announcer = TestAccessibilityAnnouncer()
        let viewModel = TaskListViewModel(announcer: announcer)

        viewModel.addTask(title: "Book flights", priority: .medium)

        #expect(viewModel.tasks.count == 1)
        #expect(viewModel.tasks[0].title == "Book flights")
        #expect(announcer.messages == ["Task added"])
    }
}
