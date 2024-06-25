//
//  ServiceManagerTests.swift
//  CryptoPaperTests
//
//  Created by Gabriel Eduardo on 21/06/24.
//

import XCTest
@testable import CryptoPaper

// MARK: Testes do ServiceManager (API da Binance)
/// Teste sem mock
class ServiceManagerTests: XCTestCase {
    private var manager: ServiceManager! // ServiceManager (API)
    
    // Build the objects that we're gonna use
    override func setUpWithError() throws {
        manager = ServiceManager()
    }
    
    // Destroy the objects that we're not gonna use anymore
    override func tearDownWithError() throws {
        manager = nil
    }
    
    func testAPIRequest() {
    // Essa função testa se a API está dando alguma resposta e se o Service Manager está salvando corretamente os valores vindos do JSON
        manager.fetchCoins { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let coins):
                    XCTAssertGreaterThan(coins.count, 0) // Checa se o array não está vazio
                    /// Checa se as informações das moedas foram salvas corretamente
                    XCTAssertNotNil(coins[0].symbol)
                    XCTAssertNotNil(coins[1].price)
                case .failure(let error):
                    XCTFail("Failed to fetch coins: \(error)")
                }
            }
        }
    }
}

// MARK: Testes do ServiceManager com Mock (API da Binance)
/// Mock do URLSession
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

/// Testes com Mock
class ServiceManagerTestsMock: XCTestCase {
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
    // Essa função testa se o ServiceManager está salvando corretamente os valores vindos do JSON
        
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
    // Essa função testa se o Service Manager detecta erros corretamente
        
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
