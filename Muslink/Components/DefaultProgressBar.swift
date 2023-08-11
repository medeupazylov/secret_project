//
//  DefaulProgressBar.swift
//  Muslink
//
//  Created by Aisha Nurgaliyeva on 05.08.2023.
//

import UIKit

class DefaultProgressBar: UIProgressView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setup() {
        progressViewStyle = .bar
        progress = 0.0
        trackTintColor = Color.neutral16.color
        progressTintColor = Color.primaryMain.color
        layer.masksToBounds = true
        layer.cornerRadius = 1
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: 2.5).isActive = true
    }
    
    func updateProgress(withScreenOrder: Int) {
        progress += 0.25 * Float(withScreenOrder)
    }
}
