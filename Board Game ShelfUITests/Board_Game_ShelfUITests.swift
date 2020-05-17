import XCTest
import Swifter

class Board_Game_ShelfUITests: XCTestCase {
    let app = XCUIApplication()
    let server = HttpServer()

    override func setUpWithError() throws {
        continueAfterFailure = false

        try server.start()
        server["/boardgames.json"] = { _ in
            .ok(.json([
                [
                    "id": 265736,
                    "name": "Tiny Towns",
                    "minimumPlayers": 1,
                    "maximumPlayers": 6,
                    "imageName": "tiny-towns",
                    "category": "Grid coverage",
                    "description": "Game description."
                ]
            ]))
        }
        app.launchEnvironment["base-url"] = "http://localhost:8080"

        app.launch()
    }

    func testViewingAGame() throws {
        app.swipeUp()
        app.buttons["Tiny Towns"].tap()
        XCTAssert(app.navigationBars.staticTexts["Tiny Towns"].exists)
    }
}
