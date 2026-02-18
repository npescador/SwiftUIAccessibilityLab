import Foundation
import Observation
import SwiftUI

@Observable
final class CustomControlViewModel {
    var rating = 3
    var volume: Double = 50
    var selectedColor: Color = .blue

    func setRating(_ newRating: Int) {
        rating = min(max(newRating, 0), 5)
    }

    func adjustVolume(by delta: Double) {
        volume = min(max(volume + delta, 0), 100)
    }

    func selectColor(_ color: Color) {
        selectedColor = color
    }
}
