import UIKit

final class MusicianInfoViewController: UIViewController {
    
    //MARK: - Properties
    
    private var images: [String] = ["musician", "musician2", "musician3"]
    private let cellIdentifier = "PhotoCarouselCell"
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Color.primaryBgColor.color
        setupView()
        setupLayout()
    }
    
    //MARK: - UI Elements
    
    private let contentStackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.spacing = 24
        view.axis = .vertical
        view.distribution = .fill
        view.alignment = .leading
        
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Об исполнителе"
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        label.textColor = Color.neutral100.color
        label.backgroundColor = Color.primaryBgColor.color
        label.textAlignment = .left
        return label
    }()
    
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = images.count
        pageControl.pageIndicatorTintColor = Color.neutral16.color
        pageControl.currentPageIndicatorTintColor = Color.neutral100.color
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.addTarget(self, action: #selector(pageControlAction), for: .valueChanged)
        return pageControl
    }()
    
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
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    private var descriptionLabel: UILabel {
        let label = UILabel()
        label.text = "Молодой исполнитель атмосферной, ангельской готроники, одновременно и яркой, и мрачной и жуткой музыки. Тромбон, пронзительная скрипка, виолончель, гитарные саундскейпы и глубокий бас, чарующие многоголосые вокальные наслоения, прихотливые ударные петли — сочетание живых инструментов и безукоризненной электроники создают уникальное звучание и настроение. Одна из самых странных и любопытных европейских околоджазовых групп."
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.textColor = Color.neutral72.color
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }
    
    private var socialNetworksStack: SocialNetworksStackView = {
        let stack = SocialNetworksStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    } ()
    
    private lazy var musicianNameStack = MusicianNameStack()
    
    @objc private func pageControlAction(_ sender: UIPageControl?) {
        guard let sender = sender else {return}
        let index = sender.currentPage
        
        collectionView.isPagingEnabled = false
        collectionView.scrollToItem(at: IndexPath(row: index, section: 0), at: .centeredHorizontally, animated: true)
        collectionView.isPagingEnabled = true
    }
    
    //MARK: - Setup
    
    private func setupView() {
        contentStackView.addArrangedSubview(titleLabel)
        contentStackView.addArrangedSubview(collectionView)
        contentStackView.setCustomSpacing( 10, after: collectionView)
        contentStackView.addArrangedSubview(pageControl)
        contentStackView.addArrangedSubview(socialNetworksStack)
        contentStackView.addArrangedSubview(descriptionLabel)
        
        view.addSubview(contentStackView)
        view.addSubview(musicianNameStack)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: 10
            ),
            contentStackView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 16
            ),
            contentStackView.bottomAnchor.constraint(
                equalTo: view.bottomAnchor, constant: -30
            ),
            contentStackView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -16
            ),
        ])
        
        NSLayoutConstraint.activate([
            collectionView.heightAnchor.constraint(equalToConstant: 278),
            collectionView.leadingAnchor.constraint(equalTo: contentStackView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentStackView.trailingAnchor),
            
            pageControl.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor),
            
            socialNetworksStack.leadingAnchor.constraint(equalTo: contentStackView.leadingAnchor),
            socialNetworksStack.trailingAnchor.constraint(equalTo: contentStackView.trailingAnchor),
            
            musicianNameStack.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor),
            musicianNameStack.bottomAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: -30)
        ])
    }
}

extension MusicianInfoViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? PhotoCarouselCell else {
            return UICollectionViewCell()
        }
    
        print(indexPath)
        cell.imageView.image = UIImage(named: images[indexPath.item])
        return cell
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }
        
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        self.pageControl.currentPage = Int(scrollView.contentOffset.x / width)
    }
}
