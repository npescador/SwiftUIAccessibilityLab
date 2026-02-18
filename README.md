# 🌟 SwiftUI Accessibility Lab

**The definitive open-source resource for mastering iOS accessibility**

[![Swift](https://img.shields.io/badge/Swift-6.0+-orange.svg)](https://swift.org)
[![iOS](https://img.shields.io/badge/iOS-18.0+-blue.svg)](https://developer.apple.com/ios/)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
[![Platform](https://img.shields.io/badge/Platform-iOS-lightgrey.svg)](https://developer.apple.com)

---

## 📌 Current MVP Status

- ✅ MVP examples implemented: `5/5` (Login, Task List, Task Detail, Custom Control, Settings)
- ✅ Accessible and inaccessible variants integrated in app navigation
- ✅ Swift Testing ViewModel suites added for all implemented examples
- ✅ Release prep artifacts drafted (`docs/RELEASE-PREP.md` and `docs/RELEASE-NOTES-v0.1.0.md`)
- ✅ VoiceOver audit template added (`docs/VOICEOVER-AUDIT-v0.1.0.md`)
- ⚠️ Repository remote URLs are placeholders until the public GitHub repository is created

---

## 📖 Overview

**SwiftUI Accessibility Lab** is an educational SwiftUI app that teaches iOS accessibility through **real-world, runnable examples** showing both ❌ **broken** and ✅ **fixed** implementations side-by-side.

### 🎯 Why This Project?

- **Learn by Comparison:** See exactly what's wrong and how to fix it
- **Run Real Code:** Not just documentation—actual working examples
- **Modern Patterns:** iOS 18+, Swift 6, `@Observable`, Observation framework
- **Test-Driven:** Every example includes accessibility tests
- **Open Source:** Free forever, community-driven

---

## ✨ Features

### 🔄 Comparison Mode
Toggle between accessible and inaccessible versions of the same UI to understand:
- What breaks without accessibility
- How to implement it correctly
- Why it matters to users

### 📱 Real-World Examples
5 core examples (MVP):
1. **Login Screen** - Forms, text fields, secure input
2. **Task List** - Lists, swipe actions, custom rows
3. **Task Detail** - Complex layouts, priority badges, date pickers
4. **Custom Control** - Star rating, custom gestures, accessibility actions
5. **Settings** - Toggles, pickers, grouped lists

### 🧪 Comprehensive Testing
- Swift Testing framework
- Accessibility property assertions
- VoiceOver simulation tests

Current test suites include ViewModel coverage for all implemented MVP examples.

### 📚 Educational Focus
- Inline code comments explaining "why"
- Difficulty ratings (⭐️⭐️⭐️)
- "What you'll learn" summaries
- References to Apple documentation

---

## 🚀 Getting Started

### Requirements
- **Xcode 16.0+**
- **iOS 18.0+** (Simulator or Device)
- **macOS 15.0+** (Sequoia)
- **Swift 6.0+**

### Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/yourusername/swiftui-accessibility-lab.git
   cd swiftui-accessibility-lab
   ```

2. **Open in Xcode:**
   ```bash
   open SwiftUIAccessibilityLab.xcodeproj
   ```

3. **Build and Run:**
   - Select a simulator (iPhone 16 Pro recommended)
   - Press `Cmd + R` to build and run
   - **Enable VoiceOver:** `Cmd + F5` (or Settings → Accessibility → VoiceOver)

4. **Explore Examples:**
   - Browse the catalog
   - Toggle between accessible and inaccessible versions
   - Turn on VoiceOver to experience the difference

---

## 📱 Usage

### Testing with VoiceOver

**Enable VoiceOver:**
- **Shortcut:** `Cmd + F5` (in Simulator)
- **Settings:** Settings → Accessibility → VoiceOver → On
- **Triple-click:** Accessibility Shortcut (on device)

**VoiceOver Gestures (Simulator):**
- **Swipe Right:** Next element (hold `Option`, swipe right with mouse)
- **Swipe Left:** Previous element
- **Double-tap:** Activate element
- **Rotate:** `Option + Cmd + Arrow Keys`

**Pro Tip:** Use the Accessibility Inspector in Xcode:
- `Xcode → Developer Tools → Accessibility Inspector`
- Select your running app
- Navigate through the accessibility tree

### Running Tests

```bash
# Run all tests
xcodebuild test -scheme SwiftUIAccessibilityLab \
  -destination 'platform=iOS Simulator,name=iPhone 16 Pro,OS=18.0'

# Run specific test suite
xcodebuild test -scheme SwiftUIAccessibilityLab \
  -only-testing:SwiftUIAccessibilityLabTests/LoginViewModelTests

# In Xcode
# Cmd + U (run all tests)
# Ctrl + Option + Cmd + U (run tests again)
```

---

## 🎓 What You'll Learn

### Accessibility Fundamentals
- ✅ Labels, Values, Hints, Identifiers
- ✅ Traits (isButton, isHeader, isImage, etc.)
- ✅ Hidden elements and accessibility hiding
- ✅ Custom actions
- ✅ Accessibility notifications

### Advanced Patterns
- ✅ Combining children for complex layouts
- ✅ Sort priority for custom navigation order
- ✅ Adjustable traits for sliders and steppers
- ✅ Dynamic announcements
- ✅ Custom accessibility focus

### iOS 18+ Features
- ✅ `isEnabled` parameter on all accessibility modifiers
- ✅ Performance optimizations
- ✅ Modern SwiftUI accessibility APIs

### Testing Accessibility
- ✅ Unit testing accessibility properties
- ✅ UI testing with XCUIApplication
- ✅ VoiceOver simulation
- ✅ Accessibility Inspector usage

---

## 🗂️ Project Structure

```
SwiftUIAccessibilityLab/
├── App/                        # App entry point
├── Examples/                   # All examples
│   ├── 01-LoginExample/
│   ├── 02-TaskListExample/
│   ├── 03-TaskDetailExample/
│   ├── 04-CustomControlExample/
│   └── 05-SettingsExample/
├── SharedComponents/           # Reusable components
├── Models/                     # Data models
├── Utils/                      # Helpers and utilities
├── Tests/                      # Unit and UI tests
└── Resources/                  # Assets and localizations
```

**Key Files:**
- `ExampleContainer.swift` - Wrapper for all examples with comparison toggle
- `ExampleMetadata.swift` - Metadata for each example (title, difficulty, etc.)
- `AccessibilityHelpers.swift` - Reusable accessibility utilities

---

## 🧩 Example Breakdown

### 1. Login Example ⭐️
**What you'll learn:**
- Text field accessibility labels
- Secure input fields
- Error announcements
- Button traits and hints
- Form validation with VoiceOver

**Key Patterns:**
- `.accessibilityLabel()` for clear field identification
- `.accessibilityValue()` for dynamic state (e.g., "Password hidden")
- `.accessibilityHint()` for instructions
- Posting announcements on errors

---

### 2. Task List Example ⭐️⭐️
**What you'll learn:**
- List row accessibility
- Swipe actions
- Custom row layouts
- Dynamic content updates
- Search field accessibility

**Key Patterns:**
- `.accessibilityElement(children: .combine)` for complex rows
- `.accessibilityActions()` for swipe alternatives
- `.accessibilityLabel()` combining multiple text elements
- Sort priority for logical navigation

---

### 3. Task Detail Example ⭐️⭐️
**What you'll learn:**
- Complex layout accessibility
- Date picker accessibility
- Priority badge traits
- Edit mode announcements
- Save/cancel actions

**Key Patterns:**
- Custom accessibility labels for badges
- Announcements on save/cancel
- `.isHeader` trait for section headers
- Custom value for editable fields

---

### 4. Custom Control Example ⭐️⭐️⭐️
**What you'll learn:**
- Building custom accessible controls
- Adjustable trait for ratings
- Custom gestures
- Accessibility actions
- Increment/decrement behavior

**Key Patterns:**
- `.accessibilityAdjustableAction()` for star rating
- Custom value ("3 out of 5 stars")
- Alternative actions for tap gestures
- Haptic feedback integration

---

### 5. Settings Example ⭐️
**What you'll learn:**
- Toggle accessibility
- Picker accessibility
- Grouped list structure
- Navigation links
- System settings integration

**Key Patterns:**
- Clear labels for toggles with state
- Picker value announcements
- `.isHeader` for section headers
- Navigation hint ("double-tap to open")

---

## 📸 Screenshots (Placeholders)

Release screenshot placeholders are tracked in:
- [docs/screenshots/README.md](docs/screenshots/README.md)

Expected files:
- `docs/screenshots/login-accessible.png`
- `docs/screenshots/login-inaccessible.png`
- `docs/screenshots/tasklist-accessible.png`
- `docs/screenshots/tasklist-inaccessible.png`
- `docs/screenshots/taskdetail-accessible.png`
- `docs/screenshots/taskdetail-inaccessible.png`
- `docs/screenshots/customcontrol-accessible.png`
- `docs/screenshots/customcontrol-inaccessible.png`
- `docs/screenshots/settings-accessible.png`
- `docs/screenshots/settings-inaccessible.png`

---

## 🧪 Testing Philosophy

### Unit Tests
- Test ViewModels in isolation
- Verify accessibility properties
- Mock dependencies
- Use Swift Testing framework

### UI Tests
- End-to-end accessibility flows
- VoiceOver navigation simulation
- Accessibility identifier usage
- Real-world scenarios

### Accessibility Tests
- Focus on user experience
- Test with VoiceOver enabled
- Verify announcements
- Check trait correctness

---

## 🤝 Contributing

We welcome contributions! See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

**Ways to contribute:**
- 🐛 Report bugs
- 💡 Suggest new examples
- 📝 Improve documentation
- ✅ Add tests
- 🎨 Enhance UI/UX
- 🌍 Add localizations

**Good first issues:**
- Look for `good first issue` label
- Add tests to existing examples
- Fix typos in documentation
- Improve code comments

---

## 📚 Resources

### Official Apple Documentation
- [Accessibility for UIKit](https://developer.apple.com/documentation/uikit/accessibility_for_uikit)
- [Accessibility for SwiftUI](https://developer.apple.com/documentation/swiftui/view-accessibility)
- [Human Interface Guidelines - Accessibility](https://developer.apple.com/design/human-interface-guidelines/accessibility)
- [WWDC Videos on Accessibility](https://developer.apple.com/videos/frameworks/accessibility)

### Tools
- [Accessibility Inspector](https://developer.apple.com/library/archive/documentation/Accessibility/Conceptual/AccessibilityMacOSX/OSXAXTestingApps.html)
- [VoiceOver](https://www.apple.com/accessibility/voiceover/)
- [Xcode Accessibility Audits](https://developer.apple.com/documentation/xcode/improving-your-app-s-accessibility)

### Community
- [GitHub Discussions](https://github.com/yourusername/swiftui-accessibility-lab/discussions)
- [Issues](https://github.com/yourusername/swiftui-accessibility-lab/issues)
- [Stack Overflow - ios-accessibility](https://stackoverflow.com/questions/tagged/ios-accessibility)

---

## 📄 License

This project is licensed under the **MIT License** - see the [LICENSE](LICENSE) file for details.

**TL;DR:** You can use this code for anything (personal, commercial, education) as long as you include the license notice.

---

## 🙏 Acknowledgments

- **Apple Developer Documentation** for comprehensive accessibility guides
- **WWDC Sessions** for best practices and examples
- **iOS Accessibility Community** for inspiration and feedback
- **All Contributors** who help improve this project

---

## 🌟 Support This Project

If you find this project helpful:
- ⭐️ **Star this repository** on GitHub
- 🐦 **Share on Twitter/X** with `#iOSAccessibility`
- 📝 **Write a blog post** about your experience
- 🎤 **Give a talk** at your local meetup
- 🤝 **Contribute** examples or improvements

---

## 📞 Contact

- **GitHub Issues:** [Report bugs or request features](https://github.com/yourusername/swiftui-accessibility-lab/issues)
- **Discussions:** [Ask questions or share ideas](https://github.com/yourusername/swiftui-accessibility-lab/discussions)
- **Twitter/X:** [@yourusername](https://twitter.com/yourusername)

---

## 🗺️ Roadmap

See [ROADMAP.md](docs/ROADMAP.md) for future plans.
Release preparation checklist: [RELEASE-PREP.md](docs/RELEASE-PREP.md).
Draft release notes: [RELEASE-NOTES-v0.1.0.md](docs/RELEASE-NOTES-v0.1.0.md).
VoiceOver manual validation template: [VOICEOVER-AUDIT-v0.1.0.md](docs/VOICEOVER-AUDIT-v0.1.0.md).

**Coming Soon:**
- Code snippet viewer (show implementation inline)
- 5+ new examples
- Search and filter examples
- Difficulty-based learning path
- Video walkthroughs

---

## ⚡️ Quick Start Checklist

- [ ] Clone the repository
- [ ] Open in Xcode 16+
- [ ] Build and run on iOS 18+ simulator
- [ ] Enable VoiceOver (`Cmd + F5`)
- [ ] Try the Login example
- [ ] Toggle between accessible and inaccessible versions
- [ ] Notice the difference with VoiceOver
- [ ] Explore other examples
- [ ] Run the tests (`Cmd + U`)
- [ ] Star the repo if you find it useful! ⭐️

---

**Built with ❤️ by the iOS Accessibility community**

**Made with SwiftUI. Powered by Swift 6. Accessible for everyone.**

---

<p align="center">
  <strong>Making iOS apps accessible, one example at a time 🌍</strong>
</p>
