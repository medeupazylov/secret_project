//
//  MusicianInfoViewController.swift
//  Muslink
//
//  Created by Aisha Nurgaliyeva on 06.08.2023.
//


import UIKit

class MusicianInfoViewController: UIViewController {
    
    private lazy var titleLabel = DefaultLabel(text: "Об исполнителе", textColor: Color.neutral100.color, fontSize: 15, fontWeight: .bold)
    
    private lazy var musicianPhotoView = MusicianPhotoView()
    
    private lazy var mainStack = VerticalStackView(arrangedSubviews: [titleLabel, musicianPhotoView, socialNetworkStack, descriptionLabel], spacing: 24)
    
    private lazy var socialNetworkStack = SocialNetworksStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
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
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12),
            mainStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            mainStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
//            mainStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30)
        ])
//        NSLayoutConstraint.activate([
//            musicianPhotoView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
//            musicianPhotoView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16)
//        ])
    }
}
