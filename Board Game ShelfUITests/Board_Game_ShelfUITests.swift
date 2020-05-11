//
//  Board_Game_ShelfUITests.swift
//  Board Game ShelfUITests
//
//  Created by Joe Masilotti on 2020-05-08.
//  Copyright © 2020 Joe Masilotti. All rights reserved.
//

import XCTest

class Board_Game_ShelfUITests: XCTestCase {
    let app = XCUIApplication()

    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
    }

    func testLaunch() throws {
        XCTAssert(app.navigationBars.staticTexts["My Shelf"].exists)
    }

    func testViewingAGame() throws {
        app.buttons["Aeon's End"].tap()
        XCTAssert(app.navigationBars.staticTexts["Aeon's End"].exists)
    }

    func testEditingAGame() throws {
        app.buttons["Carcassonne"].tap()
        app.navigationBars.buttons["Edit"].tap()

        app.textFields["Name"].tap()
        app.buttons["Clear text"].tap()
        app.textFields["Name"].typeText("Hunters and Gatherers")

        app.sliders["Minimum players"].adjust(toNormalizedSliderPosition: 0.5)
        app.sliders["Maximum players"].adjust(toNormalizedSliderPosition: 0.4)

        app.navigationBars.buttons["Done"].tap()
        XCTAssert(app.staticTexts["Hunters and Gatherers"].waitForExistence(timeout: 1))
        XCTAssert(app.staticTexts["5 players"].exists)
    }

    func testCancellingAnEdit() {
        app.buttons["Ascension: Deckbuilding Game"].tap()
        app.navigationBars.buttons["Edit"].tap()

        app.buttons["Category"].tap()
        app.buttons["Trick taking"].tap()
        app.navigationBars.buttons["Cancel"].tap()

        app.alerts.buttons["Discard changes"].tap()
        XCTAssert(app.staticTexts["Deck building"].waitForExistence(timeout: 1))
    }

    func testWebView() {
        app.buttons["Fox in the Forest"].tap()
        app.buttons["More info"].tap()
        app.webViews.staticTexts["See Full Credits"].tap()
        XCTAssert(app.webViews.staticTexts["Year Published"].waitForExistence(timeout: 5))
    }
}
