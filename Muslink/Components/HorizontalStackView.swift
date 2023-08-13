//
//  HorizontalStackView.swift
//  Muslink
//
//  Created by Аброрбек on 12.08.2023.
//

import UIKit

class HorizontalStackView: UIStackView {
    
    init(arrangedSubviews: [UIView], spacing: CGFloat = 8.0) {
        super.init(frame: .zero)
        self.spacing = spacing
        arrangedSubviews.forEach { self.addArrangedSubview($0) }
        setup()
        
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        axis = .horizontal
        alignment = .fill
        distribution = .fill
    }
    
}
