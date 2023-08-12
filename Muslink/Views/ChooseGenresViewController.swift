//
//  ChooseMoodViewController.swift
//  Muslink
//
//  Created by Аброрбек on 05.08.2023.
//

import UIKit

final class ChooseGenresViewController: UIViewController {
    
    //MARK: - Properties
    
    private let viewModel: ArtistRegistrationViewModel
    
    private var context: [String] = ["агресcивное", "весеннее", "грустное", "зимнее", "красивое", "крутое", "лето", "мечтательное", "мистическое", "мрачное", "новый год", "осеннее", "радостное", "отдыхаю", "сентиментальное", "спокойное", "энергичное", "эпичное"]
    
    private var selectedGenres: [Genre] = []
    
    //MARK: - Lifecycle
    
    init(viewModel: ArtistRegistrationViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        collectionView.dataSource = self
        collectionView.delegate = self
        setupNavigationBar()
    }
    
    //MARK: - UI elements
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = "Выберите жанры, которые лучшe всего описывают вашу музыку"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = Color.neutral100.color
        label.backgroundColor = Color.primaryBgColor.color
        label.textAlignment = .left
        label.numberOfLines = 2
        
        return label
    }()
    
    private let progressView: DefaultProgressBar = {
        let progressView = DefaultProgressBar()
        progressView.updateProgress(withScreenOrder: 3)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        return progressView
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
    
    private lazy var continueButton: DefaultButton = {
        let button = DefaultButton(buttonType: .primary)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(title: "Продолжить")
        button.addTarget(self, action: #selector(nextButtonPressed), for: .touchUpInside)
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.5
        button.layer.shadowOffset = CGSize(width: 2, height: 2)
        button.layer.shadowRadius = 4
        return button
    }()
    
    //MARK: - Setup
    
    private func setupLayout() {
        view.backgroundColor = Color.primaryBgColor.color
        view.addSubview(titleLabel)
        view.addSubview(progressView)
        view.addSubview(collectionView)
        view.addSubview(continueButton)
        
        NSLayoutConstraint.activate([
            progressView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            progressView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            progressView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            progressView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: progressView.safeAreaLayoutGuide.bottomAnchor, constant: 30),
        ])
        
        // Constraints for tableView
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 14),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            collectionView.heightAnchor.constraint(equalToConstant: 500)
        ])
        
        NSLayoutConstraint.activate([
            continueButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16.0),
            continueButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16.0),
            continueButton.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -12.0),
        ])
    }
    
    func setupNavigationBar() {
        let title = UILabel()
        title.text = "Профиль музыканта"
        title.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        title.textColor = Color.neutral100.color
        navigationItem.titleView = title
        let item = UIBarButtonItem(image: UIImage(named: "chevron_left"), style: .done, target: self, action: #selector(moveBack))
        item.tintColor = Color.neutral72.color
        navigationItem.leftBarButtonItem = item
    }
    
    //MARK: - Objective-c methods
    
    @objc
    private func nextButtonPressed() {
        viewModel.userDidEnterGenres(genres: selectedGenres)
        navigationController?.pushViewController(ChoosePhotoViewController(viewModel: viewModel), animated: false)
    }
    
    @objc
    private func moveBack() {
        navigationController?.popViewController(animated: false)
    }
}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout

extension ChooseGenresViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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
            width: (context[indexPath.item].size(
                withAttributes:
                    [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14)]).width) + 25,
                height: 40
            )
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.collectionView {
            guard let selectedCell = collectionView.cellForItem(at: indexPath as IndexPath) as? ButtonsCollectionViewCell else { return }
            let isSelected = selectedCell.select()
            let text = selectedCell.getType()
            if isSelected {
                selectedGenres.append(Genre(name: text))
            } else {
                if let index = selectedGenres.firstIndex(where: {
                    $0.name == text
                }) {
                    selectedGenres.remove(at: index)
                }
            }
        }
    }
}
