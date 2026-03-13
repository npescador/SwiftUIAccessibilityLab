import SwiftUI

enum ExampleCategory: String, CaseIterable, Identifiable, Hashable {
    case basics = "Basics"
    case forms = "Forms & Input"
    case lists = "Lists & Collections"
    case customControls = "Custom Controls"
    case navigation = "Navigation"
    case dataVisualization = "Data & Charts"
    case advanced = "Advanced Patterns"

    var id: String { rawValue }

    var icon: String {
        switch self {
        case .basics:
            "star.fill"
        case .forms:
            "square.and.pencil"
        case .lists:
            "list.bullet"
        case .customControls:
            "slider.horizontal.3"
        case .navigation:
            "arrow.triangle.turn.up.right.circle"
        case .dataVisualization:
            "chart.bar.fill"
        case .advanced:
            "gearshape.2.fill"
        }
    }

    var color: Color {
        switch self {
        case .basics: .blue
        case .forms: .green
        case .lists: .orange
        case .customControls: .purple
        case .navigation: .red
        case .dataVisualization: .pink
        case .advanced: .indigo
        }
    }
}
