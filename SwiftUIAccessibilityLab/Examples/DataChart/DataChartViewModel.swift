import Foundation
import Observation

@MainActor
@Observable
/// Provides weekly step-count data for the Data Chart lab.
final class DataChartViewModel {
    struct DataPoint: Identifiable {
        let id: UUID
        let label: String
        let shortLabel: String
        let value: Double

        init(id: UUID = UUID(), label: String, shortLabel: String, value: Double) {
            self.id = id
            self.label = label
            self.shortLabel = shortLabel
            self.value = value
        }
    }

    let weeklySteps: [DataPoint] = [
        DataPoint(label: "Monday",    shortLabel: "Mon", value: 7_241),
        DataPoint(label: "Tuesday",   shortLabel: "Tue", value: 9_832),
        DataPoint(label: "Wednesday", shortLabel: "Wed", value: 5_500),
        DataPoint(label: "Thursday",  shortLabel: "Thu", value: 11_200),
        DataPoint(label: "Friday",    shortLabel: "Fri", value: 8_900),
        DataPoint(label: "Saturday",  shortLabel: "Sat", value: 14_300),
        DataPoint(label: "Sunday",    shortLabel: "Sun", value: 3_200),
    ]

    var average: Double {
        weeklySteps.reduce(0.0) { $0 + $1.value } / Double(weeklySteps.count)
    }

    var maximumDay: DataPoint? {
        weeklySteps.max(by: { $0.value < $1.value })
    }

    var minimumDay: DataPoint? {
        weeklySteps.min(by: { $0.value < $1.value })
    }

    var totalSteps: Double {
        weeklySteps.reduce(0.0) { $0 + $1.value }
    }

    func formattedSteps(_ value: Double) -> String {
        Int(value).formatted()
    }
}
