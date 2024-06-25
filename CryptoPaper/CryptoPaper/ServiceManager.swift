//
//  ServiceManager.swift
//  CryptoPaper
//
//  Created by Gabriel Eduardo on 20/06/24.
//

import Foundation


class ServiceManager {
    
    private var session: URLSession
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    private func filterCoins(coins: [CoinWrapper], filter: String = "USDT") -> [CoinWrapper] {
        // Se o filtro for vazio, ele retorna sem filtrar
        if filter == "" {
            return coins
        }
        
        // Filtra pelas últimas letras, de acordo com a String de filtro, e então remove do nome essas letras
        return coins.filter { $0.symbol.hasSuffix(filter) }
            .map { CoinWrapper(symbol: String($0.symbol.dropLast(4)), price: $0.price) }
    }
    
    func fetchCoins(completion: @escaping (Result<[CoinWrapper], Error>) -> Void) {
        // Configurando a URL
        let urlString = "https://api.binance.com/api/v3/ticker/price"
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        // Criando a task para chamada da API
        let task = session.dataTask(with: url) { data, response, error in
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
                var coins = try JSONDecoder().decode([CoinWrapper].self, from: data)
                
                // Filtrando
                coins = self.filterCoins(coins: coins)
                
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
