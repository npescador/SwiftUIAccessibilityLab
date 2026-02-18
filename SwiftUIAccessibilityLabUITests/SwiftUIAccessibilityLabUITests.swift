import XCTest

final class SwiftUIAccessibilityLabUITests: XCTestCase {
    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    @MainActor
    func testCatalogShowsMVPExamples() throws {
        let app = XCUIApplication()
        app.launch()

        XCTAssertTrue(app.staticTexts["Login"].waitForExistence(timeout: 2))
        XCTAssertTrue(app.staticTexts["Task List"].exists)
        XCTAssertTrue(app.staticTexts["Task Detail"].exists)
        XCTAssertTrue(app.staticTexts["Custom Control"].exists)
        XCTAssertTrue(app.staticTexts["Settings"].exists)
    }

    @MainActor
    func testLoginExampleCanSwitchVariants() throws {
        let app = XCUIApplication()
        app.launch()

        openExample(route: "login", title: "Login", in: app)

        XCTAssertTrue(app.staticTexts["Welcome back"].waitForExistence(timeout: 2))
        XCTAssertTrue(app.segmentedControls["comparison.toggle"].waitForExistence(timeout: 2))
        XCTAssertTrue(app.segmentedControls.buttons["Accessible"].exists)
        XCTAssertTrue(app.segmentedControls.buttons["Inaccessible"].exists)

        app.segmentedControls.buttons["Inaccessible"].tap()
        XCTAssertTrue(app.buttons["Show"].waitForExistence(timeout: 2))

        app.segmentedControls.buttons["Accessible"].tap()
        XCTAssertTrue(app.buttons["login.password.visibility.button"].waitForExistence(timeout: 2))
    }

    @MainActor
    func testCanOpenAllMVPExamples() throws {
        let app = XCUIApplication()
        app.launch()

        let examples: [(route: String, title: String)] = [
            ("login", "Login"),
            ("taskList", "Task List"),
            ("taskDetail", "Task Detail"),
            ("customControl", "Custom Control"),
            ("settings", "Settings")
        ]

        for example in examples {
            openExample(route: example.route, title: example.title, in: app)
            XCTAssertTrue(app.navigationBars.staticTexts[example.title].waitForExistence(timeout: 2))
            navigateBack(in: app)
        }
    }

    @MainActor
    private func openExample(route: String, title: String, in app: XCUIApplication) {
        let identifiedLink = app.buttons["example.link.\(route)"]
        if identifiedLink.waitForExistence(timeout: 2) {
            identifiedLink.tap()
            return
        }

        let target = app.staticTexts[title]
        if target.waitForExistence(timeout: 2) {
            target.tap()
            return
        }

        for _ in 0..<6 {
            app.swipeUp()
            if app.buttons["example.link.\(route)"].exists {
                app.buttons["example.link.\(route)"].tap()
                return
            }
            if target.exists {
                target.tap()
                return
            }
        }

        XCTFail("Could not find example \(title) in catalog")
    }

    @MainActor
    private func navigateBack(in app: XCUIApplication) {
        let backButton = app.navigationBars.buttons.firstMatch
        XCTAssertTrue(backButton.waitForExistence(timeout: 2))
        backButton.tap()
    }

    @MainActor
    func testLaunchPerformance() throws {
        measure(metrics: [XCTApplicationLaunchMetric()]) {
            XCUIApplication().launch()
        }
    }
}
