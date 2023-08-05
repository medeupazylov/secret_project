//
//  DefaultTextField.swift
//  Muslink
//
//  Created by Аброрбек on 05.08.2023.
//

import UIKit

final class DefaultTextField: UIView {
    
    // MARK: - Properties
    
    @IBInspectable var keyboardType: UIKeyboardType = .default {
        didSet {
            textField.keyboardType = keyboardType
        }
    }
    
    var text: String {
        return textField.text ?? ""
    }
    
    //MARK: - Lifecycle
    
    init(placeHolder: String, delegate: UITextFieldDelegate){
        super.init(frame: .zero)
        textField.delegate = delegate
        textField.attributedPlaceholder = NSAttributedString(
            string: placeHolder,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]
        )
        
        setupTextField()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    private func setupTextField() {
        self.layer.cornerRadius = 8
        self.backgroundColor = Color.neutral16.color
        
        addSubviews()
        setupLayout()
    }
    
    private func addSubviews(){
        self.addSubview(textField)
    }
    
    private func setupLayout(){
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 44),
            textField.topAnchor.constraint(equalTo: self.topAnchor, constant: 12),
            textField.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -12),
            textField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12),
            textField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12)
        ])
    }
    
    //MARK: - UIElements
    
    private let textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false

        textField.font = UIFont.systemFont(ofSize: 16)
        textField.keyboardType = .default
        textField.textAlignment = .left
        textField.textColor = Color.neutral100.color
        
        return textField
    }()
}

