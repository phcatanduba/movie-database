
//
//  Movie_DatabaseUITests.swift
//  Movie-DatabaseUITests
//
//  Created by Pedro Henrique Catanduba de Andrade on 12/07/22.
//

import XCTest

class Movie_DatabaseUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUpWithError() throws {
        app = .init()
        app.launch()
        
        continueAfterFailure = false
    }

    func testDetails() throws {
        app.collectionViews.cells.firstMatch.tap()
        let synopsis = app.staticTexts.matching(identifier: "Synopsis")
        let castAndCrew = app.staticTexts.matching(identifier: "Cast & Crew")
        let photos = app.staticTexts.matching(identifier: "Photos")
    
        XCTAssert(synopsis.element.exists)
        XCTAssert(castAndCrew.element.exists)
        XCTAssert(photos.element.exists)
    }
}
