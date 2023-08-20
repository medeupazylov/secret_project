//
//  PhotoView.swift
//  Muslink
//
//  Created by Aisha Nurgaliyeva on 12.08.2023.
//

import UIKit

class PhotoView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setup() {
        layer.cornerRadius = 10.0
    }
 
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            self.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            self.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            self.heightAnchor.constraint(equalToConstant: 278)
        ])
    }
}
