//
//  CoinThatHaveView.swift
//  CryptoPaper
//
//  Created by Victor Hugo Pacheco Araujo on 25/06/24.
//

import UIKit

class CoinThatHaveView: UIView {
    weak var coinViewModel: CoinViewModel?
    
    private let coinSymbol: UIImageView = {
        let symbol = UIImageView()
        symbol.contentMode = .scaleAspectFit
        symbol.accessibilityIdentifier = "coinViewCoinSymbol"
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
    
    private let buttonMenuItems: UIButton = {
        let button = UIButton()
        button.setTitleColor(.blue, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let qtdTextField: TextFieldComponent = {
        let textField = TextFieldComponent()
        textField.textFieldToGetTheName.placeholder = "0.00"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = UIColor(.primary)
        textField.textFieldToGetTheName.borderStyle = .roundedRect
        return textField
    }()
    
    init(coinViewModel: CoinViewModel? = nil) {
        
        super.init(frame: .zero)
        
        self.coinViewModel = coinViewModel
        
        addUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addUI() {
        
        addSubview(coinSymbol)
        addSubview(qtdHave)
        addSubview(buttonMenuItems)
        addSubview(qtdTextField)
        
        coinSymbol.image = coinViewModel?.symbolCoinHave
        
        if let quantitite = coinViewModel?.qtdHave {
            qtdHave.text = "\(quantitite)"
        } else {
            qtdHave.text = "Valor não disponível"
        }
        
        (coinViewModel?.coinsMenuButton ?? []).map { coin in
            buttonMenuItems.setTitle(coin, for: .normal)
        }
        
        buttonMenuItems.addAction(UIAction(title: "", handler: { action in
            print("action")
        }), for: .touchUpInside)
        
        buttonMenuItems.showsMenuAsPrimaryAction = true
        buttonMenuItems.menu = createMenuButton()
        
        qtdTextField.textFieldToGetTheName.returnKeyType = .done
        qtdTextField.textFieldToGetTheName.autocapitalizationType = .none
        qtdTextField.textFieldToGetTheName.autocorrectionType = .no
        qtdTextField.textFieldToGetTheName.keyboardAppearance = .default
        qtdTextField.textFieldToGetTheName.keyboardType = .decimalPad
        
    }
    
    func createMenuButton() -> UIMenu {
        // Verifica se coinsMenuButton não é nil, caso contrário, usa um array vazio
        let menuActions = (coinViewModel?.coinsMenuButton ?? []).map { coin in
            UIAction(title: coin, handler: { (action) in
                // Aqui você pode adicionar o comportamento desejado para cada moeda
                print("\(coin) selecionada")
                self.buttonMenuItems.setTitle(coin, for: .normal)
                
            })
        }
        
        // Cria um UIMenu usando os UIActions
        let menuItems = UIMenu(title: "Coins", options: .displayInline, children: menuActions)
        
        return menuItems
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            coinSymbol.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            coinSymbol.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 15),
            coinSymbol.heightAnchor.constraint(equalToConstant: 30),
            coinSymbol.widthAnchor.constraint(equalToConstant: 30),
            
            qtdHave.topAnchor.constraint(equalTo: coinSymbol.bottomAnchor),
            qtdHave.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            qtdHave.widthAnchor.constraint(equalToConstant: 50),
            
            buttonMenuItems.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            buttonMenuItems.leadingAnchor.constraint(equalTo: coinSymbol.trailingAnchor, constant: 10),
            
            qtdTextField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            qtdTextField.leadingAnchor.constraint(equalTo: buttonMenuItems.trailingAnchor, constant: 10),
            qtdTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
        ])
    }
    
}
