import SwiftUI

struct SettingsView_Inaccessible: View {
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
                sectionHeader("Notifications", subtitle: "Receive alerts for important updates")

                Toggle("Enable notifications", isOn: $viewModel.notificationsEnabled)
                    .toggleStyle(.switch)
                    .tint(LabTheme.accent(for: .forms))

                Toggle("Email notifications", isOn: $viewModel.emailNotifications)
                    .toggleStyle(.switch)
                    .tint(LabTheme.accent(for: .forms))
            }
        }
    }

    private var appearanceSection: some View {
        LabSectionCard {
            VStack(alignment: .leading, spacing: 14) {
                sectionHeader("Appearance and Privacy", subtitle: "Choose theme and data-sharing preferences")

                Menu {
                    ForEach(Theme.allCases) { theme in
                        Button(theme.rawValue) {
                            viewModel.theme = theme
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

                Toggle("Share analytics", isOn: $viewModel.shareAnalytics)
                    .toggleStyle(.switch)
                    .tint(LabTheme.accent(for: .customControls))
            }
        }
    }

    private var advancedSection: some View {
        LabSectionCard {
            VStack(alignment: .leading, spacing: 14) {
                sectionHeader("Advanced", subtitle: "Administrative actions and destructive operations")

                Button("Clear cache") {
                    viewModel.clearCache()
                }
                .font(.body.weight(.semibold))
                .labSecondaryButtonChrome()

                Button("Delete account", role: .destructive) {
                    showDeleteConfirmation = true
                }
                .font(.body.weight(.semibold))
                .labDestructiveButtonChrome()
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

    private func sectionHeader(_ title: String, subtitle: String) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.headline.weight(.semibold))
                .foregroundStyle(LabTheme.titleColor)

            Text(subtitle)
                .font(.subheadline)
                .foregroundStyle(LabTheme.bodyColor)
        }
    }
}

#Preview {
    SettingsView_Inaccessible()
}
