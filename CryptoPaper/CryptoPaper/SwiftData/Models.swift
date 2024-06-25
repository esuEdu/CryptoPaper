//
//  Models.swift
//  CryptoPaper
//
//  Created by Samu Lima on 25/06/24.
//

import Foundation

// Model da moeda, que mexe direto com a API
struct Coin: Codable {
    let symbol: String
    let price: String
}

struct Coins {
    let name: String
    let amount: Double
}

struct Users {
    let coins: Coins
}

struct Transactions {
    let id: UUID
    let date: Date
    let coinBought: Coins
    let coinSold: Coins
}
