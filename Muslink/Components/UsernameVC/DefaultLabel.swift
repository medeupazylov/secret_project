//
//  DafaultLabel.swift
//  Muslink
//
//  Created by Aisha Nurgaliyeva on 06.08.2023.
//

import UIKit

class DefaultLabel: UILabel {
    
    init(text: String, textColor: UIColor, fontSize: CGFloat, fontWeight: UIFont.Weight) {
        super.init(frame: .zero)
        self.text = text
        self.textColor = textColor
        self.font = UIFont.systemFont(ofSize: fontSize, weight: fontWeight)
        setup()
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setup() {
        translatesAutoresizingMaskIntoConstraints = false
    }
}
