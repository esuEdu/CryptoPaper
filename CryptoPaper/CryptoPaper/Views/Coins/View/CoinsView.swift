//
//  CoinsView.swift
//  CryptoPaper
//
//  Created by Eduardo on 20/06/24.
//

import Foundation
import UIKit


class CoinsView: UIViewController {
    
    weak var coordinator: MainCoordinator?
    
    weak var CoinsViewModel: CoinsViewModel?
    
    init(CoinsViewModel: CoinsViewModel? = nil) {
        super.init(nibName: nil, bundle: nil)
        self.CoinsViewModel = CoinsViewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Ir para CoinView", for: .normal)
        button.backgroundColor = .blue
        
        button.addTarget(self, action: #selector(goToCoinView), for: .touchUpInside)
        
        // Create a UILabel
        let helloLabel = UILabel()
        
        // Set the text of the label
        helloLabel.text = "test"
        
        // Set the font and size of the text
        helloLabel.font = UIFont.systemFont(ofSize: 24)
        
        helloLabel.textColor = .red
        
        // Enable auto layout for the label
        helloLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Add the label to the view
        view.addSubview(helloLabel)
        view.addSubview(button)
        
        // Center the label horizontally and vertically in the view
        NSLayoutConstraint.activate([
            helloLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            helloLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            helloLabel.widthAnchor.constraint(equalToConstant: 200),
            
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            button.heightAnchor.constraint(equalToConstant: 30),
            button.widthAnchor.constraint(equalToConstant: 100),
        ])
        
        
    }
    
    @objc func goToCoinView() {
        coordinator?.goToCoinView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
