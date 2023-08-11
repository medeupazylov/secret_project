//
//  ButtonsCollectionViewCell.swift
//  Muslink
//
//  Created by Аброрбек on 05.08.2023.
//

import UIKit

final class ButtonsCollectionViewCell: UICollectionViewCell {
    
    static let identifier = String(describing: ButtonsCollectionViewCell.self)
    
    //MARK: - Properties
    
    var title = "" {
        didSet {
            titleLabel.text = title
        }
    }
    
    //MARK: - LifeCycle
    
    override init(frame: CGRect){
        super.init(frame: frame)
        setupView()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        contentView.backgroundColor = Color.neutral16.color
    }
        
    //MARK: - Setup
    
    private func setupView(){
        contentView.layer.cornerRadius = 10
        contentView.backgroundColor = Color.neutral16.color
        
        contentView.addSubview(titleLabel)
    }
    
    private func setupLayout(){
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
        ])
    }
    
    //MARK: - Internal methods
    
    func select() -> Bool {
        if contentView.backgroundColor == Color.primaryMain.color {
            contentView.backgroundColor = Color.neutral16.color
            return false
        } else {
            contentView.backgroundColor = Color.primaryMain.color
            return true
        }
    }
    
    func getType() -> String {
        return titleLabel.text ?? ""
    }
    
    //MARK: - UI Elements
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = Color.neutral100.color
        label.textAlignment = .center
        label.backgroundColor = .clear
        label.layer.masksToBounds = true
        
        return label
    }()
}
