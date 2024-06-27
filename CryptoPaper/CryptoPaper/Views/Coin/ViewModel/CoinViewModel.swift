//
//  CoinViewModel.swift
//  CryptoPaper
//
//  Created by Victor Hugo Pacheco Araujo on 24/06/24.
//

import Combine
import UIKit

class CoinViewModel {
    
    @Published var coins: [CoinWrapper] = []
    @Published var totalBalance: Double = 0.0
    
    private var cancellables = Set<AnyCancellable>()
    private var serviceManager: ServiceManager

    var symbolCoinHave: UIImage = UIImage(systemName: "square.and.arrow.up")!
    var symbolCoinWant: UIImage = UIImage(systemName: "pencil")!
     
    var qtdHave: Double = 0
    var qtdHaveInDollar: Double = 0
    var coinsMenuButton: [String] = ["ETH", "BTC"] // coins that user have in the database
    var coinToBuy: Coin
    
    @Published var coinTextField: Double = 0
    @Published var balanceCoinWant: Double = 0
    
    init(serviceManager: ServiceManager = ServiceManager(), coinsToBuy: Coin) {
        self.serviceManager = serviceManager
        self.coinToBuy = coinsToBuy
    }
    
    func calculateBalanceCoinWant() {
        
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
    
}
