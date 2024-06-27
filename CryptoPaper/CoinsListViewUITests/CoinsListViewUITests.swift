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
    
    func testTableViewHasCells() throws {
        let tableView = app.tables["Coin Table"]
        XCTAssertTrue(tableView.cells.count > 0, "The table view should have at least one cell")
    }

    func testIfUIComponentsHasNilValues() throws {
        
        let extractTableTable = XCUIApplication().tables["Coin Table"]
        
        XCTAssertFalse(extractTableTable.staticTexts[""].exists, "The TableView has some nil values")
    }
    
    func testNoInvalidValues() {
        let extractTableTable = XCUIApplication().tables["Coin Table"]

        // Verifica se não há células com o valor $inf
        XCTAssertFalse(extractTableTable.staticTexts["$0.000000000"].exists, "The price can not be nil")


    }

}
