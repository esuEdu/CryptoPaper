//
//  CoinTableViewCell.swift
//  CryptoPaper
//
//  Created by Eduardo on 28/06/24.
//

import Foundation
import UIKit

class CoinTableViewCell: UITableViewCell {
    
    let symbolLabel = UILabel()
    let priceLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        symbolLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(symbolLabel)
        contentView.addSubview(priceLabel)
        
        NSLayoutConstraint.activate([
            symbolLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            symbolLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            priceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            priceLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with coin: CoinWrapper) {
        symbolLabel.text = coin.symbol
        priceLabel.text = coin.price
    }
}
