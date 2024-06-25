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
    private var coins: [Coin] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // chamando API
//        fetchCoins()
        
        let button = UIButton(type: .system)
        button.setTitle("Go to Second View", for: .normal)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

}


