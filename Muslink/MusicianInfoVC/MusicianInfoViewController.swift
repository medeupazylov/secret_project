//
//  MusicianInfoViewController.swift
//  Muslink
//
//  Created by Aisha Nurgaliyeva on 06.08.2023.
//


import UIKit

class MusicianInfoViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout , UICollectionViewDelegate {
    
    private lazy var titleLabel = DefaultLabel(text: "Об исполнителе", textColor: Color.neutral100.color, fontSize: 15, fontWeight: .bold)
    
    private lazy var musicianNameStack = MusicianNameStack()
    
    private lazy var mainStack = VerticalStackView(arrangedSubviews: [titleLabel, photoView, pageControl, socialNetworkStack, descriptionLabel], spacing: 24)
    
    private var photoView: PhotoView {
        let photoView = PhotoView()
        photoView.addSubview(collectionView)
        photoView.addSubview(musicianNameStack)
        photoView.heightAnchor.constraint(equalToConstant: 278).isActive = true
        musicianNameStack.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor).isActive = true
        musicianNameStack.bottomAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: -24).isActive = true
        return photoView
    }
    
    private lazy var socialNetworkStack = SocialNetworksStackView()
    
    private var pageControl: UIPageControl {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = images.count
        pageControl.pageIndicatorTintColor = Color.neutral16.color
        pageControl.currentPageIndicatorTintColor = Color.neutral100.color
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.addTarget(self, action: #selector(pageControlValueChanged), for: .valueChanged)
        pageControl.isUserInteractionEnabled = true
        return pageControl
    }
    
    
    //MARK: - Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupConstraints()
    }
    
    func setupNavigationBar() {
        let title = UILabel()
        title.text = "Профиль музыканта"
        title.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        title.textColor = Color.neutral100.color
        navigationItem.titleView = title
        let item = UIBarButtonItem(image: UIImage(named: "chevron_left"), style: .done, target: nil, action: nil)
        item.tintColor = Color.neutral72.color
        navigationItem.leftBarButtonItem = item
    }
    
    
    private var descriptionLabel: UILabel {
        let label = UILabel()
        label.text = "Молодой исполнитель атмосферной, ангельской готроники, одновременно и яркой, и мрачной и жуткой музыки. Тромбон, пронзительная скрипка, виолончель, гитарные саундскейпы и глубокий бас, чарующие многоголосые вокальные наслоения, прихотливые ударные петли — сочетание живых инструментов и безукоризненной электроники создают уникальное звучание и настроение. Одна из самых странных и любопытных европейских околоджазовых групп."
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.textColor = Color.neutral72.color
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }
    
    func setup(){
        view.backgroundColor = Color.primaryBgColor.color
        view.addSubview(mainStack)
//        mainStack.backgroundColor = Color.neutral16.color
        mainStack.distribution = .fillProportionally
        mainStack.alignment = .fill
        setupNavigationBar()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12),
            mainStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            mainStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16)
        ])
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            collectionView.heightAnchor.constraint(equalToConstant: 278)
        ])
    }
    
    @objc func pageControlValueChanged() {
        collectionView.scrollToItem(at: IndexPath(item: pageControl.currentPage, section: 0), at: .centeredHorizontally, animated: true)
        print("VALUE CHANGED")
        
    }
    
    
    //MARK: - CollectionView
    
    private var images: [String] = ["musician", "musician2", "musician3"]
    private let cellIdentifier = "PhotoCarouselCell"
        
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isPagingEnabled = true
        collectionView.register(PhotoCarouselCell.self, forCellWithReuseIdentifier: cellIdentifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.layer.cornerRadius = 10
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    

        //MARK: - UICollectionViewDataSource

        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return images.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! PhotoCarouselCell
            cell.imageView.image = UIImage(named: images[indexPath.item])
            pageControl.currentPage = indexPath.row
            return cell
        }
        
        //MARK: - UICollectionViewDelegateFlowLayout
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return collectionView.bounds.size
        }
    
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            let contentOffsetX = scrollView.contentOffset.x
            let pageWidth = scrollView.bounds.width
            let currentPage = Int(contentOffsetX / pageWidth)
        
            print("Content Offset X: \(contentOffsetX)")
            print("Page Width: \(pageWidth)")
            print("Current Page: \(currentPage)")
        
            pageControl.currentPage = currentPage
    }
    
        func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
            let width = scrollView.frame.width
            pageControl.currentPage = Int(scrollView.contentOffset.x / width)
            print("AAA")
        }
    
    
    
}
