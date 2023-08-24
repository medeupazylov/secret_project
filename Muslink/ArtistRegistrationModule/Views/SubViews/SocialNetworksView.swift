//
//  SocialNetworks.swift
//  Muslink
//
//  Created by Arystan on 05.08.2023.
//

import Foundation
import UIKit

final class SocialNetworksView: UIStackView {
    
    private var helperText: String
    private var placeholder: String
    
    init(iconIMG: UIImage, placeholder: String, helperText: String,delegate: UITextFieldDelegate) {
        self.helperText = helperText
        self.placeholder = placeholder
        super.init(frame: .zero)
        
        textField.delegate = delegate
        icon.image = iconIMG
        setupView()
        setupSubviews()
        setupLayout()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateView() {
        if (textField.isEditing) {
            textField.attributedPlaceholder = NSAttributedString(string: helperText, attributes: [
                NSAttributedString.Key.foregroundColor : Color.neutral32.color
            ])
            removeButton.isHidden = false
            container.layer.borderColor = Color.infoBorder.color.cgColor
            UIView.animate(withDuration: 0.3) {
                self.notFoundLabel.isHidden = false
            }
            
        } else {
            textField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [
                NSAttributedString.Key.foregroundColor : Color.neutral72.color
            ])
            removeButton.isHidden = true
            container.layer.borderColor = Color.neutral16.color.cgColor
            UIView.animate(withDuration: 0.3) {
                self.notFoundLabel.isHidden = true
            }
        }
    }
    
    func setupView() {
        self.axis = .vertical
        self.spacing = 8.0
        self.distribution = .fillProportionally
        self.addArrangedSubview(container)
        self.addArrangedSubview(notFoundLabel)
        removeButton.addTarget(self, action: #selector(removeButtonAction), for: .touchUpInside)
    }
    
    @objc func removeButtonAction(_ sender: UIControl?) {
        textField.text = ""
    }
    
    let container: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.backgroundColor = Color.neutral16.color
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderWidth = 1.0
        view.layer.borderColor = Color.neutral16.color.cgColor
        return view
    } ()
    
    private let notFoundLabel: UILabel = {
        let label = UILabel()
        label.text = "Страница не найдена"
        label.textColor = Color.dangerMain.color
        label.font = UIFont.systemFont(ofSize: 13)
        label.isHidden = true
        label.isOpaque = true
        return label
    } ()
    
    
    
    func setupSubviews() {
        textField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: placeholderAttributes)
        container.addSubview(stackView)
        stackView.addArrangedSubview(icon)
        stackView.addArrangedSubview(textField)
        stackView.addArrangedSubview(removeButton)
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            container.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            container.rightAnchor.constraint(equalTo: self.rightAnchor),
            container.topAnchor.constraint(equalTo: self.topAnchor),
            container.heightAnchor.constraint(equalToConstant: 44),
            
            notFoundLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            
            stackView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -12),
            stackView.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            
            icon.heightAnchor.constraint(equalToConstant: 24.0),
            icon.widthAnchor.constraint(equalToConstant: 24.0)
        ])
    }
    
    private let icon: UIImageView = {
        let imgv = UIImageView()
        imgv.translatesAutoresizingMaskIntoConstraints = false
        return imgv
    }()
    
    let textField: UITextField = {
        let text = UITextField()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.textColor = Color.neutral72.color
        text.tintColor = Color.neutral72.color
        text.font = UIFont.systemFont(ofSize: 16.0, weight: .regular)
        return text
    } ()
    
    private let removeButton: UIButton = {
        let button  = UIButton()
        button.setImage(Image.close.image, for: .normal)
        button.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        button.imageView?.tintColor = Color.neutral72.color
        button.isHidden = true
        return button
    }()
    
    private let placeholderAttributes: [NSAttributedString.Key: Any] = [
        .foregroundColor: Color.neutral72.color,
    ]
    
    private let helperTextAttributes: [NSAttributedString.Key: Any] = [
        .foregroundColor: Color.neutral32.color,
    ]
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 12
        stackView.axis = .horizontal
        return stackView
    }()
}

