//
//  LabelsCell.swift
//  Muslink
//
//  Created by Arystan on 20.08.2023.
//

import Foundation
import UIKit

final class LabelsCell: UITableViewCell {
    
    static let identifier = "LabelsCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        self.setupUI()
        self.backgroundColor = .clear
        contentView.backgroundColor = Color.elevatedBgColor.color
        self.selectionStyle = .none
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    

    let instagram = getSocialNetworks(imageName: "instagram_negative")
    let youtube = getSocialNetworks(imageName: "youtube_negative")
    let vk = getSocialNetworks(imageName: "vk_negative")
    let spotify = getSocialNetworks(imageName: "spotify_negative")
    let yandexmusic = getSocialNetworks(imageName: "yandex_music_negative")
    let browser = getSocialNetworks(imageName: "spotify_negative")
    
    let oxxymiron = getArtist(name: "Oxxymiron", imageName: "pic")
    let rem = getArtist(name: "Грязный Рэм", imageName: "pic")
    let kizaru = getArtist(name: "Kizaru", imageName: "pic")
    let test = getArtist(name: "Kizaru", imageName: "pic")
    
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
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    lazy var stack: UIStackView = {
        let socialNetworkViews = [instagram, youtube, vk, spotify, yandexmusic, browser]
        let stack = UIStackView(arrangedSubviews: socialNetworkViews)
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        stack.spacing = 12
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    lazy var artists: UIStackView = {
        let socialNetworkViews = [oxxymiron, rem, kizaru, test]
        
        let stack = UIStackView(arrangedSubviews: socialNetworkViews)
        stack.axis = .horizontal
        stack.spacing = 12
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    lazy var artistsScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    func setupUI() {
        contentView.addSubview(artistsScrollView)
        contentView.addSubview(labelStack2)
        contentView.addSubview(stack)
        contentView.layer.cornerRadius = 12.0
        artistsScrollView.addSubview(artists)
        
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            contentView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16),
            
            labelStack2.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            labelStack2.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24.0),
            
            stack.topAnchor.constraint(equalTo: labelStack2.bottomAnchor, constant: 24),
            stack.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),

            artistsScrollView.topAnchor.constraint(equalTo: stack.bottomAnchor, constant: 24),
            artistsScrollView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            artistsScrollView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            artistsScrollView.heightAnchor.constraint(equalToConstant: 110),
            
            artists.topAnchor.constraint(equalTo: artistsScrollView.topAnchor, constant: 5),
            artists.bottomAnchor.constraint(equalTo: artistsScrollView.bottomAnchor, constant: 5),
            artists.trailingAnchor.constraint(equalTo: artistsScrollView.trailingAnchor, constant: -24),
            artists.leadingAnchor.constraint(equalTo: artistsScrollView.leadingAnchor, constant: 24)
            
        ])
    }
}



private func getLabel(text: String, fontName: String, fontSize: CGFloat, textColor: UIColor) -> UILabel {
    let label = UILabel()
    label.text = text
    
    if let font = UIFont(name: fontName, size: fontSize) {
        label.font = font
    } else {
        label.font = UIFont.systemFont(ofSize: fontSize)
    }
    
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

private func getArtist(name: String, imageName: String) -> UIStackView {
    let nameLabel = getLabel(text: name, fontName: "YSText-Bold", fontSize: 11, textColor: Color.neutral100.color)
    
    let image: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: imageName)
        image.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        return image
    }()
    
    let view: UIView = {
        let view = UIView()
        view.backgroundColor = Color.primaryBgColor.color
        view.translatesAutoresizingMaskIntoConstraints = true
        view.layer.cornerRadius = 8
        view.addSubview(nameLabel)
        
        return view
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [image, view])
        stackView.axis = .vertical
        stackView.spacing = -10
        
        return stackView
    }()
    
    nameLabel.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
        view.heightAnchor.constraint(equalToConstant: 28),
        view.widthAnchor.constraint(equalToConstant: 85),
        
        image.heightAnchor.constraint(equalToConstant: 85),
        image.widthAnchor.constraint(equalToConstant: 85),
        
        nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        nameLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
    ])
    
    return stackView
}
private func getSocialNetworks(imageName: String) -> UIView{
    let icon: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: imageName)
        img.contentMode = .scaleAspectFill
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    let view: UIView = {
        let view = UIView()
        view.backgroundColor = Color.neutral16.color
        view.addSubview(icon)
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    NSLayoutConstraint.activate([
        view.widthAnchor.constraint(equalToConstant: 40),
        view.heightAnchor.constraint(equalToConstant: 32),
        
        icon.heightAnchor.constraint(equalToConstant: 16.0),
        icon.widthAnchor.constraint(equalToConstant: 16.0),
        icon.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        icon.centerYAnchor.constraint(equalTo: view.centerYAnchor),
    ])
    
    return view
}
