//
//  ProfileHeaderViewController.swift
//  Muslink
//
//  Created by Arystan on 06.08.2023.
//

import Foundation
import UIKit

final class ProfileHeaderViewController: UIViewController {
    
    private let name: String
    private let city: String
    private let genres: [String]
    private let image: UIImage
    
    init(name: String = "Angelo Rodriguez", city: String = "Москва", genres: [String] = [], image: UIImage = UIImage(named: "pic")!) {
        self.name = name
        self.city = city
        self.genres = genres
        self.image = image
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private lazy var avatar: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = image
        img.clipsToBounds = true
        img.contentMode = .scaleAspectFill
        return img
    }()
    
    lazy var gradientLayer: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.type = .axial
        gradient.colors = [
            UIColor.clear.cgColor,
            Color.primaryBgColor.color.cgColor
        ]
        gradient.locations = [0, 1]
        return gradient
    }()
    
    lazy var gradientLayer2: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.type = .axial
        gradient.colors = [
            Color.primaryBgColor.color.cgColor,
            UIColor.clear.cgColor,
            UIColor.clear.cgColor,
        ]
        gradient.locations = [0,0.1, 1]
        return gradient
    } ()
    
    private lazy var fullName: UILabel = {
        let label = UILabel()
        label.text = name
        label.textColor = Color.neutral100.color
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var cityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = city
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = Color.neutral100.color
        return label
    } ()
    
    private let locationLogo: UIImageView = {
        let image = UIImageView(image: Image.mapPin.image)
        image.translatesAutoresizingMaskIntoConstraints = false
        image.tintColor = Color.neutral100.color
        return image
    } ()
    
    private let playButton: UIButton = {
       let button = UIButton()
        button.setImage(UIImage(named: "play_button"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = CustomViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.isUserInteractionEnabled = false
        collection.isScrollEnabled = false
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.showsHorizontalScrollIndicator = false
        collection.clipsToBounds = false
        collection.backgroundColor = Color.primaryBgColor.color
        collection.register(ButtonsCollectionViewCell.self, forCellWithReuseIdentifier: ButtonsCollectionViewCell.identifier)
        return collection
    }()
    
    private let statisticsView = StatisticsView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        setupUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradientLayer.frame = avatar.bounds
        avatar.layer.addSublayer(gradientLayer)
        
        gradientLayer2.frame = view.bounds
        view.layer.addSublayer(gradientLayer2)
    }
    
    private func setupUI() {
        view.backgroundColor = Color.primaryBgColor.color
        view.addSubview(avatar)
        view.addSubview(fullName)
        view.addSubview(locationLogo)
        view.addSubview(cityLabel)
        view.addSubview(playButton)
        view.addSubview(statisticsView)
        view.addSubview(collectionView)
        
        statisticsView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            avatar.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            avatar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            avatar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            avatar.heightAnchor.constraint(equalToConstant: 338),
            
            fullName.topAnchor.constraint(equalTo: avatar.bottomAnchor, constant: -52),
            fullName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            locationLogo.leadingAnchor.constraint(equalTo: fullName.leadingAnchor),
            locationLogo.topAnchor.constraint(equalTo: fullName.bottomAnchor, constant: 12),
            locationLogo.heightAnchor.constraint(equalToConstant: 16),
            locationLogo.widthAnchor.constraint(equalToConstant: 16),
            
            cityLabel.leadingAnchor.constraint(equalTo: locationLogo.trailingAnchor, constant: 8.0),
            cityLabel.centerYAnchor.constraint(equalTo: locationLogo.centerYAnchor),
            
            playButton.topAnchor.constraint(equalTo: avatar.bottomAnchor, constant: -76),
            playButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            statisticsView.topAnchor.constraint(equalTo: avatar.bottomAnchor, constant: 32),
            statisticsView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            statisticsView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            collectionView.topAnchor.constraint(equalTo: statisticsView.bottomAnchor, constant: 32),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            collectionView.heightAnchor.constraint(equalToConstant: 100),
            collectionView.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor)
        ])
        
        
    }
}


extension ProfileHeaderViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return genres.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ButtonsCollectionViewCell.identifier, for: indexPath)  as? ButtonsCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.title = genres[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(
            width: (genres[indexPath.item].size(withAttributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14)]).width ) + 25,
            height: 40)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.collectionView {
            guard let selectedCell = collectionView.cellForItem(at: indexPath as IndexPath) as? ButtonsCollectionViewCell else { return }
            selectedCell.select()
        }
    }
    
}
