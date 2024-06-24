//
//  ServiceManagerTests.swift
//  CryptoPaperTests
//
//  Created by Gabriel Eduardo on 21/06/24.
//

import XCTest
@testable import CryptoPaper

// MARK: Mock do URLSession
class MockURLSessionDataTask: URLSessionDataTask {
    override func resume() {
        // Aqui iniciaria a chamada de rede, mas não vai fazer nada.
    }
}

class MockURLSession: URLSession {
    var nextData: Data? // Armazena dados simulados
    var nextError: Error? // Armazena erros

    override func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        completionHandler(nextData, nil, nextError)
        return MockURLSessionDataTask()
    }
}

// MARK: Testes do ServiceManager (API da Binance)
class ServiceManagerTests: XCTestCase {
    private var manager: ServiceManager! // ServiceManager (API)
    private var mockURLSession: MockURLSession! // Mock do URLSession
    
    // Build the objects that we're gonna use
    override func setUpWithError() throws {
        mockURLSession = MockURLSession()
        manager = ServiceManager(session: mockURLSession) // Passando o mock para o ServiceManager
    }
    
    // Destroy the objects that we're not gonna use anymore
    override func tearDownWithError() throws {
        manager = nil
        mockURLSession = nil
    }
    
    func testFetchCoinsSuccess() {
        
        // Dados simulados
        let jsonString = """
        [
            { "symbol": "ETHBTC", "price": "0.05475000" },
            { "symbol": "LTCBTC", "price": "0.00114700" }
        ]
        """
        
        // Passando os dados simulados para o mock
        mockURLSession.nextData = jsonString.data(using: .utf8)
        
        // Testando a função em si
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
        
        // Definindo o erro simulado
        mockURLSession.nextError = NSError(domain: "test", code: -1, userInfo: nil)
        
        // Testando a função em si
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
