import Testing
@testable import SwiftUIAccessibilityLab

@MainActor
@Suite("ExampleCatalog")
struct SwiftUIAccessibilityLabTests {
    @Test("Catalog exposes the five MVP examples in canonical order")
    func catalogOrder() {
        let routes = ExampleCatalog.definitions.map(\.route)
        let titles = ExampleCatalog.definitions.map(\.metadata.title)

        #expect(routes == [.login, .taskList, .taskDetail, .customControl, .settings])
        #expect(titles == ["Login", "Task List", "Task Detail", "Custom Control", "Settings"])
    }

    @Test("Metadata wrappers resolve to the shared catalog definitions")
    func metadataWrappers() {
        #expect(LoginExampleMetadata.value == ExampleCatalog.definition(for: .login).metadata)
        #expect(TaskListExampleMetadata.value == ExampleCatalog.definition(for: .taskList).metadata)
        #expect(TaskDetailExampleMetadata.value == ExampleCatalog.definition(for: .taskDetail).metadata)
        #expect(CustomControlExampleMetadata.value == ExampleCatalog.definition(for: .customControl).metadata)
        #expect(SettingsExampleMetadata.value == ExampleCatalog.definition(for: .settings).metadata)
    }
}
