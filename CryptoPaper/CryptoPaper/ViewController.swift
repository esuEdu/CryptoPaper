//
//  ViewController.swift
//  CryptoPaper
//
//  Created by Eduardo on 20/06/24.
//

import UIKit


class ViewController: UIViewController {
    weak var coordinator: MainCoordinator?
    
    private let serviceManager = ServiceManager()
    
    private var coins: [Coin] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        fetchCoins()
        
        let button = UIButton(type: .system)
        button.setTitle("Go to Second View", for: .normal)
        button.addTarget(self, action: #selector(goToSecondView), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    @objc func goToSecondView() {
        coordinator?.goToSecondView()
    }
    
    private func fetchCoins() {
        serviceManager.fetchCoins { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let coins):
                    self?.coins = coins
                    print(coins)
                case .failure(let error):
                    print("Failed to fetch coins: \(error)")
                }
            }
        }
    }
}


