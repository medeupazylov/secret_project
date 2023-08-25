//
//  TrackLoadViewController.swift
//  Muslink
//
//  Created by Медеу Пазылов on 18.08.2023.
//

import UIKit

struct LanguageItem: SearchItem {
    var title: String
    var id: Int
}

struct GenreItem: SearchItem {
    var title: String
    var id: Int
}

class TrackLoadViewController: UIViewController {
    
    let genres = [
        "Поп",
        "Рок",
        "Хип-хоп",
        "Электронная",
        "Джаз",
        "R&B",
        "Кантри",
        "Регги",
        "Классическая",
        "Блюз",
        "Фолк",
        "Метал",
        "Панк",
        "Фанк",
        "Соул",
        "ЭДМ"
    ]
    
    var selectedGenres: [String] = []
    
    let moods = [
        "Радостное",
        "Меланхоличное",
        "Энергичное",
        "Спокойное",
        "Вдохновенное",
        "Грустное",
        "Веселое",
        "Умиротворенное",
        "Романтичное",
        "Агрессивное",
        "Тоскливое",
        "Бодрое"
    ]
    
    var selectedMoods: [String] = []
    
    var currenLanguage: SearchItem?
    var currentGenre: SearchItem?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Color.primaryBgColor.color
        setupNavigationBar()
        setupViews()
        setupLayout()
        setupGestures()
        
        genreCollectionView.dataSource = self
        genreCollectionView.delegate = self
        
        moodCollectionView.dataSource = self
        moodCollectionView.delegate = self
    }
    
    private func setupGestures() {
        let languageTapGesture = UITapGestureRecognizer(target: self, action: #selector(chooseTrackLanguage))
        trackLanguageTextField.addGestureRecognizer(languageTapGesture)
        let genreTapGesture = UITapGestureRecognizer(target: self, action: #selector(chooseTrackGenre))
        trackGenreTextField.addGestureRecognizer(genreTapGesture)
        continueButton.addTarget(self, action: #selector(nextButtonPressed), for: .touchUpInside)
    }
    
    
    private func setupNavigationBar() {
        let title = UILabel()
        title.text = NSLocalizedString("Новая заявка", comment: "")
        title.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        title.textColor = Color.neutral100.color
        navigationItem.titleView = title
        let itemleft = UIBarButtonItem(image: Image.chevronLeft.image, style: .done, target: nil, action: nil)
        itemleft.tintColor = Color.neutral72.color
        navigationItem.leftBarButtonItem = itemleft
        let itemright = UIBarButtonItem(image: Image.close.image, style: .done, target: nil, action: nil)
        itemright.tintColor = Color.neutral72.color
        navigationItem.rightBarButtonItem = itemright
    }
    
    private func addNewVC(vc: UIViewController) {
        addChild(vc)
        vc.view.translatesAutoresizingMaskIntoConstraints = false
        stack.addArrangedSubview(vc.view)

        NSLayoutConstraint.activate([
            vc.view.leftAnchor.constraint(equalTo: view.leftAnchor),
            vc.view.rightAnchor.constraint(equalTo: view.rightAnchor),
        ])
        vc.didMove(toParent: self)
    }
    
    func setupViews() {
        view.addSubview(progressView)
        view.addSubview(mainScroll)
        view.addSubview(continueButton)
        mainScroll.addSubview(stack)
        stack.addArrangedSubview(titleLabel)
        stack.addArrangedSubview(segmentedControl)
        addNewVC(vc: AudioPlayerViewController())
        stack.addArrangedSubview(trackNameTextField)
        stack.setCustomSpacing(16, after: trackNameTextField)
        stack.addArrangedSubview(trackLanguageTextField)
        stack.setCustomSpacing(16, after: trackLanguageTextField)
        stack.addArrangedSubview(trackGenreTextField)
        stack.addArrangedSubview(subGenreTitleLabel)
        stack.addArrangedSubview(genreCollectionView)
        stack.addArrangedSubview(moodTitleLabel)
        stack.addArrangedSubview(moodCollectionView)
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            progressView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            progressView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 16),
            progressView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            progressView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            mainScroll.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainScroll.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainScroll.topAnchor.constraint(equalTo: progressView.bottomAnchor, constant: 6.0),
            mainScroll.bottomAnchor.constraint(equalTo: continueButton.topAnchor),
        
            stack.topAnchor.constraint(equalTo: mainScroll.topAnchor, constant: 32.0),
            stack.bottomAnchor.constraint(equalTo: mainScroll.bottomAnchor, constant: -32),
            
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16.0),
            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16.0),
            segmentedControl.heightAnchor.constraint(equalToConstant: 44.0),
            
            trackNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16.0),
            trackNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16.0),
            trackNameTextField.heightAnchor.constraint(equalToConstant: 56),
            trackLanguageTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16.0),
            trackLanguageTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16.0),
            trackLanguageTextField.heightAnchor.constraint(equalToConstant: 56),
            trackGenreTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16.0),
            trackGenreTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16.0),
            trackGenreTextField.heightAnchor.constraint(equalToConstant: 56),
            
            continueButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16.0),
            continueButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16.0),
            continueButton.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -16.0),
        ])
        
        NSLayoutConstraint.activate([
            genreCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            genreCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            genreCollectionView.heightAnchor.constraint(equalToConstant: 208)
        ])
        
        NSLayoutConstraint.activate([
            moodCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            moodCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            moodCollectionView.heightAnchor.constraint(equalToConstant: 208)
        ])
    }
    
    @objc func chooseTrackLanguage(_ sender: UITapGestureRecognizer) {
        let page = SearchTableView(title: "Язык трека")
        page.data = [LanguageItem(title: "Русский", id: 1),
                     LanguageItem(title: "Казахский", id: 2),
                     LanguageItem(title: "Английский", id: 3),
                     LanguageItem(title: "Французский", id: 4),
                     LanguageItem(title: "Итальянский", id: 5),
                     LanguageItem(title: "Испанский", id: 6),
        ]
        page.delegate = self
        page.chosenItem = currenLanguage
        page.searchController.searchBar.text = nil
        let tt = UINavigationController(rootViewController: page)
        if let sheet = tt.sheetPresentationController {
            sheet.detents = [.medium()]
        }
        self.present(tt, animated: true)
    }
    
    @objc func chooseTrackGenre(_ sender: UITapGestureRecognizer) {
        let page = SearchTableView(title: "Жанр трека")
        page.data = [GenreItem(title: "Поп", id: 1),
                     GenreItem(title: "Диско", id: 2),
                     GenreItem(title: "Рок", id: 3),
                     GenreItem(title: "Электроника", id: 4),
                     GenreItem(title: "Метал", id: 5),
                     GenreItem(title: "Альтернатива", id: 6),
                     GenreItem(title: "Блюз", id: 7),
                     GenreItem(title: "Регги", id: 8),
                     GenreItem(title: "Панк", id: 9),
        ]
        page.delegate = self
        page.chosenItem = currentGenre
        page.searchController.searchBar.text = nil
        let tt = UINavigationController(rootViewController: page)
        if let sheet = tt.sheetPresentationController {
            sheet.detents = [.medium()]
        }
        self.present(tt, animated: true)
    }
    
    @objc
    private func nextButtonPressed() {
        navigationController?.pushViewController(DescriptionViewController(), animated: false)
    }
    
    //MARK: - UIElements
    private let progressView: DefaultProgressBar = {
        let progressView = DefaultProgressBar()
        progressView.updateProgress(withScreenOrder: 0)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        return progressView
    }()
    
    private let mainScroll: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.backgroundColor = Color.primaryBgColor.color
        scroll.bounces = true
        return scroll
    } ()
    
    private let stack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 32.0
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    } ()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Color.neutral100.color
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.text = "Информация о треке"
        return label
    }()
    
    private let segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["Загрузить трек", "Выбрать трек"])
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.backgroundColor = Color.elevatedBgColor.color
        segmentedControl.selectedSegmentTintColor = Color.neutral16.color
        segmentedControl.setTitleTextAttributes([
            .font : UIFont.systemFont(ofSize: 15, weight: .bold),
            .foregroundColor : Color.neutral100.color
        ], for: .selected)
        segmentedControl.setTitleTextAttributes([
            .font : UIFont.systemFont(ofSize: 15, weight: .bold),
            .foregroundColor : Color.neutral72.color
        ], for: .normal)
        return segmentedControl
    } ()
    
    lazy var trackNameTextField: DefaultTextField = {
        let textField = DefaultTextField(placeHolder: "Название трека", delegate: self, type: .special)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    } ()
    
    lazy var trackLanguageTextField: DefaultTextField = {
        let textField = DefaultTextField(placeHolder: "Язык трека", delegate: self, type: .specialDisabled)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    } ()
    
    lazy var trackGenreTextField: DefaultTextField = {
        let textField = DefaultTextField(placeHolder: "Основной жанр", delegate: self, type: .specialDisabled)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    } ()
    
    private let subGenreTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Выберите поджанры, которые лучше описывают ваш трек"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = Color.neutral100.color
        label.backgroundColor = Color.primaryBgColor.color
        label.textAlignment = .left
        label.numberOfLines = 2
        label.isHidden = true
        return label
    }()
    
    private lazy var genreCollectionView: UICollectionView = {
        let layout = CustomViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.isScrollEnabled = false
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.showsHorizontalScrollIndicator = false
        collection.clipsToBounds = false
        collection.backgroundColor = Color.primaryBgColor.color
        collection.isHidden = true
        collection.register(ButtonsCollectionViewCell.self, forCellWithReuseIdentifier: ButtonsCollectionViewCell.identifier)
        return collection
    }()
    
    private let moodTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Выберите настроение"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = Color.neutral100.color
        label.backgroundColor = Color.primaryBgColor.color
        label.textAlignment = .left
        label.numberOfLines = 2
        label.isHidden = true
        return label
    }()
    
    private lazy var moodCollectionView: UICollectionView = {
        let layout = CustomViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.isScrollEnabled = false
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.showsHorizontalScrollIndicator = false
        collection.clipsToBounds = false
        collection.backgroundColor = Color.primaryBgColor.color
        collection.isHidden = true
        collection.register(ButtonsCollectionViewCell.self, forCellWithReuseIdentifier: ButtonsCollectionViewCell.identifier)
        return collection
    }()
    
    private let continueButton: DefaultButton = {
        let button = DefaultButton(buttonType: .primary)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(title: "Продолжить")
        return button
    } ()
        
}

extension TrackLoadViewController: ChosenItemDelegate {
    func chosenItem(index: IndexPath?, item: SearchItem?) {
        if let item = item as? LanguageItem {
            currenLanguage = item
            trackLanguageTextField.setText(text: item.title)
        } else if let item = item as? GenreItem {
            currentGenre = item
            trackGenreTextField.setText(text: item.title)
            UIView.animate(withDuration: 0.5, delay: 0.0, animations: {
                self.subGenreTitleLabel.isHidden = false
                self.genreCollectionView.isHidden = false
                self.moodTitleLabel.isHidden = false
                self.moodCollectionView.isHidden = false
            })
        }
    }
    
}

extension TrackLoadViewController: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
     
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextTextField = view.viewWithTag(textField.tag + 1) as? UITextField {
            nextTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }

        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != nil {
            continueButton.isEnabled = true
        }
        textField.resignFirstResponder()
        return true
    }
    
    private func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty == false {
            continueButton.isEnabled = true
        }
    }
}

extension TrackLoadViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case genreCollectionView:
            return genres.count
        case moodCollectionView:
            return moods.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ButtonsCollectionViewCell.identifier, for: indexPath)  as? ButtonsCollectionViewCell else {
            return UICollectionViewCell()
        }
        switch collectionView {
        case genreCollectionView:
            cell.title = genres[indexPath.row]
        case moodCollectionView:
            cell.title = moods[indexPath.row]
        default:
            return cell
        }
        

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var string = ""
        switch collectionView {
        case genreCollectionView:
            string = genres[indexPath.row]
        case moodCollectionView:
            string = moods[indexPath.row]
        default:
            string = ""
        }
        return CGSize(
            width: (string.size(
                withAttributes:
                    [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14)]).width) + 25,
                height: 40
            )
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        if collectionView == genreCollectionView {
            guard let selectedCell = collectionView.cellForItem(at: indexPath as IndexPath) as? ButtonsCollectionViewCell else { return }
            let isSelected = selectedCell.select()
            let text = selectedCell.getType()
            if isSelected {
                selectedGenres.append(text)
            } else {
                if let index = selectedGenres.firstIndex(where: {
                    $0 == text
                }) {
                    selectedGenres.remove(at: index)
                }
            }
        } else {
            guard let selectedCell = collectionView.cellForItem(at: indexPath as IndexPath) as? ButtonsCollectionViewCell else { return }
            let isSelected = selectedCell.select()
            let text = selectedCell.getType()
            if isSelected {
                selectedMoods.append(text)
            } else {
                if let index = selectedGenres.firstIndex(where: {
                    ($0 as! String) == text
                }) {
                    selectedMoods.remove(at: index)
                }
            }
        }
    }
}

