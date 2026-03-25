import SwiftUI

struct ReduceMotionView_Inaccessible: View {
    @State private var viewModel = ReduceMotionViewModel()
    // Problem: Reduce Motion preference is never read — animations always run

    var body: some View {
        VStack(spacing: 16) {
            header
            goalsList
            if viewModel.allCompleted {
                completionBanner
                    // Problem: scale+slide transition always plays regardless of Reduce Motion
                    .transition(.scale.combined(with: .opacity))
            }
        }
        .padding(LabTheme.contentPadding)
        // Problem: spring always runs — can cause vestibular discomfort when Reduce Motion is on
        .animation(.spring(response: 0.4, dampingFraction: 0.7), value: viewModel.allCompleted)
    }

    private var header: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text("Daily Goals")
                    .font(.title2.weight(.bold))
                    .fontDesign(.rounded)
                    .foregroundStyle(LabTheme.titleColor)
                // Missing: .accessibilityAddTraits(.isHeader)

                Text("\(viewModel.completedCount) of \(viewModel.totalCount) completed")
                    .font(.subheadline)
                    .foregroundStyle(LabTheme.bodyColor)
            }
            Spacer()
            if viewModel.completedCount > 0 {
                Button("Reset") { viewModel.reset() }
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(LabTheme.accent(for: .advanced))
            }
        }
    }

    private var goalsList: some View {
        VStack(spacing: 10) {
            ForEach(viewModel.goals) { goal in
                goalRow(goal)
            }
        }
    }

    private func goalRow(_ goal: ReduceMotionViewModel.Goal) -> some View {
        Button {
            viewModel.toggle(goal)
        } label: {
            HStack(spacing: 14) {
                Text(goal.emoji)
                    .font(.title3)
                // Missing: .accessibilityHidden(true)

                Text(goal.title)
                    .font(.body.weight(.medium))
                    .foregroundStyle(LabTheme.titleColor)
                    .strikethrough(goal.isCompleted, color: LabTheme.tertiaryText)

                Spacer()

                Image(systemName: goal.isCompleted ? "checkmark.circle.fill" : "circle")
                    .font(.title3)
                    .foregroundStyle(
                        goal.isCompleted
                            ? LabTheme.accent(for: .basics)
                            : LabTheme.tertiaryText
                    )
                // Missing: .accessibilityHidden(true)
            }
            .padding(LabTheme.contentPadding)
            .background(
                RoundedRectangle(cornerRadius: LabTheme.cornerRadiusMedium, style: .continuous)
                    .fill(LabTheme.surface)
                    .overlay(
                        RoundedRectangle(cornerRadius: LabTheme.cornerRadiusMedium, style: .continuous)
                            .stroke(
                                goal.isCompleted
                                    ? LabTheme.accent(for: .basics).opacity(0.4)
                                    : LabTheme.border.opacity(0.7)
                            )
                    )
            )
        }
        .buttonStyle(.plain)
        .accessibilityLabel(goal.title)
        .accessibilityValue(goal.isCompleted ? "Completed" : "Not completed")
        // Problem: spring bounce always plays — no respect for Reduce Motion
        .animation(.spring(response: 0.35, dampingFraction: 0.8), value: goal.isCompleted)
    }

    private var completionBanner: some View {
        HStack(spacing: 12) {
            Text("🎉")
                .font(.title2)
            // Missing: .accessibilityHidden(true)
            VStack(alignment: .leading, spacing: 2) {
                Text("All done!")
                    .font(.subheadline.weight(.bold))
                    .foregroundStyle(LabTheme.titleColor)
                Text("Great work today.")
                    .font(.caption)
                    .foregroundStyle(LabTheme.bodyColor)
            }
            Spacer()
        }
        .padding(LabTheme.contentPadding)
        .background(
            RoundedRectangle(cornerRadius: LabTheme.cornerRadiusMedium, style: .continuous)
                .fill(LabTheme.accent(for: .basics).opacity(0.12))
                .overlay(
                    RoundedRectangle(cornerRadius: LabTheme.cornerRadiusMedium, style: .continuous)
                        .stroke(LabTheme.accent(for: .basics).opacity(0.3))
                )
        )
        // Missing: .accessibilityElement(children: .combine)
    }
}

#Preview {
    ReduceMotionView_Inaccessible()
        .padding()
}
