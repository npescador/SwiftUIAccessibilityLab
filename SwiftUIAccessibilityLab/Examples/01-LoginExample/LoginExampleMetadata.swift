import Foundation

enum LoginExampleMetadata {
    static let value = ExampleMetadata(
        title: "Login",
        description: "Forms, text fields, validation, and error announcements.",
        difficulty: .beginner,
        category: .forms,
        whatYouLearn: [
            "Clear text field labels",
            "Secure input accessibility",
            "Error announcements"
        ],
        keyPatterns: [
            "accessibilityLabel and accessibilityHint",
            "UIAccessibility announcements",
            "Disabled state feedback"
        ],
        iosVersion: "iOS 18.0+",
        references: [
            URL(string: "https://developer.apple.com/documentation/swiftui/view")!
        ]
    )
}
