import SwiftUI

struct DynamicTypeView_Inaccessible: View {
    @State private var viewModel = DynamicTypeViewModel()

    var body: some View {
        VStack(spacing: 12) {
            Text("Latest Articles")
                // Problem: fixed size — won't grow with the user's text preference
                .font(.system(size: 22, weight: .bold, design: .rounded))
                .foregroundStyle(LabTheme.titleColor)
                .frame(maxWidth: .infinity, alignment: .leading)
            // Missing: .accessibilityAddTraits(.isHeader)

            ForEach(viewModel.articles) { article in
                articleCard(article)
            }
        }
        .padding(LabTheme.contentPadding)
    }

    private func articleCard(_ article: DynamicTypeViewModel.Article) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .top, spacing: 10) {
                // Problem: fixed frame — icon doesn't grow at accessibility sizes
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(LabTheme.accentSoftTint(for: .basics))
                    .frame(width: 32, height: 32)
                    .overlay(
                        Image(systemName: "doc.text.fill")
                            .font(.system(size: 16))
                            .foregroundStyle(LabTheme.accent(for: .basics))
                    )
                // Missing: .accessibilityHidden(true) on decorative icon

                VStack(alignment: .leading, spacing: 4) {
                    Text(article.category)
                        // Problem: fixed size — won't scale
                        .font(.system(size: 11, weight: .semibold))
                        .foregroundStyle(LabTheme.accent(for: .basics))
                        .textCase(.uppercase)

                    Text(article.headline)
                        // Problem: fixed size — won't scale
                        .font(.system(size: 15, weight: .semibold, design: .rounded))
                        .foregroundStyle(LabTheme.titleColor)
                        // Problem: content gets clipped at large sizes instead of wrapping
                        .lineLimit(2)
                }
            }

            Text(article.excerpt)
                // Problem: fixed size — won't scale
                .font(.system(size: 13))
                .foregroundStyle(LabTheme.bodyColor)
                .lineLimit(2)
            // Missing: .fixedSize(horizontal: false, vertical: true)

            // Problem: rigid HStack — clips at large text sizes with no fallback layout
            HStack(spacing: 4) {
                Text(article.byline)
                    .font(.system(size: 11))
                    .foregroundStyle(LabTheme.bodyColor)
                Text("·")
                    .font(.system(size: 11))
                    .foregroundStyle(LabTheme.tertiaryText)
                Text(article.readTime)
                    .font(.system(size: 11))
                    .foregroundStyle(LabTheme.tertiaryText)
                Text("·")
                    .font(.system(size: 11))
                    .foregroundStyle(LabTheme.tertiaryText)
                Text(article.publishedAt)
                    .font(.system(size: 11))
                    .foregroundStyle(LabTheme.tertiaryText)
            }
            // Missing: ViewThatFits to adapt layout for accessibility sizes
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
    DynamicTypeView_Inaccessible()
        .padding()
}
