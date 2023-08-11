//
//  StatisticsView.swift
//  Muslink
//
//  Created by Arystan on 11.08.2023.
//

import Foundation
import UIKit

class StatisticsView: UIView {
    
    var stackView = StaticticsStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setup() {
        backgroundColor = Color.elevatedBgColor.color
        layer.cornerRadius = 10
        addSubview(stackView)
        translatesAutoresizingMaskIntoConstraints = false
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 24),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -24)
        ])
    }
}


class StaticticsStackView: UIStackView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    lazy var yandex = getPartStack(name: "yandex_music_negative", amount: "1349")
    lazy var spotify = getPartStack(name: "spotify_negative", amount: "800")
    lazy var vk = getPartStack(name: "vk_negative", amount: "18K")
    lazy var instagram = getPartStack(name: "instagram_negative", amount: "1743")
    lazy var youtube = getPartStack(name: "youtube_negative", amount: "34K")
    
    private func setup() {
        axis = .horizontal
        translatesAutoresizingMaskIntoConstraints = false
        spacing = 8
        heightAnchor.constraint(equalToConstant: 16).isActive = true
        distribution = .equalSpacing
        [ yandex,
          spotify,
          vk,
          instagram,
          youtube
        ].forEach{ self.addArrangedSubview($0) }
    }
    
    func getPartStack(name: String, amount: String) -> UIStackView {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 4
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        let iconView = UIImageView(image: UIImage(named: name))
        iconView.translatesAutoresizingMaskIntoConstraints = false
        iconView.contentMode = .scaleAspectFit
        
        let amountLabel = DefaultLabel(text: amount, textColor: Color.neutral100.color, fontSize: 13, fontWeight: .regular)
        
        stack.addArrangedSubview(iconView)
        stack.addArrangedSubview(amountLabel)
    
        return stack
    }
    
}
