//
//  MusicCardView.swift
//  Muslink
//
//  Created by Медеу Пазылов on 06.08.2023.
//

import UIKit
import AVFoundation

enum MusicCardState {
    case played
    case paused
    case disabled
}

class MusicCardView: UIView {
    
//MARK: - Properties
    private let index: Int
    private let musicName: String
    private let artistName: String
    private let musicPicture: String
    
    var audioPlayer: AVAudioPlayer?
    
    var disableAllClosure: (() -> Void)?
    var musicCardState: MusicCardState = .disabled {
        didSet{
            updateView()
        }
    }

//MARK: - Lifecycle
    
    init(index: Int, musicName: String, artistName: String, musicPicture: String) {
        self.index = index
        self.artistName = artistName
        self.musicName = musicName
        self.musicPicture = musicPicture
        super.init(frame: .zero)
        setupView()
        setupSubviews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

//MARK: - Internal methods
    
    func setupAudioPlayer(_ url: URL) {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.delegate = self
        } catch {
            print("Error initializing AVAudioPlayer: \(error)")
        }
    }
    
    func disableCard() {
        musicCardState = .disabled
        audioPlayer?.pause()
        
    }
    
//MARK: - Private methods
    
    private func updateState() {
        switch musicCardState {
        case .disabled:
            musicCardState = .played
        case .played:
            musicCardState = .paused
        case .paused:
            musicCardState = .played
        }
    }
    
    private func updateView() {
        switch musicCardState {
        case .disabled:
            stateButton.setImage(Image.playFill.image, for: .normal)
            stateButton.isHidden = true
            detailsButton.isHidden = true
            self.backgroundColor = .clear
            numberLabel.isHidden = false
            editButton.isHidden = false
            trashButton.isHidden = false
            audioPlayer?.stop()
        case .played:
            stateButton.setImage(Image.pause.image, for: .normal)
            stateButton.isHidden = false
            detailsButton.isHidden = false
            self.backgroundColor = UIColor(red: 34/255, green: 39/255, blue: 56/255, alpha: 1.0)
            numberLabel.isHidden = true
            editButton.isHidden = true
            trashButton.isHidden = true
            audioPlayer?.play()
        case .paused:
            stateButton.setImage(Image.playFill.image, for: .normal)
            self.backgroundColor = UIColor(red: 34/255, green: 39/255, blue: 56/255, alpha: 1.0)
            audioPlayer?.stop()
        }
    }
    
//MARK: - Setup methods
    
    private func setupView() {
        self.layer.cornerRadius = 12.0
        self.heightAnchor.constraint(equalToConstant: 76.0).isActive = true
        
        titleLabel.text = musicName
        subTitleLabel.text = artistName
        trackPicture.image = UIImage(named: musicPicture)
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(musicCardAction))
        self.addGestureRecognizer(gesture)
        stateButton.addTarget(self, action: #selector(musicCardAction), for: .touchUpInside)
    }
    
    private func setupSubviews() {
        self.addSubview(stateButton)
        self.addSubview(numberLabel)
        self.addSubview(trackPicture)
        self.addSubview(titleLabel)
        self.addSubview(subTitleLabel)
        self.addSubview(detailsButton)
        self.addSubview(trashButton)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            stateButton.heightAnchor.constraint(equalToConstant: 16.0),
            stateButton.widthAnchor.constraint(equalToConstant: 16.0),
            stateButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            stateButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16.0),
            
            numberLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            numberLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16.0),
            
            trackPicture.heightAnchor.constraint(equalToConstant: 44.0),
            trackPicture.widthAnchor.constraint(equalToConstant: 44.0),
            trackPicture.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            trackPicture.leftAnchor.constraint(equalTo: stateButton.rightAnchor, constant: 8.0),
            
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 16.0),
            titleLabel.leftAnchor.constraint(equalTo: trackPicture.rightAnchor, constant: 16.0),
            
            subTitleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16.0),
            subTitleLabel.leftAnchor.constraint(equalTo: trackPicture.rightAnchor, constant: 16.0),
            
            detailsButton.heightAnchor.constraint(equalToConstant: 16.0),
            detailsButton.widthAnchor.constraint(equalToConstant: 16.0),
            detailsButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            detailsButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16.0),
            
            trashButton.heightAnchor.constraint(equalToConstant: 16.0),
            trashButton.widthAnchor.constraint(equalToConstant: 16.0),
            trashButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            trashButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16.0),
        ])
    }
    

//MARK: - Button Actions
    
    @objc private func musicCardAction() {
        disableAllClosure?()
        updateState()
    }
    
    
//MARK: - UI Elements
    
    private lazy var numberLabel: UILabel = {
        let label = UILabel()
        label.text = "\(index)"
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = Color.neutral100.color
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()
    
    private let stateButton: UIButton = {
        let button = UIButton()
        button.setImage(Image.playFill.image, for: .normal)
        button.tintColor = Color.neutral100.color
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = true
        return button
    } ()
    
    private let detailsButton: UIButton = {
        let button = UIButton()
        button.setImage(Image.settings.image, for: .normal)
        button.tintColor = Color.neutral72.color
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = true
        return button
    } ()
    
    private let trashButton: UIButton = {
        let button = UIButton()
        button.setImage(Image.trash.image, for: .normal)
        button.tintColor = Color.neutral72.color
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    } ()
    
    private let editButton: UIButton = {
        let button = UIButton()
        button.setImage(Image.pencil.image, for: .normal)
        button.tintColor = Color.neutral72.color
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    } ()
    
    private let trackPicture: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 3.0
        return image
    } ()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Color.neutral100.color
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        label.text = "Permission to Dance"
        return label
    }()
    
    private let subTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Color.neutral72.color
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.text = "Angelo Rodrigez"
        return label
    }()
    
}

extension MusicCardView: AVAudioPlayerDelegate {
    
}
