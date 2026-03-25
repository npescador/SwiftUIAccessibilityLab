import SwiftUI

struct CustomRotorView_Accessible: View {
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
        // Key fix: custom rotor lets VoiceOver users jump between headings with a
        // flick of the rotor instead of swiping through every paragraph word by word.
        .accessibilityRotor("Headings") {
            ForEach(viewModel.sections) { section in
                AccessibilityRotorEntry(section.heading, id: section.id)
            }
        }
        .accessibilityIdentifier("customrotor.scroll")
    }

    private var articleHeader: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(viewModel.articleTitle)
                .font(.title2.weight(.bold))
                .fontDesign(.rounded)
                .foregroundStyle(LabTheme.titleColor)
                .fixedSize(horizontal: false, vertical: true)
                // Key fix: mark the article title as an h1 heading so VoiceOver
                // can navigate to it via the Headings rotor.
                .accessibilityAddTraits(.isHeader)
                .accessibilityHeading(.h1)
                .accessibilityIdentifier("customrotor.article.title")

            HStack(spacing: 6) {
                Text(viewModel.articleByline)
                    .font(.subheadline.weight(.medium))
                    .foregroundStyle(LabTheme.bodyColor)
                Text("·")
                    .foregroundStyle(LabTheme.tertiaryText)
                    .accessibilityHidden(true)
                Text(viewModel.articleDate)
                    .font(.subheadline)
                    .foregroundStyle(LabTheme.tertiaryText)
                Text("·")
                    .foregroundStyle(LabTheme.tertiaryText)
                    .accessibilityHidden(true)
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
                // Key fix: .isHeader trait exposes the element to VoiceOver's built-in
                // Headings rotor. .accessibilityHeading(.h2) provides hierarchy context.
                .accessibilityAddTraits(.isHeader)
                .accessibilityHeading(.h2)
                // Key fix: stable SwiftUI view identity lets the rotor resolve
                // AccessibilityRotorEntry(id: section.id) to this exact view.
                .id(section.id)

            Text(section.body)
                .font(.body)
                .foregroundStyle(LabTheme.bodyColor)
                .fixedSize(horizontal: false, vertical: true)
        }
    }
}

#Preview {
    CustomRotorView_Accessible()
        .padding()
}
