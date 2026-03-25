import SwiftUI

struct ContentView: View {
    private let examples = ExampleCatalog.definitions
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize

    var body: some View {
        NavigationStack {
            ZStack {
                LabTheme.pageBackground.ignoresSafeArea()

                ScrollView {
                    VStack(alignment: .leading, spacing: LabTheme.spacingXL) {
                        heroSection
                        categoriesSection
                        examplesSection
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 8)
                    .padding(.bottom, 24)
                }
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text(AppConstants.appName)
                        .font(.headline.weight(.semibold))
                        .foregroundStyle(LabTheme.titleColor)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(LabTheme.pageBackground, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .navigationDestination(for: ExampleRoute.self) { route in
                ExampleRouteView(route: route)
            }
        }
    }

    private var categories: [ExampleCategory] {
        ExampleCategory.allCases.filter { category in
            examples.contains { $0.metadata.category == category }
        }
    }

    private func examplesForCategory(_ category: ExampleCategory) -> [ExampleDefinition] {
        examples.filter { $0.metadata.category == category }
    }

    private var heroSection: some View {
        VStack(alignment: .leading, spacing: LabTheme.spacingM) {
            Text("Learn accessibility through comparison.")
                .font(.title.weight(.bold))
                .fontDesign(.rounded)
                .foregroundStyle(LabTheme.titleColor)
                .fixedSize(horizontal: false, vertical: true)

            VStack(alignment: .leading, spacing: LabTheme.spacingS) {
                Text("Focused labs that pair an intentionally flawed implementation with a corrected accessible version.")
                    .font(.subheadline)
                    .foregroundStyle(LabTheme.bodyColor)
                    .lineLimit(3)
                    .fixedSize(horizontal: false, vertical: true)
            }

            HStack(spacing: 12) {
                HeroStat(title: "\(examples.count)", subtitle: "Labs")
                HeroStat(title: "\(categories.count)", subtitle: "Categories")
                HeroStat(title: "A/B", subtitle: "Comparison")
            }
        }
        .padding(18)
        .background(
            RoundedRectangle(cornerRadius: LabTheme.cornerRadiusLarge, style: .continuous)
                .fill(
                    LinearGradient(
                        colors: [LabTheme.surface, LabTheme.heroTint],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .overlay(
                    RoundedRectangle(cornerRadius: LabTheme.cornerRadiusLarge, style: .continuous)
                        .stroke(LabTheme.border)
                )
        )
        .shadow(color: LabTheme.shadow, radius: 6, x: 0, y: 2)
    }

    private var categoriesSection: some View {
        VStack(alignment: .leading, spacing: LabTheme.spacingM) {
            sectionHeader(
                eyebrow: "Map the terrain",
                title: "Browse by learning area",
                subtitle: "Each category highlights a different accessibility pattern or common failure mode."
            )

            LazyVGrid(
                columns: Array(
                    repeating: GridItem(.flexible(), spacing: 14),
                    count: dynamicTypeSize.isAccessibilitySize ? 1 : 2
                ),
                spacing: 14
            ) {
                ForEach(categories, id: \.self) { category in
                    CategoryCard(category: category, count: examplesForCategory(category).count)
                }
            }
        }
    }

    private var examplesSection: some View {
        VStack(alignment: .leading, spacing: LabTheme.spacingL) {
            sectionHeader(
                eyebrow: "Start learning",
                title: "Guided accessibility labs",
                subtitle: "Each lesson combines context, metadata and a live comparison between inaccessible and accessible implementations."
            )

            VStack(spacing: 18) {
                ForEach(examples) { example in
                    NavigationLink(value: example.route) {
                        ExampleCard(example: example)
                    }
                    .buttonStyle(.plain)
                    .accessibilityIdentifier("example.link.\(example.route.rawValue)")
                }
            }
        }
    }

    private func sectionHeader(eyebrow: String, title: String, subtitle: String) -> some View {
        VStack(alignment: .leading, spacing: LabTheme.spacingS) {
            Text(eyebrow)
                .font(.caption.weight(.semibold))
                .textCase(.uppercase)
                .tracking(1)
                .foregroundStyle(LabTheme.tertiaryText)

            Text(title)
                .font(.title2.weight(.bold))
                .foregroundStyle(LabTheme.titleColor)

            Text(subtitle)
                .font(.body)
                .foregroundStyle(LabTheme.bodyColor)
                .fixedSize(horizontal: false, vertical: true)
        }
    }
}

private struct HeroStat: View {
    let title: String
    let subtitle: String

    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(title)
                .font(.headline.weight(.bold))
                .foregroundStyle(LabTheme.titleColor)
            Text(subtitle)
                .font(.caption)
                .foregroundStyle(LabTheme.bodyColor)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 14)
        .padding(.vertical, 12)
        .background(
            RoundedRectangle(cornerRadius: LabTheme.cornerRadiusSmall, style: .continuous)
                .fill(LabTheme.raisedSurface)
                .overlay(
                    RoundedRectangle(cornerRadius: LabTheme.cornerRadiusSmall, style: .continuous)
                        .stroke(LabTheme.border.opacity(0.65))
                )
        )
        .shadow(color: LabTheme.shadow, radius: 4, x: 0, y: 2)
    }
}

private struct ExampleCard: View {
    let example: ExampleDefinition

    var body: some View {
        VStack(alignment: .leading, spacing: LabTheme.spacingM) {
            HStack(alignment: .top, spacing: 12) {
                ZStack {
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .fill(LabTheme.accentTint(for: example.metadata.category))
                    Image(systemName: example.metadata.category.icon)
                        .font(.title3.weight(.semibold))
                        .foregroundStyle(LabTheme.accent(for: example.metadata.category))
                        .accessibilityHidden(true)
                }
                .frame(width: 52, height: 52)
                .accessibilityHidden(true)

                VStack(alignment: .leading, spacing: LabTheme.spacingXS) {
                    HStack(alignment: .center, spacing: 8) {
                        Text(example.metadata.title)
                            .font(.title3.weight(.semibold))
                            .foregroundStyle(LabTheme.titleColor)

                        Spacer(minLength: 0)

                        Image(systemName: "arrow.up.right")
                            .font(.caption.weight(.bold))
                            .foregroundStyle(LabTheme.bodyColor)
                            .accessibilityHidden(true)
                    }

                    Text(example.metadata.description)
                        .font(.body)
                        .foregroundStyle(LabTheme.bodyColor)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }

            HStack(spacing: 10) {
                DifficultyBadge(difficulty: example.metadata.difficulty)
                categoryTag
                Spacer(minLength: 0)
            }

            VStack(alignment: .leading, spacing: 8) {
                Text("Focus")
                    .font(.caption.weight(.semibold))
                    .textCase(.uppercase)
                    .tracking(0.8)
                    .foregroundStyle(LabTheme.tertiaryText)

                Text(example.metadata.whatYouLearn.first ?? example.metadata.keyPatterns.first ?? "")
                    .font(.subheadline.weight(.medium))
                    .foregroundStyle(LabTheme.titleColor)
            }
        }
        .padding(20)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: LabTheme.cornerRadiusLarge, style: .continuous)
                .fill(LabTheme.surface)
                .overlay(
                    RoundedRectangle(cornerRadius: LabTheme.cornerRadiusLarge, style: .continuous)
                        .stroke(LabTheme.border)
                )
        )
        .shadow(color: LabTheme.shadow, radius: 8, x: 0, y: 4)
        .accessibilityElement(children: .combine)
    }

    private var categoryTag: some View {
        Label(example.metadata.category.rawValue, systemImage: example.metadata.category.icon)
            .font(.caption2.weight(.semibold))
            .foregroundStyle(LabTheme.accent(for: example.metadata.category))
            .lineLimit(1)
            .minimumScaleFactor(0.74)
            .padding(.horizontal, 9)
            .padding(.vertical, 6)
            .background(
                Capsule(style: .continuous)
                    .fill(LabTheme.accentSoftTint(for: example.metadata.category))
            )
    }
}

private struct ExampleRouteView: View {
    let route: ExampleRoute

    @ViewBuilder
    var body: some View {
        switch route {
        case .login:
            LoginExampleContainer()
        case .taskList:
            TaskListExampleContainer()
        case .taskDetail:
            TaskDetailExampleContainer()
        case .customControl:
            CustomControlExampleContainer()
        case .settings:
            SettingsExampleContainer()
        case .quantityControl:
            QuantityControlExampleContainer()
        case .dynamicType:
            DynamicTypeExampleContainer()
        }
    }
}

#Preview {
    ContentView()
}
