//
//  PlayerStackView.swift
//  Muslink
//
//  Created by Aisha Nurgaliyeva on 23.08.2023.
//

import UIKit

class PlayerStackView: UIStackView {
    
    var timer = Timer()
    
    var totalTime = 20
    var secondsPassed = 0
    lazy var secondsLeft = totalTime - secondsPassed
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        setupConstraints()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    let playButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "play_button"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(PlayerStackView.self, action: #selector(playButtonPressed), for: .touchUpInside)
        return button
    }()
                   
    var progressBar = DefaultProgressBar()
    
    
    
    var trackLabel = DefaultLabel(text: "Permission to Dance",
                                  textColor: Color.neutral100.color,
                                  fontSize: 16.0,
                                  fontWeight: .regular)

    lazy var secondsLabel = DefaultLabel(text: "- 0:\(secondsLeft)",
                                         textColor: Color.neutral32.color,
                                         fontSize: 13.0,
                                         fontWeight: .light)
    
    lazy var verticalStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8.0
        stack.alignment = .leading
        stack.distribution = .fill
        stack.addArrangedSubview(trackLabel)
        stack.addArrangedSubview(progressStack)
        return stack
    }()
    
    lazy var progressStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.addArrangedSubview(progressBar)
        stack.addArrangedSubview(secondsLabel)
        stack.spacing = 12.0
        stack.alignment = .center
        return stack
    }()
    
    
    private func setup() {
        axis = .horizontal
        spacing = 16.0
        translatesAutoresizingMaskIntoConstraints = false
        addArrangedSubview(playButton)
        addArrangedSubview(verticalStack)
        alignment = .fill
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            self.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            
            playButton.widthAnchor.constraint(equalToConstant: 48.0),
            playButton.heightAnchor.constraint(equalToConstant: 48.0),
            
            trackLabel.heightAnchor.constraint(equalToConstant: 24.0),
            
            progressBar.heightAnchor.constraint(equalToConstant: 1.0),
            
            progressStack.heightAnchor.constraint(equalToConstant: 12.0),
            progressStack.widthAnchor.constraint(equalTo: verticalStack.widthAnchor),
            
            
            
        ])
    }
    
    @objc func updateTimer() {
        if secondsPassed < totalTime {
            secondsPassed += 1
            progressBar.progress = Float(secondsPassed) / Float(totalTime)
            print(Float(secondsPassed) / Float(totalTime))
        } else {
            timer.invalidate()
        }
    }
    
    @objc func playButtonPressed() {
        timer.invalidate()
        progressBar.progress = 0
        timer = Timer.scheduledTimer(timeInterval: 1.0, target:self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        
    }
}


