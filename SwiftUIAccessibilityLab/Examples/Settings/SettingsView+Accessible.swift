import SwiftUI

struct SettingsView_Accessible: View {
    @State private var viewModel = SettingsViewModel()
    @State private var showDeleteConfirmation = false

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                notificationsSection
                appearanceSection
                advancedSection

                if let statusMessage = viewModel.statusMessage {
                    LabSectionCard(surface: LabTheme.raisedSurface, shadowRadius: 4, shadowY: 2) {
                        Text(statusMessage)
                            .font(.subheadline.weight(.medium))
                            .foregroundStyle(LabTheme.bodyColor)
                            .accessibilityIdentifier("settings.status.message")
                            .accessibilityLabel(statusMessage)
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
        }
        .scrollIndicators(.hidden)
    }

    private var notificationsSection: some View {
        LabSectionCard {
            VStack(alignment: .leading, spacing: 14) {
                accessibleSectionHeader("Notifications", subtitle: "Receive alerts for important updates")

                Toggle("Enable notifications", isOn: $viewModel.notificationsEnabled)
                    .toggleStyle(.switch)
                    .tint(LabTheme.accent(for: .forms))
                    .accessibilityIdentifier("settings.notifications.toggle")
                    .accessibilityLabel("Enable notifications")
                    .accessibilityValue(viewModel.notificationsEnabled ? "On" : "Off")

                Toggle("Email notifications", isOn: $viewModel.emailNotifications)
                    .toggleStyle(.switch)
                    .tint(LabTheme.accent(for: .forms))
                    .accessibilityIdentifier("settings.emailnotifications.toggle")
                    .accessibilityLabel("Email notifications")
                    .accessibilityValue(viewModel.emailNotifications ? "On" : "Off")
            }
        }
    }

    private var appearanceSection: some View {
        LabSectionCard {
            VStack(alignment: .leading, spacing: 14) {
                accessibleSectionHeader("Appearance and Privacy", subtitle: "Choose theme and data-sharing preferences")

                Menu {
                    ForEach(Theme.allCases) { theme in
                        Button {
                            viewModel.theme = theme
                        } label: {
                            if theme == viewModel.theme {
                                Label(theme.rawValue, systemImage: "checkmark")
                            } else {
                                Text(theme.rawValue)
                            }
                        }
                    }
                } label: {
                    HStack {
                        Text("Theme")
                        Spacer()
                        Text(viewModel.theme.rawValue)
                        Image(systemName: "chevron.up.chevron.down")
                            .font(.caption2.weight(.semibold))
                    }
                    .font(.body.weight(.medium))
                    .labFieldChrome()
                }
                .accessibilityIdentifier("settings.theme.picker")
                .accessibilityLabel("Theme")
                .accessibilityValue(viewModel.theme.rawValue)
                .accessibilityHint("Double-tap to change")

                Toggle("Share analytics", isOn: $viewModel.shareAnalytics)
                    .toggleStyle(.switch)
                    .tint(LabTheme.accent(for: .customControls))
                    .accessibilityIdentifier("settings.analytics.toggle")
                    .accessibilityLabel("Share analytics")
                    .accessibilityValue(viewModel.shareAnalytics ? "On" : "Off")
            }
        }
    }

    private var advancedSection: some View {
        LabSectionCard {
            VStack(alignment: .leading, spacing: 14) {
                accessibleSectionHeader("Advanced", subtitle: "Administrative actions and destructive operations")

                Button("Clear cache") {
                    viewModel.clearCache()
                }
                .font(.body.weight(.semibold))
                .labSecondaryButtonChrome()
                .accessibilityIdentifier("settings.clearcache.button")
                .accessibilityHint("Clears temporary data")

                Button("Delete account", role: .destructive) {
                    showDeleteConfirmation = true
                }
                .font(.body.weight(.semibold))
                .labDestructiveButtonChrome()
                .accessibilityIdentifier("settings.deleteaccount.button")
                .accessibilityHint("Warning: This action cannot be undone")
                .confirmationDialog("Delete Account?", isPresented: $showDeleteConfirmation) {
                    Button("Delete", role: .destructive) {
                        Task { await viewModel.deleteAccount() }
                    }
                    Button("Cancel", role: .cancel) {
                    }
                }
            }
        }
    }

    private func accessibleSectionHeader(_ title: String, subtitle: String) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.headline.weight(.semibold))
                .foregroundStyle(LabTheme.titleColor)
                .accessibilityAddTraits(.isHeader)

            Text(subtitle)
                .font(.subheadline)
                .foregroundStyle(LabTheme.bodyColor)
        }
    }
}

#Preview {
    SettingsView_Accessible()
}
