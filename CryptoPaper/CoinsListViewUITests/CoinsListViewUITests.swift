//
//  CoinsListViewUITests.swift
//  CoinsListViewUITests
//
//  Created by Jairo Júnior on 26/06/24.
//
import XCTest

class CryptoPaperUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        continueAfterFailure = false

        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        app = nil
    }

    func testInitialView() throws {
        // Ensure we're in the correct view
        XCTAssertTrue(app.navigationBars["Coins"].exists)
        
        // Check that the balance label is present
        let balanceLabel = app.staticTexts["Balance"]
        XCTAssertTrue(balanceLabel.exists)
        
        // Check that the table view is present
        let tableView = app.tables["Coin Table"]
        XCTAssertTrue(tableView.exists)
        
        // Check that the table view has cells (this requires that coins are already loaded in the app)
        let firstCell = tableView.cells.element(boundBy: 0)
        XCTAssertTrue(firstCell.exists)
    }

    func testPullToRefresh() throws {
        let tableView = app.tables["Coin Table"]
        XCTAssertTrue(tableView.exists)

        let firstCell = tableView.cells.element(boundBy: 0)
        XCTAssertTrue(firstCell.exists)

        // Test pull-to-refresh
        let firstCellStaticText = firstCell.staticTexts.element(boundBy: 0).label
        tableView.swipeDown()
        
        // Wait for refresh to complete
        let expectation = XCTNSPredicateExpectation(predicate: NSPredicate(format: "exists == true"), object: firstCell)
        let result = XCTWaiter().wait(for: [expectation], timeout: 5)
        XCTAssertEqual(result, .completed)
        
        // Ensure the data is refreshed (this would ideally check for updated data, but for simplicity, we check that the cell still exists)
        XCTAssertTrue(tableView.cells.element(boundBy: 0).exists)
        XCTAssertEqual(firstCellStaticText, tableView.cells.element(boundBy: 0).staticTexts.element(boundBy: 0).label)
    }

    func testSearchFunctionality() throws {
        let tableView = app.tables["Coin Table"]
        XCTAssertTrue(tableView.exists)
        
        // Test search functionality
        let searchBar = app.searchFields["Search by ticket"]
        XCTAssertTrue(searchBar.exists)
        searchBar.tap()
        searchBar.typeText("btc")
        app.keyboards.buttons["Search"].tap()
        
        // Check that the search results are correct
        let searchResultCell = tableView.cells.element(boundBy: 0)
        XCTAssertTrue(searchResultCell.exists)
        XCTAssertTrue(searchResultCell.staticTexts["BTC"].exists) // Assuming BTC is a symbol in your data
        
        // Clear the search
        let clearButton = searchBar.buttons["Clear text"]
        XCTAssertTrue(clearButton.exists)
        clearButton.tap()
        
        // Check that the table view reloads all the data
        XCTAssertTrue(tableView.cells.element(boundBy: 0).exists)
    }

    func testClearSearch() throws {
        let tableView = app.tables["Coin Table"]
        XCTAssertTrue(tableView.exists)

        let searchBar = app.searchFields["Search by ticket"]
        XCTAssertTrue(searchBar.exists)
        searchBar.tap()
        searchBar.typeText("btc")
        app.keyboards.buttons["Search"].tap()

        // Clear the search
        let clearButton = searchBar.buttons["Clear text"]
        XCTAssertTrue(clearButton.exists)
        clearButton.tap()
        
        // Check that the table view reloads all the data
        XCTAssertTrue(tableView.cells.element(boundBy: 0).exists)
    }
}
