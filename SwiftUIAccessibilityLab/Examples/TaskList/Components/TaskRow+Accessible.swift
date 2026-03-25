import SwiftUI

struct TaskRow_Accessible: View {
    let task: TaskItem
    let onToggle: () -> Void
    let onDelete: () -> Void

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: task.isComplete ? "checkmark.circle.fill" : "circle")
                .font(.title3)
                .foregroundStyle(task.isComplete ? LabTheme.accent(for: .forms) : LabTheme.tertiaryText)

            VStack(alignment: .leading, spacing: 4) {
                Text(task.title)
                    .font(.title3.weight(.semibold))
                    .foregroundStyle(LabTheme.titleColor)
                if let dueDate = task.dueDate {
                    Text(dueDate, style: .relative)
                        .font(.caption)
                        .foregroundStyle(LabTheme.tertiaryText)
                }
            }

            Spacer()

            Text(task.priority.rawValue)
                .font(.caption.weight(.semibold))
                .foregroundStyle(LabTheme.titleColor)
                .padding(.horizontal, 10)
                .padding(.vertical, 6)
                .background(
                    Capsule(style: .continuous)
                        .fill(LabTheme.mutedSurface)
                )
        }
        .padding(LabTheme.contentPadding)
        .background(
            RoundedRectangle(cornerRadius: LabTheme.cornerRadiusMedium, style: .continuous)
                .fill(LabTheme.surface)
                .overlay(
                    RoundedRectangle(cornerRadius: LabTheme.cornerRadiusMedium, style: .continuous)
                        .stroke(LabTheme.border.opacity(0.7))
                )
        )
        .accessibilityElement(children: .combine)
        .accessibilityLabel(labelText)
        .accessibilityValue(task.isComplete ? "Completed" : "Not completed")
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
