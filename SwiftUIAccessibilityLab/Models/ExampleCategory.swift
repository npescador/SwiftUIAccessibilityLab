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
            return "star.fill"
        case .forms:
            return "square.and.pencil"
        case .lists:
            return "list.bullet"
        case .customControls:
            return "slider.horizontal.3"
        case .navigation:
            return "arrow.triangle.turn.up.right.circle"
        case .dataVisualization:
            return "chart.bar.fill"
        case .advanced:
            return "gearshape.2.fill"
        }
    }

    var color: Color {
        switch self {
        case .basics:
            return .blue
        case .forms:
            return .green
        case .lists:
            return .orange
        case .customControls:
            return .purple
        case .navigation:
            return .red
        case .dataVisualization:
            return .pink
        case .advanced:
            return .indigo
        }
    }
}
