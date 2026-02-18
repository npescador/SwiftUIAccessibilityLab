import Foundation

enum Priority: String, CaseIterable, Identifiable, Hashable, Codable {
    case low = "Low"
    case medium = "Medium"
    case high = "High"

    var id: String { rawValue }
}
