import SwiftUI

struct DifficultyBadge: View {
    let difficulty: ExampleDifficulty

    var body: some View {
        HStack(spacing: 6) {
            Image(systemName: difficultySymbol)
                .font(.caption2.weight(.bold))
            Text(difficulty.label.uppercased())
                .font(.caption2.weight(.semibold))
                .tracking(0.4)
                .lineLimit(1)
                .minimumScaleFactor(0.72)
        }
        .foregroundStyle(badgeColor)
        .padding(.horizontal, 9)
        .padding(.vertical, 6)
        .background(
            Capsule(style: .continuous)
                .fill(badgeColor.opacity(0.1))
        )
        .accessibilityLabel("Difficulty \(difficulty.label)")
    }

    private var difficultySymbol: String {
        switch difficulty {
        case .beginner:
            "sparkle"
        case .intermediate:
            "dial.medium"
        case .advanced:
            "bolt.fill"
        }
    }

    private var badgeColor: Color {
        switch difficulty {
        case .beginner:
            Color(red: 0.258, green: 0.6, blue: 0.664)
        case .intermediate:
            Color(red: 0.714, green: 0.536, blue: 0.356)
        case .advanced:
            Color(red: 0.478, green: 0.5, blue: 0.664)
        }
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
