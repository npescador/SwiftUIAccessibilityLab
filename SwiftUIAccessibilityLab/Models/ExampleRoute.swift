import Foundation

enum ExampleRoute: String, CaseIterable, Identifiable, Hashable {
    case login
    case taskList
    case taskDetail
    case customControl
    case settings

    var id: String { rawValue }
}
