//
//  SocialNetworkButton.swift
//  Muslink
//
//  Created by Aisha Nurgaliyeva on 10.08.2023.
//

import UIKit

final class SocialNetworkButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    
    private var iconImageView: UIImageView!
    
    func setIcon(_ icon: UIImage?) {
        iconImageView.image = icon
    }

    private func setup() {
        backgroundColor = Color.neutral16.color
        layer.cornerRadius = 8.0
        translatesAutoresizingMaskIntoConstraints = false
        
        iconImageView = UIImageView()
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(iconImageView)
        setConstraints()
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            iconImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            iconImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            iconImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            iconImageView.heightAnchor.constraint(equalToConstant: 16),
            iconImageView.widthAnchor.constraint(equalToConstant: 16),
            self.heightAnchor.constraint(equalToConstant: 48)
            
            
        ])
    }
    
}
    
