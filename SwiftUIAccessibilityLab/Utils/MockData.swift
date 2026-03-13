import Foundation

enum MockData {
    static let sampleTasks: [TaskItem] = [
        TaskItem(title: "Buy groceries", details: "Milk, bread, and fruit", priority: .high, dueDate: .now.addingTimeInterval(3600)),
        TaskItem(title: "Walk the dog", details: "30 minute walk", priority: .medium, dueDate: .now.addingTimeInterval(7200)),
        TaskItem(title: "Read book", details: "Finish chapter 4", priority: .low, dueDate: nil)
    ]
}
