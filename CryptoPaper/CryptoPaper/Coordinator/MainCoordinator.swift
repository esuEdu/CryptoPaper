//
//  MainCoordinator.swift
//  CryptoPaper
//
//  Created by Eduardo on 20/06/24.
//

import Foundation
import UIKit
import SwiftData

final class MainCoordinator: Coordinator {
        
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let view = CoinView()
        view.coordinator = self
        
        navigationController.pushViewController(view, animated: true)
    }
    
    func goToCoinView() {
        let view = CoinView()
        view.coordinator = self
        
        navigationController.present(view, animated: true)
    }
    
    func goToExtractView(){
        let view = ExtractView()
        view.coordinator = self
        
        navigationController.pushViewController(view, animated: true)
    }
}
