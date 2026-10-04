import XCTest

// Walks through the main screens and saves a screenshot of each.
// CI sets SCREENSHOT_DIR (via TEST_RUNNER_SCREENSHOT_DIR) and uploads the files.
final class ScreenshotTests: XCTestCase {
    private let app = XCUIApplication()

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    private func save(_ name: String) {
        let shot = XCUIScreen.main.screenshot()
        let attachment = XCTAttachment(screenshot: shot)
        attachment.name = name
        attachment.lifetime = .keepAlways
        add(attachment)
        if let dir = ProcessInfo.processInfo.environment["SCREENSHOT_DIR"] {
            try? FileManager.default.createDirectory(atPath: dir, withIntermediateDirectories: true)
            try? shot.pngRepresentation.write(to: URL(fileURLWithPath: dir).appendingPathComponent("\(name).png"))
        }
    }

    @MainActor
    func testScreenshots() throws {
        app.launch()

        // The simulator has no enrolled Face ID, so the app falls back to the PIN screen.
        let pinField = app.secureTextFields["PIN"]
        if !pinField.waitForExistence(timeout: 10) {
            app.buttons["Enter PIN Instead"].tap()
        }
        XCTAssertTrue(pinField.waitForExistence(timeout: 10))
        save("01-pin")
        pinField.tap()
        pinField.typeText("1234")
        app.buttons["Login"].tap()

        XCTAssertTrue(app.staticTexts["Luke Skywalker"].waitForExistence(timeout: 30))
        save("02-characters")

        app.staticTexts["Luke Skywalker"].tap()
        sleep(2)
        save("03-character-detail")
        app.navigationBars.buttons.element(boundBy: 0).tap()

        app.tabBars.buttons["Starships"].tap()
        sleep(4)
        save("04-starships")
        app.cells.element(boundBy: 0).tap()
        sleep(2)
        save("05-starship-detail")
        app.navigationBars.buttons.element(boundBy: 0).tap()

        app.tabBars.buttons["Planets"].tap()
        sleep(4)
        save("06-planets")
    }
}
