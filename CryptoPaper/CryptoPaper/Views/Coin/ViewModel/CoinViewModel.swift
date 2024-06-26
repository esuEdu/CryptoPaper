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
    private let serviceManager: ServiceManager

    var symbolCoinHave: UIImage = UIImage(systemName: "square.and.arrow.up")!
    var symbolCoinWant: UIImage = UIImage(systemName: "pencil")!
    
    var qtdHave: Double = 0
    var qtdHaveInDollar: Double = 0
    var coinsMenuButton: [String] = ["ETH", "BTC"] // coins that user have in the database
    var coinToBuy: String = "ETH"
    
    @Published var coinTextField: Double = 0
    @Published var balanceCoinWant: Double = 0
    
//    init(symbolCoinHave: UIImage = UIImage(systemName: "square.and.arrow.up")!, symbolCoinWant: UIImage = UIImage(systemName: "pencil")!, qtdHave: Double = 0, coinsMenu: [String] = ["ETH", "BTC"], coinsToBuy: String = "ETH") {
//        self.symbolCoinHave = symbolCoinHave
//        self.symbolCoinWant = symbolCoinWant
//        self.qtdHave = qtdHave
//        self.coinsMenuButton = coinsMenu
//        self.coinToBuy = coinsToBuy
//    }
    
    
    init(serviceManager: ServiceManager = ServiceManager()) {
        self.serviceManager = serviceManager
        fetchCoins()
    }
    
    // when the use create a transaction it pass to get that coin
    
    
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
