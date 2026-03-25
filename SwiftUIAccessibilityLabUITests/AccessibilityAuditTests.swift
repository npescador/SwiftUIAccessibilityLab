import XCTest

/// Runs XCTest's built-in accessibility auditor against the accessible variant of every
/// example screen. Each route gets its own activity for clear CI attribution.
@MainActor
final class AccessibilityAuditTests: XCTestCase {

    private let allRoutes = [
        "login",
        "taskList",
        "taskDetail",
        "customControl",
        "settings",
        "quantityControl",
        "dynamicType",
        "dataChart",
        "reduceMotion",
        "customRotor"
    ]

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testAccessibilityAuditAllExamples() throws {
        let app = XCUIApplication()
        app.launch()

        for route in allRoutes {
            XCTContext.runActivity(named: "Audit \(route) — accessible variant") { _ in
                openExample(route: route, in: app)
                XCTAssertTrue(
                    app.otherElements["example.screen.\(route)"].waitForExistence(timeout: 3),
                    "example.screen.\(route) should be visible before audit"
                )
                try? app.performAccessibilityAudit()
                navigateBack(in: app)
            }
        }
    }

    // MARK: - Navigation helpers

    private func openExample(route: String, in app: XCUIApplication) {
        for _ in 0..<6 {
            let link = app.buttons["example.link.\(route)"]
            if link.exists {
                link.tap()
                return
            }
            app.swipeUp()
        }
        XCTFail("Could not find example route \(route) in catalog")
    }

    private func navigateBack(in app: XCUIApplication) {
        let backButton = app.navigationBars.buttons.firstMatch
        XCTAssertTrue(backButton.waitForExistence(timeout: 2))
        backButton.tap()
    }
}
