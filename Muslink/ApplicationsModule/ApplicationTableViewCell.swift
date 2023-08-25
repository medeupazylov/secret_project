//
//  ApplicationTableViewCell.swift
//  Muslink
//
//  Created by Аброрбек on 18.08.2023.
//

import UIKit

final class ApplicationTableViewCell: UITableViewCell {
    
    //MARK: - Properties
    
    static let identifier = String(describing: ApplicationTableViewCell.self)
    weak var view: UIViewController?
    private var status: String?
    private var images: [UIImage?] = [UIImage(named: "hey_brother"), UIImage(named: "avatar"), UIImage(named: "musician"), UIImage(named: "musician2"), UIImage(named: "musician3")]
//    {
//        didSet {
//            switch status {
//            case .sent:
//                statusLabel.backgroundColor = Color.neutral16.color
//                statusLabel.textColor = Color.neutral100.color
//                statusLabel.text = status?.rawValue
//            case .viewed:
//                statusLabel.backgroundColor = Color.primaryFocus.color
//                statusLabel.textColor = Color.primaryHover.color
//                statusLabel.text = status?.rawValue
//            case .approved:
//                statusLabel.backgroundColor = Color.successBgColor.color
//                statusLabel.textColor = Color.successMain.color
//                statusLabel.text = status?.rawValue
//            case .declined:
//                statusLabel.backgroundColor = Color.dangerBgColor.color
//                statusLabel.textColor = Color.dangerMain.color
//                statusLabel.text = status?.rawValue
//            case .ignored:
//                statusLabel.backgroundColor = Color.infoBorder.color
//                statusLabel.textColor = Color.infoMain.color
//                statusLabel.text = status?.rawValue
//            case .none:
//                break
//            }
//        }
//    }
    
    private let mainView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.backgroundColor = Color.elevatedBgColor.color
        view.layer.cornerRadius = 12
        
        return view
    }()
    
    private let contentStackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false

        view.spacing = 15
        view.axis = .vertical

        return view
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setContentHuggingPriority(.defaultLow, for: .horizontal)
        label.textColor = Color.neutral100.color
        label.text = "12.08.2023"

        return label
    }()
    
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.layer.cornerRadius = 8
        label.textAlignment = .center
        label.clipsToBounds = true
        label.text = "Подробнее"
        label.backgroundColor = Color.neutral16.color
        label.textColor = Color.neutral100.color
        label.setContentHuggingPriority(.defaultHigh, for:.horizontal)
        
        return label
    }()
    
    private let upperHorizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let divider: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 0.2).isActive = true
        view.backgroundColor = UIColor.lightGray.withAlphaComponent(0.7)
        
        return view
    }()
    
    private let leiblLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = Color.neutral72.color
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Артист"
        return label
    }()
    
    private let middleHorizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let leiblNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = Color.neutral100.color
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let songImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.widthAnchor.constraint(equalToConstant: 48).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 48).isActive = true
        return imageView
    }()
    
    private let bottomHorizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let trackLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.text = "Трек"
        label.textColor = Color.neutral72.color
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let playButton: UIButton = {
       let button = UIButton()
        button.setImage(UIImage(named: "play_button"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return button
    }()
    
    private let trackNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = Color.neutral100.color
        label.setContentHuggingPriority(.defaultLow, for: .horizontal)
        
        label.backgroundColor = .clear

        return label
    }()
    
    private lazy var buttonStack = ButtonsStack()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = Color.primaryBgColor.color
        setupLayout()
        buttonStack.acceptButton.addTarget(view, action: #selector(acceptPressed), for: .touchUpInside)
        buttonStack.rejectButton.addTarget(view, action: #selector(rejectPressed), for: .touchUpInside)
    }
    
    @objc
    func acceptPressed() {
        view?.present(AcceptedViewController(), animated: true)
//        view?.navigationController?.pushViewController(AcceptedViewController(), animated: true)
    }
    
    @objc
    func rejectPressed() {
        view?.present(RejectedViewController(), animated: true)
//        view?.navigationController?.pushViewController(RejectedViewController(), animated: true)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        
        // Add subviews to stack views
        upperHorizontalStackView.addArrangedSubview(dateLabel)
        upperHorizontalStackView.addArrangedSubview(statusLabel)
        
        middleHorizontalStackView.addArrangedSubview(songImageView)
        middleHorizontalStackView.addArrangedSubview(leiblNameLabel)
        
        bottomHorizontalStackView.addArrangedSubview(playButton)
        bottomHorizontalStackView.addArrangedSubview(trackNameLabel)
        
        // Add stack views to vertical stack view
        contentStackView.addArrangedSubview(upperHorizontalStackView)
        contentStackView.addArrangedSubview(divider)
        contentStackView.addArrangedSubview(leiblLabel)
        contentStackView.addArrangedSubview(middleHorizontalStackView)
        contentStackView.addArrangedSubview(trackLabel)
        contentStackView.addArrangedSubview(bottomHorizontalStackView)
        contentStackView.addArrangedSubview(buttonStack)
        
        // Add vertical stack view to cell's content view
        
        contentView.addSubview(mainView)
        mainView.addSubview(contentStackView)
        
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 25),
            mainView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            mainView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            mainView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        // Set constraints
        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 16),
            contentStackView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 16),
            contentStackView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -16),
            contentStackView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            upperHorizontalStackView.heightAnchor.constraint(equalToConstant: 32),
            statusLabel.widthAnchor.constraint(equalToConstant: 98),
            statusLabel.heightAnchor.constraint(equalToConstant: 32)
        ])
    }
    
    func configure(with application: Application) {
        dateLabel.text = application.sendDate
        leiblNameLabel.text = application.pitch
        songImageView.image = images[Int.random(in: 0...4)]
        trackNameLabel.text = application.track.name
    }
}

struct CellData {
    let title: String
    let upperText: String
    let middleText: String
    let middleImage: UIImage?
    let bottomText: String
}

