# 📚 Examples Catalog

**Complete specification of all examples in the SwiftUI Accessibility Lab**

This document provides detailed breakdowns of each example, including what users will learn, accessibility patterns demonstrated, and implementation notes.

---

## 📋 Table of Contents

### MVP Examples (v0.1.0)
1. [Login Example](#1-login-example-)
2. [Task List Example](#2-task-list-example-)
3. [Task Detail Example](#3-task-detail-example-)
4. [Custom Control Example](#4-custom-control-example-)
5. [Settings Example](#5-settings-example-)

### Future Examples (v0.2.0+)
6. [Photo Picker](#6-photo-picker-)
7. [Chart/Graph](#7-chartgraph-)
8. [Alert & Dialog](#8-alert--dialog-)
9. [Complex Navigation](#9-complex-navigation-)
10. [Form Validation](#10-form-validation-)
11. [Onboarding Flow](#11-onboarding-flow-)
12. [Video Player](#12-video-player-)
13. [Map/Location](#13-maplocation-)
14. [Drag & Drop](#14-drag--drop-)
15. [Multi-Step Wizard](#15-multi-step-wizard-)

---

## MVP Examples (v0.1.0)

---

## 1. Login Example ⭐️

**Category:** Forms & Input  
**Difficulty:** Beginner  
**iOS Version:** 18.0+

### What Users Will Learn
- Text field accessibility labels
- Secure input field accessibility
- Error message announcements
- Button traits and hints
- Form validation with VoiceOver
- Dynamic state communication

### Accessibility Patterns Demonstrated

#### 1. Text Fields with Clear Labels
```swift
TextField("Email", text: $email)
    .accessibilityLabel("Email address")
    .accessibilityHint("Enter your email to log in")
```

#### 2. Secure Input
```swift
SecureField("Password", text: $password)
    .accessibilityLabel("Password")
    .accessibilityValue(showPassword ? "Visible" : "Hidden")
```

#### 3. Error Announcements
```swift
if let error = errorMessage {
    Text(error)
        .foregroundColor(.red)
        .accessibilityLabel(error)
        .onAppear {
            AccessibilityHelpers.announce("Error: \(error)")
        }
}
```

#### 4. Submit Button with Context
```swift
Button("Log In") { login() }
    .accessibilityLabel("Log in")
    .accessibilityHint("Logs you into your account")
    .disabled(!isFormValid)
```

### Components Breakdown

**Accessible Version:**
- Email field with clear label and hint
- Password field with visibility toggle
- Show/hide password button with state
- Login button with disabled state
- Error message with announcement
- Forgot password link with hint

**Inaccessible Version (Shows):**
- Missing labels (VoiceOver reads placeholder only)
- No password visibility state
- No error announcements
- No hint on what login does
- No disabled state feedback

### ViewModel Logic
```swift
@Observable
class LoginViewModel {
    var email: String = ""
    var password: String = ""
    var isLoading: Bool = false
    var errorMessage: String? = nil
    var showPassword: Bool = false
    
    var isFormValid: Bool {
        !email.isEmpty && !password.isEmpty && email.contains("@")
    }
    
    func login() async {
        guard isFormValid else {
            errorMessage = "Please enter a valid email and password"
            return
        }
        
        isLoading = true
        defer { isLoading = false }
        
        // Simulate network call
        try? await Task.sleep(for: .seconds(1))
        
        if email == "test@example.com" && password == "password" {
            errorMessage = nil
            // Success
        } else {
            errorMessage = "Invalid email or password"
        }
    }
    
    func togglePasswordVisibility() {
        showPassword.toggle()
    }
}
```

### Testing Focus
- Email validation logic
- Password field state changes
- Error message presence
- Form validation rules
- VoiceOver announcements

### Common Mistakes Highlighted
❌ Using placeholder as the only label  
❌ No feedback for password visibility  
❌ Silent errors (no announcement)  
❌ No hint on button purpose  
❌ No loading state feedback  

### VoiceOver Experience

**Accessible:**
- "Email address. Text field. Hint: Enter your email to log in."
- "Password. Secure text field. Hidden."
- "Show password. Button."
- "Log in. Button. Hint: Logs you into your account."
- (On error) "Error: Invalid email or password"

**Inaccessible:**
- "Email. Text field."
- "Password. Secure text field."
- "Button."
- (On error) Silence or just red text

---

## 2. Task List Example ⭐️⭐️

**Category:** Lists & Collections  
**Difficulty:** Intermediate  
**iOS Version:** 18.0+

### What Users Will Learn
- List row accessibility
- Swipe action alternatives
- Combining child elements
- Dynamic content updates
- Search field accessibility
- Empty state handling
- Loading state announcements

### Accessibility Patterns Demonstrated

#### 1. Complex Row Accessibility
```swift
HStack {
    Image(systemName: task.isComplete ? "checkmark.circle.fill" : "circle")
    VStack(alignment: .leading) {
        Text(task.title)
        Text(task.dueDate, style: .relative)
            .font(.caption)
    }
    Spacer()
    PriorityBadge(priority: task.priority)
}
.accessibilityElement(children: .combine)
.accessibilityLabel("\(task.title), \(task.priority.rawValue) priority, due \(task.dueDate, style: .relative)")
.accessibilityValue(task.isComplete ? "Completed" : "Not completed")
.accessibilityAddTraits(.isButton)
```

#### 2. Swipe Actions as Accessibility Actions
```swift
.swipeActions(edge: .trailing, allowsFullSwipe: false) {
    Button(role: .destructive) {
        deleteTask(task)
    } label: {
        Label("Delete", systemImage: "trash")
    }
}
.accessibilityActions {
    Button("Delete") { deleteTask(task) }
    Button("Toggle completion") { toggleTask(task) }
}
```

#### 3. Search Field
```swift
TextField("Search tasks", text: $searchText)
    .accessibilityLabel("Search tasks")
    .accessibilityValue(searchText.isEmpty ? "Empty" : searchText)
    .accessibilityHint("Enter text to filter tasks")
```

#### 4. Empty State
```swift
if tasks.isEmpty {
    ContentUnavailableView(
        "No Tasks",
        systemImage: "checkmark.circle",
        description: Text("Create a task to get started")
    )
    .accessibilityElement(children: .combine)
    .accessibilityLabel("No tasks. Create a task to get started.")
}
```

### Components Breakdown

**Main View:**
- Search bar at top
- Filtered task list
- Empty state view
- Pull-to-refresh
- Add button

**TaskRow Subcomponent:**
- Completion checkbox (accessible)
- Task title
- Due date (relative time)
- Priority badge
- Swipe actions

**Accessible Version:**
- Combined labels for full context
- Accessibility actions for swipe alternatives
- Search field with value feedback
- Empty state combines icon and text
- Loading announcements

**Inaccessible Version (Shows):**
- VoiceOver reads each element separately ("Circle", "Task title", "High", "Due in 2 hours")
- No alternative to swipe actions
- Search field with no value feedback
- Empty state reads decorative icon
- No loading feedback

### ViewModel Logic
```swift
@Observable
class TaskListViewModel {
    var tasks: [Task] = []
    var searchText: String = ""
    var isLoading: Bool = false
    var errorMessage: String? = nil
    
    var filteredTasks: [Task] {
        if searchText.isEmpty {
            return tasks
        }
        return tasks.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
    }
    
    func loadTasks() async {
        isLoading = true
        defer { isLoading = false }
        
        try? await Task.sleep(for: .seconds(1))
        tasks = MockData.sampleTasks
        
        AccessibilityHelpers.announce("\(tasks.count) tasks loaded")
    }
    
    func toggleCompletion(_ task: Task) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index].isComplete.toggle()
            let status = tasks[index].isComplete ? "completed" : "not completed"
            AccessibilityHelpers.announce("Task \(status)")
        }
    }
    
    func deleteTask(_ task: Task) {
        tasks.removeAll { $0.id == task.id }
        AccessibilityHelpers.announce("Task deleted")
    }
    
    func addTask(title: String, priority: Priority) {
        let newTask = Task(title: title, priority: priority)
        tasks.append(newTask)
        AccessibilityHelpers.announce("Task added")
    }
}
```

### Testing Focus
- Task filtering logic
- Completion toggle
- Task deletion
- Search filtering
- Announcement on actions

### Common Mistakes Highlighted
❌ Reading each element separately (icon, text, badge)  
❌ Swipe actions with no VoiceOver alternative  
❌ Search with no current value feedback  
❌ Empty state reads "Circle" (decorative icon)  
❌ No announcement on add/delete/toggle  

---

## 3. Task Detail Example ⭐️⭐️

**Category:** Forms & Input  
**Difficulty:** Intermediate  
**iOS Version:** 18.0+

### What Users Will Learn
- Complex layout accessibility
- Edit mode handling
- Date picker accessibility
- Section headers with traits
- Priority selection accessibility
- Save/cancel announcements
- Form field grouping

### Accessibility Patterns Demonstrated

#### 1. Section Headers
```swift
Text("Details")
    .font(.headline)
    .accessibilityAddTraits(.isHeader)
```

#### 2. Editable Fields
```swift
if isEditing {
    TextField("Task title", text: $title)
        .accessibilityLabel("Task title")
        .accessibilityValue(title)
} else {
    Text(title)
        .accessibilityLabel("Task title: \(title)")
}
```

#### 3. Date Picker
```swift
DatePicker("Due date", selection: $dueDate, displayedComponents: [.date, .hourAndMinute])
    .accessibilityLabel("Due date")
    .accessibilityValue(dueDate.formatted(date: .long, time: .shortened))
    .accessibilityHint("Double-tap to change")
```

#### 4. Priority Picker
```swift
Picker("Priority", selection: $priority) {
    ForEach(Priority.allCases) { priority in
        Text(priority.rawValue).tag(priority)
    }
}
.accessibilityLabel("Priority")
.accessibilityValue(priority.rawValue)
.accessibilityHint("Double-tap to change priority")
```

#### 5. Save/Cancel Actions
```swift
Button("Save") {
    saveChanges()
}
.accessibilityLabel("Save changes")
.onAppear {
    if changesSaved {
        AccessibilityHelpers.announce("Changes saved")
    }
}

Button("Cancel") {
    cancelEditing()
}
.accessibilityLabel("Cancel editing")
.onAppear {
    if editingCanceled {
        AccessibilityHelpers.announce("Editing canceled")
    }
}
```

### Components Breakdown

**Main View:**
- Task title (editable)
- Description (editable)
- Priority picker
- Due date picker
- Completion toggle
- Notes section
- Edit/Save/Cancel buttons

**Accessible Version:**
- Section headers with `.isHeader` trait
- Fields announce current values
- Pickers with clear labels and hints
- Announcements on save/cancel
- Disabled state for save if no changes

**Inaccessible Version (Shows):**
- Headers read as normal text
- Fields don't announce current values
- Pickers with unclear labels
- No announcement on save/cancel
- No feedback if form is invalid

### ViewModel Logic
```swift
@Observable
class TaskDetailViewModel {
    var task: Task
    var isEditing: Bool = false
    var hasUnsavedChanges: Bool = false
    
    // Temporary edit state
    var editTitle: String = ""
    var editDescription: String = ""
    var editPriority: Priority = .medium
    var editDueDate: Date = .now
    
    init(task: Task) {
        self.task = task
        resetEditState()
    }
    
    func startEditing() {
        isEditing = true
        resetEditState()
    }
    
    func saveChanges() {
        task.title = editTitle
        task.description = editDescription
        task.priority = editPriority
        task.dueDate = editDueDate
        
        isEditing = false
        hasUnsavedChanges = false
        
        AccessibilityHelpers.announce("Changes saved")
    }
    
    func cancelEditing() {
        isEditing = false
        hasUnsavedChanges = false
        resetEditState()
        
        AccessibilityHelpers.announce("Editing canceled")
    }
    
    private func resetEditState() {
        editTitle = task.title
        editDescription = task.description ?? ""
        editPriority = task.priority
        editDueDate = task.dueDate ?? .now
    }
    
    func toggleCompletion() {
        task.isComplete.toggle()
        let status = task.isComplete ? "completed" : "not completed"
        AccessibilityHelpers.announce("Task marked as \(status)")
    }
}
```

### Testing Focus
- Edit mode transitions
- Save validation
- Cancel resets state
- Date formatting
- Priority changes

### Common Mistakes Highlighted
❌ Headers without `.isHeader` trait  
❌ Fields don't read current value  
❌ Pickers don't explain how to change  
❌ Silent save/cancel (no feedback)  
❌ Can save invalid data  

---

## 4. Custom Control Example ⭐️⭐️⭐️

**Category:** Custom Controls  
**Difficulty:** Advanced  
**iOS Version:** 18.0+

### What Users Will Learn
- Building custom accessible controls
- Adjustable trait for ratings
- Custom accessibility actions
- Gesture accessibility
- Increment/decrement behavior
- Custom value formatting
- Haptic feedback with VoiceOver

### Accessibility Patterns Demonstrated

#### 1. Star Rating Control
```swift
struct StarRating: View {
    @Binding var rating: Int
    let maxRating: Int = 5
    
    var body: some View {
        HStack {
            ForEach(1...maxRating, id: \.self) { index in
                Image(systemName: index <= rating ? "star.fill" : "star")
                    .foregroundColor(.yellow)
                    .onTapGesture {
                        rating = index
                        playHaptic()
                    }
            }
        }
        .accessibilityElement(children: .ignore)  // Combine stars
        .accessibilityLabel("Rating")
        .accessibilityValue("\(rating) out of \(maxRating) stars")
        .accessibilityAdjustableAction { direction in
            switch direction {
            case .increment:
                if rating < maxRating {
                    rating += 1
                    playHaptic()
                    AccessibilityHelpers.announce("\(rating) stars")
                }
            case .decrement:
                if rating > 0 {
                    rating -= 1
                    playHaptic()
                    AccessibilityHelpers.announce("\(rating) stars")
                }
            @unknown default:
                break
            }
        }
        .accessibilityHint("Swipe up to increase, swipe down to decrease")
    }
    
    private func playHaptic() {
        if UIAccessibility.isVoiceOverRunning {
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
        }
    }
}
```

#### 2. Custom Slider with Steps
```swift
struct StepperSlider: View {
    @Binding var value: Double
    let range: ClosedRange<Double>
    let step: Double
    
    var body: some View {
        // Custom visual slider
        customSliderView
            .accessibilityElement(children: .ignore)
            .accessibilityLabel("Volume")
            .accessibilityValue("\(Int(value))%")
            .accessibilityAdjustableAction { direction in
                switch direction {
                case .increment:
                    value = min(value + step, range.upperBound)
                case .decrement:
                    value = max(value - step, range.lowerBound)
                @unknown default:
                    break
                }
            }
            .accessibilityHint("Swipe up or down to adjust")
    }
}
```

#### 3. Color Picker with Descriptions
```swift
struct AccessibleColorPicker: View {
    @Binding var selectedColor: Color
    let colors: [Color]
    
    var body: some View {
        HStack {
            ForEach(colors, id: \.self) { color in
                Circle()
                    .fill(color)
                    .frame(width: 40, height: 40)
                    .accessibilityLabel(colorName(for: color))
                    .accessibilityAddTraits(color == selectedColor ? .isSelected : [])
                    .accessibilityHint("Double-tap to select this color")
                    .onTapGesture {
                        selectedColor = color
                        AccessibilityHelpers.announce("\(colorName(for: color)) selected")
                    }
            }
        }
    }
    
    private func colorName(for color: Color) -> String {
        // Map Color to human-readable names
        switch color {
        case .red: return "Red"
        case .blue: return "Blue"
        case .green: return "Green"
        default: return "Color"
        }
    }
}
```

### Components Breakdown

**Accessible Version:**
- Star rating with adjustable trait
- Swipe up/down to change rating
- Announcements on change
- Haptic feedback when VoiceOver is on
- Clear value ("3 out of 5 stars")
- Hint explains gesture

**Inaccessible Version (Shows):**
- Each star is separate button
- No way to change rating with VoiceOver
- No value announcement
- No haptic feedback
- Unclear current state

### ViewModel Logic
```swift
@Observable
class CustomControlViewModel {
    var rating: Int = 0
    var volume: Double = 50.0
    var selectedColor: Color = .blue
    
    func setRating(_ newRating: Int) {
        rating = newRating
    }
    
    func adjustVolume(by delta: Double) {
        volume = max(0, min(100, volume + delta))
    }
}
```

### Testing Focus
- Rating adjustments
- Boundary conditions (0 and max)
- Haptic feedback presence
- Announcements on change

### Common Mistakes Highlighted
❌ Each star is separate element (5 buttons)  
❌ No adjustable action (can't change with VoiceOver)  
❌ No value ("3 out of 5")  
❌ No hint on how to use  
❌ Haptic feedback interferes with VoiceOver  

---

## 5. Settings Example ⭐️

**Category:** Forms & Input  
**Difficulty:** Beginner  
**iOS Version:** 18.0+

### What Users Will Learn
- Toggle accessibility
- Grouped list structure
- Section headers
- Navigation link accessibility
- System setting integration
- Destructive actions
- Preference persistence

### Accessibility Patterns Demonstrated

#### 1. Toggle with Clear State
```swift
Toggle("Enable notifications", isOn: $notificationsEnabled)
    .accessibilityLabel("Enable notifications")
    .accessibilityValue(notificationsEnabled ? "On" : "Off")
    .accessibilityHint("Double-tap to toggle")
```

#### 2. Navigation Links
```swift
NavigationLink("Account Settings") {
    AccountSettingsView()
}
.accessibilityLabel("Account Settings")
.accessibilityHint("Double-tap to open")
.accessibilityAddTraits(.isButton)
```

#### 3. Destructive Actions with Confirmation
```swift
Button("Delete Account", role: .destructive) {
    showDeleteConfirmation = true
}
.accessibilityLabel("Delete account")
.accessibilityHint("Warning: This action cannot be undone")
.confirmationDialog("Delete Account?", isPresented: $showDeleteConfirmation) {
    Button("Delete", role: .destructive) { deleteAccount() }
    Button("Cancel", role: .cancel) { }
}
```

#### 4. Grouped Lists with Headers
```swift
Form {
    Section {
        Toggle("Enable notifications", isOn: $notifications)
    } header: {
        Text("Notifications")
            .accessibilityAddTraits(.isHeader)
    } footer: {
        Text("Receive alerts for important updates")
    }
}
```

### Components Breakdown

**Sections:**
1. **Account**
   - Email (read-only)
   - Name (navigates to edit)
   - Password (navigates to change)

2. **Notifications**
   - Enable notifications toggle
   - Email notifications toggle
   - Push notifications toggle

3. **Appearance**
   - Theme picker (Light, Dark, System)
   - Text size adjustment

4. **Privacy**
   - Share analytics toggle
   - Privacy policy link

5. **Advanced**
   - Clear cache button
   - Delete account button (destructive)

**Accessible Version:**
- Toggles announce state
- Navigation links have hints
- Section headers use `.isHeader`
- Destructive actions have warnings
- Footers provide context

**Inaccessible Version (Shows):**
- Toggles don't read state clearly
- Navigation links unclear
- Headers blend with content
- No warning for destructive actions
- Footers ignored

### ViewModel Logic
```swift
@Observable
class SettingsViewModel {
    @AppStorage("notificationsEnabled") var notificationsEnabled = true
    @AppStorage("emailNotifications") var emailNotifications = false
    @AppStorage("theme") var theme: Theme = .system
    @AppStorage("shareAnalytics") var shareAnalytics = false
    
    func clearCache() {
        // Clear logic
        AccessibilityHelpers.announce("Cache cleared")
    }
    
    func deleteAccount() async {
        // Delete logic
        AccessibilityHelpers.announce("Account deleted")
    }
}

enum Theme: String, CaseIterable, Identifiable {
    case light = "Light"
    case dark = "Dark"
    case system = "System"
    
    var id: String { rawValue }
}
```

### Testing Focus
- Toggle state changes
- AppStorage persistence
- Theme selection
- Destructive action confirmation

### Common Mistakes Highlighted
❌ Toggle reads "Switch" without state  
❌ Navigation links just say "Button"  
❌ Headers not distinguished  
❌ Destructive actions with no warning  
❌ Footer text ignored  

---

## 📊 Example Comparison Matrix

| Example | Difficulty | Category | Key Patterns | Tests |
|---------|-----------|----------|--------------|-------|
| Login | ⭐️ | Forms | Labels, Hints, Announcements | 5 |
| Task List | ⭐️⭐️ | Lists | Combining, Actions, Search | 8 |
| Task Detail | ⭐️⭐️ | Forms | Headers, Pickers, Edit Mode | 7 |
| Custom Control | ⭐️⭐️⭐️ | Custom | Adjustable, Gestures, Haptics | 6 |
| Settings | ⭐️ | Forms | Toggles, Navigation, Groups | 5 |

**Total MVP:** 5 examples, 31 tests

---

## 🔮 Future Examples (Brief Overview)

### 6. Photo Picker ⭐️⭐️
- PHPickerViewController accessibility
- Image selection with VoiceOver
- Album browsing
- **Patterns:** Image labels, selection state, custom actions

### 7. Chart/Graph ⭐️⭐️⭐️
- Data visualization accessibility
- Chart element descriptions
- Summary announcements
- **Patterns:** Chart accessibility, data point navigation, audio graphs

### 8. Alert & Dialog ⭐️
- Alert accessibility
- Dialog patterns
- Sheet presentation
- **Patterns:** Modal announcements, focus management, dismiss actions

### 9. Complex Navigation ⭐️⭐️
- Multi-screen flows
- Deep linking
- Back navigation
- **Patterns:** Navigation paths, breadcrumbs, focus restoration

### 10. Form Validation ⭐️⭐️
- Real-time validation
- Error inline display
- Field-level errors
- **Patterns:** Live announcements, error associations, validation summaries

---

**Status:** Living Document  
**Last Updated:** 2026-02-16  
**Examples Planned:** 15+  
**Examples in MVP:** 5

---

**Ready to implement! 🚀**
