//
//  SocialNetworksStackView.swift
//  Muslink
//
//  Created by Aisha Nurgaliyeva on 13.08.2023.
//

import UIKit

class SocialNetworksStackView: UIStackView {
    
    private var yandexMusicButton = SocialNetworkButton()
    private var spotifyButton = SocialNetworkButton()
    private var vkontakteButton = SocialNetworkButton()
    private var instagramButton = SocialNetworkButton()
    private var youtubeButton = SocialNetworkButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setup() {
        [yandexMusicButton,
         spotifyButton,
         vkontakteButton,
         instagramButton,
         youtubeButton].forEach { self.addArrangedSubview($0) }
        
        yandexMusicButton.setIcon(Image.yandexMusicNegative.image)
        spotifyButton.setIcon(Image.spotifyNegative.image)
        vkontakteButton.setIcon(Image.vkontakteNegative.image)
        instagramButton.setIcon(Image.instagramNegative.image)
        youtubeButton.setIcon(Image.youtubeNegative.image)
        
        translatesAutoresizingMaskIntoConstraints = false
        alignment = .fill
        distribution = .fillEqually
        spacing = 16.0
    }

    
    
}
