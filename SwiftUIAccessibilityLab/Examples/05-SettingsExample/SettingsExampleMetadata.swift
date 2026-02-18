import Foundation

enum SettingsExampleMetadata {
    static let value = ExampleMetadata(
        title: "Settings",
        description: "Toggles, navigation links, and grouped lists.",
        difficulty: .beginner,
        category: .forms,
        whatYouLearn: [
            "Toggle state announcements",
            "Navigation link hints",
            "Grouped list structure"
        ],
        keyPatterns: [
            "accessibilityLabel",
            "accessibilityValue",
            "accessibilityHint"
        ],
        iosVersion: "iOS 18.0+",
        references: [
            URL(string: "https://developer.apple.com/documentation/swiftui/form")!
        ]
    )
}
