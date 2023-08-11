//
//  CitiesCell.swift
//  Muslink
//
//  Created by Arystan on 05.08.2023.
//

import Foundation
import UIKit

final class CitiesCell: UITableViewCell {
    
    static let identifier = "CitiesCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        selectIcon.isHidden = true

    }
    private let city: UILabel = {
        let label = UILabel()
        label.textColor = Color.neutral80.color
        label.font = UIFont(name: "SF Pro Text", size: 17)
        
        return label
    }()
    
    private let selectIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Image.check.image
        imageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        imageView.isHidden = true
        
        return imageView
    }()
    
    private func setupUI() {
        self.contentView.addSubview(city)
        self.contentView.backgroundColor = Color.elevatedBgColor.color
        self.contentView.addSubview(selectIcon)
        
        city.translatesAutoresizingMaskIntoConstraints = false
        selectIcon.translatesAutoresizingMaskIntoConstraints = false
        selectIcon.tintColor = Color.accentMain.color
        
        
        NSLayoutConstraint.activate([
            city.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            city.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            selectIcon.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            selectIcon.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
        ])
    }
    
    func showSelectIcon() {
        selectIcon.isHidden = false
    }
    
    func hideSelectIcon() {
        selectIcon.isHidden = true
    }
    
    func configure(with data: String) {
        city.text = data
    }
    
}
