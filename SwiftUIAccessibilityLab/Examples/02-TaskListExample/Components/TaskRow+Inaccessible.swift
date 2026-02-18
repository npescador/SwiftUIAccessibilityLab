import SwiftUI

struct TaskRow_Inaccessible: View {
    let task: Task
    let onToggle: () -> Void
    let onDelete: () -> Void

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: task.isComplete ? "checkmark.circle.fill" : "circle")

            VStack(alignment: .leading, spacing: 4) {
                Text(task.title)
                if let dueDate = task.dueDate {
                    Text(dueDate, style: .relative)
                        .font(.caption)
                }
            }

            Spacer()

            Text(task.priority.rawValue)
                .font(.caption)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(Color.secondary.opacity(0.15))
                .clipShape(Capsule())
        }
        .onTapGesture {
            onToggle()
        }
        // Missing: combined accessibility label and actions for swipe alternatives.
    }
}

#Preview {
    TaskRow_Inaccessible(
        task: Task(title: "Buy groceries", priority: .high, dueDate: .now),
        onToggle: {},
        onDelete: {}
    )
    .padding()
}
