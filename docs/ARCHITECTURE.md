# 🏗️ Technical Architecture

**Project:** SwiftUI Accessibility Lab  
**Version:** 1.0  
**Last Updated:** 2026-02-16

---

## 🎯 Architecture Principles

### 1. **Simplicity First**
- Minimal dependencies (zero third-party)
- Standard SwiftUI patterns
- Clear separation of concerns
- Easy to understand for learners

### 2. **Educational Focus**
- Code should teach, not just work
- Favor clarity over cleverness
- Explicit over implicit
- Comments explain "why", not "what"

### 3. **Consistency**
- Same patterns across all examples
- Predictable file structure
- Naming conventions enforced
- Style guide followed

### 4. **Testability**
- All logic testable
- ViewModels pure (no side effects)
- Mocked dependencies
- Accessibility assertions

---

## 📦 Project Structure

```
SwiftUIAccessibilityLab/
│
├── 📱 App/
│   ├── SwiftUIAccessibilityLabApp.swift          # App entry point
│   ├── ContentView.swift                       # Root catalog view
│   └── AppConfiguration.swift                  # App-level config
│
├── 🎨 Examples/
│   │
│   ├── Login/
│   │   ├── LoginExampleContainer.swift         # Wrapper with toggle
│   │   ├── LoginView.swift                     # Shared UI structure
│   │   ├── LoginView+Accessible.swift          # ✅ Version
│   │   ├── LoginView+Inaccessible.swift        # ❌ Version
│   │   ├── LoginViewModel.swift                # Business logic
│   │   └── README.md                           # Example-specific docs
│   │
│   ├── TaskList/
│   │   ├── TaskListExampleContainer.swift
│   │   ├── TaskListView.swift
│   │   ├── TaskListView+Accessible.swift
│   │   ├── TaskListView+Inaccessible.swift
│   │   ├── TaskListViewModel.swift
│   │   ├── Components/
│   │   │   ├── TaskRow.swift
│   │   │   ├── TaskRow+Accessible.swift
│   │   │   └── TaskRow+Inaccessible.swift
│   │   └── README.md
│   │
│   ├── TaskDetail/
│   ├── CustomControl/
│   └── Settings/
│
├── 🧩 SharedComponents/
│   ├── ExampleContainer.swift                  # Base container for all examples
│   ├── ExampleMetadata.swift                   # Title, description, difficulty
│   ├── ComparisonToggle.swift                  # Accessible ↔ Inaccessible toggle
│   ├── CategoryCard.swift                      # Catalog category cards
│   ├── DifficultyBadge.swift                   # ⭐️⭐️⭐️ rating
│   └── CodeSnippetView.swift                   # Future: show code inline
│
├── 📊 Models/
│   ├── ExampleCategory.swift                   # Enum of example categories
│   ├── Example.swift                           # Example metadata model
│   ├── Task.swift                              # Task data model
│   ├── Priority.swift                          # Priority enum
│   └── User.swift                              # User model (for login)
│
├── 🛠️ Utils/
│   ├── AccessibilityHelpers.swift              # Reusable accessibility utilities
│   ├── MockData.swift                          # Sample data for examples
│   ├── AccessibilityTester.swift               # Runtime accessibility checks
│   └── Constants.swift                         # App-wide constants
│
├── 🧪 Tests/
│   ├── SwiftUIAccessibilityLabTests/             # Swift Testing unit tests
│   │   ├── LoginAccessibilityTests.swift
│   │   ├── TaskListAccessibilityTests.swift
│   │   ├── TaskDetailAccessibilityTests.swift
│   │   ├── CustomControlAccessibilityTests.swift
│   │   └── SettingsAccessibilityTests.swift
│   │
│   └── SwiftUIAccessibilityLabUITests/           # UI Tests
│       ├── AccessibilityUITests.swift
│       └── VoiceOverNavigationTests.swift
│
├── 📚 Resources/
│   ├── Assets.xcassets/                        # Images, colors
│   │   ├── AppIcon.appiconset/
│   │   └── Colors/
│   │       ├── Primary.colorset
│   │       ├── Error.colorset
│   │       └── Success.colorset
│   │
│   ├── Localizable.xcstrings                   # String catalog (future)
│   └── README-EXAMPLES.md                      # Examples documentation
│
└── 📖 Documentation/
    ├── PROJECT-VISION.md
    ├── MVP-PLAN.md
    ├── ARCHITECTURE.md                         # This file
    ├── ROADMAP.md
    ├── CONTRIBUTING.md
    └── EXAMPLES-CATALOG.md
```

---

## 🏛️ Core Components Architecture

### 1. ExampleContainer

**Purpose:** Wrapper for all examples providing consistent UI and functionality

**Responsibilities:**
- Display example title and description
- Provide accessible ↔ inaccessible toggle
- Show "Why it matters" section
- Link to code (future)
- Collect feedback (future)

**Interface:**
```swift
struct ExampleContainer<Accessible: View, Inaccessible: View>: View {
    let metadata: ExampleMetadata
    let accessibleView: () -> Accessible
    let inaccessibleView: () -> Inaccessible
    
    @State private var showAccessibleVersion: Bool = true
    
    var body: some View {
        NavigationStack {
            VStack {
                metadataHeader
                comparisonToggle
                Divider()
                currentView
            }
            .navigationTitle(metadata.title)
        }
    }
}
```

**Key Features:**
- Generic over view types
- State management for toggle
- Consistent presentation
- Accessibility: Container itself is accessible

---

### 2. ExampleMetadata

**Purpose:** Standardized information about each example

**Data Structure:**
```swift
struct ExampleMetadata: Identifiable {
    let id: UUID
    let title: String
    let description: String
    let difficulty: Difficulty
    let category: ExampleCategory
    let whatYouLearn: [String]
    let keyPatterns: [String]
    let iosVersion: String
    let references: [URL]
    
    enum Difficulty: Int, CaseIterable {
        case beginner = 1
        case intermediate = 2
        case advanced = 3
        
        var stars: String {
            String(repeating: "⭐️", count: rawValue)
        }
    }
}
```

---

### 3. Example Category System

**Purpose:** Organize examples by learning progression

**Categories:**
```swift
enum ExampleCategory: String, CaseIterable, Identifiable {
    case basics = "Basics"
    case forms = "Forms & Input"
    case lists = "Lists & Collections"
    case customControls = "Custom Controls"
    case navigation = "Navigation"
    case dataVisualization = "Data & Charts"
    case advanced = "Advanced Patterns"
    
    var id: String { rawValue }
    
    var icon: String {
        switch self {
        case .basics: return "star.fill"
        case .forms: return "square.and.pencil"
        case .lists: return "list.bullet"
        case .customControls: return "slider.horizontal.3"
        case .navigation: return "arrow.triangle.turn.up.right.circle"
        case .dataVisualization: return "chart.bar.fill"
        case .advanced: return "gearshape.2.fill"
        }
    }
    
    var color: Color {
        switch self {
        case .basics: return .blue
        case .forms: return .green
        case .lists: return .orange
        case .customControls: return .purple
        case .navigation: return .red
        case .dataVisualization: return .pink
        case .advanced: return .indigo
        }
    }
}
```

---

## 🎨 View Architecture Pattern

### Standard Example Structure:

Each example follows this pattern:

```swift
// 1. Container - Entry point for the example
struct LoginExampleContainer: View {
    let metadata = LoginExampleMetadata()
    
    var body: some View {
        ExampleContainer(
            metadata: metadata,
            accessibleView: { LoginView_Accessible() },
            inaccessibleView: { LoginView_Inaccessible() }
        )
    }
}

// 2. Shared View - Common UI structure (if needed)
struct LoginView {
    // Shared layout components
}

// 3. Accessible Version - Full accessibility
struct LoginView_Accessible: View {
    @StateObject private var viewModel = LoginViewModel()
    
    var body: some View {
        // Implementation with ALL accessibility modifiers
    }
}

// 4. Inaccessible Version - Demonstrates problems
struct LoginView_Inaccessible: View {
    @StateObject private var viewModel = LoginViewModel()
    
    var body: some View {
        // Implementation WITHOUT accessibility
        // Comments explaining what's broken
    }
}

// 5. ViewModel - Business logic (shared)
@Observable
class LoginViewModel {
    var email: String = ""
    var password: String = ""
    var isLoading: Bool = false
    var errorMessage: String?
    
    func login() async {
        // Logic
    }
}
```

**Benefits:**
- Clear separation of concerns
- Shared ViewModel reduces duplication
- Easy to compare accessible vs inaccessible
- Testable ViewModels

---

## 🧠 State Management

### Principles:
- Use `@Observable` for ViewModels (iOS 17+)
- Use `@State` for view-local state
- Use `@Environment` for app-wide config
- Avoid global state
- Make ViewModels testable (no side effects in init)

### Example:
```swift
@Observable
class TaskListViewModel {
    // Published state
    var tasks: [Task] = []
    var isLoading: Bool = false
    var errorMessage: String?
    var searchText: String = ""
    
    // Computed
    var filteredTasks: [Task] {
        tasks.filter { task in
            searchText.isEmpty || task.title.contains(searchText)
        }
    }
    
    // Actions
    func loadTasks() async {
        isLoading = true
        defer { isLoading = false }
        
        // Simulate network
        try? await Task.sleep(for: .seconds(1))
        tasks = MockData.sampleTasks
    }
    
    func toggleCompletion(_ task: Task) {
        // Logic
    }
    
    func deleteTask(_ task: Task) {
        // Logic
    }
}
```

---

## 🧪 Testing Architecture

### 1. Unit Tests (Swift Testing)

**Focus:** Business logic, ViewModels, utilities

```swift
import Testing
@testable import SwiftUIAccessibilityLab

@Suite("Login ViewModel Tests")
struct LoginViewModelTests {
    
    @Test("Email validation rejects invalid format")
    func testEmailValidation() async {
        let viewModel = LoginViewModel()
        viewModel.email = "invalid-email"
        
        await viewModel.login()
        
        #expect(viewModel.errorMessage != nil)
        #expect(viewModel.errorMessage?.contains("email") == true)
    }
    
    @Test("Successful login clears error")
    func testSuccessfulLogin() async {
        let viewModel = LoginViewModel()
        viewModel.email = "test@example.com"
        viewModel.password = "password123"
        
        await viewModel.login()
        
        #expect(viewModel.errorMessage == nil)
    }
}
```

### 2. Accessibility Tests (Swift Testing)

**Focus:** Accessibility properties, traits, labels

```swift
@Suite("Login Accessibility Tests")
struct LoginAccessibilityTests {
    
    @Test("Email field has label")
    func testEmailFieldLabel() {
        let view = LoginView_Accessible()
        // Test accessibility properties
        // Note: Direct view testing limited in SwiftUI
        // Focus on ViewModel-driven accessibility
    }
    
    @Test("Error announcement includes message")
    func testErrorAnnouncement() async {
        let viewModel = LoginViewModel()
        viewModel.email = "invalid"
        
        await viewModel.login()
        
        #expect(viewModel.errorMessage != nil)
        // Verify announcement would occur
    }
}
```

### 3. UI Tests

**Focus:** End-to-end accessibility with VoiceOver simulation

```swift
import XCTest

final class LoginUITests: XCTestCase {
    
    func testLoginFlowAccessibility() throws {
        let app = XCUIApplication()
        app.launch()
        
        // Navigate to login example
        app.buttons["Examples"].tap()
        app.buttons["Login Example"].tap()
        
        // Verify accessibility identifiers
        let emailField = app.textFields["login.email.field"]
        XCTAssertTrue(emailField.exists)
        XCTAssertTrue(emailField.isHittable)
        
        // Verify label
        XCTAssertFalse(emailField.label.isEmpty)
        XCTAssertTrue(emailField.label.contains("Email"))
    }
}
```

---

## 🎨 Design System

### Colors:
```swift
extension Color {
    // Brand
    static let primary = Color("Primary")       // Blue
    static let secondary = Color("Secondary")   // Purple
    
    // Semantic
    static let success = Color("Success")       // Green
    static let error = Color("Error")           // Red
    static let warning = Color("Warning")       // Orange
    
    // Accessibility
    static let focusIndicator = Color.blue
    static let accessibleGreen = Color(red: 0, green: 0.7, blue: 0.3)  // WCAG AA
}
```

### Typography:
```swift
extension Font {
    // Use system fonts with Dynamic Type
    static let title = Font.largeTitle
    static let heading = Font.title2
    static let body = Font.body
    static let caption = Font.caption
}
```

### Spacing:
```swift
enum Spacing {
    static let xs: CGFloat = 4
    static let sm: CGFloat = 8
    static let md: CGFloat = 16
    static let lg: CGFloat = 24
    static let xl: CGFloat = 32
}
```

---

## 🔧 Utilities & Helpers

### AccessibilityHelpers.swift

```swift
enum AccessibilityHelpers {
    
    /// Post announcement to VoiceOver
    static func announce(_ message: String) {
        UIAccessibility.post(
            notification: .announcement,
            argument: message
        )
    }
    
    /// Post layout change notification
    static func layoutChanged() {
        UIAccessibility.post(
            notification: .layoutChanged,
            argument: nil
        )
    }
    
    /// Check if VoiceOver is running
    static var isVoiceOverRunning: Bool {
        UIAccessibility.isVoiceOverRunning
    }
    
    /// Check if reduce motion is enabled
    static var isReduceMotionEnabled: Bool {
        UIAccessibility.isReduceMotionEnabled
    }
}
```

### MockData.swift

```swift
enum MockData {
    static let sampleTasks: [Task] = [
        Task(title: "Buy groceries", priority: .high, dueDate: .now),
        Task(title: "Walk the dog", priority: .medium, dueDate: .now.addingTimeInterval(3600)),
        Task(title: "Read book", priority: .low)
    ]
    
    static let sampleUser = User(
        email: "demo@example.com",
        name: "Demo User"
    )
}
```

---

## 📊 Data Flow

```
User Interaction
      ↓
  SwiftUI View
      ↓
  ViewModel (@Observable)
      ↓
  Business Logic
      ↓
  Model Update
      ↓
  View Re-renders
      ↓
  Accessibility Tree Updated
      ↓
  VoiceOver Announces
```

---

## 🚀 Build & Deployment

### Requirements:
- iOS 18.0+
- Xcode 16.0+
- Swift 6.0+
- macOS 15.0+ (for development)

### Build Configurations:
- **Debug**: Development, all logging
- **Release**: Production-ready, optimized

### No External Dependencies:
- Zero CocoaPods
- Zero Swift Package Manager dependencies
- 100% native SwiftUI + Foundation

---

## 📝 Code Style & Conventions

### File Naming:
- Views: `ExampleNameView.swift`
- ViewModels: `ExampleNameViewModel.swift`
- Models: `ModelName.swift`
- Extensions: `Type+Extension.swift`

### Code Organization:
```swift
// 1. Imports
import SwiftUI

// 2. Type Definition
struct LoginView: View {
    
    // 3. Properties (in order)
    // - Environment
    // - StateObject/ObservedObject
    // - State
    // - Binding
    // - Let properties
    // - Var properties
    
    // 4. Body
    var body: some View {
        // Implementation
    }
    
    // 5. Private Views
    private var emailField: some View {
        // ...
    }
    
    // 6. Private Methods
    private func handleLogin() {
        // ...
    }
}

// 7. Previews
#Preview {
    LoginView()
}
```

### Comments:
```swift
// ✅ GOOD: Explain WHY and accessibility decisions
.accessibilityLabel("Login")  // Clear action, not just "button"

// ❌ BAD: State the obvious
.accessibilityLabel("Login")  // Adds accessibility label
```

---

## 🔄 Version Control

### Git Strategy:
- `main` branch: stable releases
- `develop` branch: active development
- Feature branches: `feature/example-name`
- Hotfix branches: `hotfix/issue-description`

### Commit Messages:
```
<type>: <subject>

<body>

Types: feat, fix, docs, style, refactor, test, chore
```

Example:
```
feat: Add Login example with accessibility comparison

- Implement accessible version with all modifiers
- Implement inaccessible version showing common mistakes
- Add comparison toggle
- Include Swift Testing tests
- Document patterns inline
```

---

**Status:** Living Document  
**Next Update:** As architecture evolves  
**Maintainer:** Project Lead
