//
//  TrackDescriptionViewController.swift
//  Muslink
//
//  Created by Aisha Nurgaliyeva on 23.08.2023.
//

import UIKit

class TrackDescriptionViewController: UIViewController, UITextViewDelegate {
    
    //MARK: - Properties
    
    var trackName: String
    
    //MARK: - UI Elements
    
    lazy var trackLabel = DefaultLabel(text: "\(trackName)",
                                  textColor: Color.neutral100.color,
                                  fontSize: 16.0,
                                  fontWeight: .bold)
    
    lazy var trackTextView: CustomTextView = {
        let textView = CustomTextView(delegate: self)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.layer.cornerRadius = 12.0
        textView.isUserInteractionEnabled  = false
        textView.text = "Трек «Синтетический Ритм» переносит в будущее через электронные пульсации звуков. Начиная с нежных звуков, трек превращается в мощные волны электронных битов, словно рассказывая историю синтетической жизни. Каждый такт наполняется энергией, пульсируя чувства. Середина трека погружает в цифровое пространство, раскрывая новые возможности технологий. «Синтетический Ритм» оставляет отпечаток будущего в настоящем. Середина трека погружает в цифровое пространство, раскрывая новые возможности технологий"
        textView.setTextColor(color: Color.neutral80.color)
        return textView
    }()
    
    //MARK: - App Lifecycle

    init(trackName: String = "") {
        self.trackName = trackName
        super.init(nibName: nil, bundle: nil)
    }
  
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Color.primaryBgColor.color
        view.addSubview(trackLabel)
        view.addSubview(trackTextView)
        
        setupConstraints()
    }
    
    //MARK: - Setup Functions
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            trackLabel.topAnchor.constraint(equalTo: view.topAnchor),
            trackLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            trackLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            
            trackTextView.topAnchor.constraint(equalTo: trackLabel.bottomAnchor, constant: 16.0),
            trackTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            trackTextView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            trackTextView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
        ])
    }
    

}
