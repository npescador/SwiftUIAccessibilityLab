import Foundation
import OSLog

enum AppLogger {
    private static let subsystem = Bundle.main.bundleIdentifier ?? "com.npescador.SwiftUIAccessibilityLab"

    static let exampleContainer = Logger(subsystem: subsystem, category: "ExampleContainer")
    static let taskList = Logger(subsystem: subsystem, category: "TaskList")
    static let login = Logger(subsystem: subsystem, category: "Login")
    static let settings = Logger(subsystem: subsystem, category: "Settings")
}
