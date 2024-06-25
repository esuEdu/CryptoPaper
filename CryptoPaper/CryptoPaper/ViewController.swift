//
//  ViewController.swift
//  CryptoPaper
//
//  Created by Eduardo on 20/06/24.
//

import UIKit


class ViewController: UIViewController {
    weak var coordinator: MainCoordinator?
    
    // Função que gerencia a API
    private let serviceManager = ServiceManager()
    
    // Array que contém as moedas
    private var coins: [CoinWrapper] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
                
        let button = UIButton(type: .system)
        button.setTitle("Go to Second View", for: .normal)
//        button.addTarget(self, action: #selector(goToSecondView), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }


//    @objc func goToSecondView() {
//        coordinator?.goToSecondView()
//    }
    
    // Função para chamar a API
    private func fetchCoins() {
        serviceManager.fetchCoins { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let coins):
                    self?.coins = coins
                    print("Success fetching coins.")
                case .failure(let error):
                    print("Failed to fetch coins: \(error)")
                }
            }
        }
    }
}


