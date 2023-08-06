//
//  ChoseCityView.swift
//  Muslink
//
//  Created by Arystan on 05.08.2023.
//

import Foundation
import UIKit

final class ChoseCityView: UIViewController {
    
    var chosenCityIndex: IndexPath?
    let page = CitiesTable()
    
    private lazy var titleLabel = createLabel(text: "Откуда вы", fontSize: 18, color: Color.neutral100.color)
    private lazy var cityLabel = createLabel(text: "Город", fontSize: 14, color: Color.neutral32.color)
    private lazy var choseLabel = createLabel(text: "Выберите город", fontSize: 16, color: Color.neutral80.color)
    private let button = DefaultButton(buttonType: .primary)
    
    private let chevronIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Image.chevronDown.image
        imageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        return imageView
    }()
   
    private lazy var cityButton: UIControl = {
        let button = UIControl()
        button.addSubview(choseLabel)
        button.addSubview(chevronIcon)
        button.backgroundColor = Color.neutral32.color
        button.layer.cornerRadius = 10
        
        choseLabel.translatesAutoresizingMaskIntoConstraints = false
        chevronIcon.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            choseLabel.leadingAnchor.constraint(equalTo: button.leadingAnchor, constant: 12),
            choseLabel.centerYAnchor.constraint(equalTo: button.centerYAnchor),
            chevronIcon.centerYAnchor.constraint(equalTo: button.centerYAnchor),
            chevronIcon.trailingAnchor.constraint(equalTo: button.trailingAnchor, constant: -12),
            button.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        return button
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Color.primaryBgColor.color
        setupUI()
        setupNavigationBar()
        button.isEnabled = false
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
    
    private func createLabel(text: String, fontSize: CGFloat, color: UIColor) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = color
        label.font = UIFont(name: "YSText-Bold", size: fontSize)
        
        return label
    }
    
    private func updateChoseLabel(city: String) {
        choseLabel.text = city
    }
    
    private func setupUI() {
        cityButton.addTarget(self, action: #selector(radioButtonTapped), for: .touchUpInside)

        view.addSubview(titleLabel)
        view.addSubview(cityLabel)
        view.addSubview(cityButton)
        view.addSubview(button)
        
        button.setTitle(title: "Продолжить")
        button.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        cityButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            cityLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            cityLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            cityButton.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 8),
            cityButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            cityButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
    @objc private func radioButtonTapped() {
        page.delegate = self
        page.updateChosenCity(index: chosenCityIndex ?? nil)
        self.present(page, animated: true)
    }
}

extension ChoseCityView: ChosenCityDelegate {
    func chosenCity(index: IndexPath?, city: String?) {
        updateChoseLabel(city: city!)
        chosenCityIndex = index
    }
}
