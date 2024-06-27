//
//  CoinThatHaveView.swift
//  CryptoPaper
//
//  Created by Victor Hugo Pacheco Araujo on 25/06/24.
//

import UIKit
import Combine

class CoinThatHaveView: UIView, TextFieldComponentDelegate {
   
    weak var coinViewModel: CoinViewModel?
    
    private var cancellables = Set<AnyCancellable>()
    
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
        qtd.font = .preferredFont(forTextStyle: .subheadline)
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
        textField.accessibilityIdentifier = "textFieldCoinThatHave"
        return textField
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
        addSubview(qtdHave)
        addSubview(buttonMenuItems)
        addSubview(qtdTextField)
        
        coinSymbol.image = coinViewModel?.symbolCoinHave
        
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
        qtdTextField.becomeFirstResponder()
        
        qtdTextField.delegate = self
    }
    
    private func createMenuButton() -> UIMenu {
        // Verifica se coinsMenuButton não é nil, caso contrário, usa um array vazio
        
        let menuActions = (coinViewModel?.coinsMenuButton ?? []).map { coin in
            UIAction(title: coin, handler: { (action) in
                // Aqui você pode adicionar o comportamento desejado para cada moeda
                print("\(coin) selecionada")
                self.buttonMenuItems.setTitle(coin, for: .normal)
                self.coinViewModel?.coinSelected?.name = coin
                
            })
        }
        
        // Cria um UIMenu usando os UIActions
        let menuItems = UIMenu(title: "", options: .displayInline, children: menuActions)
        
        return menuItems
    }
    
    private func bindViewModel() {
        coinViewModel?.$coinsMenuButton
            .receive(on: RunLoop.main)
            .sink { [weak self] coinsMenu in
                let _ = coinsMenu.map({ coin in
                    self?.buttonMenuItems.setTitle(coin.uppercased(), for: .normal)
                })
            }
            .store(in: &cancellables)
        
        coinViewModel?.$qtdHave
            .receive(on: RunLoop.main)
            .sink { [weak self] qtd in
                
                for coinQtd in qtd {
                    self?.qtdHave.text = "\(coinQtd)"
                }
                
            }
            .store(in: &cancellables)
        
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            coinSymbol.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            coinSymbol.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 15),
            coinSymbol.heightAnchor.constraint(equalToConstant: 30),
            coinSymbol.widthAnchor.constraint(equalToConstant: 30),
            
            qtdHave.topAnchor.constraint(equalTo: coinSymbol.bottomAnchor, constant: 10),
            qtdHave.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            //qtdHave.widthAnchor.constraint(equalToConstant: 100),
            
            buttonMenuItems.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            buttonMenuItems.leadingAnchor.constraint(equalTo: coinSymbol.trailingAnchor, constant: 10),
            
            qtdTextField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            qtdTextField.leadingAnchor.constraint(equalTo: buttonMenuItems.trailingAnchor, constant: 10),
            qtdTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
        ])
    }
    
    func textFieldDidBeginEditing() {}
    
    func textFieldDidEndEditing() {}
    
    func textFieldDidChangeSelection() {
        
        
        // Verifique se a string da text field contém uma vírgula
        if let text = qtdTextField.textFieldToGetTheName.text {
            if text.contains(",") {
                // Lide com o caso onde a string contém uma vírgula, se necessário
                print("A string contém uma vírgula")
                // Você pode substituir a vírgula por ponto, se for o caso
                let textWithDot = text.replacingOccurrences(of: ",", with: ".")
                if let doubleValue = Double(textWithDot) {
                    coinViewModel?.coinTextField = doubleValue
                    
                } else {
                    // Lide com o caso onde a conversão falha, se necessário
                    coinViewModel?.coinTextField = 25 // Valor padrão ou outra lógica
                    
                }
            } else {
                // Tente converter a string para Double diretamente
                if let doubleValue = Double(text) {
                    
                    coinViewModel?.coinTextField = doubleValue
                } else {
                    // Lide com o caso onde a conversão falha, se necessário
                    coinViewModel?.coinTextField = 45 // Valor padrão ou outra lógica
                }
            }
        } else {
            // Lide com o caso onde a string é nula, se necessário
            coinViewModel?.coinTextField = 3 // Valor padrão ou outra lógica
        }
    }

}
