import Foundation

enum TaskListExampleMetadata {
    static let value = ExampleMetadata(
        title: "Task List",
        description: "Lists, swipe actions, complex rows, and search.",
        difficulty: .intermediate,
        category: .lists,
        whatYouLearn: [
            "Combining child elements",
            "Swipe actions as accessibility actions",
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
    )
}
