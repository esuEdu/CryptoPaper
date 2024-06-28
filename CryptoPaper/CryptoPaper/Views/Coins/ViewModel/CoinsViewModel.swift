//
//  CoinsViewModel.swift
//  CryptoPaper
//
//  Created by Eduardo on 20/06/24.
//

import Foundation
import Combine
import SwiftData

class CoinsViewModel {
    @Published var coins: [CoinWrapper] = [] {
        didSet {
            getBalance()
        }
    }
    @Published var totalBalance: Double = 0.0
    
    private var cancellables = Set<AnyCancellable>()
    private let serviceManager: ServiceManager
    
    var user: User?
    
    init(serviceManager: ServiceManager = ServiceManager()) {
        self.serviceManager = serviceManager
        fetchCoins()
        getData()
    }
    

    func getBalance() {
        if let coins = user?.coins {
            for coin in coins {
                if coin.name == "usd" {
                    totalBalance += coin.amount
                }else {
                    let coinFind = findCoin(byName: coin.name, in: self.coins)
                    if let coinFind {
                        totalBalance += (Double(coinFind.price) ?? 0.0) * coin.amount
                    }
                    
                }
            }
        }
    }
    
    func getData() {
        Task {
            user = await DataController.shared.fetchUser()
        }
    }
    

    private func fetchCoins() {
        serviceManager.fetchCoins { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let coins):
                    self?.coins = coins
                case .failure(let error):
                    print("Error fetching coins: \(error)")
                }
            }
        }
    }
    
    private func findCoin(byName name: String, in coins: [Coin]) -> Coin? {
        return coins.first { $0.name == name }
    }
    
    private func findCoin(byName name: String, in coins: [CoinWrapper]) -> CoinWrapper? {
        return coins.first { $0.symbol == name }
    }
}
