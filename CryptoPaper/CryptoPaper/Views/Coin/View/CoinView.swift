//
//  CoinView.swift
//  CryptoPaper
//
//  Created by Victor Hugo Pacheco Araujo on 24/06/24.
//

import Foundation
import UIKit

class CoinView: UIViewController {
    
    weak var coinViewModel: CoinViewModel?
    
    private let buyButton: UIButton = {
        let button = UIButton()
        button.setTitle("Buy", for: .normal)
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    init(coinViewModel: CoinViewModel? = nil) {
        super.init(nibName: nil, bundle: nil)
        self.coinViewModel = coinViewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        let coinThatHaveView = CoinThatHaveView(coinViewModel: coinViewModel)
        coinThatHaveView.translatesAutoresizingMaskIntoConstraints = false
        
        let coinThatWant = CoinThatWant(coinViewModel: coinViewModel)
        coinThatWant.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(coinThatHaveView)
        view.addSubview(coinThatWant)
        
        view.addSubview(buyButton)
    
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
//        tapGesture.cancelsTouchesInView = false
//        view.addGestureRecognizer(tapGesture)

        #warning("tirar o magic number 70")
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
            buyButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            buyButton.widthAnchor.constraint(equalToConstant: 300),
            buyButton.heightAnchor.constraint(equalToConstant: 50),
        ])
        
    }
   
}