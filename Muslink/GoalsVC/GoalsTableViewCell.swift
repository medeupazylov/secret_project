//
//  GoalsTableViewCell.swift
//  Muslink
//
//  Created by Aisha Nurgaliyeva on 16.08.2023.
//

import UIKit

class GoalsTableViewCell: UITableViewCell {
    
    lazy var checkButton: UIButton = {
        let button = UIButton()
        button.sizeThatFits(CGSize(width: 24, height: 24))
        button.backgroundColor = Color.neutral16.color
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addSubview(checkIcon)
        checkIcon.isHidden = true
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
    

//    var goal: Goal {
//        didSet {
//            titleLabel.text = goal.title
//            checkIcon.isHidden = goal.checked
//        }
//    }
//
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setup() {
        backgroundColor = .clear
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
    
    

}
