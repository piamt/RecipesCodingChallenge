//
//  RecipesCodingChallengeUITests.swift
//  RecipesCodingChallengeUITests
//
//  Created by Pia on 1/10/24.
//

import XCTest

final class RecipesCodingChallengeUITests: XCTestCase {
    
    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments = ["-UITests"]
        app.launch()
    }

    override func tearDownWithError() throws {
    }
    
    func testTapOnSearch() {
        let startSearchButton = app.buttons["Start search"]
        app.navigationBars["Recipes"].searchFields["Search recipes"].tap()
        app.navigationBars["Recipes"].searchFields["Search recipes"].typeText("Chicken")
        startSearchButton.tap()
        XCTAssertEqual(app.collectionViews["list_recipes"].cells.count, 2)
        XCTAssertEqual(app.collectionViews["list_recipes"].cells.element(boundBy: 0).staticTexts.element.label, "Miso Soup Potato Chips Recipe")
    }
}
