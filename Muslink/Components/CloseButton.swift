//
//  CloseButton.swift
//  Muslink
//
//  Created by Aisha Nurgaliyeva on 20.08.2023.
//

import UIKit

class CloseButton: UIButton {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private let closeIcon: UIImageView = {
        let icon = UIImageView(image: Image.close.image)
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.tintColor = Color.neutral72.color
        icon.sizeThatFits(CGSize(width: 16.0, height: 16.0))
        return icon
    }()
   
    
    private func setup() {
        addSubview(closeIcon)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            closeIcon.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            closeIcon.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            self.widthAnchor.constraint(equalToConstant: 24),
            self.heightAnchor.constraint(equalToConstant: 24),

        
        ])
    }
    
}

