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
    
    private let quantInDollar: UILabel = {
        let qtd = UILabel()
        qtd.numberOfLines = 1
        qtd.textAlignment = .right
        qtd.font = .preferredFont(forTextStyle: .footnote)
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
        bindViewModel()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addUI() {
        
        addSubview(coinSymbol)
        addSubview(quantInDollar)
        addSubview(coinLabel)
        addSubview(balanceCoin)
        
        coinSymbol.image = coinViewModel?.symbolCoinWant
        
        coinLabel.text = coinViewModel?.coinToBuy.name
                
    }

    func setConstraints() {
        NSLayoutConstraint.activate([
            coinSymbol.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            coinSymbol.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            coinSymbol.heightAnchor.constraint(equalToConstant: 30),
            coinSymbol.widthAnchor.constraint(equalToConstant: 30),
            
            coinLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            coinLabel.leadingAnchor.constraint(equalTo: coinSymbol.trailingAnchor, constant: 10),
            
            balanceCoin.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            balanceCoin.leadingAnchor.constraint(equalTo: coinLabel.trailingAnchor, constant: 10),
            balanceCoin.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            
            quantInDollar.topAnchor.constraint(equalTo: balanceCoin.bottomAnchor),
            quantInDollar.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            
        ])
    }
    
    private func bindViewModel() {
        coinViewModel?.$balanceCoinWant
            .receive(on: RunLoop.main)
            .sink { [weak self] coinTextField in
                self?.balanceCoin.text = "\(coinTextField)"
//                print("\(coinTextField)")
            }
            .store(in: &cancellables)
        
        coinViewModel?.$qtdHaveInDollarOfCoinWant
            .receive(on: RunLoop.main)
            .sink { [weak self] qtdWant in
                self?.quantInDollar.text = "\(qtdWant)"
            }
            .store(in: &cancellables)
        
    }
    
}
