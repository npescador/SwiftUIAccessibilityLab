import SwiftUI

struct CustomRotorView_Inaccessible: View {
    @State private var viewModel = CustomRotorViewModel()

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                articleHeader
                ForEach(viewModel.sections) { section in
                    sectionView(section)
                }
            }
            .padding(LabTheme.contentPadding)
        }
        // Missing: .accessibilityRotor("Headings") — VoiceOver users must swipe through
        // every paragraph to reach a later section, with no shortcut available.
    }

    private var articleHeader: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(viewModel.articleTitle)
                .font(.title2.weight(.bold))
                .fontDesign(.rounded)
                .foregroundStyle(LabTheme.titleColor)
                .fixedSize(horizontal: false, vertical: true)
            // Missing: .accessibilityAddTraits(.isHeader) and .accessibilityHeading(.h1)
            // VoiceOver reads this as plain static text, not a navigable heading.

            HStack(spacing: 6) {
                Text(viewModel.articleByline)
                    .font(.subheadline.weight(.medium))
                    .foregroundStyle(LabTheme.bodyColor)
                Text("·")
                    .foregroundStyle(LabTheme.tertiaryText)
                // Missing: .accessibilityHidden(true) — VoiceOver reads "·" aloud
                Text(viewModel.articleDate)
                    .font(.subheadline)
                    .foregroundStyle(LabTheme.tertiaryText)
                Text("·")
                    .foregroundStyle(LabTheme.tertiaryText)
                // Missing: .accessibilityHidden(true)
                Text(viewModel.readTime)
                    .font(.subheadline)
                    .foregroundStyle(LabTheme.tertiaryText)
            }
        }
    }

    private func sectionView(_ section: CustomRotorViewModel.Section) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(section.heading)
                .font(.title3.weight(.bold))
                .fontDesign(.rounded)
                .foregroundStyle(LabTheme.titleColor)
            // Missing: .accessibilityAddTraits(.isHeader) — VoiceOver cannot distinguish
            // this bold text from regular content, and the Headings rotor entry is absent.
            // Missing: .accessibilityHeading(.h2) — no heading hierarchy is communicated.
            // Missing: .id(section.id) — rotor entries cannot resolve to this view.

            Text(section.body)
                .font(.body)
                .foregroundStyle(LabTheme.bodyColor)
                .fixedSize(horizontal: false, vertical: true)
        }
    }
}

#Preview {
    CustomRotorView_Inaccessible()
        .padding()
}
