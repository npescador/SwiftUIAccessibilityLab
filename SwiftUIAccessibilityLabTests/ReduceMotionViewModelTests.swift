import Testing
@testable import SwiftUIAccessibilityLab

@MainActor
@Suite("ReduceMotionViewModel")
struct ReduceMotionViewModelTests {

    @Test("Default goals are all incomplete")
    func defaultGoals() {
        let viewModel = ReduceMotionViewModel(announcer: TestAccessibilityAnnouncer())

        #expect(viewModel.goals.isEmpty == false)
        #expect(viewModel.goals.allSatisfy { !$0.isCompleted })
        #expect(viewModel.completedCount == 0)
        #expect(viewModel.allCompleted == false)
    }

    @Test("Toggle marks goal as completed and announces")
    func toggleComplete() {
        let announcer = TestAccessibilityAnnouncer()
        let viewModel = ReduceMotionViewModel(announcer: announcer)
        let goal = viewModel.goals[0]

        viewModel.toggle(goal)

        #expect(viewModel.goals[0].isCompleted == true)
        #expect(viewModel.completedCount == 1)
        #expect(announcer.messages.last?.contains("completed") == true)
    }

    @Test("Toggle unmarks a completed goal")
    func toggleUncomplete() {
        let announcer = TestAccessibilityAnnouncer()
        let viewModel = ReduceMotionViewModel(announcer: announcer)
        viewModel.toggle(viewModel.goals[0])
        viewModel.toggle(viewModel.goals[0])

        #expect(viewModel.goals[0].isCompleted == false)
        #expect(viewModel.completedCount == 0)
    }

    @Test("allCompleted is true only when every goal is done")
    func allCompletedFlag() {
        let viewModel = ReduceMotionViewModel(announcer: TestAccessibilityAnnouncer())

        for goal in viewModel.goals {
            #expect(viewModel.allCompleted == false)
            viewModel.toggle(goal)
        }

        #expect(viewModel.allCompleted == true)
    }

    @Test("Reset marks all goals as incomplete and announces")
    func reset() {
        let announcer = TestAccessibilityAnnouncer()
        let viewModel = ReduceMotionViewModel(announcer: announcer)
        for goal in viewModel.goals { viewModel.toggle(goal) }

        viewModel.reset()

        #expect(viewModel.goals.allSatisfy { !$0.isCompleted })
        #expect(viewModel.completedCount == 0)
        #expect(announcer.messages.last == "All goals reset")
    }

    @Test("totalCount matches number of goals")
    func totalCount() {
        let viewModel = ReduceMotionViewModel(announcer: TestAccessibilityAnnouncer())

        #expect(viewModel.totalCount == viewModel.goals.count)
    }
}
