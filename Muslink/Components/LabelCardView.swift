//
//  LabelCardView.swift
//  Muslink
//
//  Created by Arystan on 12.08.2023.
//

import Foundation
import UIKit


class LabelCardView: UIView {
    
}


final class TestViewController: UIViewController {
    
    let instagram = getSocialNetworks(imageName: "instagram_negative")
    let youtube = getSocialNetworks(imageName: "youtube_negative")
    let vk = getSocialNetworks(imageName: "vk_negative")
    let spotify = getSocialNetworks(imageName: "spotify_negative")
    let yandexmusic = getSocialNetworks(imageName: "yandex_music_negative")
    let browser = getSocialNetworks(imageName: "spotify_negative")
    
    let oxxymiron = getArtist(name: "Oxxymiron", imageName: "pic")
    let rem = getArtist(name: "Oxxymiron", imageName: "pic")
    let kizaru = getArtist(name: "Oxxymiron", imageName: "pic")
    
    let labelIcon = getLabelIcon(imgName: "instagram")
    
    let labelName = getLabel(text: "Depressing Rap (iSpy Tunes)", fontName: "YSText-Bold", fontSize: 15, textColor: Color.neutral100.color)
    
    let hashtag = getLabel(text: "#mumble", fontName: "YSText-Regular", fontSize: 13, textColor: .lightGray)
    
    lazy var labelStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [labelName, hashtag])
        stack.axis = .vertical
        stack.spacing = 4
        
        return stack
    }()

    lazy var labelStack2: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [labelIcon, labelStack])
        stack.axis = .horizontal
        stack.spacing = 12
        
        return stack
    }()
    
    lazy var stack: UIStackView = {
        let socialNetworkViews = [instagram, youtube, vk, spotify, yandexmusic, browser]
        
        let stack = UIStackView(arrangedSubviews: socialNetworkViews)
        stack.axis = .horizontal
        stack.spacing = 12
        stack.distribution = .equalCentering
        
        return stack
    }()

    lazy var artists: UIStackView = {
        let socialNetworkViews = [oxxymiron, rem, kizaru]
        
        let stack = UIStackView(arrangedSubviews: socialNetworkViews)
        stack.axis = .horizontal
        stack.spacing = 20
        stack.distribution = .equalCentering
        
        return stack
    }()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(stack)
        view.addSubview(artists)
        view.addSubview(labelStack2)
        setupUI()
    }
    
    func setupUI() {
        artists.translatesAutoresizingMaskIntoConstraints = false
        stack.translatesAutoresizingMaskIntoConstraints = false
        labelStack2.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemPink
        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            artists.topAnchor.constraint(equalTo: stack.bottomAnchor, constant: 24),
            artists.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            artists.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            
            labelStack2.topAnchor.constraint(equalTo: artists.bottomAnchor, constant: 20),
            labelStack2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            
        ])
    }
}

private func getLabel(text: String, fontName: String, fontSize: CGFloat, textColor: UIColor) -> UILabel {
    let label = UILabel()
    label.text = text
    label.font = UIFont(name: fontName, size: fontSize)
    label.textColor = textColor
    
    return label
}

private func getLabelIcon(imgName: String) -> UIImageView {
    let img = UIImageView()
    img.image = UIImage(named: imgName)
    img.layer.cornerRadius = 100
    img.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    img.translatesAutoresizingMaskIntoConstraints = false
    img.widthAnchor.constraint(equalToConstant: 60).isActive = true
    img.heightAnchor.constraint(equalToConstant: 60).isActive = true
    
    return img
}

private func getArtist(name: String, imageName: String) ->  UIStackView {

    let name = getLabel(text: name, fontName: "", fontSize: 11, textColor: Color.neutral100.color)
    
    let image: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: imageName)
        image.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        return image
    }()
    
    let view: UIView = {
        let view = UIView()
        view.addSubview(name)
        view.translatesAutoresizingMaskIntoConstraints = true
        view.backgroundColor = Color.primaryBgColor.color
        
        return view
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [image,view])
        stackView.axis = .vertical
        stackView.spacing = -10
        
        return stackView
    }()
    
    NSLayoutConstraint.activate([
        view.heightAnchor.constraint(equalToConstant: 28),
        view.widthAnchor.constraint(equalToConstant: 85),
        
        image.heightAnchor.constraint(equalToConstant: 85),
        image.widthAnchor.constraint(equalToConstant: 85),
        
        name.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        name.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        
    ])
    
    return stackView
}

private func getSocialNetworks(imageName: String) -> UIView{
    let icon: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: imageName)
        img.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        img.translatesAutoresizingMaskIntoConstraints = false
        
        return img
    }()
    
    let view: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.addSubview(icon)
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    NSLayoutConstraint.activate([
        view.widthAnchor.constraint(equalToConstant: 39),
        view.heightAnchor.constraint(equalToConstant: 32),
        
        icon.topAnchor.constraint(equalTo: view.topAnchor, constant: 8),
        icon.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
        icon.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
        icon.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -8),
    ])
    
    return view
}

