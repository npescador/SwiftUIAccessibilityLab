import SwiftUI
import Charts

struct DataChartView_Inaccessible: View {
    @State private var viewModel = DataChartViewModel()

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            header
            chart
            statsRow
        }
        .padding(LabTheme.contentPadding)
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Weekly Steps")
                .font(.title2.weight(.bold))
                .fontDesign(.rounded)
                .foregroundStyle(LabTheme.titleColor)
            // Missing: .accessibilityAddTraits(.isHeader)

            Text("Your activity for the past 7 days")
                .font(.subheadline)
                .foregroundStyle(LabTheme.bodyColor)
        }
    }

    private var chart: some View {
        // Problem: bare Chart with no accessibility configuration.
        // VoiceOver reads "Chart" and stops — none of the data is reachable.
        Chart {
            ForEach(viewModel.weeklySteps) { point in
                BarMark(
                    x: .value("Day", point.shortLabel),
                    y: .value("Steps", point.value)
                )
                .foregroundStyle(LabTheme.accent(for: .dataVisualization).gradient)
                .cornerRadius(6)
                // Missing: .accessibilityLabel and .accessibilityValue per bar
            }

            RuleMark(y: .value("Goal", 10_000))
                .lineStyle(StrokeStyle(lineWidth: 1.5, dash: [6, 4]))
                .foregroundStyle(LabTheme.tertiaryText)
                .annotation(position: .top, alignment: .leading) {
                    Text("Goal")
                        .font(.caption2.weight(.semibold))
                        .foregroundStyle(LabTheme.tertiaryText)
                }
            // Missing: .accessibilityHidden(true) on the goal reference line
        }
        // Missing: .chartAccessibilityLabel — no chart-level description for VoiceOver
        // Audio Graph is also unavailable without this
        .frame(height: 200)
    }

    private var statsRow: some View {
        HStack(spacing: 12) {
            statCell(label: "Average", value: viewModel.formattedSteps(viewModel.average))
            statCell(label: "Best day", value: viewModel.maximumDay?.label ?? "–")
            statCell(label: "Total", value: viewModel.formattedSteps(viewModel.totalSteps))
        }
    }

    private func statCell(label: String, value: String) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(label)
                .font(.caption.weight(.semibold))
                .textCase(.uppercase)
                .tracking(0.5)
                .foregroundStyle(LabTheme.tertiaryText)
            Text(value)
                .font(.subheadline.weight(.bold))
                .fontDesign(.rounded)
                .foregroundStyle(LabTheme.titleColor)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: LabTheme.cornerRadiusSmall, style: .continuous)
                .fill(LabTheme.raisedSurface)
                .overlay(
                    RoundedRectangle(cornerRadius: LabTheme.cornerRadiusSmall, style: .continuous)
                        .stroke(LabTheme.border.opacity(0.6))
                )
        )
        // Missing: .accessibilityElement(children: .combine) — VoiceOver reads the label
        // ("AVERAGE") and value ("7,453") as separate elements with no connection between them
    }
}

#Preview {
    DataChartView_Inaccessible()
        .padding()
}
