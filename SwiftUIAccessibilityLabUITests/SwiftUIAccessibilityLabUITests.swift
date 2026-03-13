import XCTest

final class SwiftUIAccessibilityLabUITests: XCTestCase {
    private let routes = ["login", "taskList", "taskDetail", "customControl", "settings"]

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    @MainActor
    func testCatalogShowsMVPExamples() throws {
        let app = XCUIApplication()
        app.launch()

        for route in routes {
            openExample(route: route, in: app)
            navigateBack(in: app)
        }
    }

    @MainActor
    func testLoginExampleCanSwitchVariants() throws {
        let app = XCUIApplication()
        app.launch()

        openExample(route: "login", in: app)

        XCTAssertTrue(app.staticTexts["Welcome back"].waitForExistence(timeout: 2))
        XCTAssertTrue(app.otherElements["comparison.toggle"].waitForExistence(timeout: 2))
        XCTAssertTrue(app.buttons["comparison.option.accessible"].exists)
        XCTAssertTrue(app.buttons["comparison.option.inaccessible"].exists)

        app.buttons["comparison.option.inaccessible"].tap()
        XCTAssertTrue(app.buttons["Show"].waitForExistence(timeout: 2))

        app.buttons["comparison.option.accessible"].tap()
        XCTAssertTrue(app.buttons["login.password.visibility.button"].waitForExistence(timeout: 2))
    }

    @MainActor
    func testCanOpenAllMVPExamples() throws {
        let app = XCUIApplication()
        app.launch()

        for route in routes {
            openExample(route: route, in: app)
            XCTAssertTrue(app.otherElements["example.screen.\(route)"].waitForExistence(timeout: 2))
            navigateBack(in: app)
        }
    }

    @MainActor
    func testAccessibleLoginContract() throws {
        let app = XCUIApplication()
        app.launch()

        openExample(route: "login", in: app)

        let emailField = app.textFields["login.email.field"]
        XCTAssertTrue(emailField.waitForExistence(timeout: 2))

        let passwordField = app.secureTextFields["login.password.field"]
        XCTAssertTrue(passwordField.exists)

        let submitButton = app.buttons["login.submit.button"]
        XCTAssertTrue(submitButton.exists)
        XCTAssertFalse(submitButton.isEnabled)

        emailField.tap()
        emailField.typeText("invalid@example.com")
        passwordField.tap()
        passwordField.typeText("wrong")

        XCTAssertTrue(submitButton.isEnabled)
        submitButton.tap()

        XCTAssertTrue(app.staticTexts["login.error.message"].waitForExistence(timeout: 3))
    }

    @MainActor
    func testAccessibleTaskListContract() throws {
        let app = XCUIApplication()
        app.launch()

        openExample(route: "taskList", in: app)

        let searchField = app.textFields["tasklist.search.field"]
        XCTAssertTrue(searchField.waitForExistence(timeout: 3))
        XCTAssertTrue(app.buttons["tasklist.add.button"].exists)
        XCTAssertTrue(app.otherElements["tasklist.list"].waitForExistence(timeout: 3))

        let row = app.buttons.matching(NSPredicate(format: "identifier BEGINSWITH %@", "tasklist.row.")).firstMatch
        XCTAssertTrue(row.waitForExistence(timeout: 3))
    }

    @MainActor
    func testAccessibleTaskDetailContract() throws {
        let app = XCUIApplication()
        app.launch()

        openExample(route: "taskDetail", in: app)

        let editButton = app.buttons["taskdetail.edit.button"]
        XCTAssertTrue(editButton.waitForExistence(timeout: 2))

        let completedToggle = app.switches["taskdetail.completed.toggle"]
        XCTAssertTrue(completedToggle.exists)

        editButton.tap()
        XCTAssertTrue(app.buttons["taskdetail.save.button"].waitForExistence(timeout: 2))
        XCTAssertTrue(app.textFields["taskdetail.title.field"].exists)
    }

    @MainActor
    func testAccessibleCustomControlContract() throws {
        let app = XCUIApplication()
        app.launch()

        openExample(route: "customControl", in: app)

        let rating = app.otherElements["customcontrol.rating"]
        XCTAssertTrue(rating.waitForExistence(timeout: 2))

        let slider = app.sliders["customcontrol.volume.slider"]
        XCTAssertTrue(slider.exists)
        XCTAssertTrue(app.otherElements["customcontrol.color.red"].exists)
        XCTAssertTrue(app.otherElements["customcontrol.color.green"].exists)
        XCTAssertTrue(app.otherElements["customcontrol.color.blue"].exists)
    }

    @MainActor
    func testAccessibleSettingsContract() throws {
        let app = XCUIApplication()
        app.launch()

        openExample(route: "settings", in: app)

        let notificationsToggle = app.switches["settings.notifications.toggle"]
        XCTAssertTrue(notificationsToggle.waitForExistence(timeout: 2))

        let themePicker = app.otherElements["settings.theme.picker"]
        XCTAssertTrue(themePicker.exists)
        XCTAssertTrue(app.buttons["settings.clearcache.button"].exists)

        app.buttons["settings.clearcache.button"].tap()
        XCTAssertTrue(app.staticTexts["settings.status.message"].waitForExistence(timeout: 2))
    }

    @MainActor
    private func openExample(route: String, in app: XCUIApplication) {
        for _ in 0..<6 {
            let link = findExampleLink(for: route, in: app)
            if link.exists {
                link.tap()
                return
            }
            app.swipeUp()
        }

        XCTFail("Could not find example route \(route) in catalog")
    }

    @MainActor
    private func findExampleLink(for route: String, in app: XCUIApplication) -> XCUIElement {
        app.buttons["example.link.\(route)"]
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
