import SwiftUI

struct DynamicTypeView_Accessible: View {
    @State private var viewModel = DynamicTypeViewModel()

    // Key fix: @ScaledMetric scales the icon size proportionally with the
    // user's text size preference — from Default (32pt) up to AX5 (~64pt+).
    @ScaledMetric(relativeTo: .body) private var iconSize: CGFloat = 32

    var body: some View {
        VStack(spacing: 12) {
            Text("Latest Articles")
                .font(.title2.weight(.bold))
                .fontDesign(.rounded)
                .foregroundStyle(LabTheme.titleColor)
                .frame(maxWidth: .infinity, alignment: .leading)
                .accessibilityAddTraits(.isHeader)
                .accessibilityIdentifier("dynamictype.heading")

            ForEach(viewModel.articles) { article in
                articleCard(article)
            }
        }
        .padding(LabTheme.contentPadding)
    }

    private func articleCard(_ article: DynamicTypeViewModel.Article) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .top, spacing: 10) {
                // Key fix: iconSize scales with Dynamic Type
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(LabTheme.accentSoftTint(for: .basics))
                    .frame(width: iconSize, height: iconSize)
                    .overlay(
                        Image(systemName: "doc.text.fill")
                            .font(.system(size: iconSize * 0.5))
                            .foregroundStyle(LabTheme.accent(for: .basics))
                    )
                    .accessibilityHidden(true)

                VStack(alignment: .leading, spacing: 4) {
                    Text(article.category)
                        .font(.caption.weight(.semibold))
                        .foregroundStyle(LabTheme.accent(for: .basics))
                        .textCase(.uppercase)
                        .tracking(0.5)

                    // Key fix: semantic text style — scales automatically
                    Text(article.headline)
                        .font(.subheadline.weight(.semibold))
                        .fontDesign(.rounded)
                        .foregroundStyle(LabTheme.titleColor)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }

            Text(article.excerpt)
                .font(.footnote)
                .foregroundStyle(LabTheme.bodyColor)
                .fixedSize(horizontal: false, vertical: true)

            // Key fix: ViewThatFits adapts the metadata row layout at large text sizes.
            // At default sizes: horizontal (byline · read time · date).
            // At AX sizes: vertical stack so nothing gets clipped.
            ViewThatFits(in: .horizontal) {
                metadataRow(article, axis: .horizontal)
                metadataRow(article, axis: .vertical)
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
        .accessibilityIdentifier("dynamictype.article.\(article.id.uuidString)")
    }

    @ViewBuilder
    private func metadataRow(_ article: DynamicTypeViewModel.Article, axis: Axis) -> some View {
        let byline = Text(article.byline).font(.caption).foregroundStyle(LabTheme.bodyColor)
        let dot = Text(" · ").font(.caption).foregroundStyle(LabTheme.tertiaryText).accessibilityHidden(true)
        let readTime = Text(article.readTime).font(.caption).foregroundStyle(LabTheme.tertiaryText)
        let date = Text(article.publishedAt).font(.caption).foregroundStyle(LabTheme.tertiaryText)

        if axis == .horizontal {
            (byline + dot + readTime + dot + date)
                .lineLimit(1)
        } else {
            VStack(alignment: .leading, spacing: 2) {
                byline
                (readTime + dot + date)
            }
        }
    }
}

#Preview {
    DynamicTypeView_Accessible()
        .padding()
}
