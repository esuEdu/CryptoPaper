//
//  ServiceManager.swift
//  CryptoPaper
//
//  Created by Gabriel Eduardo on 20/06/24.
//

import Foundation

// Model da moeda
struct Coin: Codable {
    let symbol: String
    let price: String
}

class ServiceManager {
    private var session: URLSession
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    
    
    func fetchCoins(completion: @escaping (Result<[Coin], Error>) -> Void) {
        // Configurando a URL
        let urlString = "https://api.binance.com/api/v3/ticker/price"
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        // Criando a task para chamada da API
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            // Salvando os dados. Se não der certo, ele retorna um erro.
            guard let data = data else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data"])))
                return
            }
            
            // Decodificando os dados. Se não der certo, ele retorna um erro.
            do {
                // Array de moedas
                let coins = try JSONDecoder().decode([Coin].self, from: data)
                
                // Printando as moedas para garantir
                for coin in coins {
                    print(coin)
                }
                
                completion(.success(coins))
                
            } catch {
                completion(.failure(error))
            }
        }
        
        // Inicia a task para chamar a API.
        task.resume()
    }
}
