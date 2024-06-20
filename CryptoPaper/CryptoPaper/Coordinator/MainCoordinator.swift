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
        let view = ViewController()
        view.coordinator = self
        navigationController.pushViewController(view, animated: true)
    }
    
    func goToSecondView() {
        let view = CoinsView()
        navigationController.pushViewController(view, animated: true)
    }
}
