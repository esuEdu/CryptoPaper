//
//  Models.swift
//  CryptoPaper
//
//  Created by Samu Lima on 25/06/24.
//

import Foundation
import SwiftData


class Coin: Decodable {
     var symbol: String
     var price: String
}

@Model
class Coins{
    @Attribute var name: String
    @Attribute var amount: Double
    
    init(name: String, amount: Double) {
        self.name = name
        self.amount = amount
    }
}

@Model
class User {
    @Relationship var coins: [Coins]
    
    init(coins: [Coins]) {
        self.coins = coins
    }
}

@Model
class Transactions {
    @Attribute var id: UUID
    @Attribute var date: Date
    @Relationship var coinBought: Coins
    @Relationship var coinSold: Coins
    
    init(id: UUID, date: Date, coinBought: Coins, coinSold: Coins) {
        self.id = id
        self.date = date
        self.coinBought = coinBought
        self.coinSold = coinSold
    }
    
}
