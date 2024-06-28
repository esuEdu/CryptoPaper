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
    
    private var serviceManager: ServiceManager
    
    var symbolCoinHave: UIImage = UIImage(systemName: "dollarsign")!
    var symbolCoinWant: UIImage = UIImage(systemName: "bitcoinsign")!
    
    @Published var qtdHave: Double = 0.0
    
    @Published var coinsMenuButton: [String] = [] {
        didSet {
            coinSelected = coinsMenuButton.last
        }
    }
    
    var coinToBuy: Coin
    
    @Published var coinTextField: Double = 0 {
        didSet {
            calculateBalanceCoinWant()
        }
    }
    @Published var balanceCoinWant: Double = 0
    @Published var qtdHaveInDollarOfCoinWant: Double = 0
    
    var coinSelected: String? {
        didSet {
            Task {
                await updateQtdHaveOfTheCoin(coinSelected: coinSelected ?? "")
            }
        }
    }
    
    init(serviceManager: ServiceManager = ServiceManager(), coinsToBuy: Coin) {
        self.serviceManager = serviceManager
        self.coinToBuy = coinsToBuy
        
        getDatabase()
    }
    
    private func getDatabase() {
        Task {
            user = await DataController.shared.fetchUsers()
            await updateMenuButtonOptions()
        }
    }
    
    private func updateMenuButtonOptions() async {
        if let coins = self.user?.coins {
            for coin in coins {
                self.coinsMenuButton.append(coin.name)
            }

            // Ordena o array com base na condição que coloca "dolar" sempre no final
            self.coinsMenuButton.sort {
                if $0 == "usd" {
                    return false
                } else if $1 == "usd" {
                    return true
                } else {
                    return $0 < $1
                }
            }
        }

    }
    
    private func updateQtdHaveOfTheCoin(coinSelected: String) async {
        let coin = findCoin(byName: coinSelected, in: user?.coins ?? [])
        qtdHave = coin?.amount ?? 0
    }
    
    private func calculateBalanceCoinWant()  {

        fetchCoins()
        
        if coinSelected == "usd" {
            self.balanceCoinWant = coinTextField / coinToBuy.amount
        } else {
            
            let coinSelectedValue = findCoin(byName: coinSelected ?? "", in: coins)
            
            if let doubleValue = Double(coinSelectedValue?.price ?? "") {
                self.balanceCoinWant = doubleValue * coinTextField / coinToBuy.amount
            }
        }
        
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
        
        let moeda = Coin(name: coinSold.name, amount: coinSold.amount)
        
        moeda.amount = coinTextField
        coinToBuy.amount = balanceCoinWant
        
        Task {
            await DataController.shared.addTransaction(coinBought: coinToBuy, coinSold: moeda)
        }
    }
    
    private func findCoin(byName name: String, in coins: [Coin]) -> Coin? {
        return coins.first { $0.name == name }
    }
    
    private func findCoin(byName symbol: String, in coins: [CoinWrapper]) -> CoinWrapper? {
        return coins.first { $0.symbol == symbol }
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
