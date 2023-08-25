//
//  DefaultSeparator.swift
//  Muslink
//
//  Created by Aisha Nurgaliyeva on 23.08.2023.
//

import UIKit

class DefaultSeparator: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setup() {
        backgroundColor = Color.neutral16.color
        
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 0.5),
            leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
        ])
    }
}
