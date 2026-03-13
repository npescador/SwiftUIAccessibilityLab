import SwiftUI
import Testing
@testable import SwiftUIAccessibilityLab

@MainActor
@Suite("CustomControlViewModel")
struct CustomControlViewModelTests {
    @Test("Rating is clamped between 0 and 5")
    func clampRating() {
        let viewModel = CustomControlViewModel()

        viewModel.setRating(8)
        #expect(viewModel.rating == 5)

        viewModel.setRating(-1)
        #expect(viewModel.rating == 0)
    }

    @Test("Volume stays within bounds")
    func adjustVolume() {
        let viewModel = CustomControlViewModel()

        viewModel.adjustVolume(by: 70)
        #expect(viewModel.volume == 100)

        viewModel.adjustVolume(by: -200)
        #expect(viewModel.volume == 0)
    }

    @Test("Color selection updates selected color")
    func selectColor() {
        let viewModel = CustomControlViewModel()

        viewModel.selectColor(.green)

        #expect(viewModel.selectedColor == .green)
    }
}
