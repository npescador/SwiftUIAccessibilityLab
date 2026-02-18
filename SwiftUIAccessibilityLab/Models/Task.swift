import Foundation

struct Task: Identifiable, Hashable, Codable {
    let id: UUID
    var title: String
    var details: String?
    var priority: Priority
    var dueDate: Date?
    var isComplete: Bool

    init(
        id: UUID = UUID(),
        title: String,
        details: String? = nil,
        priority: Priority,
        dueDate: Date? = nil,
        isComplete: Bool = false
    ) {
        self.id = id
        self.title = title
        self.details = details
        self.priority = priority
        self.dueDate = dueDate
        self.isComplete = isComplete
    }
}
