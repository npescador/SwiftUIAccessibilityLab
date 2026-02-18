import SwiftUI

struct SettingsView_Inaccessible: View {
    @State private var viewModel = SettingsViewModel()
    @State private var showDeleteConfirmation = false

    var body: some View {
        Form {
            Section {
                Toggle("Enable notifications", isOn: $viewModel.notificationsEnabled)
                Toggle("Email notifications", isOn: $viewModel.emailNotifications)
                // Missing: clear value announcements and hints.
            } header: {
                Text("Notifications")
                // Missing: header trait.
            }

            Section {
                Picker("Theme", selection: $viewModel.theme) {
                    ForEach(Theme.allCases) { theme in
                        Text(theme.rawValue).tag(theme)
                    }
                }
                // Missing: label, value, and hint.

                Toggle("Share analytics", isOn: $viewModel.shareAnalytics)
            } header: {
                Text("Appearance and Privacy")
            }

            Section {
                Button("Clear cache") {
                    viewModel.clearCache()
                }

                Button("Delete account", role: .destructive) {
                    showDeleteConfirmation = true
                }
                .confirmationDialog("Delete Account?", isPresented: $showDeleteConfirmation) {
                    Button("Delete", role: .destructive) {
                        Task { await viewModel.deleteAccount() }
                    }
                    Button("Cancel", role: .cancel) {
                    }
                }
                // Missing: destructive warning hint.
            } header: {
                Text("Advanced")
            }

            if let statusMessage = viewModel.statusMessage {
                Text(statusMessage)
            }
        }
    }
}

#Preview {
    SettingsView_Inaccessible()
}
