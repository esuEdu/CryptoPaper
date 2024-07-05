//
//  BinanceAPITests.swift
//
//
//  Created by Eduardo on 05/07/24.
//

import Foundation
import XCTest
@testable import CryptoPaperNetwork

final class BinanceAPITests: XCTestCase {

    func testGetPriceEndpointWithSymbol() {
        let endpoint = BinanceAPI.getPrice(symbol: "BTCUSDT")
        
        XCTAssertEqual(endpoint.host, "api.binance.com")
        XCTAssertEqual(endpoint.scheme, "https")
        XCTAssertEqual(endpoint.path, "/api/v3/ticker/price?symbol=BTCUSDT")
        XCTAssertEqual(endpoint.method, .get)
        XCTAssertNil(endpoint.header)
        XCTAssertNil(endpoint.body)
        XCTAssertNil(endpoint.queryParams)
        XCTAssertNil(endpoint.pathParams)
    }
    
    func testGetPriceEndpointWithoutSymbol() {
        let endpoint = BinanceAPI.getPrice(symbol: nil)
        
        XCTAssertEqual(endpoint.host, "api.binance.com")
        XCTAssertEqual(endpoint.scheme, "https")
        XCTAssertEqual(endpoint.path, "/api/v3/ticker/price")
        XCTAssertEqual(endpoint.method, .get)
        XCTAssertNil(endpoint.header)
        XCTAssertNil(endpoint.body)
        XCTAssertNil(endpoint.queryParams)
        XCTAssertNil(endpoint.pathParams)
    }
}
