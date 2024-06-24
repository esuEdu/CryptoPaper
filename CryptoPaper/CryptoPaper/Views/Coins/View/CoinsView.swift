//
//  CoinsView.swift
//  CryptoPaper
//
//  Created by Eduardo on 20/06/24.
//

import Foundation
import UIKit


class CoinsView: UIViewController {
    
    weak var CoinsViewModel: CoinsViewModel?
    
    init(CoinsViewModel: CoinsViewModel? = nil) {
        super.init(nibName: nil, bundle: nil)
        self.CoinsViewModel = CoinsViewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        
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
        
        // Center the label horizontally and vertically in the view
        NSLayoutConstraint.activate([
            helloLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            helloLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
