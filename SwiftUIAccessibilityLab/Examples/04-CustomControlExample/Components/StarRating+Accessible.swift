import SwiftUI

struct StarRating_Accessible: View {
    @Binding var rating: Int
    let maxRating: Int = 5

    var body: some View {
        HStack(spacing: 8) {
            ForEach(1...maxRating, id: \.self) { index in
                Image(systemName: index <= rating ? "star.fill" : "star")
                    .foregroundStyle(.yellow)
                    .onTapGesture {
                        rating = index
                        announceRating()
                    }
            }
        }
        .accessibilityElement(children: .ignore)
        .accessibilityIdentifier("customcontrol.rating")
        .accessibilityLabel("Rating")
        .accessibilityValue("\(rating) out of \(maxRating) stars")
        .accessibilityAdjustableAction { direction in
            switch direction {
            case .increment:
                if rating < maxRating {
                    rating += 1
                    announceRating()
                }
            case .decrement:
                if rating > 0 {
                    rating -= 1
                    announceRating()
                }
            @unknown default:
                break
            }
        }
        .accessibilityHint("Swipe up to increase, swipe down to decrease")
    }

    private func announceRating() {
        AccessibilityHelpers.announce("\(rating) out of \(maxRating) stars")
    }
}

#Preview {
    StarRating_Accessible(rating: .constant(3))
        .padding()
}
