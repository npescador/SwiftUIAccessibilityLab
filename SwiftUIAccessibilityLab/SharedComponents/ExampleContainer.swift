import SwiftUI
import OSLog

/// Shared wrapper that provides consistent context and variant switching for every example.
struct ExampleContainer<AccessibleContent: View, InaccessibleContent: View>: View {
    private let horizontalInset: CGFloat = 16
    @Environment(\.verticalSizeClass) private var verticalSizeClass

    /// Route identifier used by tests and analytics-like hooks.
    let route: ExampleRoute
    /// Metadata shown in the example header.
    let metadata: ExampleMetadata
    /// Builder for the accessible implementation.
    let accessibleView: () -> AccessibleContent
    /// Builder for the inaccessible implementation.
    let inaccessibleView: () -> InaccessibleContent

    @State private var variant: ExampleVariant = .accessible
    @State private var showsLabDetails = false

    var body: some View {
        GeometryReader { proxy in
            let isCompactHeight = verticalSizeClass == .compact || proxy.size.height < 760

            ZStack {
                LabTheme.pageBackground.ignoresSafeArea()

                VStack(spacing: isCompactHeight ? 10 : 12) {
                    header(isCompactHeight: isCompactHeight)
                        .padding(.horizontal, horizontalInset)
                        .padding(.top, isCompactHeight ? 8 : 12)

                    currentView
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                        .background(
                            RoundedRectangle(cornerRadius: LabTheme.cornerRadiusLarge, style: .continuous)
                                .fill(LabTheme.surface)
                                .overlay(
                                    RoundedRectangle(cornerRadius: LabTheme.cornerRadiusLarge, style: .continuous)
                                        .stroke(LabTheme.border)
                                )
                                .shadow(color: LabTheme.shadow, radius: 10, x: 0, y: 4)
                        )
                        .padding(.horizontal, horizontalInset)
                        .padding(.bottom, 12)
                }
            }
        }
        .accessibilityIdentifier("example.screen.\(route.rawValue)")
        .navigationTitle(metadata.title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(LabTheme.pageBackground, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .onAppear {
            AppLogger.exampleContainer.debug("Opened example route=\(self.route.rawValue, privacy: .public) variant=\(self.variant.rawValue, privacy: .public)")
        }
        .onChange(of: variant) { oldValue, newValue in
            AppLogger.exampleContainer.debug(
                "Variant changed route=\(self.route.rawValue, privacy: .public) from=\(oldValue.rawValue, privacy: .public) to=\(newValue.rawValue, privacy: .public)"
            )
        }
        .sheet(isPresented: $showsLabDetails) {
            labDetailsSheet
                .presentationDetents([.medium, .large])
                .presentationDragIndicator(.visible)
        }
    }

    @ViewBuilder
    private var currentView: some View {
        Group {
            switch variant {
            case .accessible:
                accessibleView()
                    .onAppear {
                        AppLogger.exampleContainer.debug("Rendered accessible variant route=\(self.route.rawValue, privacy: .public)")
                    }
                    .onDisappear {
                        AppLogger.exampleContainer.debug("Disposed accessible variant route=\(self.route.rawValue, privacy: .public)")
                    }
            case .inaccessible:
                inaccessibleView()
                    .onAppear {
                        AppLogger.exampleContainer.debug("Rendered inaccessible variant route=\(self.route.rawValue, privacy: .public)")
                    }
                    .onDisappear {
                        AppLogger.exampleContainer.debug("Disposed inaccessible variant route=\(self.route.rawValue, privacy: .public)")
                    }
            }
        }
        .id(variant)
    }

    private func header(isCompactHeight: Bool) -> some View {
        VStack(alignment: .leading, spacing: isCompactHeight ? 10 : 12) {
            HStack(alignment: .center, spacing: 12) {
                DifficultyBadge(difficulty: metadata.difficulty)
                categoryPill
                Spacer(minLength: 0)
                detailsButton
            }

            VStack(alignment: .leading, spacing: 6) {
                Text(metadata.title)
                    .font(isCompactHeight ? .title3.weight(.bold) : .title2.weight(.bold))
                    .fontDesign(.rounded)
                    .foregroundStyle(LabTheme.titleColor)

                Text(metadata.description)
                    .font(.subheadline)
                    .foregroundStyle(LabTheme.bodyColor)
                    .lineLimit(isCompactHeight ? 1 : 2)
                    .fixedSize(horizontal: false, vertical: true)
            }

            ComparisonToggle(selection: $variant, isCompact: isCompactHeight)
        }
        .padding(isCompactHeight ? LabTheme.shellPadding : 18)
        .background(
            RoundedRectangle(cornerRadius: LabTheme.cornerRadiusLarge, style: .continuous)
                .fill(
                    LinearGradient(
                        colors: [LabTheme.surface, LabTheme.heroTint.opacity(isCompactHeight ? 0.55 : 0.72)],
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

    private var categoryPill: some View {
        Label(metadata.category.rawValue, systemImage: metadata.category.icon)
            .font(.caption2.weight(.semibold))
            .foregroundStyle(LabTheme.accent(for: metadata.category))
            .lineLimit(1)
            .minimumScaleFactor(0.74)
            .padding(.horizontal, 9)
            .padding(.vertical, 6)
            .background(
                Capsule(style: .continuous)
                    .fill(LabTheme.accentSoftTint(for: metadata.category))
            )
            .layoutPriority(1)
    }

    private var learningHighlights: some View {
        VStack(alignment: .leading, spacing: 8) {
            ForEach(metadata.whatYouLearn.prefix(3), id: \.self) { item in
                HStack(alignment: .top, spacing: 10) {
                    Image(systemName: "circle.fill")
                        .font(.system(size: 7))
                        .foregroundStyle(LabTheme.accent(for: metadata.category))
                        .padding(.top, 6)
                        .accessibilityHidden(true)

                    Text(item)
                        .font(.subheadline)
                        .foregroundStyle(LabTheme.bodyColor)
                }
            }
        }
    }

    private var detailsButton: some View {
        Button {
            showsLabDetails = true
        } label: {
            Image(systemName: "info.circle")
                .font(.body.weight(.semibold))
                .foregroundStyle(LabTheme.tertiaryText)
                .frame(width: 32, height: 32)
                .background(
                    Circle()
                        .fill(LabTheme.raisedSurface)
                )
        }
        .buttonStyle(.plain)
        .accessibilityLabel("About this lab")
        .accessibilityHint("Shows the full learning objectives and metadata")
    }

    private var labDetailsSheet: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    HStack(alignment: .center, spacing: 12) {
                        DifficultyBadge(difficulty: metadata.difficulty)
                        categoryPill
                    }

                    VStack(alignment: .leading, spacing: 10) {
                        Text(metadata.title)
                            .font(.title.weight(.bold))
                            .fontDesign(.rounded)
                            .foregroundStyle(LabTheme.titleColor)

                        Text(metadata.description)
                            .font(.body)
                            .foregroundStyle(LabTheme.bodyColor)
                    }

                    VStack(alignment: .leading, spacing: 10) {
                        Text("You will learn")
                            .font(.caption.weight(.semibold))
                            .textCase(.uppercase)
                            .tracking(1)
                            .foregroundStyle(LabTheme.accent(for: metadata.category))

                        learningHighlights
                    }
                }
                .padding(24)
            }
            .background(LabTheme.pageBackground)
            .navigationTitle("Lab details")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") {
                        showsLabDetails = false
                    }
                }
            }
        }
    }
}
