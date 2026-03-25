import Testing
@testable import SwiftUIAccessibilityLab

@MainActor
@Suite("CustomRotorViewModel")
struct CustomRotorViewModelTests {

    @Test("ViewModel initialises with 6 sections")
    func defaultSections() {
        let viewModel = CustomRotorViewModel()

        #expect(viewModel.sections.count == 6)
    }

    @Test("Each section has a non-empty heading and body")
    func sectionContent() {
        let viewModel = CustomRotorViewModel()

        for section in viewModel.sections {
            #expect(section.heading.isEmpty == false)
            #expect(section.body.isEmpty == false)
        }
    }

    @Test("Each section has a unique identifier")
    func uniqueIdentifiers() {
        let viewModel = CustomRotorViewModel()
        let ids = viewModel.sections.map(\.id)
        let uniqueIds = Set(ids)

        #expect(ids.count == uniqueIds.count)
    }

    @Test("Article metadata is non-empty")
    func articleMetadata() {
        let viewModel = CustomRotorViewModel()

        #expect(viewModel.articleTitle.isEmpty == false)
        #expect(viewModel.articleByline.isEmpty == false)
        #expect(viewModel.articleDate.isEmpty == false)
        #expect(viewModel.readTime.isEmpty == false)
    }
}
