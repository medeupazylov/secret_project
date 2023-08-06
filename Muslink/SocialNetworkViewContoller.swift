//
//  SocialNetworkViewContoller.swift
//  Muslink
//
//  Created by Медеу Пазылов on 05.08.2023.
//

import UIKit

class SocialNetworkViewContoller: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Color.primaryBgColor.color
        
        setupViews()
        setupMainStack()
        setupLayout()
        setupNavigationBar()
        
        
    }
    
    @objc func action() {
        print("pressed")
    }
    
    func setupNavigationBar() {
        let title = UILabel()
        title.text = NSLocalizedString("Musician profile", comment: "")
        title.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        title.textColor = Color.neutral100.color
        navigationItem.titleView = title
        let item = UIBarButtonItem(image: UIImage(named: "chevron_left"), style: .done, target: nil, action: nil)
        item.tintColor = Color.neutral72.color
        navigationItem.leftBarButtonItem = item
    }
    
    func setupViews() {
        view.addSubview(titleLabel)
        view.addSubview(subTitleLabel)
        view.addSubview(mainScrollView)
        view.addSubview(continueButton)
        mainScrollView.addSubview(mainVStack)
        continueButton.addAction {
            print("hello world")
        }
    }
    
    func setupLayout() {
            NSLayoutConstraint.activate([
                titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16.0),
                titleLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 50),
                
                subTitleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16.0),
                subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
                
                continueButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16.0),
                continueButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16.0),
                continueButton.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -16.0),
                
                mainScrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
                mainScrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
                mainScrollView.topAnchor.constraint(equalTo: subTitleLabel.bottomAnchor, constant: 36),
                mainScrollView.bottomAnchor.constraint(equalTo: continueButton.topAnchor, constant: 10),
                
                mainVStack.topAnchor.constraint(equalTo: mainScrollView.topAnchor),
                mainVStack.bottomAnchor.constraint(equalTo: mainScrollView.bottomAnchor, constant: -35),

                yandexView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16.0),
                yandexView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16.0),

                spotifyView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16.0),
                spotifyView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16.0),

                instagramView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16.0),
                instagramView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16.0),


                youtubeView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16.0),
                youtubeView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16.0)
            ])
        }
    
    func setupMainStack() {
        mainVStack.addArrangedSubview(yandexView)
        mainVStack.addArrangedSubview(vkontakteView)
        mainVStack.addArrangedSubview(spotifyView)
        mainVStack.addArrangedSubview(youtubeView)
        mainVStack.addArrangedSubview(instagramView)
//        mainVStack.addArrangedSubview(telegramView)
    }
        
    private let continueButton: DefaultButton = {
        let button = DefaultButton(buttonType: .primary)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(title: "Продолжить")
        return button
    } ()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Color.neutral100.color
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.text = "Добавьте профили соцсетей"
        return label
    }()
    
    private let subTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Color.neutral72.color
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.text = "Помогите лейблам лучше узнать вас"
        return label
    }()
    
    private let mainScrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.isScrollEnabled = true
        scroll.alwaysBounceVertical = true
        scroll.showsVerticalScrollIndicator = false
        return scroll
    } ()
    
    private let mainVStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 24.0
        return stack
    } ()
    
    private lazy var yandexView: SocialNetworksView = {
        let socialNetworksView = SocialNetworksView(iconIMG: Image.yandexMusic.image,
                                                    placeholder: "Яндекс Музыка",
                                                    helperText: "music.yandex.ru/artist/0000",
                                                    delegate: self)
        socialNetworksView.translatesAutoresizingMaskIntoConstraints = false
        return socialNetworksView
    } ()
    
    private lazy var vkontakteView: SocialNetworksView = {
        let logoImage = Image.vkontakte.image
        let socialNetworksView = SocialNetworksView(iconIMG: Image.vkontakte.image,
                                                    placeholder: "Вконтакте",
                                                    helperText: "",
                                                    delegate: self)
        socialNetworksView.translatesAutoresizingMaskIntoConstraints = false
        return socialNetworksView
    } ()
    
    
    private lazy var spotifyView: SocialNetworksView = {
        let socialNetworksView = SocialNetworksView(iconIMG: Image.spotify.image,
                                                    placeholder: "Spotify",
                                                    helperText: "",
                                                    delegate: self)
        socialNetworksView.translatesAutoresizingMaskIntoConstraints = false
        return socialNetworksView
    } ()
    
    private lazy var youtubeView: SocialNetworksView = {
        let socialNetworksView = SocialNetworksView(iconIMG: Image.youtube.image,
                                                    placeholder: "Youtube",
                                                    helperText: "",
                                                    delegate: self)
        socialNetworksView.translatesAutoresizingMaskIntoConstraints = false
        return socialNetworksView
    } ()
    
    private lazy var instagramView: SocialNetworksView = {
        let socialNetworksView = SocialNetworksView(iconIMG: Image.instagram.image,
                                                    placeholder: "Instagram",
                                                    helperText: "",
                                                    delegate: self)
        socialNetworksView.translatesAutoresizingMaskIntoConstraints = false
        return socialNetworksView
    } ()
    
    private lazy var telegramView: SocialNetworksView = {
        let socialNetworksView = SocialNetworksView(iconIMG: Image.telegram.image,
                                                    placeholder: "Telegram",
                                                    helperText: "",
                                                    delegate: self)
        socialNetworksView.translatesAutoresizingMaskIntoConstraints = false
        return socialNetworksView
    } ()

}

extension SocialNetworkViewContoller: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        updateSocialNetworkViews(textField)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSocialNetworkViews(textField)
    }
    
    private func updateSocialNetworkViews(_ textField: UITextField) {
        switch textField {
        case yandexView.textField:
            yandexView.updateView()
        case spotifyView.textField:
            spotifyView.updateView()
        case youtubeView.textField:
            youtubeView.updateView()
        case instagramView.textField:
            instagramView.updateView()
        case telegramView.textField:
            telegramView.updateView()
        case vkontakteView.textField:
            vkontakteView.updateView()
        default:
            print("nothing")
        }
    }
}



