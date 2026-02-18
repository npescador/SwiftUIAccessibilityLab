import Foundation

enum CustomControlExampleMetadata {
    static let value = ExampleMetadata(
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
    )
}
