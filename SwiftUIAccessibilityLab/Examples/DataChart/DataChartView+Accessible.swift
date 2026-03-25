import SwiftUI
import Charts

struct DataChartView_Accessible: View {
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
                .accessibilityAddTraits(.isHeader)
                .accessibilityIdentifier("datachart.heading")

            Text("Your activity for the past 7 days")
                .font(.subheadline)
                .foregroundStyle(LabTheme.bodyColor)
        }
    }

    private var chart: some View {
        Chart {
            ForEach(viewModel.weeklySteps) { point in
                BarMark(
                    x: .value("Day", point.shortLabel),
                    y: .value("Steps", point.value)
                )
                .foregroundStyle(LabTheme.accent(for: .dataVisualization).gradient)
                .cornerRadius(6)
                // Key fix: per-mark accessibility label and value.
                // VoiceOver reads each bar as a discrete data point.
                .accessibilityLabel(point.label)
                .accessibilityValue("\(viewModel.formattedSteps(point.value)) steps")
            }

            // Reference line for daily goal
            RuleMark(y: .value("Goal", 10_000))
                .lineStyle(StrokeStyle(lineWidth: 1.5, dash: [6, 4]))
                .foregroundStyle(LabTheme.tertiaryText)
                .annotation(position: .top, alignment: .leading) {
                    Text("Goal")
                        .font(.caption2.weight(.semibold))
                        .foregroundStyle(LabTheme.tertiaryText)
                }
                // The goal line is visual context; mark it hidden so VoiceOver
                // doesn't navigate to it as a separate element.
                .accessibilityHidden(true)
        }
        // Key fix: chart-level label gives VoiceOver context before navigating marks.
        // Swift Charts automatically enables Audio Graph when this is set.
        .chartAccessibilityLabel("Weekly steps bar chart")
        .frame(height: 200)
        .accessibilityIdentifier("datachart.chart")
    }

    private var statsRow: some View {
        HStack(spacing: 12) {
            statCell(
                label: "Average",
                value: viewModel.formattedSteps(viewModel.average),
                identifier: "datachart.stat.average"
            )
            statCell(
                label: "Best day",
                value: viewModel.maximumDay?.label ?? "–",
                identifier: "datachart.stat.best"
            )
            statCell(
                label: "Total",
                value: viewModel.formattedSteps(viewModel.totalSteps),
                identifier: "datachart.stat.total"
            )
        }
    }

    private func statCell(label: String, value: String, identifier: String) -> some View {
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
        // Key fix: combine label + value into a single meaningful announcement
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(label): \(value)")
        .accessibilityIdentifier(identifier)
    }
}

#Preview {
    DataChartView_Accessible()
        .padding()
}
