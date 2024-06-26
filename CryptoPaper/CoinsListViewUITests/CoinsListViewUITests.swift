//
//  CoinsListViewUITests.swift
//  CoinsListViewUITests
//
//  Created by Jairo Júnior on 26/06/24.
//

import XCTest

final class CoinsListViewUITests: XCTestCase {

    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    override func tearDownWithError() throws {
        app = nil
        try super.tearDownWithError()
    }
    
    func testBalanceLabelExists() throws {
        // Verifica se o balanceLabel existe
        let balanceLabel = app.staticTexts["Balance"]
        XCTAssertTrue(balanceLabel.exists, "The balance label should exist")
    }
    
    func testTableViewExists() throws {
        // Verifica se a tableView existe
        let tableView = app.tables["Coin Table"]
        XCTAssertTrue(tableView.exists, "The table view should exist")
    }

}


extension XCUIElement {
    func scrollToElement(element: XCUIElement) {
        while !element.exists {
            swipeUp()
        }
    }
}
