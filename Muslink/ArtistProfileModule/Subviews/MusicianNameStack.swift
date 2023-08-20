//
//  MusicianNameStack.swift
//  Muslink
//
//  Created by Aisha Nurgaliyeva on 11.08.2023.
//

import UIKit

final class MusicianNameStack: UIStackView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private lazy var musicIcon = UIImageView(image: Image.music.image)
    private lazy var tracksLabel = DefaultLabel(text: "34 трека",
                                                textColor: Color.neutral100.color,
                                                fontSize: 13,
                                                fontWeight: .light)
    private lazy var tracksStack = HorizontalStackView(arrangedSubviews: [musicIcon,
                                                                          tracksLabel], spacing: 4.0)
    
    private lazy var locationIcon = UIImageView(image: Image.location.image)
    private lazy var locationLabel = DefaultLabel(text: "Москва",
                                                  textColor: Color.neutral100.color,
                                                  fontSize: 13,
                                                  fontWeight: .light)
    private lazy var locationStack = HorizontalStackView(arrangedSubviews: [locationIcon,
                                                                            locationLabel], spacing: 4.0)
    private lazy var subtitleStack = HorizontalStackView(arrangedSubviews: [tracksStack,
                                                                            locationStack], spacing: 16.0)
    
    private lazy var verifiedIcon = UIImageView(image: Image.verified.image)
    
    
    private lazy var musicianNameLabel = DefaultLabel(text: "Angelo Rodrigez",
                                                      textColor: Color.neutral100.color,
                                                      fontSize: 20,
                                                      fontWeight: .heavy)
    private lazy var musicianNameStack = HorizontalStackView(arrangedSubviews: [verifiedIcon,
                                                                                musicianNameLabel])
    
    private func setup() {
        [musicianNameStack,
         subtitleStack].forEach { self.addArrangedSubview($0) }
        translatesAutoresizingMaskIntoConstraints = false
        axis = .vertical
        spacing = 12.0
        distribution = .fill
        alignment = .center
        verifiedIcon.contentMode = .scaleAspectFit
    }
    
}



