//
//  DefaultButton.swift
//  Muslink
//
//  Created by Медеу Пазылов on 05.08.2023.
//

import UIKit

enum ButtonType {
    case primary
    case bordered
}

final class DefaultButton: UIControl {
    
    // MARK: - Properties
    
    private var buttonType: ButtonType
    
    override var isEnabled: Bool {
        didSet {
            switch buttonType {
            case .primary:
                backgroundColor = isEnabled ? Color.accentMain.color : Color.warningHover.color
            case .bordered:
                layer.borderColor = isEnabled ? Color.primaryBorder.color.cgColor : Color.neutral16.color.cgColor
                titleLabel.textColor = isEnabled ? Color.neutral72.color : Color.neutral32.color 
            }
        }
    }
    
    override var isSelected: Bool {
        didSet {
            switch buttonType {
            case .primary:
                backgroundColor = isSelected ? Color.accentPressed.color : Color.accentMain.color
            case .bordered:
                backgroundColor = isSelected ? .clear : Color.primaryBgColor.color
                layer.borderColor = isSelected ? Color.infoBorder.color.cgColor : Color.primaryBorder.color.cgColor
            }
        }
    }
    
    override var isHighlighted: Bool {
        didSet {
            switch buttonType {
            case .primary:
                backgroundColor = isHighlighted ? Color.accentPressed.color : Color.accentMain.color
            case .bordered:
                backgroundColor = isHighlighted ? Color.neutral16.color : .clear
                layer.borderColor = isHighlighted ? Color.infoBorder.color.cgColor : Color.primaryBorder.color.cgColor
            }
            
        }
    }
    
    // MARK: - Lifecycle
    init(buttonType: ButtonType) {
        self.buttonType = buttonType
        super.init(frame: .zero)
        setupButton()
        setupSubViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Internal Methods
    
    func setTitle(title: String) {
        titleLabel.text = title
    }
    
    func getTitle() -> String? {
        return titleLabel.text
    }
    
    // MARK: - Private Methods
    private func setupSubViews() {
        self.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
    }

    private func setupButton() {
        switch buttonType {
        case .primary:
            backgroundColor = Color.accentMain.color
            layer.shadowColor = UIColor.black.cgColor
            layer.shadowOpacity = 0.7
            layer.shadowOffset = CGSize(width: 0, height: -10)
            layer.shadowRadius = 10
            titleLabel.textColor = Color.primaryBgColor.color
        case .bordered:
            backgroundColor = .clear
            layer.borderColor = Color.primaryBorder.color.cgColor
            layer.borderWidth = 1
            titleLabel.textColor = Color.neutral72.color
        }
        
        layer.cornerRadius = 12.0
        let buttonHeight = 56.0
        heightAnchor.constraint(equalToConstant: buttonHeight).isActive = true

    }
    
    // MARK: - UI Elements
    
    private let titleLabel: UILabel = {
        let title = UILabel()
        title.font = UIFont.systemFont(ofSize: 16.0, weight: .bold)
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    } ()

}
