//
//  ProfileHeaderViewController.swift
//  Muslink
//
//  Created by Arystan on 06.08.2023.
//

import Foundation
import UIKit

final class ProfileHeaderViewController: UIViewController {
    
    private var context: [String] = ["classical music", "film music", "instrumental", "neo / modern classical", "solo piano"]
    
    private let avatar: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(named: "pic")
        img.contentMode = .scaleAspectFill
//        img.contentMode = .scaleAspectFit
        
        return img
    }()
    
    private let gradientLayer: CAGradientLayer = {
        let gradient = CAGradientLayer()
//        gradient.frame = imageView.bounds
        gradient.colors = [UIColor.clear.cgColor, UIColor.black.cgColor, UIColor.black.cgColor, UIColor.clear.cgColor]
        gradient.locations = [0.5, 0.1, 0.1, 0.6]
        return gradient
    }()
    
    private let fullName: UILabel = {
        let label = UILabel()
        label.text = "Angelo Rodrigez"
        label.textColor = Color.neutral100.color
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
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
        addGradientToAvatar()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateGradientFrame()
    }
    
    private func addGradientToAvatar() {
        avatar.layer.addSublayer(gradientLayer)
        updateGradientFrame()
    }
    
    private func updateGradientFrame() {
        gradientLayer.frame = avatar.bounds
    }
    
    
    private func setupUI() {
        view.backgroundColor = Color.bgColor20.color
        view.addSubview(avatar)
        view.addSubview(fullName)
        view.addSubview(playButton)
        view.addSubview(statisticsView)
        view.addSubview(collectionView)
        
        avatar.layer.addSublayer(gradientLayer)
        gradientLayer.frame = avatar.bounds
        statisticsView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            avatar.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            avatar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            avatar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            avatar.heightAnchor.constraint(equalToConstant: 338),
            
            fullName.topAnchor.constraint(equalTo: avatar.bottomAnchor, constant: -52),
            fullName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            playButton.topAnchor.constraint(equalTo: avatar.bottomAnchor, constant: -76),
            playButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            statisticsView.topAnchor.constraint(equalTo: avatar.bottomAnchor, constant: 32),
            statisticsView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            statisticsView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            collectionView.topAnchor.constraint(equalTo: statisticsView.bottomAnchor, constant: 32),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            collectionView.heightAnchor.constraint(equalToConstant: 120),
            collectionView.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor)
        ])
        
        addGradientToAvatar()
    }
}


extension ProfileHeaderViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return context.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ButtonsCollectionViewCell.identifier, for: indexPath)  as? ButtonsCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.title = context[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(
            width: (context[indexPath.item].size(withAttributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14)]).width ) + 25,
            height: 40)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.collectionView {
            guard let selectedCell = collectionView.cellForItem(at: indexPath as IndexPath) as? ButtonsCollectionViewCell else { return }
            selectedCell.select()
        }
    }
    
}
