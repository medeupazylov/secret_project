//
//  MusicianPhotoView.swift
//  Muslink
//
//  Created by Aisha Nurgaliyeva on 11.08.2023.
//

import UIKit

class MusicianPhotoView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private lazy var image = UIImageView(image: UIImage(named: "musician"))
    private lazy var musicianNameStack = MusicianNameStack()
    
    private func setup() {
        
        addSubview(image)
        addSubview(musicianNameStack)
        translatesAutoresizingMaskIntoConstraints = false
        setConstraints()
        
        leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        musicianNameStack.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        musicianNameStack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -24).isActive = true
        
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 278)
        ])
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: topAnchor),
            image.leadingAnchor.constraint(equalTo: leadingAnchor),
            image.trailingAnchor.constraint(equalTo: trailingAnchor),
            image.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}


