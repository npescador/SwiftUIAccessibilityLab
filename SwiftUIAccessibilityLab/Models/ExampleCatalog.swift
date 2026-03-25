import Foundation

struct ExampleDefinition: Identifiable, Hashable {
    let route: ExampleRoute
    let metadata: ExampleMetadata

    var id: ExampleRoute { route }
}

enum ExampleCatalog {
    static let definitions: [ExampleDefinition] = [
        ExampleDefinition(
            route: .login,
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
                    URL(string: "https://developer.apple.com/documentation/swiftui/view-accessibility")!
                ]
            )
        ),
        ExampleDefinition(
            route: .taskList,
            metadata: ExampleMetadata(
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
        ),
        ExampleDefinition(
            route: .taskDetail,
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
            )
        ),
        ExampleDefinition(
            route: .customControl,
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
                    URL(string: "https://developer.apple.com/documentation/swiftui/view/accessibilityadjustableaction(_:)")!
                ]
            )
        ),
        ExampleDefinition(
            route: .settings,
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
                    URL(string: "https://developer.apple.com/documentation/swiftui/form")!
                ]
            )
        ),
        ExampleDefinition(
            route: .quantityControl,
            metadata: ExampleMetadata(
                title: "Quantity Control",
                description: "Custom +/− stepper UI made accessible with accessibilityRepresentation.",
                difficulty: .intermediate,
                category: .customControls,
                whatYouLearn: [
                    "Map custom UI to a native Stepper for VoiceOver",
                    "Keep visual design while exposing standard interaction",
                    "Why onTapGesture blocks VoiceOver"
                ],
                keyPatterns: [
                    "accessibilityRepresentation",
                    "Stepper binding from custom control",
                    "onTapGesture vs Button"
                ],
                iosVersion: "iOS 18.0+",
                references: [
                    URL(string: "https://developer.apple.com/documentation/swiftui/view/accessibilityrepresentation(representation:)")!
                ]
            )
        )
    ]

    static func definition(for route: ExampleRoute) -> ExampleDefinition {
        guard let definition = definitions.first(where: { $0.route == route }) else {
            preconditionFailure("Missing example definition for route \(route.rawValue)")
        }

        return definition
    }
}
