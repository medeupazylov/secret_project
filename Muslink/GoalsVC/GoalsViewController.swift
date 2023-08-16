//
//  GoalsViewController.swift
//  Muslink
//
//  Created by Aisha Nurgaliyeva on 16.08.2023.
//

import UIKit

class GoalsViewController: UIViewController {
    
    var cellIdentifier = "cellIdentifier"
    
    private var progressBar = DefaultProgressBar()
    
    private var titleLabel = DefaultLabel(text: "Укажите вашу цель",
                                          textColor: Color.neutral100.color,
                                          fontSize: 18.0,
                                          fontWeight: .bold)
    
    private var goals = ["Помощь с дистрибуцией",
                         "Маркетинг и продвижение",
                         "Организация концертов и туров",
                         "Лицензирование и синхронизации",
                         "Сбор роялти и учет",
                         "Выход на международные рынки",
                         "Юридическое сопровождение",
                         "Запись и производство музыки",
                        ]
    
    private var tableView = ContentSizedTableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupNavigationBar()
        setConstraints()
    }

    private func setupNavigationBar() {
        let title = UILabel()
        title.text = NSLocalizedString("Новая заявка", comment: "")
        title.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        title.textColor = Color.neutral100.color
        navigationItem.titleView = title
        let item = UIBarButtonItem(image: UIImage(named: "chevron_left"), style: .done, target: nil, action: nil)
        item.tintColor = Color.neutral72.color
        navigationItem.leftBarButtonItem = item
        
        let closeButton = UIBarButtonItem(image: Image.close.image, style: .done, target: nil, action: nil)
        closeButton.tintColor = Color.neutral72.color
        navigationItem.rightBarButtonItem = closeButton
    }
    
    private func setupView() {
        setupTableView()
        view.backgroundColor = Color.primaryBgColor.color
        view.addSubview(progressBar)
        view.addSubview(titleLabel)
        view.addSubview(tableView)
        progressBar.progress = 0.5
    }
    
    private func setupTableView() {
        tableView.separatorColor = .clear
        tableView.backgroundColor = .clear
        tableView.register(GoalsTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            progressBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            progressBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            progressBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            titleLabel.topAnchor.constraint(equalTo: progressBar.bottomAnchor, constant: 40),
            titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 32),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
        ])
    }
}

extension GoalsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        goals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! GoalsTableViewCell
        cell.titleLabel.text = goals[indexPath.row]
        return cell
    }
    
    
}
