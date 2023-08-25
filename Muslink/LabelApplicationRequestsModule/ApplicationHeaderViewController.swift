//
//  HeaderViewController.swift
//  Muslink
//
//  Created by Aisha Nurgaliyeva on 23.08.2023.
//

import UIKit

class ApplicationHeaderViewController: UIViewController {
    
    //MARK: - Properties
    
    var artistName: String
    var locationName: String
    var artistImageName: String
    
    private var genres: [Genre] = [Genre(id: 0, name: "английский"),
                                   Genre(id: 0, name: "электроника"),
                                   Genre(id: 0, name: "эмбиент"),
                                   Genre(id: 0, name: "ланж"),
                                   Genre(id: 0, name: "мечтательное"),
                                   Genre(id: 0, name: "спокойное")]
       
    //MARK: - UI Elements
    
    var containerStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 32.0
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    lazy var nameLabel = DefaultLabel(text: "\(artistName)",
                                 textColor: Color.neutral100.color,
                                 fontSize: 16.0,
                                 fontWeight: .bold)
    
    lazy var locationIcon: UIImageView = {
        let imageView = UIImageView(image: Image.location.image)
        imageView.tintColor = Color.neutral80.color
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var locationLabel = DefaultLabel(text: "\(locationName)",
                                                  textColor: Color.neutral80.color,
                                                  fontSize: 13,
                                                  fontWeight: .light)
    
    lazy var locationStack = HorizontalStackView(arrangedSubviews: [locationIcon,
                                                                    locationLabel])
    
    lazy var artistImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "\(artistImageName)"))
        imageView.layer.cornerRadius = 12.0
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var artistStackView: HorizontalStackView = {
        let stack = HorizontalStackView(arrangedSubviews: [artistImageView,
                                                           infoStack])
        stack.spacing = 24.0
        return stack
    }()
    
    private lazy var socialNetworksStack = HeaderSocialNetworks()
    
    private lazy var infoStack: VerticalStackView = {
        let stack = VerticalStackView(arrangedSubviews: [nameLabel,
                                                        locationStack,
                                                        socialNetworksStack])
        stack.setCustomSpacing(8.0, after: nameLabel)
        stack.setCustomSpacing(16.0, after: locationStack)
        stack.distribution = .fill
        stack.alignment = .leading
        return stack
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = CustomViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.isScrollEnabled = false
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.showsHorizontalScrollIndicator = false
        collection.clipsToBounds = false
        collection.backgroundColor = Color.primaryBgColor.color
        collection.register(ButtonsCollectionViewCell.self, forCellWithReuseIdentifier: ButtonsCollectionViewCell.identifier)
        return collection
    }()
    
    private lazy var separator = DefaultSeparator()
    
    private lazy var playerStack = PlayerStackView()
    
    //MARK: - App lifecycle
    
    init(artistName: String, locationName: String, artistImageName: String) {
        self.artistName = artistName
        self.locationName = locationName
        self.artistImageName = artistImageName
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupConstraints()
    }
    
    //MARK: - Setup Functions
    
    private func setup() {
        view.backgroundColor = Color.primaryBgColor.color
        containerStack.addArrangedSubview(artistStackView)
        containerStack.addArrangedSubview(separator)
        containerStack.addArrangedSubview(playerStack)
        containerStack.addArrangedSubview(collectionView)
        view.addSubview(containerStack)
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            containerStack.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 24.0),
            containerStack.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            containerStack.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            containerStack.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            infoStack.heightAnchor.constraint(equalToConstant: 96),
            
            artistImageView.heightAnchor.constraint(equalToConstant: 96),
            artistImageView.widthAnchor.constraint(equalToConstant: 96),
            
            
            collectionView.topAnchor.constraint(equalTo: playerStack.bottomAnchor, constant: 32),
            collectionView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo:view.layoutMarginsGuide.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 58)
  
        ])
    }
    
    
}

//MARK: - UICollectionView Configuration

extension ApplicationHeaderViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return genres.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ButtonsCollectionViewCell.identifier, for: indexPath)  as? ButtonsCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.title = genres[indexPath.row].name

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(
            width: (genres[indexPath.item].name.size(
                withAttributes:
                    [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14)]).width) + 25,
                height: 28
            )
        
    }
}
