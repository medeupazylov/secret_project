//
//  FooterInfoViewController.swift
//  Muslink
//
//  Created by Aisha Nurgaliyeva on 20.08.2023.
//

import UIKit

class ApplicationFooterInfoViewController: UIViewController {
    
    //MARK: - Properties
    
    let cellIdentifier = "goalsIdentifier"
    
    private var goals = [Goal(title: "Помощь с дистрибуцией", checked: false),
                         Goal(title: "Создание и продажа мерча", checked: false),
                         Goal(title: "Выход на международные рынки", checked: false),
                         Goal(title: "Запись и производство музыки", checked: false)
                        ]
    
    //MARK: - UI Elements
    
    private var buttonStack = ButtonsStack()
    
    private let goalsLabel = DefaultLabel(text: "Цели",
                                          textColor: Color.neutral100.color,
                                          fontSize: 16.0,
                                          fontWeight: .bold)
    
    private var tableView = ContentSizedTableView()

    
    //MARK: - App Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Color.primaryBgColor.color
        setupTableView()
        view.addSubview(goalsLabel)
        view.addSubview(tableView)
        view.addSubview(buttonStack)
        setupConstraints()
    }

    //MARK: - Setup Functions
    
    private func setupTableView() {
        tableView.separatorColor = .clear
        tableView.backgroundColor = .clear
        tableView.register(GoalsTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            
            goalsLabel.topAnchor.constraint(equalTo: view.topAnchor),
            goalsLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            goalsLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            tableView.topAnchor.constraint(equalTo: goalsLabel.bottomAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            buttonStack.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 32),
            buttonStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            buttonStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            buttonStack.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -32)
        ])
    }
}

//MARK: - UITableView Configuration

extension ApplicationFooterInfoViewController: UITableViewDelegate, UITableViewDataSource {
    
    func goalsChanged() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        goals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! GoalsTableViewCell
        cell.goal = goals[indexPath.row]
        cell.index = indexPath.row
        cell.onToggleChecked = { [weak self] index in
            guard let self = self else {return}
            self.goals[index].checked = !goals[index].checked
            self.tableView.reloadData()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        goals[indexPath.row].checked = !goals[indexPath.row].checked
        goalsChanged()
    }
}
