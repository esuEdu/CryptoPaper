//
//  CoinsListView.swift
//  CryptoPaperUITests
//
//  Created by Eduardo on 25/06/24.
//

import XCTest

final class CoinsListView: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
    
    func testCoinListView() {
        let app = XCUIApplication()
        app.launch()

        // Verify the navigation title
        let navigationTitle = app.navigationBars["My Coins"].staticTexts["My Coins"]
        XCTAssertTrue(navigationTitle.exists)
        
        // Verify the balance label
        let balanceLabel = app.staticTexts.matching(identifier: "Balance").firstMatch
        XCTAssertTrue(balanceLabel.exists)
        
        // Wait for the table view to load and verify that it has cells
        let tableView = app.tables.firstMatch
        let expectation = XCTNSPredicateExpectation(predicate: NSPredicate(format: "exists == 1"), object: tableView)
        let result = XCTWaiter.wait(for: [expectation], timeout: 5.0)
        XCTAssertEqual(result, .completed, "Table view did not load in time")
        
        // Add a 5-second delay
        let expectationTime = XCTestExpectation(description: "Wait for 5 seconds")
        let result = XCTWaiter.wait(for: [expectationTime], timeout: 5.0)
        
        if result == .timedOut {
            // Verify that the table view has cells
            let tableView = app.tables["YourTableViewIdentifier"] // replace with your table view identifier
            XCTAssertTrue(tableView.cells.count > 0, "The table view should have cells")
        } else {
            XCTFail("Delay interrupted")
        }
        
        // Verify the first cell
        let firstCell = tableView.cells.element(boundBy: 0)
        XCTAssertTrue(firstCell.exists, "The first cell should exist")
        XCTAssertTrue(firstCell.staticTexts.element.exists, "The first cell should have text")
    }
}
