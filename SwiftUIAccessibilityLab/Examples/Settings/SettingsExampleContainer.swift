import SwiftUI

struct SettingsExampleContainer: View {
    var body: some View {
        ExampleContainer(
            route: .settings,
            metadata: SettingsExampleMetadata.value,
            accessibleView: { SettingsView_Accessible() },
            inaccessibleView: { SettingsView_Inaccessible() }
        )
    }
}

#Preview {
    NavigationStack {
        SettingsExampleContainer()
    }
}
