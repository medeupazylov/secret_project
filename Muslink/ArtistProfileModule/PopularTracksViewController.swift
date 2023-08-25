//
//  PopularTracksViewController.swift
//  Muslink
//
//  Created by Медеу Пазылов on 06.08.2023.
//

import UIKit
import AVFoundation

extension PopularTracksViewController: UIDocumentPickerDelegate {
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let audioURL = urls.first else { return }
        let musicCard = mainStack.subviews[loadedTracks] as! MusicCardView
        musicCard.setupAudioPlayer(audioURL)
        loadedTracks+=1;
        audioList.append(audioURL)
    }
}

class PopularTracksViewController: UIViewController {
    
    private var audioList: [URL] = []
    var audioPlayer: AVAudioPlayer?
    
    private var loadedTracks = 0 {
        didSet {
            self.mainStack.subviews[self.loadedTracks-1].layer.opacity = 0.0
            UIView.animate(withDuration: 0.5) {
                self.mainStack.subviews[self.loadedTracks-1].layer.opacity = 1.0
                self.mainStack.subviews[self.loadedTracks-1].isHidden.toggle()
            }
            if loadedTracks == 4 {
                UIView.animate(withDuration: 0.5) {
                    self.loadButtonContainer.isHidden.toggle()
                    self.loadButtonContainer.layer.opacity = 0.0
                }
            }
        }
    }
    
//MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Color.primaryBgColor.color
        setupViews()
        setupLayout()
        setupActions()
    }
    
//MARK: - Setup methods
    
    private func setupNavigationBar() {
        let title = UILabel()
        title.text = NSLocalizedString("Профиль музыканта", comment: "")
        title.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        title.textColor = Color.neutral100.color
        navigationItem.titleView = title
        let item = UIBarButtonItem(image: UIImage(named: "chevron_left"), style: .done, target: nil, action: nil)
        item.tintColor = Color.neutral72.color
        navigationItem.leftBarButtonItem = item
    }
    
    private func setupViews() {
        view.addSubview(titleLabel)
        view.addSubview(seeAllButton)
        seeAllButton.addSubview(seeAllButtonTitle)
        seeAllButton.addSubview(seeAllButtonIcon)
        view.addSubview(mainStack)
        mainStack.addArrangedSubview(musicCardOne)
        mainStack.addArrangedSubview(musicCardTwo)
        mainStack.addArrangedSubview(musicCardThree)
        mainStack.addArrangedSubview(musicCardFour)
        mainStack.addArrangedSubview(loadButtonContainer)

    }
    
    private func setupActions() {
        musicCardOne.disableAllClosure = { self.disableMusicCards(self.musicCardOne, self.musicCardOne.musicCardState) }
        musicCardTwo.disableAllClosure = { self.disableMusicCards(self.musicCardTwo, self.musicCardTwo.musicCardState) }
        musicCardThree.disableAllClosure = { self.disableMusicCards(self.musicCardThree, self.musicCardThree.musicCardState) }
        musicCardFour.disableAllClosure = { self.disableMusicCards(self.musicCardFour, self.musicCardFour.musicCardState) }
        
        loadButtonContainer.addTarget(self, action: #selector(loadAudioFromDevice), for: .touchUpInside)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16.0),
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 11.0),
            
            seeAllButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16.0),
            seeAllButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            seeAllButton.widthAnchor.constraint(equalToConstant: 110.0),
            seeAllButton.heightAnchor.constraint(equalToConstant: 20.0),
            
            seeAllButtonTitle.centerYAnchor.constraint(equalTo: seeAllButton.centerYAnchor),
            seeAllButtonTitle.rightAnchor.constraint(equalTo: seeAllButtonIcon.leftAnchor, constant: -4.0),
            
            seeAllButtonIcon.heightAnchor.constraint(equalToConstant: 18.0),
            seeAllButtonIcon.widthAnchor.constraint(equalToConstant: 18.0),
            seeAllButtonIcon.centerYAnchor.constraint(equalTo: seeAllButton.centerYAnchor, constant: 1.0),
            seeAllButtonIcon.rightAnchor.constraint(equalTo: seeAllButton.rightAnchor),
            
            mainStack.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16.0),
            mainStack.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16.0),
            mainStack.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 24.0),
            mainStack.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
//MARK: - Private methods
    
    private func disableMusicCards(_ previousCard: MusicCardView, _ previousState: MusicCardState) {
        musicCardOne.disableCard()
        musicCardTwo.disableCard()
        musicCardThree.disableCard()
        musicCardFour.disableCard()
        previousCard.musicCardState = previousState
    }
    
    @objc func loadAudioFromDevice() {
        var documentPicker: UIDocumentPickerViewController
        if #available(iOS 14.0, *) {
            let supportedTypes: [UTType] = [UTType.audio]
            documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: supportedTypes)
        } else {
            documentPicker = UIDocumentPickerViewController(documentTypes: ["public.audio"], in: UIDocumentPickerMode.import)
        }
        documentPicker.delegate = self
        self.present(documentPicker, animated: true, completion: nil)
    }
    
//MARK: - UI Elements
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Популярные треки"
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        label.textColor = Color.neutral100.color
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()
    
    private let seeAllButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    } ()
    
    private let seeAllButtonIcon: UIImageView = {
        let image = UIImageView(image: Image.chevronRight.image)
        image.translatesAutoresizingMaskIntoConstraints = false
        image.tintColor = Color.neutral100.color
        image.contentMode = .scaleAspectFill
        return image
    } ()
    
    private let seeAllButtonTitle: UILabel = {
        let label = UILabel()
        label.text = "Смотреть всё"
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = Color.neutral72.color
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()
    
    private let mainStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .fill
        stack.spacing = 12.0
        return stack
    } ()
    
    private let loadButtonContainer: DefaultButton = {
        let button = DefaultButton(buttonType: .bordered)
        button.setTitle(title: "Загрузить с устройства")
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    } ()
    
    private let musicCardOne: MusicCardView = {
        let card = MusicCardView(index: 1, musicName: "Permission to Dance", artistName: "Angelo Rodriguez", musicPicture: "permission_to_dance")
        card.translatesAutoresizingMaskIntoConstraints = false
        card.isHidden = true
        return card
    } ()
    
    private let musicCardTwo: MusicCardView = {
        let card = MusicCardView(index: 2, musicName: "Life short", artistName: "Angelo Rodriguez", musicPicture: "life_short")
        card.translatesAutoresizingMaskIntoConstraints = false
        card.isHidden = true
        return card
    } ()
    
    private let musicCardThree: MusicCardView = {
        let card = MusicCardView(index: 3, musicName: "Hey, brother", artistName: "Angelo Rodriguez", musicPicture: "hey_brother")
        card.translatesAutoresizingMaskIntoConstraints = false
        card.isHidden = true
        return card
    } ()
    
    private let musicCardFour: MusicCardView = {
        let card = MusicCardView(index: 4, musicName: "Feedback forever", artistName: "Angelo Rodriguez", musicPicture: "feedback_forever")
        card.translatesAutoresizingMaskIntoConstraints = false
        card.isHidden = true
        return card
    } ()
    
}
