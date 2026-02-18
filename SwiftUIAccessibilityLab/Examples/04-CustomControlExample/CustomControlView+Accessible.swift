import SwiftUI

struct CustomControlView_Accessible: View {
    @State private var viewModel = CustomControlViewModel()

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Custom Controls")
                .font(.title2)
                .fontWeight(.semibold)
                .accessibilityAddTraits(.isHeader)

            VStack(alignment: .leading, spacing: 12) {
                Text("Rating")
                    .font(.headline)
                StarRating_Accessible(rating: $viewModel.rating)
            }

            VStack(alignment: .leading, spacing: 12) {
                Text("Volume")
                    .font(.headline)

                Slider(value: $viewModel.volume, in: 0...100, step: 5)
                    .accessibilityLabel("Volume")
                    .accessibilityValue("\(Int(viewModel.volume)) percent")
                    .accessibilityAdjustableAction { direction in
                        switch direction {
                        case .increment:
                            viewModel.adjustVolume(by: 5)
                        case .decrement:
                            viewModel.adjustVolume(by: -5)
                        @unknown default:
                            break
                        }
                    }
                    .accessibilityHint("Swipe up or down to adjust")
            }

            VStack(alignment: .leading, spacing: 12) {
                Text("Accent Color")
                    .font(.headline)

                HStack(spacing: 12) {
                    colorSwatch(.red, label: "Red")
                    colorSwatch(.green, label: "Green")
                    colorSwatch(.blue, label: "Blue")
                }
            }
        }
        .padding()
    }

    private func colorSwatch(_ color: Color, label: String) -> some View {
        Circle()
            .fill(color)
            .frame(width: 44, height: 44)
            .overlay {
                if viewModel.selectedColor == color {
                    Image(systemName: "checkmark")
                        .foregroundStyle(.white)
                }
            }
            .onTapGesture {
                viewModel.selectColor(color)
                AccessibilityHelpers.announce("\(label) selected")
            }
            .accessibilityLabel(label)
            .accessibilityAddTraits(viewModel.selectedColor == color ? .isSelected : [])
            .accessibilityHint("Double-tap to select")
    }
}

#Preview {
    CustomControlView_Accessible()
}
