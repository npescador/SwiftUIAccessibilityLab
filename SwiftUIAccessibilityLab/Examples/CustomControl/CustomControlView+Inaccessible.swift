import SwiftUI

struct CustomControlView_Inaccessible: View {
    @State private var viewModel = CustomControlViewModel()

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Custom Controls")
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundStyle(LabTheme.titleColor)

            LabSectionCard {
                VStack(alignment: .leading, spacing: 12) {
                    LabSectionHeader("Rating", subtitle: "A custom step-based control with adjustable actions.")
                    StarRating_Inaccessible(rating: $viewModel.rating)
                    // Missing: adjustable action and combined element.
                }
            }

            LabSectionCard {
                VStack(alignment: .leading, spacing: 12) {
                    LabSectionHeader("Volume", subtitle: "\(Int(viewModel.volume)) percent")

                    Slider(value: $viewModel.volume, in: 0...100, step: 5)
                        .tint(LabTheme.accent(for: .customControls))
                    // Missing: accessibility label and value.
                }
            }

            LabSectionCard {
                VStack(alignment: .leading, spacing: 12) {
                    LabSectionHeader("Accent Color", subtitle: "Select a visual accent.")

                    HStack(spacing: 12) {
                        Circle()
                            .fill(Color.red)
                            .frame(width: 44, height: 44)
                            .overlay {
                                Circle()
                                    .stroke(LabTheme.surface, lineWidth: 2)
                                    .padding(1)
                            }
                            .shadow(color: LabTheme.shadow, radius: 4, x: 0, y: 2)
                            .onTapGesture { viewModel.selectColor(.red) }

                        Circle()
                            .fill(Color.green)
                            .frame(width: 44, height: 44)
                            .overlay {
                                Circle()
                                    .stroke(LabTheme.surface, lineWidth: 2)
                                    .padding(1)
                            }
                            .shadow(color: LabTheme.shadow, radius: 4, x: 0, y: 2)
                            .onTapGesture { viewModel.selectColor(.green) }

                        Circle()
                            .fill(Color.blue)
                            .frame(width: 44, height: 44)
                            .overlay {
                                Circle()
                                    .stroke(LabTheme.surface, lineWidth: 2)
                                    .padding(1)
                            }
                            .shadow(color: LabTheme.shadow, radius: 4, x: 0, y: 2)
                            .onTapGesture { viewModel.selectColor(.blue) }
                    }
                }
            }
        }
        .padding()
    }
}

#Preview {
    CustomControlView_Inaccessible()
}
