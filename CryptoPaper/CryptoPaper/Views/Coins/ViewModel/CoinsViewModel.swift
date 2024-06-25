//
//  CoinsViewModel.swift
//  CryptoPaper
//
//  Created by Eduardo on 20/06/24.
//

import Foundation
import Combine

class CoinsViewModel {
    @Published var coins: [Coin] = []
    @Published var totalBalance: Double = 0.0
    
    private var cancellables = Set<AnyCancellable>()
    private let serviceManager: ServiceManager
    
    init(serviceManager: ServiceManager = ServiceManager()) {
        self.serviceManager = serviceManager
        fetchCoins()
    }
    
    private func fetchCoins() {
        serviceManager.fetchCoins { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let coins):
                    self?.coins = coins
                case .failure(let error):
                    print("Error fetching coins: \(error)")
                }
            }
        }
    }
    
}
