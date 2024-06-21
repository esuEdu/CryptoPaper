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
    let price: String
}

class ServiceManager {
    func fetchCoins(completion: @escaping (Result<[Coin], Error>) -> Void) {
        let urlString = "https://api.binance.com/api/v3/ticker/price"
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data"])))
                return
            }

            do {
                let coins = try JSONDecoder().decode([Coin].self, from: data)
                print(coins)
                completion(.success(coins))
            } catch {
                completion(.failure(error))
            }
        }

        task.resume()
    }
}
