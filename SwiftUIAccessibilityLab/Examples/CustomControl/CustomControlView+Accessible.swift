import SwiftUI

struct CustomControlView_Accessible: View {
    @State private var viewModel = CustomControlViewModel()

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Custom Controls")
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundStyle(LabTheme.titleColor)
                .accessibilityAddTraits(.isHeader)

            LabSectionCard {
                VStack(alignment: .leading, spacing: 12) {
                    LabSectionHeader("Rating", subtitle: "A custom step-based control with adjustable actions.")
                    StarRating_Accessible(rating: $viewModel.rating)
                }
            }

            LabSectionCard {
                VStack(alignment: .leading, spacing: 12) {
                    LabSectionHeader("Volume", subtitle: "\(Int(viewModel.volume)) percent")

                    Slider(value: $viewModel.volume, in: 0...100, step: 5)
                        .tint(LabTheme.accent(for: .customControls))
                        .accessibilityIdentifier("customcontrol.volume.slider")
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
            }

            LabSectionCard {
                VStack(alignment: .leading, spacing: 12) {
                    LabSectionHeader("Accent Color", subtitle: "Select a visual accent.")

                    HStack(spacing: 12) {
                        colorSwatch(.red, label: "Red")
                        colorSwatch(.green, label: "Green")
                        colorSwatch(.blue, label: "Blue")
                    }
                }
            }
        }
        .padding()
    }

    private func colorSwatch(_ color: Color, label: String) -> some View {
        Button {
            viewModel.selectColor(color)
            AccessibilityHelpers.announce("\(label) selected")
        } label: {
            Circle()
                .fill(color)
                .frame(width: 44, height: 44)
                .overlay {
                    Circle()
                        .stroke(LabTheme.surface, lineWidth: 2)
                        .padding(1)
                }
                .overlay {
                    if viewModel.selectedColor == color {
                        Image(systemName: "checkmark")
                            .foregroundStyle(.white)
                    }
                }
                .shadow(color: LabTheme.shadow, radius: 4, x: 0, y: 2)
        }
        .buttonStyle(.plain)
        .accessibilityIdentifier("customcontrol.color.\(label.lowercased())")
        .accessibilityLabel(label)
        .accessibilityAddTraits(viewModel.selectedColor == color ? .isSelected : [])
    }
}

#Preview {
    CustomControlView_Accessible()
}
