import SwiftUI

struct QuantityControlView_Inaccessible: View {
    @State private var viewModel = QuantityControlViewModel()

    var body: some View {
        VStack(spacing: 12) {
            Text("Cart")
                .font(.title2.weight(.bold))
                .fontDesign(.rounded)
                .foregroundStyle(LabTheme.titleColor)
                .frame(maxWidth: .infinity, alignment: .leading)
            // Missing: .accessibilityAddTraits(.isHeader) — VoiceOver won't recognise this as a heading

            ForEach(viewModel.items) { item in
                cartRow(item)
            }

            Divider()

            HStack {
                Text("Total items")
                    .font(.subheadline.weight(.medium))
                    .foregroundStyle(LabTheme.bodyColor)
                Spacer()
                Text("\(viewModel.totalItems)")
                    .font(.subheadline.weight(.bold))
                    .foregroundStyle(LabTheme.titleColor)
            }
            // Missing: .accessibilityElement(children: .combine) — VoiceOver reads "Total items"
            // and "3" as two unrelated elements, with no context that the number is the total
        }
        .padding(LabTheme.contentPadding)
    }

    private func cartRow(_ item: QuantityControlViewModel.CartItem) -> some View {
        HStack(spacing: 12) {
            Text(item.emoji)
                .font(.title2)
            // Missing: .accessibilityHidden(true) — VoiceOver reads the emoji as a separate element

            Text(item.name)
                .font(.body.weight(.semibold))
                .foregroundStyle(LabTheme.titleColor)
                .lineLimit(2)
                .fixedSize(horizontal: false, vertical: true)

            Spacer(minLength: 8)

            // Problem: three separate elements with no semantic relationship.
            // VoiceOver reads "minus.circle.fill image", "1", "plus.circle.fill image" — no
            // indication of what item they relate to, or how to interact with them.
            HStack(spacing: 10) {
                Image(systemName: "minus.circle.fill")
                    .font(.title2)
                    .foregroundStyle(LabTheme.tertiaryText)
                    .onTapGesture { viewModel.decrement(item) }
                // Missing: Button wrapper — onTapGesture is not reachable via VoiceOver double-tap
                // Missing: accessibilityLabel

                Text("\(item.quantity)")
                    .font(.title3.weight(.bold))
                    .foregroundStyle(LabTheme.titleColor)
                    .frame(minWidth: 28, alignment: .center)
                    .monospacedDigit()
                // Missing: accessibilityLabel — VoiceOver just reads the number with no context

                Image(systemName: "plus.circle.fill")
                    .font(.title2)
                    .foregroundStyle(LabTheme.accent(for: .customControls))
                    .onTapGesture { viewModel.increment(item) }
                // Missing: Button wrapper — onTapGesture is not reachable via VoiceOver double-tap
                // Missing: accessibilityLabel
            }
        }
        .padding(LabTheme.contentPadding)
        .background(
            RoundedRectangle(cornerRadius: LabTheme.cornerRadiusMedium, style: .continuous)
                .fill(LabTheme.surface)
                .overlay(
                    RoundedRectangle(cornerRadius: LabTheme.cornerRadiusMedium, style: .continuous)
                        .stroke(LabTheme.border.opacity(0.7))
                )
        )
    }
}

#Preview {
    QuantityControlView_Inaccessible()
        .padding()
}
