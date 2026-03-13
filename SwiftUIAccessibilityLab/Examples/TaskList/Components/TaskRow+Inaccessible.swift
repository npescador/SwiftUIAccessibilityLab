import SwiftUI

struct TaskRow_Inaccessible: View {
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
        .onTapGesture {
            onToggle()
        }
        // Missing: combined accessibility label and actions for swipe alternatives.
    }
}

#Preview {
    TaskRow_Inaccessible(
        task: TaskItem(title: "Buy groceries", priority: .high, dueDate: .now),
        onToggle: {},
        onDelete: {}
    )
    .padding()
}
