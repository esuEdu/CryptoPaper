//
//  CoinViewModel.swift
//  CryptoPaper
//
//  Created by Victor Hugo Pacheco Araujo on 24/06/24.
//

import Foundation
import UIKit

class CoinViewModel {
    
    weak var coordinator: MainCoordinator?
    
    var symbolCoinHave: UIImage = UIImage(systemName: "square.and.arrow.up")!
    var symbolCoinWant: UIImage = UIImage(systemName: "pencil")!
    
    var qtdHave: Double = 0
    var coinsMenuButton: [String] = ["ETH", "BTC"]
    var coinToBuy: String = "ETH"
    
    init(coordinator: MainCoordinator? = nil, symbolCoinHave: UIImage = UIImage(systemName: "square.and.arrow.up")!, symbolCoinWant: UIImage = UIImage(systemName: "pencil")!, qtdHave: Double = 0, coinsMenu: [String] = ["ETH", "BTC"], coinsToBuy: String = "ETH") {
        self.coordinator = coordinator
        self.symbolCoinHave = symbolCoinHave
        self.symbolCoinWant = symbolCoinWant
        self.qtdHave = qtdHave
        self.coinsMenuButton = coinsMenu
        self.coinToBuy = coinsToBuy
    }
    
}

