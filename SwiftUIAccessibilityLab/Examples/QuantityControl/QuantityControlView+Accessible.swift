import SwiftUI

struct QuantityControlView_Accessible: View {
    @State private var viewModel = QuantityControlViewModel()

    var body: some View {
        VStack(spacing: 12) {
            Text("Cart")
                .font(.title2.weight(.bold))
                .fontDesign(.rounded)
                .foregroundStyle(LabTheme.titleColor)
                .frame(maxWidth: .infinity, alignment: .leading)
                .accessibilityAddTraits(.isHeader)
                .accessibilityIdentifier("quantitycontrol.heading")

            ForEach(viewModel.items) { item in
                cartRow(item)
            }

            Divider()
                .accessibilityHidden(true)

            HStack {
                Text("Total items")
                    .font(.subheadline.weight(.medium))
                    .foregroundStyle(LabTheme.bodyColor)
                Spacer()
                Text("\(viewModel.totalItems)")
                    .font(.subheadline.weight(.bold))
                    .foregroundStyle(LabTheme.titleColor)
                    .accessibilityIdentifier("quantitycontrol.total")
            }
            .accessibilityElement(children: .combine)
            .accessibilityLabel("Total items, \(viewModel.totalItems)")
        }
        .padding(LabTheme.contentPadding)
    }

    private func cartRow(_ item: QuantityControlViewModel.CartItem) -> some View {
        HStack(spacing: 12) {
            Text(item.emoji)
                .font(.title2)
                .accessibilityHidden(true)

            Text(item.name)
                .font(.body.weight(.semibold))
                .foregroundStyle(LabTheme.titleColor)
                .lineLimit(2)
                .fixedSize(horizontal: false, vertical: true)

            Spacer(minLength: 8)

            // Visual stepper UI — same appearance as inaccessible variant
            HStack(spacing: 10) {
                Button {
                    viewModel.decrement(item)
                } label: {
                    Image(systemName: "minus.circle.fill")
                        .font(.title2)
                        .foregroundStyle(LabTheme.accent(for: .customControls))
                }
                .buttonStyle(.plain)

                Text("\(item.quantity)")
                    .font(.title3.weight(.bold))
                    .foregroundStyle(LabTheme.titleColor)
                    .frame(minWidth: 28, alignment: .center)
                    .monospacedDigit()

                Button {
                    viewModel.increment(item)
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .font(.title2)
                        .foregroundStyle(LabTheme.accent(for: .customControls))
                }
                .buttonStyle(.plain)
            }
            // Key fix: VoiceOver sees a native Stepper instead of 3 separate elements.
            // The custom +/- UI remains visible to sighted users.
            .accessibilityRepresentation {
                Stepper(
                    item.name,
                    value: Binding(
                        get: { item.quantity },
                        set: { viewModel.setQuantity($0, for: item) }
                    ),
                    in: 0...99
                )
            }
            .accessibilityIdentifier("quantitycontrol.stepper.\(item.id.uuidString)")
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
    QuantityControlView_Accessible()
        .padding()
}
