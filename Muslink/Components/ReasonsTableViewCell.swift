//
//  ReasonsTableViewCell.swift
//  Muslink
//
//  Created by Aisha Nurgaliyeva on 19.08.2023.
//

import UIKit

class ReasonsTableViewCell: UITableViewCell {
    
    var onToggleChecked: ((Int) -> ())?
    
    var index: Int?
    
    lazy var checkButton: UIButton = {
        let button = UIButton()
        button.sizeThatFits(CGSize(width: 24, height: 24))
        button.backgroundColor = Color.neutral16.color
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addSubview(checkIcon)
        checkIcon.isHidden = true
        button.addTarget(self, action: #selector(checkButtonPressed), for: .touchUpInside)
        return button
    }()
    
    var checkIcon: UIImageView = {
        let icon = UIImageView(image: Image.check.image)
        icon.sizeThatFits(CGSize(width: 24, height: 24))
        icon.tintColor = Color.primaryBgColor.color
        icon.translatesAutoresizingMaskIntoConstraints = false
        return icon
    }()
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = Color.neutral100.color
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var cellStack = HorizontalStackView(arrangedSubviews: [checkButton, titleLabel], spacing: 12.0)
    

    @objc private func checkButtonPressed() {
        onToggleChecked?(self.index!)
    }
    
    
    var reason: Reason? {
        didSet {
            if reason != nil {
                titleLabel.text = reason?.title
                if reason!.checked {
                    showSelection()
                } else {
                    hideSelection()
                }
            }
        }
    }

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    private func setup() {
        backgroundColor = .clear
        selectionStyle = .none
        contentView.addSubview(cellStack)
        setConstraints()
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate(
            [
                cellStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
                cellStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                cellStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                cellStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
                
                checkButton.widthAnchor.constraint(equalToConstant: 24),
                checkButton.heightAnchor.constraint(equalToConstant: 24)
            ]
        )
    }
    
    func showSelection() {
        checkButton.backgroundColor = Color.primaryMain.color
        checkIcon.isHidden = false
    }
    
    func hideSelection() {
        checkButton.backgroundColor = Color.neutral16.color
        checkIcon.isHidden = true
    }

}
