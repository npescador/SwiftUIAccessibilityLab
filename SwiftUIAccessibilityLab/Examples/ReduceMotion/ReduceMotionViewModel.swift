import Foundation
import Observation

@MainActor
@Observable
/// Manages a daily goals list for the Reduce Motion lab.
final class ReduceMotionViewModel {
    struct Goal: Identifiable, Equatable {
        let id: UUID
        let title: String
        let emoji: String
        var isCompleted: Bool

        init(id: UUID = UUID(), title: String, emoji: String, isCompleted: Bool = false) {
            self.id = id
            self.title = title
            self.emoji = emoji
            self.isCompleted = isCompleted
        }
    }

    private let announcer: any AccessibilityAnnouncing

    var goals: [Goal]

    var completedCount: Int { goals.filter(\.isCompleted).count }
    var totalCount: Int { goals.count }
    var allCompleted: Bool { goals.allSatisfy(\.isCompleted) }

    init(announcer: any AccessibilityAnnouncing = SystemAccessibilityAnnouncer()) {
        self.announcer = announcer
        self.goals = [
            Goal(title: "30 minutes of exercise", emoji: "🏃"),
            Goal(title: "Drink 8 glasses of water", emoji: "💧"),
            Goal(title: "Read for 20 minutes", emoji: "📖"),
            Goal(title: "Meditate for 10 minutes", emoji: "🧘"),
            Goal(title: "No screens after 9 PM", emoji: "📵"),
        ]
    }

    func toggle(_ goal: Goal) {
        guard let index = goals.firstIndex(where: { $0.id == goal.id }) else { return }
        goals[index].isCompleted.toggle()
        let status = goals[index].isCompleted ? "completed" : "not completed"
        announcer.announce("\(goals[index].title) marked as \(status)")
    }

    func reset() {
        for index in goals.indices {
            goals[index].isCompleted = false
        }
        announcer.announce("All goals reset")
    }
}
