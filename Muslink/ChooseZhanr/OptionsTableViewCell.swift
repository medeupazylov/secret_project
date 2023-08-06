//
//  OptionsTableViewCell.swift
//  Muslink
//
//  Created by Аброрбек on 05.08.2023.
//

import UIKit

final class OptionsTableViewCell: UITableViewCell {

    static let identifier = String(describing: OptionsTableViewCell.self)
    
    //MARK: - Propersties
    
    private var context: [String]?

    //MARK: - LifeCycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        setupView()
        setupLayout()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        contentView.endEditing(true)
    }
    
    //MARK: - Setup
    
    private func setupView(){
        contentView.backgroundColor = Color.primaryBgColor.color
        collectionView.dataSource = self
        collectionView.delegate = self
        mainView.addSubview(collectionView)
        mainView.addSubview(titleLabel)
        contentView.addSubview(mainView)
    }
    
    private func setupLayout(){
        
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            mainView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -32),
            mainView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            mainView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: mainView.topAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 24),
            titleLabel.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            collectionView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor),
            collectionView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
            collectionView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor)
        ])
    }
    
    //MARK: - Internal methods
    
    func configureCell(context: [String], title: String){
        self.context = context
        self.titleLabel.text = title
    }
    
    //MARK: - UI Elements
    
    private let mainView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Color.primaryBgColor.color
        
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = Color.neutral100.color
        label.backgroundColor = Color.primaryBgColor.color
        label.textAlignment = .left

        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 12

        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.isScrollEnabled = false
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.showsHorizontalScrollIndicator = false
        collection.clipsToBounds = false
        collection.backgroundColor = Color.primaryBgColor.color
        collection.register(ButtonsCollectionViewCell.self, forCellWithReuseIdentifier: ButtonsCollectionViewCell.identifier)
        
        return collection
    }()
}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout extesnion

extension OptionsTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return context?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ButtonsCollectionViewCell.identifier, for: indexPath)  as? ButtonsCollectionViewCell else {
            return UICollectionViewCell()
        }
        guard let context = context else { return UICollectionViewCell() }
        cell.title = context[indexPath.row]

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(
            width: (context?[indexPath.item].size(withAttributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 12)]).width ?? 65) + 25,
                height: 40)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.collectionView {
            guard let selectedCell = collectionView.cellForItem(at: indexPath as IndexPath) as? ButtonsCollectionViewCell else { return }
            selectedCell.select()
        }
    }
    
}
