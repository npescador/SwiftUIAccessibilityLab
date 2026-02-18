import SwiftUI

struct CustomControlView_Inaccessible: View {
    @State private var viewModel = CustomControlViewModel()

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Custom Controls")
                .font(.title2)
                .fontWeight(.semibold)

            VStack(alignment: .leading, spacing: 12) {
                Text("Rating")
                    .font(.headline)
                StarRating_Inaccessible(rating: $viewModel.rating)
                // Missing: adjustable action and combined element.
            }

            VStack(alignment: .leading, spacing: 12) {
                Text("Volume")
                    .font(.headline)

                Slider(value: $viewModel.volume, in: 0...100, step: 5)
                // Missing: accessibility label and value.
            }

            VStack(alignment: .leading, spacing: 12) {
                Text("Accent Color")
                    .font(.headline)

                HStack(spacing: 12) {
                    Circle()
                        .fill(Color.red)
                        .frame(width: 44, height: 44)
                        .onTapGesture { viewModel.selectColor(.red) }

                    Circle()
                        .fill(Color.green)
                        .frame(width: 44, height: 44)
                        .onTapGesture { viewModel.selectColor(.green) }

                    Circle()
                        .fill(Color.blue)
                        .frame(width: 44, height: 44)
                        .onTapGesture { viewModel.selectColor(.blue) }
                }
                // Missing: labels and selected state.
            }
        }
        .padding()
    }
}

#Preview {
    CustomControlView_Inaccessible()
}
