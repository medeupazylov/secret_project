//
//  AddImageView.swift
//  Muslink
//
//  Created by Аброрбек on 06.08.2023.
//

import UIKit

final class CustomImageView: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        translatesAutoresizingMaskIntoConstraints = false
        contentMode = .scaleToFill
        isUserInteractionEnabled = true
        backgroundColor = Color.elevatedBgColor.color
        image = Image.plus.image
        layer.cornerRadius = 12
        clipsToBounds = true
    }
}
