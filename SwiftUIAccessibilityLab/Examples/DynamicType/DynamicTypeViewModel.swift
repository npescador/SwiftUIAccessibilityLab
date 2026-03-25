import Foundation
import Observation

@MainActor
@Observable
/// Provides static article data for the Dynamic Type lab.
final class DynamicTypeViewModel {
    struct Article: Identifiable {
        let id: UUID
        let category: String
        let headline: String
        let byline: String
        let excerpt: String
        let readTime: String
        let publishedAt: String

        init(
            id: UUID = UUID(),
            category: String,
            headline: String,
            byline: String,
            excerpt: String,
            readTime: String,
            publishedAt: String
        ) {
            self.id = id
            self.category = category
            self.headline = headline
            self.byline = byline
            self.excerpt = excerpt
            self.readTime = readTime
            self.publishedAt = publishedAt
        }
    }

    let articles: [Article] = [
        Article(
            category: "Accessibility",
            headline: "Building Accessible iOS Apps with SwiftUI",
            byline: "Sarah Chen",
            excerpt: "Discover how modern SwiftUI APIs make it easier than ever to build apps that work for everyone.",
            readTime: "5 min read",
            publishedAt: "2 hours ago"
        ),
        Article(
            category: "UI Design",
            headline: "Dynamic Type Best Practices for Complex Layouts",
            byline: "Alex Kim",
            excerpt: "Learn how to adapt your layouts gracefully across all Dynamic Type sizes without breaking your design.",
            readTime: "8 min read",
            publishedAt: "Yesterday"
        ),
        Article(
            category: "VoiceOver",
            headline: "Custom Rotors and Focus Management",
            byline: "Maria Garcia",
            excerpt: "A deep dive into building custom rotors and focus management patterns for complex navigation flows.",
            readTime: "12 min read",
            publishedAt: "3 days ago"
        ),
    ]
}
