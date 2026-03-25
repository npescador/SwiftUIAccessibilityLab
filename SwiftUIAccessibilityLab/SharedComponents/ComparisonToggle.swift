import SwiftUI

enum ExampleVariant: String, CaseIterable, Identifiable {
    case accessible = "Accessible"
    case inaccessible = "Inaccessible"

    var id: String { rawValue }
}

struct ComparisonToggle: View {
    @Binding var selection: ExampleVariant
    var isCompact: Bool = false

    var body: some View {
        VStack(alignment: .leading, spacing: isCompact ? 8 : LabTheme.spacingS) {
            Text("Compare implementations")
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(LabTheme.titleColor)

            if !isCompact {
                Text("Switch between the intentionally flawed version and the accessible solution.")
                    .font(.subheadline)
                    .foregroundStyle(LabTheme.bodyColor)
            }

            HStack(spacing: 8) {
                ForEach(ExampleVariant.allCases) { variant in
                    button(for: variant)
                }
            }
            .padding(6)
            .background(
                Capsule(style: .continuous)
                    .fill(LabTheme.raisedSurface)
                    .overlay(
                        Capsule(style: .continuous)
                            .stroke(LabTheme.border.opacity(0.9))
                    )
            )
            .accessibilityIdentifier("comparison.toggle")
        }
    }

    private func button(for variant: ExampleVariant) -> some View {
        Button {
            selection = variant
        } label: {
            Text(variant.rawValue)
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(selection == variant ? LabTheme.titleColor : LabTheme.tertiaryText)
                .frame(maxWidth: .infinity)
                .padding(.vertical, isCompact ? 10 : 11)
                .background(
                    Capsule(style: .continuous)
                        .fill(selection == variant ? LabTheme.surface : Color.clear)
                        .shadow(
                            color: selection == variant ? LabTheme.shadow : .clear,
                            radius: 5,
                            x: 0,
                            y: 2
                        )
                )
        }
        .buttonStyle(.plain)
        .accessibilityIdentifier("comparison.option.\(variant.rawValue.lowercased())")
        .accessibilityAddTraits(selection == variant ? .isSelected : [])
    }
}

#Preview {
    ComparisonToggle(selection: .constant(.accessible))
        .padding()
}
