//
//  TrackSendedViewController.swift
//  Muslink
//
//  Created by Aisha Nurgaliyeva on 13.08.2023.
//

import UIKit

class TrackSentViewController: UIViewController {
    

    //MARK: - Properties

    private var imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "rocket"))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private var profileButton: DefaultButton = {
        let button = DefaultButton(buttonType: .bordered)
        button.setTitle(title: "Профиль")
        return button
    }()
    
    private var applictionsButton: DefaultButton = {
        let button = DefaultButton(buttonType: .primary)
        button.setTitle(title: "Мои заявки")
        button.layer.shadowColor = UIColor.clear.cgColor
        return button
    }()

    private lazy var buttonsStack = VerticalStackView(arrangedSubviews: [profileButton, applictionsButton], spacing: 12.0)
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = Color.neutral100.color
        label.font = .systemFont(ofSize: 20.0, weight: .bold)
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.19
        paragraphStyle.alignment = .center
        label.numberOfLines = 0
        label.attributedText = NSMutableAttributedString(string: "Ваш трек успешно \n отправлен лейблам",
                                                         attributes: [NSAttributedString.Key.kern: 0.4,          NSAttributedString.Key.paragraphStyle: paragraphStyle])
        label.clipsToBounds = true
        return label
    }()
    
    private var subtitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .natural
        label.textColor = Color.neutral80.color
        label.font = .systemFont(ofSize: 16.0, weight: .regular)
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.28
        paragraphStyle.alignment = .center
        label.numberOfLines = 0
        label.attributedText = NSMutableAttributedString(string: "Вы можете отслеживать статус заявок \n в разделе «Мои заявки»",
                                                        attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        return label
    }()
    
    private lazy var textStack = VerticalStackView(arrangedSubviews: [titleLabel, subtitleLabel])
    
    private lazy var contentStackView = VerticalStackView(arrangedSubviews: [UIView(),imageView, textStack, buttonsStack,UIView()], spacing: 24.0)

    private func setupView() {
        view.backgroundColor = UIColor(white: 0, alpha: 0.7) // 50% transparent black
        textStack.clipsToBounds = true
        titleLabel.clipsToBounds = true
        subtitleLabel.clipsToBounds = true
        view.addSubview(contentStackView)
        contentStackView.backgroundColor = Color.elevatedBgColor.color
        contentStackView.layer.cornerRadius = 12.0
    }
    
    
    //MARK: - App Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupLayout()
    }
    
    
    //MARK: - Functions
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: 180
            ),
            contentStackView.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                constant: 24
            ),
            contentStackView.bottomAnchor.constraint(
                lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor
            ),
            contentStackView.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                constant: -24
            )
        ])
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 96.0),
            imageView.heightAnchor.constraint(equalToConstant: 96.0)
        ])
        
        NSLayoutConstraint.activate([
            buttonsStack.leadingAnchor.constraint(equalTo: contentStackView.leadingAnchor, constant: 16),
            buttonsStack.trailingAnchor.constraint(equalTo: contentStackView.trailingAnchor, constant: -16),
        ])
        
    }
    
    @objc func buttonTapped() {
        
    }
    

}
