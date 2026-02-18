import SwiftUI

enum ExampleVariant: String, CaseIterable, Identifiable {
    case accessible = "Accessible"
    case inaccessible = "Inaccessible"

    var id: String { rawValue }
}

struct ComparisonToggle: View {
    @Binding var selection: ExampleVariant

    var body: some View {
        Picker("Version", selection: $selection) {
            ForEach(ExampleVariant.allCases) { variant in
                Text(variant.rawValue).tag(variant)
            }
        }
        .pickerStyle(.segmented)
        .accessibilityLabel("Example version")
        .accessibilityHint("Switch between accessible and inaccessible versions")
    }
}

#Preview {
    ComparisonToggle(selection: .constant(.accessible))
        .padding()
}
