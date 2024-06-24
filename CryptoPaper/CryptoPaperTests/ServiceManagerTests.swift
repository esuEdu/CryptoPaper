//
//  ServiceManagerTests.swift
//  CryptoPaperTests
//
//  Created by Gabriel Eduardo on 21/06/24.
//

import XCTest
@testable import CryptoPaper

class MockURLSessionDataTask: URLSessionDataTask {
    override func resume() {
        // Não faz nada
    }
}

class MockURLSession: URLSession {
    var nextData: Data?
    var nextError: Error?

    override func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        completionHandler(nextData, nil, nextError)
        return MockURLSessionDataTask()
    }
}

class ServiceManagerTests: XCTestCase {
    private var manager: ServiceManager!
    private var mockURLSession: MockURLSession!
    
    // Build the objects that we're gonna use
    override func setUpWithError() throws {
        mockURLSession = MockURLSession()
        manager = ServiceManager(session: mockURLSession)
    }
    
    // Destroy the objects that we're not gonna use anymore
    override func tearDownWithError() throws {
        manager = nil
    }
    
    func testFetchCoinsSuccess() {
            let jsonString = """
            [
                { "symbol": "ETHBTC", "price": "0.05475000" },
                { "symbol": "LTCBTC", "price": "0.00114700" }
            ]
            """
            mockURLSession.nextData = jsonString.data(using: .utf8)
            manager.fetchCoins { result in
                switch result {
                case .success(let coins):
                    XCTAssertEqual(coins.count, 2)
                    XCTAssertEqual(coins[0].symbol, "ETHBTC")
                    XCTAssertEqual(coins[0].price, "0.05475000")
                    XCTAssertEqual(coins[1].symbol, "LTCBTC")
                    XCTAssertEqual(coins[1].price, "0.00114700")
                case .failure(let error):
                    XCTFail("Expected success, got \(error) instead")
                }
            }
        }

        func testFetchCoinsFailure() {
            mockURLSession.nextError = NSError(domain: "test", code: -1, userInfo: nil)
            manager.fetchCoins { result in
                switch result {
                case .success:
                    XCTFail("Expected failure, got success instead")
                case .failure:
                    // O teste passa, pois esperamos uma falha
                    XCTAssert(true)
                }
            }
        }
}
