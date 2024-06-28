import XCTest

final class ExtractViewUITests: XCTestCase {
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
    
    func testTableViewHasCells() throws {
        let tableView = app.tables["Extract Table"]
        XCTAssertTrue(tableView.cells.count > 0, "The table view should have at least one cell")
    }

    func testIfUIComponentsHasNilValues() throws {
        
        let extractTableTable = XCUIApplication().tables["Extract Table"]
        
        XCTAssertFalse(extractTableTable.staticTexts[""].exists, "The TableView has some nil values")
    }
    
    func testNoInvalidValues() {
        let extractTableTable = XCUIApplication().tables["Extract Table"]

        // Verifica se não há células com o valor $inf
        XCTAssertFalse(extractTableTable.staticTexts["Price: $"].exists, "The price can not be nil")
        XCTAssertFalse(extractTableTable.staticTexts["Price: $inf"].exists, "The price can not be inf")
        XCTAssertFalse(extractTableTable.staticTexts["Price: $0.0000"].exists, "The price can not be zero")

        
        XCTAssertFalse(extractTableTable.staticTexts["Paid: $"].exists, "The paid can not be nil")
        XCTAssertFalse(extractTableTable.staticTexts["Paid: $inf"].exists, "The paid can not be inf")
        XCTAssertFalse(extractTableTable.staticTexts["Paid: $0.0000"].exists, "The paid can not be zero")
        
    }
}
