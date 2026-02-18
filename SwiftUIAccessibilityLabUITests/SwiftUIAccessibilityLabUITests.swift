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

        openExample(named: "Login", in: app)

        XCTAssertTrue(app.staticTexts["Welcome back"].waitForExistence(timeout: 2))
        XCTAssertTrue(app.segmentedControls.buttons["Accessible"].exists)
        XCTAssertTrue(app.segmentedControls.buttons["Inaccessible"].exists)

        app.segmentedControls.buttons["Inaccessible"].tap()
        XCTAssertTrue(app.buttons["Show"].waitForExistence(timeout: 2))

        app.segmentedControls.buttons["Accessible"].tap()
        XCTAssertTrue(app.buttons["Show password"].waitForExistence(timeout: 2))
    }

    @MainActor
    func testCanOpenAllMVPExamples() throws {
        let app = XCUIApplication()
        app.launch()

        let examples = ["Login", "Task List", "Task Detail", "Custom Control", "Settings"]

        for title in examples {
            openExample(named: title, in: app)
            XCTAssertTrue(app.navigationBars.staticTexts[title].waitForExistence(timeout: 2))
            navigateBack(in: app)
        }
    }

    @MainActor
    private func openExample(named title: String, in app: XCUIApplication) {
        let target = app.staticTexts[title]
        if target.waitForExistence(timeout: 2) {
            target.tap()
            return
        }

        for _ in 0..<6 {
            app.swipeUp()
            if app.staticTexts[title].exists {
                app.staticTexts[title].tap()
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
