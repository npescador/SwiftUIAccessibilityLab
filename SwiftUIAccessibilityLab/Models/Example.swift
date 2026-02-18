import Foundation

struct Example: Identifiable, Hashable {
    let id: UUID
    let metadata: ExampleMetadata
    let route: ExampleRoute

    init(id: UUID = UUID(), metadata: ExampleMetadata, route: ExampleRoute) {
        self.id = id
        self.metadata = metadata
        self.route = route
    }
}
