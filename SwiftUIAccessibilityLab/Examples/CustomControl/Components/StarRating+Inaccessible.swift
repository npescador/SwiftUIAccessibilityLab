import SwiftUI

struct StarRating_Inaccessible: View {
    @Binding var rating: Int
    let maxRating: Int = 5

    var body: some View {
        HStack(spacing: 8) {
            ForEach(1...maxRating, id: \.self) { index in
                Image(systemName: index <= rating ? "star.fill" : "star")
                    .foregroundStyle(.yellow)
                    .onTapGesture {
                        rating = index
                    }
            }
        }
        // Missing: combined accessibility element and adjustable action.
    }
}

#Preview {
    StarRating_Inaccessible(rating: .constant(3))
        .padding()
}
