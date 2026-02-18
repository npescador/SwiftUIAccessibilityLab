import SwiftUI

struct DifficultyBadge: View {
    let difficulty: ExampleDifficulty

    var body: some View {
        Text("\(difficulty.label) \(difficulty.stars)")
            .font(.caption)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(Color.secondary.opacity(0.15))
            .clipShape(Capsule())
            .accessibilityLabel("Difficulty \(difficulty.label)")
    }
}

#Preview {
    VStack(alignment: .leading, spacing: 8) {
        DifficultyBadge(difficulty: .beginner)
        DifficultyBadge(difficulty: .intermediate)
        DifficultyBadge(difficulty: .advanced)
    }
    .padding()
}
