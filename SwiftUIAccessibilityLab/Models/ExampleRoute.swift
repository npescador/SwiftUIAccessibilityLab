import Foundation

enum ExampleRoute: String, CaseIterable, Identifiable, Hashable {
    case login
    case taskList
    case taskDetail
    case customControl
    case settings
    case quantityControl
    case dynamicType

    var id: String { rawValue }
}
