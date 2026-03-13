import SwiftUI

enum LabTheme {
    static let pageBackground = Color("LabPageBackground")
    static let heroTint = Color("LabHeroTint")
    static let surface = Color("LabSurface")
    static let raisedSurface = Color("LabRaisedSurface")
    static let mutedSurface = Color("LabMutedSurface")
    static let controlSurface = Color("LabControlSurface")
    static let border = Color("LabBorder")
    static let shadow = Color("LabShadow")
    static let titleColor = Color("LabTitleColor")
    static let bodyColor = Color("LabBodyColor")
    static let tertiaryText = Color("LabTertiaryText")
    static let buttonFill = Color("LabButtonFill")
    static let buttonForeground = Color("LabButtonForeground")
    static let dangerColor = Color("LabDangerColor")
    static let dangerTint = Color("LabDangerTint")
    static let dangerBorder = Color("LabDangerBorder")

    static let cornerRadiusLarge: CGFloat = 28
    static let cornerRadiusMedium: CGFloat = 22
    static let cornerRadiusSmall: CGFloat = 16

    static let spacingXS: CGFloat = 6
    static let spacingS: CGFloat = 10
    static let spacingM: CGFloat = 16
    static let spacingL: CGFloat = 24
    static let spacingXL: CGFloat = 32

    static let shellPadding: CGFloat = 14
    static let contentPadding: CGFloat = 16
    static let compactControlHeight: CGFloat = 44
    static func accent(for category: ExampleCategory) -> Color {
        switch category {
        case .forms:
            Color(red: 0.386, green: 0.628, blue: 0.452)
        case .lists:
            Color(red: 0.706, green: 0.545, blue: 0.384)
        case .customControls:
            Color(red: 0.552, green: 0.528, blue: 0.7)
        case .navigation:
            Color(red: 0.656, green: 0.458, blue: 0.42)
        case .basics:
            Color(red: 0.354, green: 0.58, blue: 0.656)
        case .dataVisualization:
            Color(red: 0.656, green: 0.496, blue: 0.572)
        case .advanced:
            Color(red: 0.458, green: 0.49, blue: 0.644)
        }
    }

    static func accentTint(for category: ExampleCategory) -> Color {
        accent(for: category).opacity(0.12)
    }

    static func accentSoftTint(for category: ExampleCategory) -> Color {
        accent(for: category).opacity(0.07)
    }
}

struct LabSectionCard<Content: View>: View {
    var padding: CGFloat = LabTheme.contentPadding
    var surface: Color = LabTheme.surface
    var radius: CGFloat = LabTheme.cornerRadiusMedium
    var shadowRadius: CGFloat = 8
    var shadowY: CGFloat = 4
    let content: Content

    init(
        padding: CGFloat = LabTheme.contentPadding,
        surface: Color = LabTheme.surface,
        radius: CGFloat = LabTheme.cornerRadiusMedium,
        shadowRadius: CGFloat = 8,
        shadowY: CGFloat = 4,
        @ViewBuilder content: () -> Content
    ) {
        self.padding = padding
        self.surface = surface
        self.radius = radius
        self.shadowRadius = shadowRadius
        self.shadowY = shadowY
        self.content = content()
    }

    var body: some View {
        content
            .padding(padding)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(
                RoundedRectangle(cornerRadius: radius, style: .continuous)
                    .fill(surface)
                    .overlay(
                        RoundedRectangle(cornerRadius: radius, style: .continuous)
                            .stroke(LabTheme.border)
                    )
            )
            .shadow(color: LabTheme.shadow, radius: shadowRadius, x: 0, y: shadowY)
    }
}

struct LabSectionHeader: View {
    let title: String
    let subtitle: String?

    init(_ title: String, subtitle: String? = nil) {
        self.title = title
        self.subtitle = subtitle
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.headline.weight(.semibold))
                .foregroundStyle(LabTheme.titleColor)

            if let subtitle {
                Text(subtitle)
                    .font(.subheadline)
                    .foregroundStyle(LabTheme.bodyColor)
            }
        }
    }
}

extension View {
    func labFieldChrome() -> some View {
        self
            .foregroundStyle(LabTheme.titleColor)
            .padding(.horizontal, 14)
            .frame(height: LabTheme.compactControlHeight)
            .background(
                RoundedRectangle(cornerRadius: LabTheme.cornerRadiusSmall, style: .continuous)
                    .fill(LabTheme.controlSurface)
                    .overlay(
                        RoundedRectangle(cornerRadius: LabTheme.cornerRadiusSmall, style: .continuous)
                            .stroke(LabTheme.border)
                    )
            )
    }

    func labSecondaryButtonChrome() -> some View {
        self
            .foregroundStyle(LabTheme.titleColor)
            .padding(.horizontal, 16)
            .frame(height: LabTheme.compactControlHeight)
            .background(
                Capsule(style: .continuous)
                    .fill(LabTheme.controlSurface)
                    .overlay(
                        Capsule(style: .continuous)
                            .stroke(LabTheme.border)
                    )
            )
    }

    func labPrimaryButtonChrome(isEnabled: Bool = true) -> some View {
        self
            .foregroundStyle(isEnabled ? LabTheme.buttonForeground : LabTheme.tertiaryText)
            .padding(.horizontal, 18)
            .frame(height: LabTheme.compactControlHeight)
            .background(
                Capsule(style: .continuous)
                    .fill(isEnabled ? LabTheme.buttonFill : LabTheme.mutedSurface)
            )
    }

    func labDestructiveButtonChrome() -> some View {
        self
            .foregroundStyle(LabTheme.dangerColor)
            .frame(maxWidth: .infinity)
            .frame(height: LabTheme.compactControlHeight)
            .background(
                Capsule(style: .continuous)
                    .fill(LabTheme.dangerTint)
                    .overlay(
                        Capsule(style: .continuous)
                            .stroke(LabTheme.dangerBorder)
                    )
            )
    }
}

struct CategoryCard: View {
    let category: ExampleCategory
    let count: Int

    var body: some View {
        VStack(alignment: .leading, spacing: LabTheme.spacingM) {
            HStack(alignment: .top, spacing: 12) {
                ZStack {
                    RoundedRectangle(cornerRadius: 14, style: .continuous)
                        .fill(LabTheme.accentTint(for: category))
                    Image(systemName: category.icon)
                        .foregroundStyle(LabTheme.accent(for: category))
                        .font(.title3.weight(.semibold))
                }
                .frame(width: 46, height: 46)

                Spacer(minLength: 0)

                Text("\(count)")
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(LabTheme.bodyColor)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 6)
                    .background(
                        Capsule(style: .continuous)
                            .fill(LabTheme.mutedSurface)
                    )
            }

            VStack(alignment: .leading, spacing: LabTheme.spacingXS) {
                Text(category.rawValue)
                    .font(.headline.weight(.semibold))
                    .foregroundStyle(LabTheme.titleColor)
                    .multilineTextAlignment(.leading)

                Text(count == 1 ? "1 guided lab" : "\(count) guided labs")
                    .font(.subheadline)
                    .foregroundStyle(LabTheme.bodyColor)
                    .multilineTextAlignment(.leading)
            }
        }
        .frame(maxWidth: .infinity, minHeight: 142, alignment: .topLeading)
        .padding(18)
        .background(
            RoundedRectangle(cornerRadius: LabTheme.cornerRadiusMedium, style: .continuous)
                .fill(LabTheme.surface)
                .overlay(
                    RoundedRectangle(cornerRadius: LabTheme.cornerRadiusMedium, style: .continuous)
                        .stroke(LabTheme.border)
                )
        )
        .shadow(color: LabTheme.shadow, radius: 8, x: 0, y: 4)
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(category.rawValue), \(count) examples")
    }
}

#Preview {
    CategoryCard(category: .forms, count: 3)
        .padding()
}
