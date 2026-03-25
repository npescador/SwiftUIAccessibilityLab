import Testing
@testable import SwiftUIAccessibilityLab

@MainActor
@Suite("DataChartViewModel")
struct DataChartViewModelTests {

    @Test("ViewModel initialises with 7 data points")
    func defaultDataPoints() {
        let viewModel = DataChartViewModel()

        #expect(viewModel.weeklySteps.count == 7)
    }

    @Test("Average is calculated correctly")
    func average() {
        let viewModel = DataChartViewModel()
        let expected = viewModel.weeklySteps.reduce(0.0) { $0 + $1.value } / 7.0

        #expect(viewModel.average == expected)
    }

    @Test("Maximum day is Saturday (14,300 steps)")
    func maximumDay() {
        let viewModel = DataChartViewModel()

        #expect(viewModel.maximumDay?.label == "Saturday")
        #expect(viewModel.maximumDay?.value == 14_300)
    }

    @Test("Minimum day is Sunday (3,200 steps)")
    func minimumDay() {
        let viewModel = DataChartViewModel()

        #expect(viewModel.minimumDay?.label == "Sunday")
        #expect(viewModel.minimumDay?.value == 3_200)
    }

    @Test("totalSteps sums all data points")
    func totalSteps() {
        let viewModel = DataChartViewModel()
        let expected = viewModel.weeklySteps.reduce(0.0) { $0 + $1.value }

        #expect(viewModel.totalSteps == expected)
    }

    @Test("formattedSteps returns a non-empty string")
    func formattedSteps() {
        let viewModel = DataChartViewModel()
        let result = viewModel.formattedSteps(7_241)

        #expect(result.isEmpty == false)
    }

    @Test("Each data point has unique id")
    func uniqueIdentifiers() {
        let viewModel = DataChartViewModel()
        let ids = viewModel.weeklySteps.map(\.id)
        let uniqueIds = Set(ids)

        #expect(ids.count == uniqueIds.count)
    }
}
