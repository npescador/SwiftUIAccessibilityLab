import Foundation

struct ExampleMetadata: Identifiable, Hashable {
    let id: UUID
    let title: String
    let description: String
    let difficulty: ExampleDifficulty
    let category: ExampleCategory
    let whatYouLearn: [String]
    let keyPatterns: [String]
    let iosVersion: String
    let references: [URL]

    init(
        id: UUID = UUID(),
        title: String,
        description: String,
        difficulty: ExampleDifficulty,
        category: ExampleCategory,
        whatYouLearn: [String],
        keyPatterns: [String],
        iosVersion: String,
        references: [URL]
    ) {
        self.id = id
        self.title = title
        self.description = description
        self.difficulty = difficulty
        self.category = category
        self.whatYouLearn = whatYouLearn
        self.keyPatterns = keyPatterns
        self.iosVersion = iosVersion
        self.references = references
    }
}
