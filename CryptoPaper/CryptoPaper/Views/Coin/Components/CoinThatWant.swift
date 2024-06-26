//
//  CoinThatHaveView.swift
//  CryptoPaper
//
//  Created by Victor Hugo Pacheco Araujo on 25/06/24.
//

import UIKit
import Combine

class CoinThatWant: UIView {
    weak var coinViewModel: CoinViewModel?
    
    private var cancellables = Set<AnyCancellable>()
    
    private let coinSymbol: UIImageView = {
        let symbol = UIImageView()
        symbol.contentMode = .scaleAspectFit
        symbol.accessibilityIdentifier = "coinViewCoinSymbolImage"
        symbol.translatesAutoresizingMaskIntoConstraints = false
        return symbol
    }()
    
    private let qtdHave: UILabel = {
        let qtd = UILabel()
        qtd.numberOfLines = 1
        qtd.textAlignment = .left
        qtd.font = .preferredFont(forTextStyle: .headline)
        qtd.adjustsFontSizeToFitWidth = true
        qtd.translatesAutoresizingMaskIntoConstraints = false
        return qtd
    }()
    
    private let coinLabel: UILabel = {
        let coinLabel = UILabel()
        coinLabel.font = .preferredFont(forTextStyle: .title3)
        coinLabel.textAlignment = .left
        coinLabel.translatesAutoresizingMaskIntoConstraints = false
        return coinLabel
    }()
    
    let balanceCoin: UILabel = {
        let balance = UILabel()
        balance.font = .preferredFont(forTextStyle: .title2)
        balance.textAlignment = .right
        balance.translatesAutoresizingMaskIntoConstraints = false
        return balance
    }()
    
    init(coinViewModel: CoinViewModel? = nil) {
        
        super.init(frame: .zero)
        
        self.coinViewModel = coinViewModel
        
        addUI()
        setConstraints()
        bindViewModel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addUI() {
        
        addSubview(coinSymbol)
        addSubview(qtdHave)
        addSubview(coinLabel)
        addSubview(balanceCoin)
        
        coinSymbol.image = coinViewModel?.symbolCoinWant
        
        if let quantitite = coinViewModel?.qtdHave {
            qtdHave.text = "\(quantitite)"
        } else {
            qtdHave.text = "Valor não disponível"
        }
        
        coinLabel.text = coinViewModel?.coinToBuy.name
        
    }

    func setConstraints() {
        NSLayoutConstraint.activate([
            coinSymbol.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            coinSymbol.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            coinSymbol.heightAnchor.constraint(equalToConstant: 30),
            coinSymbol.widthAnchor.constraint(equalToConstant: 30),
            
            qtdHave.topAnchor.constraint(equalTo: coinSymbol.bottomAnchor),
            qtdHave.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            qtdHave.widthAnchor.constraint(equalToConstant: 50),
            
            coinLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            coinLabel.leadingAnchor.constraint(equalTo: coinSymbol.trailingAnchor, constant: 10),
            
            balanceCoin.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            balanceCoin.leadingAnchor.constraint(equalTo: coinLabel.trailingAnchor, constant: 10),
            balanceCoin.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
        ])
    }
    
    private func bindViewModel() {
        coinViewModel?.$coinTextField
            .receive(on: RunLoop.main)
            .sink { [weak self] coinTextField in
                self?.balanceCoin.text = "\(coinTextField)"
            }
            .store(in: &cancellables)
    }
    
}
