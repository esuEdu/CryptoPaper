//
//  ServiceManager.swift
//  CryptoPaper
//
//  Created by Gabriel Eduardo on 20/06/24.
//

import Foundation

struct WrapperCoins: Codable {
    let items: [Coin]
}

struct Coin: Codable {
    let symbol: String
    let price: Double
}

protocol NetworkingService {
    func fetchData(url: URL, completion: @escaping (Data?, Error?) -> Void)
}

class ServiceManager: NetworkingService {
    func fetchData(url: URL, completion: @escaping (Data?, (any Error)?) -> Void) {
        
    }
}
