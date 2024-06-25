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
        let viewModel = CoinsViewModel(coordinator: self)
        let view = CoinsView(CoinsViewModel: viewModel)
        view.coordinator = self
        
        navigationController.pushViewController(view, animated: true)
    }
    
    func goToCoinView() {
        let viewModel = CoinViewModel(coordinator: self)
        let view = CoinView(coinViewModel: viewModel)
        
        navigationController.present(view, animated: true)
    }
    
    
}
