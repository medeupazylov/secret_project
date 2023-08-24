//
//  SocialNetworkViewContoller.swift
//  Muslink
//
//  Created by on 05.08.2023.
//

import UIKit

final class ChooseSocialNetworksViewContoller: UIViewController {
    
    //MARK: - Properties

    private var networks: [SocialNetwork] = []
    
    private let viewModel: ArtistRegistrationViewModel
    private let window: UIWindow
    
    //MARK: - Lifecycle
    
    init(viewModel: ArtistRegistrationViewModel, window: UIWindow) {
        self.viewModel = viewModel
        self.window = window
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Color.primaryBgColor.color
        
        setupViews()
        setupMainStack()
        setupLayout()
        setupNavigationBar()
        
        
    }
    
    @objc
    private func moveBack() {
        navigationController?.popViewController(animated: false)
    }
    
    @objc
    private func nextButtonPressed() {
        viewModel.userDidEnterSocialNetworks(socialNetworks: networks)
        navigationController?.pushViewController(ChooseGenresViewController(viewModel: viewModel, window: window), animated: false)
    }
    
    func setupNavigationBar() {
        let title = UILabel()
        title.text = NSLocalizedString("Musician profile", comment: "")
        title.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        title.textColor = Color.neutral100.color
        navigationItem.titleView = title
        let item = UIBarButtonItem(image: UIImage(named: "chevron_left"), style: .done, target: self, action: #selector(moveBack))
        item.tintColor = Color.neutral72.color
        navigationItem.leftBarButtonItem = item
        continueButton.addTarget(self, action: #selector(nextButtonPressed), for: .touchUpInside)
    }
    
    func setupViews() {
        view.addSubview(progressView)
        view.addSubview(titleLabel)
        view.addSubview(subTitleLabel)
        view.addSubview(mainScrollView)
        view.addSubview(continueButton)
        mainScrollView.addSubview(mainVStack)
        
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            progressView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            progressView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            progressView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            
            
            titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16.0),
            titleLabel.topAnchor.constraint(equalTo: progressView.safeAreaLayoutGuide.bottomAnchor, constant: 30),

            subTitleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16.0),
            subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            
            continueButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16.0),
            continueButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16.0),
            continueButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -12.0),
            
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
    
    private func setupMainStack() {
        mainVStack.addArrangedSubview(yandexView)
        mainVStack.addArrangedSubview(vkontakteView)
        mainVStack.addArrangedSubview(spotifyView)
        mainVStack.addArrangedSubview(youtubeView)
        mainVStack.addArrangedSubview(instagramView)
    }
    
    private let progressView: DefaultProgressBar = {
        let progressView = DefaultProgressBar()
        progressView.updateProgress(withScreenOrder: 2)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        return progressView
    }()
    
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

extension ChooseSocialNetworksViewContoller: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        updateSocialNetworkViews(textField)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard textField.hasText else {
            return
        }
        getSocialLink(textField)
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
            return
        }
    }
    
    private func getSocialLink(_ textField: UITextField) {
        switch textField {
        case yandexView.textField:
            yandexView.updateView()
            if let index = networks.firstIndex(where: {
                $0.mediaType == "Yandex"
            }) {
                networks.remove(at: index)
            }
            guard let link = textField.text, !link.isEmpty else {
                return
            }
            networks.append(SocialNetwork(mediaType: "Yandex", link: link))
            
        case spotifyView.textField:
            spotifyView.updateView()
            guard let link = textField.text, !link.isEmpty else {
                return
            }
            networks.append(SocialNetwork(mediaType: "Spotify", link: link))
            
        case youtubeView.textField:
            youtubeView.updateView()
            guard let link = textField.text, !link.isEmpty else {
                return
            }
            networks.append(SocialNetwork(mediaType: "YouTube", link: link))
            
        case instagramView.textField:
            instagramView.updateView()
            guard let link = textField.text, !link.isEmpty else {
                return
            }
            networks.append(SocialNetwork(mediaType: "Instagram", link: link))
            
        case telegramView.textField:
            telegramView.updateView()
            guard let link = textField.text, !link.isEmpty else {
                return
            }
            networks.append(SocialNetwork(mediaType: "Telegram", link: link))
            
        case vkontakteView.textField:
            vkontakteView.updateView()
            guard let link = textField.text, !link.isEmpty else {
                return
            }
            networks.append(SocialNetwork(mediaType: "VKontakte", link: link))
            
        default:
            return
        }
    }

}



