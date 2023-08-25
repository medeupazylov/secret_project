//
//  ButtonsStack.swift
//  Muslink
//
//  Created by Aisha Nurgaliyeva on 20.08.2023.
//

import UIKit

class ButtonsStack: UIStackView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        setupConstraints()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func sfToString(image: UIImage, color: UIColor) -> String {
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = image.withTintColor(color)
        let fullString = NSMutableAttributedString(string: "")
        fullString.append(NSAttributedString(attachment: imageAttachment))
        return fullString.string
    }
    
    var rejectButton: DefaultButton = {
        let button = DefaultButton(buttonType: .bordered)
        let attachment = NSTextAttachment()
        attachment.image = UIImage(systemName: "xmark.circle")?.withTintColor(Color.neutral72.color)
        let imageString = NSMutableAttributedString(attachment: attachment)
        let attributes: [NSAttributedString.Key: Any] = [
                    .font: UIFont.boldSystemFont(ofSize: 16)
                ]
        let textString = NSAttributedString(string: " Отказать", attributes: attributes)
        imageString.append(textString)

        let label = UILabel()
        label.attributedText = imageString
        label.textColor = Color.neutral72.color
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        button.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: button.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: button.centerYAnchor),
        ])
        return button
    }()

    var acceptButton: DefaultButton = {
        let button = DefaultButton(buttonType: .primary)
        let attachment = NSTextAttachment()
        attachment.image = UIImage(systemName: "checkmark.circle")?.withTintColor(Color.primaryBgColor.color)
        let attributes: [NSAttributedString.Key: Any] = [
                    .font: UIFont.boldSystemFont(ofSize: 16)
                ]
        let imageString = NSMutableAttributedString(attachment: attachment)
        let textString = NSAttributedString(string: " Одобрить", attributes: attributes)
        imageString.append(textString)

        let label = UILabel()
        label.attributedText = imageString
        label.textColor = Color.primaryBgColor.color
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        button.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: button.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: button.centerYAnchor),
        ])
        return button
    }()

    private func setup() {
        axis = .horizontal
        spacing = 12.0
        translatesAutoresizingMaskIntoConstraints = false
        addArrangedSubview(rejectButton)
        addArrangedSubview(acceptButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            rejectButton.widthAnchor.constraint(equalTo: acceptButton.widthAnchor),
            rejectButton.heightAnchor.constraint(equalTo: acceptButton.heightAnchor),
        ])
    }
    
}
