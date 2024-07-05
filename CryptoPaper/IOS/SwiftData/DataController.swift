//
//  DataController.swift
//  CryptoPaper
//
//  Created by Samu Lima on 25/06/24.
//

import Foundation
import SwiftData

@MainActor
class DataController {
    static let shared = DataController()
    
    let container: ModelContainer

    
    init(container: ModelContainer = .appContainer) {
        defer { mockData() }
        self.container = container
        
    }
    
    private func mockData() {
        do {
            // Make sure the persistent store is empty. If it's not, return the non-empty container.
            var itemFetchDescriptor = FetchDescriptor<User>()
            itemFetchDescriptor.fetchLimit = 1
            guard try container.mainContext.fetch(itemFetchDescriptor).count == 0 else { return }
            
            // This code will only run if the persistent store is empty.
            let user = User(coins: [Coin(name: "usd", amount: 100000)])
            
            container.mainContext.insert(user)
        } catch {
            fatalError("Fetch failed: \(error)")
        }
    }
    
    func fetchUser() -> User {
        do {
            let descriptor = FetchDescriptor<User>()
            if let fetchedModel = try container.mainContext.fetch(descriptor).first {
                return fetchedModel
            } else {
                fatalError("No data fetched")
            }
        } catch {
            fatalError("Fetch failed: \(error)")
        }
    }
    
    
    func addTransaction(id: UUID = UUID(), date: Date = Date.now, coinBought: Coin, coinSold: Coin) {
        let newTransaction = Transactions(id: id, date: date, coinBought: coinBought, coinSold: coinSold)
        
        let user = fetchUser()
        
        if let coin = findCoin(byName: coinBought.name, in: user.coins) {
            updateCoin(coin: coin.name, Amount: coin.amount + coinBought.amount)
        }else {
            addCoin(name: coinBought.name, amount: coinBought.amount)
        }
        
        if let coin = findCoin(byName: coinSold.name, in: user.coins) {
            updateCoin(coin: coin.name, Amount: coin.amount - coinSold.amount)
        }
        
        user.transactions?.append(newTransaction)
        try? container.mainContext.save()
    }
    
    // Create data
    func addCoin(name: String, amount: Double) {
        let newCoin = Coin(name: name, amount: amount)
        
        let user = fetchUser()
        
        user.coins.append(newCoin)
        
        try? container.mainContext.save()
    }

    
    // Update data
    private func updateCoin(coin: String, Amount: Double) {
        let user = fetchUser()
        
        let coin = findCoin(byName: coin, in: user.coins)
        
        coin?.amount = Amount
        try? container.mainContext.save()
    }
    
    private func findCoin(byName name: String, in coins: [Coin]) -> Coin? {
        return coins.first { $0.name == name }
    }
    
}
