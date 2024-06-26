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
        let tableView = app.tables["Extract Table"]
        XCTAssertTrue(tableView.exists, "The table view should exist")
    }
    
    func testTableViewCells() throws {
        let tableView = app.tables["Extract Table"]
        
        // Aguarda a tableView estar presente
        let exists = NSPredicate(format: "exists == true")
        expectation(for: exists, evaluatedWith: tableView, handler: nil)
        waitForExpectations(timeout: 5, handler: nil)
        
        // Verifica se há células na tableView
        XCTAssertTrue(tableView.cells.count > 0, "There should be cells in the table view")
        
        // Verifica o conteúdo da primeira célula
        let firstCell = tableView.cells.element(boundBy: 0)
        XCTAssertTrue(firstCell.staticTexts["BTC"].exists, "The first cell should display 'BTC'")
    }
    
    func testTableViewScroll() throws {
        let tableView = app.tables["Extract Table"]
        
        // Aguarda a tableView estar presente
        let exists = NSPredicate(format: "exists == true")
        expectation(for: exists, evaluatedWith: tableView, handler: nil)
        waitForExpectations(timeout: 5, handler: nil)
        
        // Faz scroll até a última célula
        let lastCell = tableView.cells.element(boundBy: tableView.cells.count - 1)
        tableView.scrollToElement(element: lastCell)
        
        // Verifica se a última célula está visível
        XCTAssertTrue(lastCell.isHittable, "The last cell should be visible after scrolling")
    }
}


extension XCUIElement {
    func scrollToElement(element: XCUIElement) {
        while !element.exists {
            swipeUp()
        }
    }
}
