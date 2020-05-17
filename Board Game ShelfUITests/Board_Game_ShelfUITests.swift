import XCTest

struct NetworkStub: Codable {
    var path: String
    var response: Data
}

class Board_Game_ShelfUITests: XCTestCase {
    let app = XCUIApplication()

    override func setUpWithError() throws {
        continueAfterFailure = false

        enableUITesting()
        stubNetwork()

        app.launch()
    }

    func testViewingAGame() throws {
        app.swipeUp()
        app.buttons["Tiny Towns"].tap()
        XCTAssert(app.navigationBars.staticTexts["Tiny Towns"].exists)
    }

    private func enableUITesting() {
        var launchArguments = app.launchArguments
        launchArguments += ["ui-testing"]
        app.launchArguments = launchArguments
    }

    private func stubNetwork() {
        let response = """
        [
            {
                "id": 265736,
                "name": "Tiny Towns",
                "minimumPlayers": 1,
                "maximumPlayers": 6,
                "imageName": "tiny-towns",
                "category": "Grid coverage",
                "description": "Game description."
            }
        ]
        """.data(using: .utf8)!
        let networkStub = NetworkStub(path: "boardgames.json", response: response)
        let data = try! JSONEncoder().encode([networkStub])
        app.launchEnvironment["network-stubs"] = String(data: data, encoding: .utf8)
    }
}
