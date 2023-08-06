//
//  DefaultButton.swift
//  Muslink
//
//  Created by Медеу Пазылов on 05.08.2023.
//

import UIKit

enum ButtonType {
    case primary
    case secondary
}

final class DefaultButton: UIControl {
    
    // MARK: - Properties
    
    private var buttonType: ButtonType
    
    override var isEnabled: Bool {
        didSet {
            backgroundColor = isEnabled ? Color.accentMain.color : Color.warningHover.color
        }
    }
    
    override var isSelected: Bool {
        didSet {
            backgroundColor = isSelected ? Color.accentPressed.color : Color.accentMain.color
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
        self.backgroundColor = Color.accentMain.color
        self.layer.cornerRadius = 12.0
        let buttonHeight = (buttonType == .primary) ? 56.0 : 44.0
        self.heightAnchor.constraint(equalToConstant: buttonHeight).isActive = true
    }
    
//    // MARK: - Touch handling
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        isSelected = true
//    }
//    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        isSelected = false
//    }
    
    // MARK: - UI Elements
    private let titleLabel: UILabel = {
        let title = UILabel()
        title.font = UIFont.systemFont(ofSize: 16.0, weight: .bold)
        title.textColor = Color.primaryBgColor.color
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    } ()

}
