//
//  CoinsViewModel.swift
//  CryptoPaper
//
//  Created by Eduardo on 20/06/24.
//

import Foundation

class CoinsViewModel {
    weak var coordinator: MainCoordinator?
    
    init(coordinator: MainCoordinator? = nil) {
        self.coordinator = coordinator
    }
    
    func goToCoinView() {
        coordinator?.goToCoinView()
    }
    
}
