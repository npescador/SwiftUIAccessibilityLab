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
        ,
        ExampleDefinition(
            route: .dynamicType,
            metadata: ExampleMetadata(
                title: "Dynamic Type",
                description: "Article cards that adapt — or fail to adapt — to the user's text size preference.",
                difficulty: .intermediate,
                category: .basics,
                whatYouLearn: [
                    "Use text styles instead of fixed font sizes",
                    "Scale non-text elements with @ScaledMetric",
                    "Adapt layout at accessibility sizes with ViewThatFits"
                ],
                keyPatterns: [
                    "Font text styles (.headline, .body, .caption)",
                    "@ScaledMetric for icons and spacing",
                    "ViewThatFits for adaptive layout"
                ],
                iosVersion: "iOS 18.0+",
                references: [
                    URL(string: "https://developer.apple.com/documentation/swiftui/scaledmetric")!
                ]
            )
        )
        ,
        ExampleDefinition(
            route: .dataChart,
            metadata: ExampleMetadata(
                title: "Data Chart",
                description: "A weekly step-count chart that's invisible to VoiceOver until fixed with per-mark labels.",
                difficulty: .intermediate,
                category: .dataVisualization,
                whatYouLearn: [
                    "Add per-mark labels and values to Swift Charts",
                    "Set a chart-level accessibility label to enable Audio Graph",
                    "Hide decorative chart elements from VoiceOver"
                ],
                keyPatterns: [
                    ".accessibilityLabel / .accessibilityValue on BarMark",
                    ".chartAccessibilityLabel",
                    ".accessibilityHidden(true) on reference lines"
                ],
                iosVersion: "iOS 18.0+",
                references: [
                    URL(string: "https://developer.apple.com/documentation/charts")!
                ]
            )
        ),
        ExampleDefinition(
            route: .reduceMotion,
            metadata: ExampleMetadata(
                title: "Reduce Motion",
                description: "A goals checklist that triggers animations — with and without Reduce Motion support.",
                difficulty: .intermediate,
                category: .advanced,
                whatYouLearn: [
                    "Read accessibilityReduceMotion from the environment",
                    "Swap spring animations for simple fades when Reduce Motion is on",
                    "Use .sensoryFeedback as a non-motion feedback channel"
                ],
                keyPatterns: [
                    "@Environment(\\.accessibilityReduceMotion)",
                    ".animation(reduceMotion ? .easeInOut : .spring, value:)",
                    ".transition with conditional opacity vs scale"
                ],
                iosVersion: "iOS 18.0+",
                references: [
                    URL(string: "https://developer.apple.com/documentation/swiftui/environmentvalues/accessibilityreducemotion")!
                ]
            )
        ),
        ExampleDefinition(
            route: .customRotor,
            metadata: ExampleMetadata(
                title: "Custom Rotor",
                description: "An article reader where VoiceOver can jump between sections — once headings and a rotor are added.",
                difficulty: .advanced,
                category: .navigation,
                whatYouLearn: [
                    "Add .isHeader trait and .accessibilityHeading level to section titles",
                    "Build a custom rotor with AccessibilityRotorEntry",
                    "Use .id() to anchor rotor entries to specific views"
                ],
                keyPatterns: [
                    ".accessibilityAddTraits(.isHeader)",
                    ".accessibilityHeading(.h1 / .h2)",
                    ".accessibilityRotor with AccessibilityRotorEntry"
                ],
                iosVersion: "iOS 18.0+",
                references: [
                    URL(string: "https://developer.apple.com/documentation/swiftui/view/accessibilityrotor(_:entries:entrylabel:)")!
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
