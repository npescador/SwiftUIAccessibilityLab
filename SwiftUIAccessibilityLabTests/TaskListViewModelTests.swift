import Testing
@testable import SwiftUIAccessibilityLab

@Suite("TaskListViewModel")
struct TaskListViewModelTests {
    @Test("Load tasks populates sample data")
    @MainActor
    func loadTasks() async {
        let viewModel = TaskListViewModel()

        await viewModel.loadTasks()

        #expect(viewModel.tasks.isEmpty == false)
        #expect(viewModel.isLoading == false)
    }

    @Test("Search filters tasks")
    func searchFilters() {
        let viewModel = TaskListViewModel()
        viewModel.tasks = MockData.sampleTasks
        viewModel.searchText = "groceries"

        #expect(viewModel.filteredTasks.count == 1)
        #expect(viewModel.filteredTasks.first?.title == "Buy groceries")
    }

    @Test("Toggle completion updates task state")
    @MainActor
    func toggleCompletion() {
        let viewModel = TaskListViewModel()
        viewModel.tasks = MockData.sampleTasks
        let first = viewModel.tasks[0]

        viewModel.toggleCompletion(first)

        #expect(viewModel.tasks[0].isComplete == true)
    }

    @Test("Delete task removes task")
    @MainActor
    func deleteTask() {
        let viewModel = TaskListViewModel()
        viewModel.tasks = MockData.sampleTasks
        let first = viewModel.tasks[0]

        viewModel.deleteTask(first)

        #expect(viewModel.tasks.count == 2)
    }
}
