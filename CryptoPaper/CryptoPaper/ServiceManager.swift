//
//  ServiceManager.swift
//  CryptoPaper
//
//  Created by Gabriel Eduardo on 20/06/24.
//

import Foundation

protocol NetworkingService {
    func fetchData(url: URL, completion: @escaping (Data?, Error?) -> Void)
}

class ServiceManager: NetworkingService {
    func fetchData(url: URL, completion: @escaping (Data?, (any Error)?) -> Void) {
        // Código
    }
}

// Mock
class MockNetworkingService: NetworkingService {
    func fetchData(url: URL, completion: @escaping (Data?, Error?) -> Void) {
        
        // Mock the data and response here (e.g., create a sample JSON response)
        let jsonString = """
            {
                "symbol": "ETHBTC",
                "price": "0.05475000"
            }
        """
        
        // Success
        if let data = jsonString.data(using: .utf8) {
            completion(data, nil)
        
        // Error
        } else {
            let error = NSError(domain: "MockNetworkingServiceErrorDomain", code: -1, userInfo: nil)
            completion(nil, error)
        }
    }
}
