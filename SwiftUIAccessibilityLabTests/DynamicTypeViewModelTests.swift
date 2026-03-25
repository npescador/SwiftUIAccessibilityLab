import Testing
@testable import SwiftUIAccessibilityLab

@MainActor
@Suite("DynamicTypeViewModel")
struct DynamicTypeViewModelTests {

    @Test("ViewModel initialises with sample articles")
    func defaultArticles() {
        let viewModel = DynamicTypeViewModel()

        #expect(viewModel.articles.isEmpty == false)
        #expect(viewModel.articles.count == 3)
    }

    @Test("Each article has non-empty headline and byline")
    func articleContent() {
        let viewModel = DynamicTypeViewModel()

        for article in viewModel.articles {
            #expect(article.headline.isEmpty == false)
            #expect(article.byline.isEmpty == false)
            #expect(article.excerpt.isEmpty == false)
            #expect(article.readTime.isEmpty == false)
        }
    }

    @Test("Each article has a unique identifier")
    func articleIdentifiers() {
        let viewModel = DynamicTypeViewModel()
        let ids = viewModel.articles.map(\.id)
        let uniqueIds = Set(ids)

        #expect(ids.count == uniqueIds.count)
    }
}
