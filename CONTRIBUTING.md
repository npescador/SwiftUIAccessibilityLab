# 🤝 Contributing Guide

**Welcome! Thank you for considering contributing to SwiftUI Accessibility Lab!**

This document provides guidelines for contributing to the project. Following these guidelines helps maintain quality and makes the contribution process smooth for everyone.

Current implementation source of truth:
- `README.md`
- `docs/ARCHITECTURE.md`

---

## 📋 Table of Contents

1. [Code of Conduct](#code-of-conduct)
2. [How Can I Contribute?](#how-can-i-contribute)
3. [Development Setup](#development-setup)
4. [Adding a New Example](#adding-a-new-example)
5. [Code Style Guidelines](#code-style-guidelines)
6. [Testing Requirements](#testing-requirements)
7. [Commit Message Format](#commit-message-format)
8. [Pull Request Process](#pull-request-process)
9. [Review Process](#review-process)
10. [Getting Help](#getting-help)

---

## 📜 Code of Conduct

This project follows a **Code of Conduct** that all contributors must adhere to:

### Our Pledge
- **Be respectful** and inclusive
- **Be patient** with beginners
- **Be constructive** in feedback
- **Be professional** in all interactions

### Unacceptable Behavior
- Harassment, discrimination, or offensive language
- Trolling or insulting comments
- Personal attacks
- Publishing private information

**Violations will result in removal from the project.**

---

## 🎯 How Can I Contribute?

### 1. Report Bugs 🐛
- Use GitHub Issues
- Search existing issues first
- Provide clear reproduction steps
- Include Xcode/iOS version

**Template:**
```
**Description:**
Brief description of the bug

**Steps to Reproduce:**
1. Open example X
2. Toggle to inaccessible version
3. Enable VoiceOver
4. Observe the issue

**Expected Behavior:**
What should happen

**Actual Behavior:**
What actually happens

**Environment:**
- iOS: 18.0+
- Xcode: 26+
- Device: iPhone 17 Pro Simulator
```

---

### 2. Suggest New Examples 💡
- Use GitHub Discussions or Issues
- Explain the use case
- Describe what users will learn
- Check if similar example exists

**Template:**
```
**Example Title:**
E.g., "Photo Picker with Accessibility"

**What it teaches:**
- Accessibility for PHPickerViewController
- Accessibility for images
- Album selection accessibility

**Why it's valuable:**
Photo pickers are common but often inaccessible

**Difficulty Level:**
⭐️⭐️ (Intermediate)
```

---

### 3. Improve Documentation 📝
- Fix typos
- Clarify explanations
- Add missing details
- Update outdated information

---

### 4. Add Tests ✅
- Unit tests for ViewModels
- Accessibility tests for views
- UI tests for flows

---

### 5. Contribute Code 💻
- New examples
- Improvements to existing examples
- Utility functions
- Bug fixes

---

## 🛠️ Development Setup

### Prerequisites
- macOS 15.0+ (Sequoia)
- Xcode 26+
- Git
- GitHub account

### Fork & Clone

1. **Fork the repository** on GitHub

2. **Clone your fork:**
   ```bash
   git clone https://github.com/YOUR_USERNAME/swiftui-accessibility-lab.git
   cd swiftui-accessibility-lab
   ```

3. **Add upstream remote:**
   ```bash
   git remote add upstream https://github.com/ORIGINAL_OWNER/swiftui-accessibility-lab.git
   ```

4. **Verify remotes:**
   ```bash
   git remote -v
   # origin    https://github.com/YOUR_USERNAME/swiftui-accessibility-lab.git (fetch)
   # origin    https://github.com/YOUR_USERNAME/swiftui-accessibility-lab.git (push)
   # upstream  https://github.com/ORIGINAL_OWNER/swiftui-accessibility-lab.git (fetch)
   # upstream  https://github.com/ORIGINAL_OWNER/swiftui-accessibility-lab.git (push)
   ```

### Build & Run

1. **Open in Xcode:**
   ```bash
   open SwiftUIAccessibilityLab.xcodeproj
   ```

2. **Select scheme:** SwiftUIAccessibilityLab

3. **Select simulator:** iPhone 17 Pro (iOS 18.0+)

4. **Build:** `Cmd + B`

5. **Run:** `Cmd + R`

6. **Run tests:** `Cmd + U`

---

## 🆕 Adding a New Example

Follow this step-by-step guide to add a new example:

### Step 1: Plan the Example

**Create an issue first:**
- Describe what the example will teach
- Get feedback from maintainers
- Wait for approval before implementing

### Step 2: Create File Structure

```bash
Examples/
└── [Number]-[Name]Example/
    ├── [Name]ExampleContainer.swift
    ├── [Name]View.swift                 # If shared structure
    ├── [Name]View+Accessible.swift
    ├── [Name]View+Inaccessible.swift
    ├── [Name]ViewModel.swift
    ├── Components/                       # If sub-components needed
    │   ├── SubComponent.swift
    │   ├── SubComponent+Accessible.swift
    │   └── SubComponent+Inaccessible.swift
    └── README.md
```

**Example:** For a "PhotoPicker" example:
```
Examples/
└── 06-PhotoPickerExample/
    ├── PhotoPickerExampleContainer.swift
    ├── PhotoPickerView+Accessible.swift
    ├── PhotoPickerView+Inaccessible.swift
    ├── PhotoPickerViewModel.swift
    └── README.md
```

### Step 3: Implement the Container

```swift
import SwiftUI

struct PhotoPickerExampleContainer: View {
    
    var body: some View {
        ExampleContainer(
            metadata: PhotoPickerMetadata(),
            accessibleView: { PhotoPickerView_Accessible() },
            inaccessibleView: { PhotoPickerView_Inaccessible() }
        )
    }
}

// MARK: - Metadata

private struct PhotoPickerMetadata: ExampleMetadata {
    let id = UUID()
    let title = "Photo Picker"
    let description = "Learn to make photo selection accessible for all users"
    let difficulty = Difficulty.intermediate
    let category = ExampleCategory.forms
    
    let whatYouLearn = [
        "PHPickerViewController accessibility",
        "Image selection with VoiceOver",
        "Album browsing accessibility",
        "Selected image feedback"
    ]
    
    let keyPatterns = [
        ".accessibilityLabel() for images",
        ".accessibilityValue() for selection state",
        "Announcements on image selection",
        "Accessibility actions for quick selection"
    ]
    
    let iosVersion = "iOS 18.0+"
    let references = [
        URL(string: "https://developer.apple.com/documentation/photokit")!
    ]
}

// MARK: - Preview

#Preview {
    PhotoPickerExampleContainer()
}
```

### Step 4: Implement ViewModel

```swift
import SwiftUI
import PhotosUI

@Observable
class PhotoPickerViewModel {
    
    // MARK: - State
    
    var selectedImage: UIImage?
    var isPickerPresented = false
    var errorMessage: String?
    
    // MARK: - Computed
    
    var hasSelectedImage: Bool {
        selectedImage != nil
    }
    
    // MARK: - Actions
    
    func selectPhoto() {
        isPickerPresented = true
    }
    
    func clearSelection() {
        selectedImage = nil
        
        // Announce to VoiceOver
        AccessibilityHelpers.announce("Photo removed")
    }
}
```

### Step 5: Implement Accessible Version

```swift
import SwiftUI
import PhotosUI

struct PhotoPickerView_Accessible: View {
    
    @State private var viewModel = PhotoPickerViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
            
            // Selected image preview
            if let image = viewModel.selectedImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                    .cornerRadius(12)
                    // ✅ GOOD: Clear label
                    .accessibilityLabel("Selected photo")
                    // ✅ GOOD: Provide action
                    .accessibilityAction(named: "Remove") {
                        viewModel.clearSelection()
                    }
            } else {
                placeholderView
            }
            
            // Select photo button
            Button("Select Photo") {
                viewModel.selectPhoto()
            }
            .buttonStyle(.borderedProminent)
            // ✅ GOOD: Hint explains result
            .accessibilityHint("Opens photo picker")
            
        }
        .padding()
        .navigationTitle("Photo Picker")
        .sheet(isPresented: $viewModel.isPickerPresented) {
            // PhotosPicker is accessible by default in iOS 16+
            Text("Photo Picker Sheet")
        }
    }
    
    // MARK: - Subviews
    
    private var placeholderView: some View {
        RoundedRectangle(cornerRadius: 12)
            .fill(Color.gray.opacity(0.3))
            .frame(height: 200)
            .overlay {
                Image(systemName: "photo")
                    .font(.largeTitle)
                    .foregroundColor(.gray)
            }
            // ✅ GOOD: Placeholder has label
            .accessibilityLabel("No photo selected")
            // ✅ GOOD: Hide decorative icon
            .accessibilityElement(children: .ignore)
    }
}

#Preview {
    PhotoPickerView_Accessible()
}
```

### Step 6: Implement Inaccessible Version

```swift
struct PhotoPickerView_Inaccessible: View {
    
    @State private var viewModel = PhotoPickerViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
            
            // ❌ BAD: No accessibility for selected image
            if let image = viewModel.selectedImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                    .cornerRadius(12)
                // Missing: accessibilityLabel
                // Missing: remove action
                // Result: User can't identify or remove photo
            } else {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.gray.opacity(0.3))
                    .frame(height: 200)
                    .overlay {
                        Image(systemName: "photo")
                            .font(.largeTitle)
                    }
                // ❌ BAD: No label for placeholder
                // Result: VoiceOver reads nothing
            }
            
            Button("Select Photo") {
                viewModel.selectPhoto()
            }
            .buttonStyle(.borderedProminent)
            // ❌ BAD: No hint about what happens
            
        }
        .padding()
        .navigationTitle("Photo Picker")
        .sheet(isPresented: $viewModel.isPickerPresented) {
            Text("Photo Picker Sheet")
        }
    }
}

#Preview {
    PhotoPickerView_Inaccessible()
}
```

### Step 7: Add Tests

```swift
import Testing
@testable import SwiftUIAccessibilityLab

@Suite("Photo Picker Accessibility Tests")
struct PhotoPickerAccessibilityTests {
    
    @Test("ViewModel starts with no image")
    func testInitialState() {
        let viewModel = PhotoPickerViewModel()
        
        #expect(viewModel.selectedImage == nil)
        #expect(viewModel.hasSelectedImage == false)
    }
    
    @Test("Clear selection removes image")
    func testClearSelection() {
        let viewModel = PhotoPickerViewModel()
        viewModel.selectedImage = UIImage()
        
        viewModel.clearSelection()
        
        #expect(viewModel.selectedImage == nil)
        #expect(viewModel.hasSelectedImage == false)
    }
    
    @Test("Select photo presents picker")
    func testSelectPhoto() {
        let viewModel = PhotoPickerViewModel()
        
        viewModel.selectPhoto()
        
        #expect(viewModel.isPickerPresented == true)
    }
}
```

### Step 8: Add to Catalog

Update `ContentView.swift` to include your example:

```swift
let examples: [Example] = [
    // ... existing examples
    
    Example(
        id: UUID(),
        title: "Photo Picker",
        category: .forms,
        difficulty: .intermediate,
        destination: AnyView(PhotoPickerExampleContainer())
    )
]
```

### Step 9: Create Example README

```markdown
# Photo Picker Example

## What You'll Learn
- How to make image selection accessible
- Accessibility for PHPickerViewController
- Announcements for selection changes
- Custom actions for image management

## Accessibility Patterns Used
1. `.accessibilityLabel()` for selected images
2. `.accessibilityAction()` for remove action
3. `.accessibilityElement(children: .ignore)` for placeholders
4. `AccessibilityHelpers.announce()` for feedback

## Common Mistakes
❌ No label for selected image
❌ No way to remove image with VoiceOver
❌ Placeholder reads decorative icon

## VoiceOver Experience
### Accessible Version:
- "Selected photo. Actions available."
- "Remove. Action."
- "Select Photo. Button. Hint: Opens photo picker."

### Inaccessible Version:
- (No label for image)
- "Select Photo. Button."
```

### Step 10: Test Thoroughly

- [ ] Build succeeds with zero warnings
- [ ] Accessible version works perfectly with VoiceOver
- [ ] Inaccessible version demonstrates clear problems
- [ ] All tests pass
- [ ] Code follows style guidelines
- [ ] Comments explain accessibility decisions

---

## 🎨 Code Style Guidelines

### General Rules
- **Swift 6.0** language features
- **iOS 18.0+** deployment target
- **SwiftUI-first** (no UIKit unless necessary)
- **Zero warnings** policy

### File Organization
```swift
// 1. Imports
import SwiftUI

// 2. Main Type
struct MyView: View {
    
    // 3. Properties (in order)
    @Environment(\.accessibilityVoiceOverEnabled) private var voiceOverEnabled
    @State private var viewModel = MyViewModel()
    
    // 4. Body
    var body: some View {
        // ...
    }
    
    // 5. Private Subviews
    private var subview: some View {
        // ...
    }
    
    // 6. Private Methods
    private func action() {
        // ...
    }
}

// 7. Previews
#Preview {
    MyView()
}
```

### Naming Conventions
- **Files:** `ComponentName.swift`, `ComponentName+Extension.swift`
- **Types:** `PascalCase`
- **Variables/Functions:** `camelCase`
- **Constants:** `camelCase` (not SCREAMING_SNAKE_CASE)

### Accessibility Modifiers
- **Always use named parameters:**
  ```swift
  // ✅ GOOD
  .accessibilityLabel("Login")
  .accessibilityValue("Email: \(email)")
  .accessibilityHint("Logs you into your account")
  
  // ❌ BAD (too terse)
  .accessibilityLabel("Login").accessibilityHint("Logs in")
  ```

- **One modifier per line:**
  ```swift
  Button("Save") { save() }
      .accessibilityLabel("Save task")
      .accessibilityHint("Double-tap to save changes")
      .accessibilityIdentifier("task.save.button")
  ```

### Comments
```swift
// ✅ GOOD: Explain WHY and accessibility decisions
.accessibilityLabel("Priority: High")  // Combine icon meaning with text

// ❌ BAD: State the obvious
.accessibilityLabel("Priority")  // Adds accessibility label
```

### Line Length
- **Maximum 135 characters** per line
- Break long lines at logical points

---

## ✅ Testing Requirements

### Unit Tests (Mandatory)
- Every ViewModel must have tests
- Test accessibility-related logic
- Use Swift Testing framework

### Accessibility Tests (Recommended)
- Test accessibility properties
- Verify announcements
- Check trait correctness

### UI Tests (Optional for complex flows)
- End-to-end flows
- VoiceOver navigation
- Real-world scenarios

### Test Coverage
- **Goal:** >80% coverage on ViewModels
- **Focus:** Business logic and accessibility

### Running Tests
```bash
# All tests
xcodebuild test -scheme SwiftUIAccessibilityLab

# Specific suite
xcodebuild test -scheme SwiftUIAccessibilityLab \
  -only-testing:SwiftUIAccessibilityLabTests/PhotoPickerAccessibilityTests
```

---

## 📝 Commit Message Format

Use **Conventional Commits** format:

```
<type>: <subject>

<body>

<footer>
```

### Types
- **feat:** New feature or example
- **fix:** Bug fix
- **docs:** Documentation only
- **style:** Formatting, whitespace
- **refactor:** Code restructuring
- **test:** Adding tests
- **chore:** Build, dependencies

### Examples

```
feat: Add Photo Picker example

- Implement accessible version with labels and actions
- Implement inaccessible version showing common mistakes
- Add ViewModel with image selection logic
- Include Swift Testing tests
- Document patterns in README

Closes #42
```

```
fix: Correct VoiceOver label for task priority badge

The badge was reading "Circle" instead of the priority level.
Added .accessibilityLabel() with descriptive text.

Fixes #38
```

```
docs: Update CONTRIBUTING with example creation guide

- Add step-by-step guide for new examples
- Include code templates
- Clarify testing requirements
```

---

## 🔄 Pull Request Process

### Before Submitting

1. **Sync with upstream:**
   ```bash
   git fetch upstream
   git rebase upstream/main
   ```

2. **Run tests:**
   ```bash
   xcodebuild test -scheme SwiftUIAccessibilityLab
   ```

3. **Check for warnings:**
   - Build in Xcode
   - Resolve ALL warnings
   - Zero warnings policy

4. **Test with VoiceOver:**
   - Enable VoiceOver
   - Navigate your example
   - Verify accessible version works
   - Verify inaccessible version shows problems

### Creating PR

1. **Push to your fork:**
   ```bash
   git push origin feature/photo-picker-example
   ```

2. **Open PR on GitHub**

3. **Fill out PR template:**
   - Description of changes
   - Related issue number
   - Testing checklist
   - Screenshots (if UI changes)

4. **Request review**

### PR Template

```markdown
## Description
Brief description of what this PR accomplishes

## Related Issue
Closes #42

## Changes
- Added Photo Picker example
- Implemented accessible and inaccessible versions
- Added ViewModel and tests
- Updated catalog

## Testing Checklist
- [x] Builds with zero warnings
- [x] All tests pass
- [x] Tested with VoiceOver enabled
- [x] Code follows style guidelines
- [x] Documentation updated

## Screenshots
(If applicable)
```

---

## 👀 Review Process

### What Reviewers Check

- ✅ Code quality and style
- ✅ Accessibility correctness
- ✅ Test coverage
- ✅ Documentation clarity
- ✅ Performance implications

### Responding to Feedback

- **Be receptive** to suggestions
- **Ask questions** if unclear
- **Make changes** in new commits (don't force-push)
- **Thank reviewers** for their time

### After Approval

- Maintainer will merge PR
- Your contribution will be credited
- PR will be closed automatically

---

## ❓ Getting Help

### Have Questions?

- **GitHub Discussions:** Ask in [Q&A](https://github.com/username/swiftui-accessibility-lab/discussions)
- **Discord/Slack:** (If available)
- **Issues:** For bugs or feature requests

### Stuck on Implementation?

- Check existing examples for patterns
- Review `ARCHITECTURE.md`
- Ask in discussions
- Tag maintainers if urgent

### Need Clarification?

- Comment on the related issue
- Start a discussion
- Reach out to maintainers

---

## 🎉 Recognition

All contributors will be:
- Listed in the project README
- Credited in release notes
- Thanked in the community

**Thank you for making iOS apps more accessible! 🌍**

---

**Questions?** Open an issue or discussion. We're here to help!
