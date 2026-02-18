import SwiftUI

struct SettingsView_Accessible: View {
    @State private var viewModel = SettingsViewModel()
    @State private var showDeleteConfirmation = false

    var body: some View {
        Form {
            Section {
                Toggle("Enable notifications", isOn: $viewModel.notificationsEnabled)
                    .accessibilityIdentifier("settings.notifications.toggle")
                    .accessibilityLabel("Enable notifications")
                    .accessibilityValue(viewModel.notificationsEnabled ? "On" : "Off")
                    .accessibilityHint("Double-tap to toggle")

                Toggle("Email notifications", isOn: $viewModel.emailNotifications)
                    .accessibilityIdentifier("settings.emailnotifications.toggle")
                    .accessibilityLabel("Email notifications")
                    .accessibilityValue(viewModel.emailNotifications ? "On" : "Off")
                    .accessibilityHint("Double-tap to toggle")
            } header: {
                Text("Notifications")
                    .accessibilityAddTraits(.isHeader)
            } footer: {
                Text("Receive alerts for important updates")
            }

            Section {
                Picker("Theme", selection: $viewModel.theme) {
                    ForEach(Theme.allCases) { theme in
                        Text(theme.rawValue).tag(theme)
                    }
                }
                .accessibilityIdentifier("settings.theme.picker")
                .accessibilityLabel("Theme")
                .accessibilityValue(viewModel.theme.rawValue)
                .accessibilityHint("Double-tap to change")

                Toggle("Share analytics", isOn: $viewModel.shareAnalytics)
                    .accessibilityIdentifier("settings.analytics.toggle")
                    .accessibilityLabel("Share analytics")
                    .accessibilityValue(viewModel.shareAnalytics ? "On" : "Off")
                    .accessibilityHint("Double-tap to toggle")
            } header: {
                Text("Appearance and Privacy")
                    .accessibilityAddTraits(.isHeader)
            }

            Section {
                Button("Clear cache") {
                    viewModel.clearCache()
                }
                .accessibilityIdentifier("settings.clearcache.button")
                .accessibilityHint("Clears temporary data")

                Button("Delete account", role: .destructive) {
                    showDeleteConfirmation = true
                }
                .accessibilityIdentifier("settings.deleteaccount.button")
                .accessibilityHint("Warning: This action cannot be undone")
                .confirmationDialog("Delete Account?", isPresented: $showDeleteConfirmation) {
                    Button("Delete", role: .destructive) {
                        Task { await viewModel.deleteAccount() }
                    }
                    Button("Cancel", role: .cancel) {
                    }
                }
            } header: {
                Text("Advanced")
                    .accessibilityAddTraits(.isHeader)
            }

            if let statusMessage = viewModel.statusMessage {
                Text(statusMessage)
                    .accessibilityIdentifier("settings.status.message")
                    .foregroundStyle(.secondary)
                    .accessibilityLabel(statusMessage)
            }
        }
    }
}

#Preview {
    SettingsView_Accessible()
}
