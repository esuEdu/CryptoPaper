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
