import SwiftUI

struct CategoryCard: View {
    let category: ExampleCategory
    let count: Int

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: category.icon)
                .foregroundStyle(category.color)
                .font(.title2)

            VStack(alignment: .leading, spacing: 4) {
                Text(category.rawValue)
                    .font(.headline)
                Text("\(count) examples")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            Spacer()
        }
        .padding(12)
        .background(Color.secondary.opacity(0.08))
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(category.rawValue), \(count) examples")
    }
}

#Preview {
    CategoryCard(category: .forms, count: 3)
        .padding()
}
