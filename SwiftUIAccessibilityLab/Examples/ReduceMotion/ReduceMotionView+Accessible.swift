import SwiftUI

struct ReduceMotionView_Accessible: View {
    @State private var viewModel = ReduceMotionViewModel()
    // Key fix: read the user's Reduce Motion preference from the environment
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    var body: some View {
        VStack(spacing: 16) {
            header
            goalsList
            if viewModel.allCompleted {
                completionBanner
                    // Key fix: fade in instead of scale+slide when Reduce Motion is on
                    .transition(reduceMotion ? .opacity : .scale.combined(with: .opacity))
            }
        }
        .padding(LabTheme.contentPadding)
        .animation(
            // Key fix: use a simple ease when Reduce Motion is on; spring otherwise
            reduceMotion ? .easeInOut(duration: 0.2) : .spring(response: 0.4, dampingFraction: 0.7),
            value: viewModel.allCompleted
        )
        // Key fix: haptic feedback provides non-motion reinforcement for goal completion
        .sensoryFeedback(.success, trigger: viewModel.allCompleted)
    }

    private var header: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text("Daily Goals")
                    .font(.title2.weight(.bold))
                    .fontDesign(.rounded)
                    .foregroundStyle(LabTheme.titleColor)
                    .accessibilityAddTraits(.isHeader)
                    .accessibilityIdentifier("reducemotion.heading")

                Text("\(viewModel.completedCount) of \(viewModel.totalCount) completed")
                    .font(.subheadline)
                    .foregroundStyle(LabTheme.bodyColor)
                    .accessibilityIdentifier("reducemotion.progress")
            }
            Spacer()
            if viewModel.completedCount > 0 {
                Button("Reset") { viewModel.reset() }
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(LabTheme.accent(for: .advanced))
                    .accessibilityIdentifier("reducemotion.reset.button")
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
                    .accessibilityHidden(true)

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
                    .accessibilityHidden(true)
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
        .accessibilityIdentifier("reducemotion.goal.\(goal.id.uuidString)")
        // Key fix: animate state changes using a simple fade when Reduce Motion is on
        .animation(
            reduceMotion ? .easeInOut(duration: 0.15) : .spring(response: 0.35, dampingFraction: 0.8),
            value: goal.isCompleted
        )
    }

    private var completionBanner: some View {
        HStack(spacing: 12) {
            Text("🎉")
                .font(.title2)
                .accessibilityHidden(true)
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
        .accessibilityElement(children: .combine)
        .accessibilityLabel("All done! Great work today.")
        .accessibilityIdentifier("reducemotion.completion.banner")
    }
}

#Preview {
    ReduceMotionView_Accessible()
        .padding()
}
