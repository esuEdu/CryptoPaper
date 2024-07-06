//
//  MainCoordinator.swift
//  CryptoPaper
//
//  Created by Eduardo on 20/06/24.
//

import Foundation
import UIKit

final class MainCoordinator: Coordinator {
        
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let view = CoinsListView()
        view.coordinator = self
        
        navigationController.pushViewController(view, animated: true)
    }
    
    func goToCoinView(coin: Coin) {
        let viewModel = CoinViewModel(coinsToBuy: coin)
        let view = CoinView()
        
        view.coinViewModel = viewModel
        view.coordinator = self
        
        navigationController.present(view, animated: true)
    }
    
    func goToExtractView(balance: Double) {
        let view = ExtractView(balance: balance)
        view.coordinator = self
        
        navigationController.pushViewController(view, animated: true)
    }
}
