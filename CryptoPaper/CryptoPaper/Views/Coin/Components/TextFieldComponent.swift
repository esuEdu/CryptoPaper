//
//  File.swift
//  DailyTask
//
//  Created by Leonardo Mesquita Alves on 25/09/23.
//

import UIKit

/// Protocol to configurate the changes of the `TextFieldComponent` when the editing of start or end
protocol TextFieldComponentDelegate: AnyObject {
    func textFieldDidEndEditing()
    func textFieldDidBeginEditing()
}

class TextFieldComponent: UIView {
    
    weak var delegate: TextFieldComponentDelegate?
    
    let textFieldToGetTheName: UITextField = {
        let textField = UITextField()
        textField.font = .systemFont(ofSize: 16)
        textField.textColor = .label
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
        addAllConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// If you want do get the updated text of the `textFieldComponent` you can use this function
    func getText() -> String{
        return textFieldToGetTheName.text ?? ""
    }
    
    private func setUpUI(){
        self.textFieldToGetTheName.delegate = self
        backgroundColor = UIColor(.gray)
        layer.cornerRadius = 10
        addSubview(textFieldToGetTheName)
    }
    
    private func addAllConstraints(){
        NSLayoutConstraint.activate([
            textFieldToGetTheName.leadingAnchor.constraint(equalTo: leadingAnchor),
            textFieldToGetTheName.trailingAnchor.constraint(equalTo: trailingAnchor),
            textFieldToGetTheName.topAnchor.constraint(equalTo: topAnchor),
            textFieldToGetTheName.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
}

extension TextFieldComponent: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxCharactor = 30
        
        let currentString :NSString = (textField.text ?? "") as NSString
        
        let newString: NSString = currentString.replacingCharacters (in: range, with: string) as NSString
        
        return newString.length <= maxCharactor
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        delegate?.textFieldDidEndEditing()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        delegate?.textFieldDidBeginEditing()
    }
}
