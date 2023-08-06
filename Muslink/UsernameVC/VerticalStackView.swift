//
//  ReusableStackView.swift
//  Muslink
//
//  Created by Aisha Nurgaliyeva on 06.08.2023.
//

import UIKit

class VerticalStackView: UIStackView {
    
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
        axis = .vertical
        alignment = .fill
        distribution = .fill
    } 
    
}
