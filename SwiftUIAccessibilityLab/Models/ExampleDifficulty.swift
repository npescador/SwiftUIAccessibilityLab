import Foundation

enum ExampleDifficulty: Int, CaseIterable, Identifiable, Hashable {
    case beginner = 1
    case intermediate = 2
    case advanced = 3

    var id: Int { rawValue }

    var stars: String {
        String(repeating: "*", count: rawValue)
    }

    var label: String {
        switch self {
        case .beginner:
            return "Beginner"
        case .intermediate:
            return "Intermediate"
        case .advanced:
            return "Advanced"
        }
    }
}
