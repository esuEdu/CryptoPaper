//
//  Models.swift
//  CryptoPaper
//
//  Created by Samu Lima on 25/06/24.
//

import Foundation
import SwiftData


struct CoinWrapper: Codable {
     var symbol: String
     var price: String
}

@Model
class Coin {
    @Attribute var name: String
    @Attribute var amount: Double
    
    init(name: String, amount: Double) {
        self.name = name
        self.amount = amount
    }
}

@Model
class User {
    @Relationship var coins: [Coin]
    @Relationship var transactions: [Transactions]?
    init(coins: [Coin], transactions: [Transactions]? = nil) {
        self.coins = coins
        self.transactions = transactions
    }
}

@Model
class Transactions {
    @Attribute var id: UUID
    @Attribute var date: Date
    @Relationship var coinBought: Coin
    @Relationship var coinSold: Coin
    
    init(id: UUID, date: Date, coinBought: Coin, coinSold: Coin) {
        self.id = id
        self.date = date
        self.coinBought = coinBought
        self.coinSold = coinSold
    }
}
