//
//  DefaultOptionsChooser.swift
//  Muslink
//
//  Created by Arystan on 13.08.2023.
//

import Foundation
import UIKit

final class DefaultOptionsChooser: UIControl{
    
    
    let choseLabel: UILabel = {
        let label = UILabel()
        label.textColor = Color.neutral100.color
        label.font = UIFont(name: "YSText-Bold", size: 14)
        
        return label
    }()    
    
    private let chevronIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Image.chevronDown.image
        imageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        return imageView
    }()
    
    
    init(text: String) {
        self.choseLabel.text = text
        super.init(frame: .zero)
        setupChooser()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupChooser() {
        self.addSubview(choseLabel)
        self.addSubview(chevronIcon)
        self.backgroundColor = Color.neutral32.color
        self.layer.cornerRadius = 10
        
        choseLabel.translatesAutoresizingMaskIntoConstraints = false
        chevronIcon.translatesAutoresizingMaskIntoConstraints = false
        self.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            choseLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12),
            choseLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            chevronIcon.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            chevronIcon.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12),
            
            self.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    
}
