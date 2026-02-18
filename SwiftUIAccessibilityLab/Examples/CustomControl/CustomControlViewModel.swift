import Foundation
import Observation
import SwiftUI

@Observable
/// Holds state and mutation logic for the custom control example.
final class CustomControlViewModel {
    var rating = 3
    var volume: Double = 50
    var selectedColor: Color = .blue

    /// Sets rating while enforcing supported bounds.
    func setRating(_ newRating: Int) {
        rating = min(max(newRating, 0), 5)
    }

    /// Adjusts volume while clamping to 0...100.
    func adjustVolume(by delta: Double) {
        volume = min(max(volume + delta, 0), 100)
    }

    /// Updates currently selected accent color.
    func selectColor(_ color: Color) {
        selectedColor = color
    }
}
