import Foundation

enum TaskDetailExampleMetadata {
    static let value = ExampleMetadata(
        title: "Task Detail",
        description: "Complex layouts, pickers, and edit mode feedback.",
        difficulty: .intermediate,
        category: .forms,
        whatYouLearn: [
            "Accessible section headers",
            "Picker labels and hints",
            "Save and cancel announcements"
        ],
        keyPatterns: [
            "accessibilityAddTraits(.isHeader)",
            "accessibilityHint",
            "Announcements on change"
        ],
        iosVersion: "iOS 18.0+",
        references: [
            URL(string: "https://developer.apple.com/documentation/swiftui/form")!
        ]
    )
}
