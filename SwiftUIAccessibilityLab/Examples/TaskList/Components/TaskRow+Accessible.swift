import SwiftUI

struct TaskRow_Accessible: View {
    let task: TaskItem
    let onToggle: () -> Void
    let onDelete: () -> Void

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: task.isComplete ? "checkmark.circle.fill" : "circle")
                .foregroundStyle(task.isComplete ? .green : .secondary)

            VStack(alignment: .leading, spacing: 4) {
                Text(task.title)
                    .font(.headline)
                if let dueDate = task.dueDate {
                    Text(dueDate, style: .relative)
                        .font(.caption)
                        .foregroundStyle(.secondary)
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
        .accessibilityElement(children: .combine)
        .accessibilityLabel(labelText)
        .accessibilityValue(task.isComplete ? "Completed" : "Not completed")
        .accessibilityAddTraits(.isButton)
        .accessibilityIdentifier("tasklist.row.\(task.id.uuidString)")
        .accessibilityActions {
            Button("Toggle completion", action: onToggle)
            Button("Delete", action: onDelete)
        }
    }

    private var labelText: String {
        var parts: [String] = [task.title, "\(task.priority.rawValue) priority"]
        if let dueDate = task.dueDate {
            parts.append("due \(dueDate.formatted(date: .abbreviated, time: .shortened))")
        }
        return parts.joined(separator: ", ")
    }
}

#Preview {
    TaskRow_Accessible(
        task: TaskItem(title: "Buy groceries", priority: .high, dueDate: .now),
        onToggle: {},
        onDelete: {}
    )
    .padding()
}
