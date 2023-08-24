//
//  AudioPlayerViewController.swift
//  Muslink
//
//  Created by Медеу Пазылов on 18.08.2023.
//

import UIKit
import AVFoundation

enum AudioPlayerState {
    case empty
    case loaded
}

extension AudioPlayerViewController: UIDocumentPickerDelegate {
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let audioURL = urls.first else { return }
        setupAudioPlayer(audioURL)
        currentState = .loaded
    }
}


extension AudioPlayerViewController: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        timer?.invalidate()
        audioIsPlaying = false
        playButton.setImage(UIImage(named: "play_button"), for: .normal)
    }
}

class AudioPlayerViewController: UIViewController {
    
    var currentState: AudioPlayerState = .empty {
        didSet {
            updateView()
        }
    }
    var duration: TimeInterval!
    var cropTimeInterval: (TimeInterval, TimeInterval) = (0.0, 20.0)
    var audioPlayer: AVAudioPlayer?
    var audioIsPlaying: Bool = false
    var isCropingAudio: Bool = false
    var timer: Timer?
    
    var poinerLeadingConstraint: NSLayoutConstraint!
    var intervalDragPanGesture: UIPanGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupSynthesisView()
        setupLayout()
        setupGestures()
    }
    
    func setupDefaultConfigurations() {
        timer?.invalidate()
        playButton.setImage(UIImage(named: "play_button"), for: .normal)
        editButton.setImage(Image.pencil.image, for: .normal)
        setHPositionToPoiner(constant: 0)
        audioIsPlaying = false
        isCropingAudio = false
        intervalDragPanGesture.isEnabled = false
        currenTimeLabel.text = "\(formatTimeInterval(cropTimeInterval.0))"
    }
    
    func updateView() {
        cropTimeInterval = (0,20)
        changeCropViewInterval()
        setupDefaultConfigurations()
        switch currentState {
        case .empty:
            UIView.animate(withDuration: 0.3, delay: 0.0, animations: {
                self.loadedContainer.isHidden = true
                self.loadedContainer.layer.opacity = 0.0
                self.horizontalStackContainer.isHidden = true
                self.horizontalStackContainer.layer.opacity = 0.0
            })
            UIView.animate(withDuration: 0.3, delay: 0.0, animations: {
                self.loadButtonContainer.layer.opacity = 1.0
                self.loadButtonContainer.isHidden = false
            })
        case .loaded:
            UIView.animate(withDuration: 0.2, delay: 0.0, animations: {
                self.loadButtonContainer.layer.opacity = 0.0
                self.loadButtonContainer.isHidden = true
            })
            loadedContainer.layer.opacity = 0.0
            UIView.animate(withDuration: 0.5, delay: 0.0, animations: {
                self.loadedContainer.isHidden = false
                self.loadedContainer.layer.opacity = 1.0
                self.horizontalStackContainer.isHidden = false
                self.horizontalStackContainer.layer.opacity = 1.0
            })
        }
    }
    
    private func setupAudioPlayer(_ url: URL) {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.delegate = self
            guard let duration = audioPlayer?.duration else {return}
            self.duration = duration
            timer?.invalidate()
            endTimeLabel.text = formatTimeInterval(duration)
            changeCropViewInterval()
        } catch {
            print("Error initializing AVAudioPlayer: \(error)")
        }
    }
    
    @objc func editButtonAction(_ sender: Any?) {
        UIView.animate(withDuration: 0.3, delay: 0.0, animations: {
            self.horizontalStackContainer.isHidden = true
            self.horizontalStackContainer.layer.opacity = 0.0
        })
        if isCropingAudio {
            isCropingAudio = false
            editButton.setImage(Image.pencil.image, for: .normal)
            intervalDragPanGesture.isEnabled = false
        } else {
            isCropingAudio = true
            editButton.setImage(Image.check.image, for: .normal)
            intervalDragPanGesture.isEnabled = true
        }
    }
    
    @objc func deleteButtonAction(_ sender: Any?) {
        audioPlayer = nil
        currentState = .empty
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
    
    
    private func setupGestures() {
        loadButtonContainer.addTarget(self, action: #selector(loadAudioFromDevice), for: .touchUpInside)
        deleteButton.addTarget(self, action: #selector(deleteButtonAction), for: .touchUpInside)
        editButton.addTarget(self, action: #selector(editButtonAction), for: .touchUpInside)
        playButton.addTarget(self, action: #selector(playButtonAction), for: .touchUpInside)
        
        intervalDragPanGesture = UIPanGestureRecognizer(target: self, action: #selector(intervalDragAction))
        intervalDragPanGesture.isEnabled = false
        synthesisView.addGestureRecognizer(intervalDragPanGesture)
        
        let currentTimeDragPanGesture = UIPanGestureRecognizer(target: self, action: #selector(currentTimeDragAction))
        poinerView.addGestureRecognizer(currentTimeDragPanGesture)
    }
    
    @objc func playButtonAction() {
        guard let audioPlayer = audioPlayer else {return}
        print("playButtonAction")
        timer?.invalidate()
        if audioPlayer.isPlaying {
            audioPlayer.pause()
            playButton.setImage(UIImage(named: "play_button"), for: .normal)
            audioIsPlaying = false
        } else {
            audioPlayer.currentTime = cropTimeInterval.0
            audioPlayer.play()
            audioIsPlaying = true
            playButton.setImage(UIImage(named: "pause_button"), for: .normal)
            timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
        }
    }
    
    @objc private func currentTimeDragAction(_ sender: UIPanGestureRecognizer) {
        audioPlayer?.pause()
        timer?.invalidate()
        var translation = sender.location(in: synthesisView)
        if Double(translation.x) < 0 {
            translation.x = 1
        }
        if Double(translation.x) > Double(synthesisView.frame.width) {
            translation.x = synthesisView.frame.width-1
        }
        
        guard let audioPlayer = audioPlayer else {return}
        audioPlayer.currentTime = audioPlayer.duration * Double(translation.x/synthesisView.frame.width)
        setHPositionToPoiner(constant: translation.x)
        
        if sender.state == .ended && audioIsPlaying {
            audioPlayer.play()
            timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
        }
    }
    
    private func setHPositionToPoiner(constant: Double) {
        poinerLeadingConstraint.isActive = false
        poinerLeadingConstraint = poinerView.leadingAnchor.constraint(equalTo: synthesisView.leadingAnchor,constant: constant)
        poinerLeadingConstraint.isActive = true
    }
    
    @objc private func intervalDragAction(_ sender: UIPanGestureRecognizer) {
        let translation = sender.location(in: synthesisView)
        changeCropTimeInterval(translation: translation)
        changeCropViewInterval()
        print(cropTimeInterval)
    }
    
    private func changeCropTimeInterval(translation: CGPoint) {
        var pivotTime = duration * (translation.x/synthesisView.frame.width)
        if(pivotTime < 10) {
            cropTimeInterval = (0, 20)
        } else if (pivotTime > (duration-10)) {
            cropTimeInterval = (duration-20, duration)
        } else {
            cropTimeInterval = (pivotTime-10, pivotTime+10)
        }
    }
    
    
    private func changeCropViewInterval() {
        synthesisView.arrangedSubviews.forEach({ view in
            view.backgroundColor = Color.neutral72.color
        })
        for i in getRangeForCropView() {
            synthesisView.subviews[i].backgroundColor = Color.primaryMain.color
        }
    }
    
    private func getRangeForCropView() -> Range<Int> {
        let start = Int(50 * (cropTimeInterval.0/duration))
        var end = Int(50 * (cropTimeInterval.1/duration))
        print(start)
        print(end)
        if end == 50 {
            end-=1
        }
        return (start..<end+1)
    }
    
    @objc private func timerAction() {
        if let currentTime = audioPlayer?.currentTime {
            if currentTime >= cropTimeInterval.1 {
                audioPlayer?.pause()
                setupDefaultConfigurations()
                setHPositionToPoiner(constant: getConstraintConstant(currentTime: cropTimeInterval.0))
                return
            }
            currenTimeLabel.text = "\(formatTimeInterval(currentTime))"
            print(currentTime)
            setHPositionToPoiner(constant: getConstraintConstant(currentTime: currentTime))
        } else {
            print("Невозможно получить текущее время воспроизведения")
        }
    }
    
    private func getConstraintConstant(currentTime: TimeInterval) -> CGFloat {
        return CGFloat(synthesisView.frame.width * (currentTime/duration))
    }
    
    private func playInterval(startSeconds: TimeInterval, endSeconds: TimeInterval) {
        guard let audioPlayer = audioPlayer else { return }
        if startSeconds >= 0 && startSeconds < audioPlayer.duration
            && endSeconds > startSeconds && endSeconds <= audioPlayer.duration {
            audioPlayer.currentTime = startSeconds
            audioPlayer.play()
            
            let intervalDuration = endSeconds - startSeconds
            DispatchQueue.main.asyncAfter(deadline: .now() + intervalDuration) {
                audioPlayer.stop()
            }
        } else {
            print("Invalid interval range.")
        }
    }
    
    
    private let poinerView: UIView = {
        let line = UIView()
        line.backgroundColor = Color.accentMain.color
        line.translatesAutoresizingMaskIntoConstraints = false
        return line
    } ()
    
    private func formatTimeInterval(_ timeInterval: TimeInterval) -> String {
        let minutes = Int(timeInterval) / 60
        let seconds = Int(timeInterval) % 60
        return String(format: "%01d:%02d", minutes, seconds)
    }
    
    
    
    private let synthesisView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.backgroundColor = .clear
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .equalSpacing
        return stack
    } ()
    
    private let stackContainer: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .equalCentering
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 12
        return stack
    } ()
    
    private let loadButtonContainer: DefaultButton = {
        let button = DefaultButton(buttonType: .bordered)
        button.setTitle(title: "Загрузить с устройства")
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    } ()
    
    private let horizontalStackContainer: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        stack.alignment = .top
        stack.spacing = 8.0
        stack.isHidden = true
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let infoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Image.alert.image
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = Color.neutral72.color
        return imageView
    }()
    
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.text = "Выберите 20-секундный отрывок, который лейбл услышит в заявке"
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = Color.neutral80.color
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let loadedContainer: UIView = {
        let view = UIView()
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Color.elevatedBgColor.color
        view.layer.cornerRadius = 12.0
        return view
    } ()
    
    private let currenTimeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = Color.neutral72.color
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "0:00"
        return label
    } ()
    
    private let endTimeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = Color.neutral72.color
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "4:19"
        return label
    } ()
    
    private let deleteButton: UIButton = {
        let button = UIButton()
        button.setImage(Image.trash.image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = Color.neutral16.color
        button.layer.cornerRadius = 20.0
        button.tintColor = Color.neutral100.color
        return button
    }()
    
    private let playButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "play_button"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let editButton: UIButton = {
        let button = UIButton()
        button.setImage(Image.pencil.image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = Color.neutral16.color
        button.layer.cornerRadius = 20.0
        button.tintColor = Color.neutral100.color
        return button
    }()
    
}

//MARK: - Setup

extension AudioPlayerViewController {
    private func setupSynthesisView() {
        for _ in 0..<50 {
            let stick = UIView()
            stick.translatesAutoresizingMaskIntoConstraints = false
            stick.heightAnchor.constraint(equalToConstant: CGFloat.random(in: 5...44)).isActive = true
            stick.widthAnchor.constraint(equalToConstant: 2).isActive = true
            stick.layer.cornerRadius = 1.0
            stick.backgroundColor = Color.neutral72.color
            synthesisView.addArrangedSubview(stick)
        }
        synthesisView.addSubview(poinerView)
    }
    
    private func setupViews() {
        view.addSubview(stackContainer)
        horizontalStackContainer.addArrangedSubview(infoImageView)
        horizontalStackContainer.addArrangedSubview(infoLabel)
        stackContainer.addArrangedSubview(horizontalStackContainer)
        stackContainer.addArrangedSubview(loadedContainer)
        stackContainer.addArrangedSubview(loadButtonContainer)
        loadedContainer.addSubview(synthesisView)
        loadedContainer.addSubview(playButton)
        loadedContainer.addSubview(deleteButton)
        loadedContainer.addSubview(editButton)
        loadedContainer.addSubview(currenTimeLabel)
        loadedContainer.addSubview(endTimeLabel)
    }
    
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            stackContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16.0),
            stackContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16.0),
            stackContainer.topAnchor.constraint(equalTo: view.topAnchor),
            stackContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            infoImageView.heightAnchor.constraint(equalToConstant: 16),
            infoImageView.widthAnchor.constraint(equalToConstant: 16),
            
            loadedContainer.leadingAnchor.constraint(equalTo: stackContainer.leadingAnchor),
            loadedContainer.trailingAnchor.constraint(equalTo: stackContainer.trailingAnchor),
            loadedContainer.heightAnchor.constraint(equalToConstant: 156),
            
            synthesisView.leadingAnchor.constraint(equalTo: loadedContainer.leadingAnchor, constant: 16.0),
            synthesisView.trailingAnchor.constraint(equalTo: loadedContainer.trailingAnchor, constant: -16.0),
            synthesisView.topAnchor.constraint(equalTo: loadedContainer.topAnchor, constant: 16.0),
            synthesisView.heightAnchor.constraint(equalToConstant: 48),
            
            currenTimeLabel.leadingAnchor.constraint(equalTo: loadedContainer.leadingAnchor, constant: 16.0),
            currenTimeLabel.topAnchor.constraint(equalTo: synthesisView.bottomAnchor, constant: 8.0),
            
            endTimeLabel.trailingAnchor.constraint(equalTo: loadedContainer.trailingAnchor, constant: -16.0),
            endTimeLabel.topAnchor.constraint(equalTo: synthesisView.bottomAnchor, constant: 8.0),
            
            playButton.heightAnchor.constraint(equalToConstant: 48),
            playButton.widthAnchor.constraint(equalToConstant: 48),
            playButton.centerXAnchor.constraint(equalTo: loadedContainer.centerXAnchor),
            playButton.bottomAnchor.constraint(equalTo: loadedContainer.bottomAnchor, constant: -16),
            
            deleteButton.heightAnchor.constraint(equalToConstant: 40),
            deleteButton.widthAnchor.constraint(equalToConstant: 40),
            deleteButton.trailingAnchor.constraint(equalTo: playButton.leadingAnchor, constant: -40),
            deleteButton.centerYAnchor.constraint(equalTo: playButton.centerYAnchor),
            
            editButton.heightAnchor.constraint(equalToConstant: 40),
            editButton.widthAnchor.constraint(equalToConstant: 40),
            editButton.leadingAnchor.constraint(equalTo: playButton.trailingAnchor, constant: 40),
            editButton.centerYAnchor.constraint(equalTo: playButton.centerYAnchor),
        ])
        NSLayoutConstraint.activate([
            poinerView.heightAnchor.constraint(equalToConstant: 55),
            poinerView.centerYAnchor.constraint(equalTo: synthesisView.centerYAnchor),
            poinerView.widthAnchor.constraint(equalToConstant: 3),
        ])
        
        poinerLeadingConstraint = poinerView.leadingAnchor.constraint(equalTo: synthesisView.leadingAnchor)
        poinerLeadingConstraint?.isActive = true
    }
}



