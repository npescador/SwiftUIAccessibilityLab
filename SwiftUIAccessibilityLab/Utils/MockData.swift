import Foundation

enum MockData {
    static let examples: [Example] = [
        Example(
            metadata: ExampleMetadata(
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
                    URL(string: "https://developer.apple.com/documentation/swiftui")!
                ]
            ),
            route: .login
        ),
        Example(
            metadata: ExampleMetadata(
                title: "Task List",
                description: "Lists, swipe actions, complex rows, and search.",
                difficulty: .intermediate,
                category: .lists,
                whatYouLearn: [
                    "Combining child elements",
                    "Accessibility actions for swipe",
                    "Search field feedback"
                ],
                keyPatterns: [
                    "accessibilityElement(children: .combine)",
                    "accessibilityActions",
                    "accessibilityValue"
                ],
                iosVersion: "iOS 18.0+",
                references: [
                    URL(string: "https://developer.apple.com/documentation/swiftui/list")!
                ]
            ),
            route: .taskList
        ),
        Example(
            metadata: ExampleMetadata(
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
            ),
            route: .taskDetail
        ),
        Example(
            metadata: ExampleMetadata(
                title: "Custom Control",
                description: "Custom controls with adjustable actions and values.",
                difficulty: .advanced,
                category: .customControls,
                whatYouLearn: [
                    "Adjustable accessibility",
                    "Custom values",
                    "Gesture alternatives"
                ],
                keyPatterns: [
                    "accessibilityAdjustableAction",
                    "accessibilityValue",
                    "Haptic feedback with VoiceOver"
                ],
                iosVersion: "iOS 18.0+",
                references: [
                    URL(string: "https://developer.apple.com/documentation/swiftui/view")!
                ]
            ),
            route: .customControl
        ),
        Example(
            metadata: ExampleMetadata(
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
                    URL(string: "https://developer.apple.com/documentation/swiftui/toggle")!
                ]
            ),
            route: .settings
        )
    ]

    static let sampleTasks: [Task] = [
        Task(title: "Buy groceries", details: "Milk, bread, and fruit", priority: .high, dueDate: .now.addingTimeInterval(3600)),
        Task(title: "Walk the dog", details: "30 minute walk", priority: .medium, dueDate: .now.addingTimeInterval(7200)),
        Task(title: "Read book", details: "Finish chapter 4", priority: .low, dueDate: nil)
    ]
}
