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
    
    var user: User?
    
//    private var cancellables = Set<AnyCancellable>()
    private var serviceManager: ServiceManager
    
    var symbolCoinHave: UIImage = UIImage(systemName: "dollarsign")!
    var symbolCoinWant: UIImage = UIImage(systemName: "bitcoinsign")!
    
    @Published var qtdHave: [Double] = []
    @Published var coinsMenuButton: [String] = [] // coins that user have in the database
    var coinToBuy: Coin
    
    @Published var coinTextField: Double = 0 {
        didSet {
            calculateBalanceCoinWant()
        }
    }
    @Published var balanceCoinWant: Double = 0
    @Published var qtdHaveInDollarOfCoinWant: Double = 0
    
    var coinSelected: String?
    
    init(serviceManager: ServiceManager = ServiceManager(), coinsToBuy: Coin) {
        self.serviceManager = serviceManager
        self.coinToBuy = coinsToBuy
        
        getDatabase()
    }
    
    private func getDatabase() {
        Task {
            user = await DataController.shared.fetchUsers()
            await updateMenuButtonOptions()
            await updateQtdHaveOfTheCoin()
        }
    }
    
    private func updateMenuButtonOptions() async {
        if let coins = self.user?.coins {
            dump(coins)
            for coin in coins {
                self.coinsMenuButton.append(coin.name)
                
            }
        }
    }
    
    private func updateQtdHaveOfTheCoin() async {
        if let coins = self.user?.coins {
            for coin in coins {
                self.qtdHave.append(coin.amount)
            }
        }
    }
    
    private func calculateBalanceCoinWant()  {
        self.balanceCoinWant = coinTextField / coinToBuy.amount
        calculateQtdInDollarOfCoinThatWant()
    }
    
    private func calculateQtdInDollarOfCoinThatWant() {
        self.qtdHaveInDollarOfCoinWant = balanceCoinWant * coinToBuy.amount
    }
    
    func createTransaction(coinSelected: String) {
        
        guard let coins = user?.coins else {
            return
        }
        
        guard let coinSold = findCoin(byName: coinSelected, in: coins) else {
            return
        }
        
        Task {
            await DataController.shared.addTransaction(coinBought: coinToBuy, coinSold: coinSold)
        }
    }
    
    private func findCoin(byName name: String, in coins: [Coin]) -> Coin? {
        return coins.first { $0.name == name }
    }
}
