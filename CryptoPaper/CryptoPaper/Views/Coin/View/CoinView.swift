//
//  CoinView.swift
//  CryptoPaper
//
//  Created by Victor Hugo Pacheco Araujo on 24/06/24.
//

import Foundation
import UIKit

class CoinView: UIViewController {
    
    weak var coordinator: MainCoordinator?
    
    weak var coinViewModel: CoinViewModel?
    
    private let buyButton: UIButton = {
        let button = UIButton()
        button.setTitle("Buy", for: .normal)
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        let coinThatHaveView = CoinThatHaveView(coinViewModel: coinViewModel)
        coinThatHaveView.translatesAutoresizingMaskIntoConstraints = false
        
        guard let viewModel = coinViewModel else {
            return
        }
        
        let coinThatWant = CoinThatWant(coinViewModel: viewModel)
        coinThatWant.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(coinThatHaveView)
        view.addSubview(coinThatWant)
        
        view.addSubview(buyButton)
        buyButton.addTarget(self, action: #selector(createTransaction), for: .touchUpInside)

        NSLayoutConstraint.activate([
            coinThatHaveView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            coinThatHaveView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            coinThatHaveView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            coinThatHaveView.heightAnchor.constraint(equalToConstant: 30),
            
            coinThatWant.topAnchor.constraint(equalTo: coinThatHaveView.bottomAnchor, constant: 70),
            coinThatWant.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            coinThatWant.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            coinThatWant.heightAnchor.constraint(equalToConstant: 30),
            
            buyButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buyButton.topAnchor.constraint(equalTo: coinThatWant.bottomAnchor, constant: 100),
            buyButton.widthAnchor.constraint(equalToConstant: 300),
            buyButton.heightAnchor.constraint(equalToConstant: 50),
        ])
        
    }
    
    @objc func createTransaction() {
        if let coinSelected = coinViewModel?.coinSelected {
            coinViewModel?.createTransaction(coinSelected: coinSelected)
            dismiss(animated: true)
        }
    }
   
}
