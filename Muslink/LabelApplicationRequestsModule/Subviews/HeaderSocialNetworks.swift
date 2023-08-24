//
//  HeaderSocialNetworks.swift
//  Muslink
//
//  Created by Aisha Nurgaliyeva on 23.08.2023.
//

import UIKit

class HeaderSocialNetworks: UIStackView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func getSocialNetworkButton(name: String) -> UIButton {
        let button = UIButton()
        button.backgroundColor = Color.neutral16.color
        button.layer.cornerRadius = 8.0
        button.translatesAutoresizingMaskIntoConstraints = false
        let iconImageView = UIImageView()
        iconImageView.image = UIImage(named: name)
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        button.addSubview(iconImageView)
        
        NSLayoutConstraint.activate([
            iconImageView.leadingAnchor.constraint(equalTo: button.leadingAnchor, constant: 4),
            iconImageView.trailingAnchor.constraint(equalTo: button.trailingAnchor, constant: -4),
            iconImageView.centerYAnchor.constraint(equalTo: button.centerYAnchor),
            iconImageView.heightAnchor.constraint(equalToConstant: 16),
            iconImageView.widthAnchor.constraint(equalToConstant: 16),
            button.heightAnchor.constraint(equalToConstant: 24)
        ])
        
        return button
    }
    
    private func setup() {
        axis = .horizontal
        let yandexMusicButton = getSocialNetworkButton(name: "yandex_music_negative")
        let spotifyButton = getSocialNetworkButton(name: "spotify_negative")
        let vkontakteButton = getSocialNetworkButton(name: "vk_negative")
        let instagramButton = getSocialNetworkButton(name: "instagram_negative")
        let youtubeButton = getSocialNetworkButton(name: "youtube_negative")
        self.addArrangedSubview(vkontakteButton)
        self.addArrangedSubview(instagramButton)
        self.addArrangedSubview(yandexMusicButton)
        self.addArrangedSubview(youtubeButton)
        self.addArrangedSubview(spotifyButton)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.alignment = .fill
        self.distribution = .fillEqually
        self.spacing = 8.0
    }
    
}
