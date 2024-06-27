//
//  SwiftDataTest.swift
//  CryptoPaperTests
//
//  Created by Eduardo on 26/06/24.
//

import XCTest
@testable import CryptoPaper

final class SwiftDataTest: XCTestCase {
    
    var dataController: DataController!
    
    @MainActor
    override func setUp() {
        super.setUp()
        
        // Initialize the DataController with a mock container if needed
        dataController = DataController(container: .testContainer)
    }
    
    override func tearDown() {
        // Deinitialize your objects
        dataController = nil
        super.tearDown()
    }
    
    @MainActor
    func testFetchUsers() {
        // Ensure mockData is called and data is fetched correctly
        let user = dataController.fetchUser()
        XCTAssertNotNil(user, "User should not be nil")
        XCTAssertEqual(user.coins.first?.name, "usd", "First coin's name should be 'usd'")
        XCTAssertEqual(user.coins.first?.amount, 100000, "First coin's amount should be 100000")
    }
    
    @MainActor
    func testTransaction() {
        let bought = Coin(name: "eth", amount: 2.00)
        let sold = Coin(name: "usd", amount: 2000.00)

        dataController.addTransaction(coinBought: bought, coinSold: sold)
                
        let user = dataController.fetchUser()
        let boughtCoin = user.coins.first { $0.name == "eth" }
        let soldCoin = user.coins.first { $0.name == "usd" }
        
        // Check the bought coin
        XCTAssertNotNil(boughtCoin, "Bought coin should be added")
        XCTAssertEqual(boughtCoin?.name, "eth", "Bought coin name should be 'eth'")
        XCTAssertEqual(boughtCoin?.amount, 2.0, "Bought coin amount should be 2.0")
        
        // Check the sold coin
        XCTAssertNotNil(soldCoin, "Sold coin should exist")
        XCTAssertEqual(soldCoin?.name, "usd", "Sold coin name should be 'usd'")
        XCTAssertEqual(soldCoin?.amount, 98000.0, "Sold coin amount should be 98000.0") // Assuming initial 100000 - 2000 = 98000
        
        // Check the transaction
        let transaction = user.transactions?.first
        XCTAssertNotNil(transaction, "Transaction should be added")
        XCTAssertEqual(transaction?.coinBought.name, "eth", "Transaction bought coin name should be 'eth'")
        XCTAssertEqual(transaction?.coinBought.amount, 2.0, "Transaction bought coin amount should be 2.0")
        XCTAssertEqual(transaction?.coinSold.name, "usd", "Transaction sold coin name should be 'usd'")
        XCTAssertEqual(transaction?.coinSold.amount, 2000.0, "Transaction sold coin amount should be 2000.0")
        
    }
    
}
