import SwiftUI

/// Shared wrapper that provides consistent context and variant switching for every example.
struct ExampleContainer<AccessibleContent: View, InaccessibleContent: View>: View {
    /// Metadata shown in the example header.
    let metadata: ExampleMetadata
    /// Builder for the accessible implementation.
    let accessibleView: () -> AccessibleContent
    /// Builder for the inaccessible implementation.
    let inaccessibleView: () -> InaccessibleContent

    @State private var variant: ExampleVariant = .accessible

    var body: some View {
        VStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 16) {
                header
                ComparisonToggle(selection: $variant)
                Divider()
            }
            .padding(.horizontal)
            .padding(.top)

            currentView
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        }
        .navigationTitle(metadata.title)
        .navigationBarTitleDisplayMode(.inline)
    }

    @ViewBuilder
    private var currentView: some View {
        switch variant {
        case .accessible:
            accessibleView()
        case .inaccessible:
            inaccessibleView()
        }
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(metadata.title)
                .font(.title2)
                .fontWeight(.semibold)

            Text(metadata.description)
                .font(.body)
                .foregroundStyle(.secondary)

            HStack(spacing: 12) {
                DifficultyBadge(difficulty: metadata.difficulty)
                Label(metadata.category.rawValue, systemImage: metadata.category.icon)
                    .font(.subheadline)
                    .foregroundStyle(metadata.category.color)
            }
        }
        .accessibilityElement(children: .combine)
    }
}
