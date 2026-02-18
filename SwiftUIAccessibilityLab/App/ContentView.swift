import SwiftUI

struct ContentView: View {
    private let examples = MockData.examples

    var body: some View {
        NavigationStack {
            List {
                ForEach(categories, id: \.self) { category in
                    Section {
                        ForEach(examplesForCategory(category)) { example in
                            NavigationLink(value: example.route) {
                                ExampleRow(example: example)
                            }
                        }
                    } header: {
                        Text(category.rawValue)
                    }
                }
            }
            .navigationTitle(AppConstants.appName)
            .navigationDestination(for: ExampleRoute.self) { route in
                switch route {
                case .login:
                    LoginExampleContainer()
                case .taskList:
                    TaskListExampleContainer()
                case .taskDetail:
                    TaskDetailExampleContainer()
                case .customControl:
                    ExamplePlaceholderView(title: "Custom Control")
                case .settings:
                    ExamplePlaceholderView(title: "Settings")
                }
            }
        }
    }

    private var categories: [ExampleCategory] {
        ExampleCategory.allCases.filter { category in
            examples.contains { $0.metadata.category == category }
        }
    }

    private func examplesForCategory(_ category: ExampleCategory) -> [Example] {
        examples.filter { $0.metadata.category == category }
    }
}

private struct ExampleRow: View {
    let example: Example

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack(spacing: 8) {
                Text(example.metadata.title)
                    .font(.headline)
                DifficultyBadge(difficulty: example.metadata.difficulty)
            }
            Text(example.metadata.description)
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .accessibilityElement(children: .combine)
    }
}

#Preview {
    ContentView()
}
