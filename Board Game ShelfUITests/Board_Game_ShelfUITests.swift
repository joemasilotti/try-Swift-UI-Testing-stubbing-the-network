import XCTest

struct NetworkStub: Codable {
    var path: String
    var response: Data
}

class Board_Game_ShelfUITests: XCTestCase {
    let app = XCUIApplication()

    override func setUpWithError() throws {
        continueAfterFailure = false


        app.launch()
    }

    func testViewingAGame() throws {
        app.swipeUp()
        app.buttons["Tiny Towns"].tap()
        XCTAssert(app.navigationBars.staticTexts["Tiny Towns"].exists)
    }

}
