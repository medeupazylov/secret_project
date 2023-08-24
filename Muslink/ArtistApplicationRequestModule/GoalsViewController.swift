//
//  GoalsViewController.swift
//  Muslink
//
//  Created by Aisha Nurgaliyeva on 16.08.2023.
//

import UIKit

class GoalsViewController: UIViewController {
    
    private let continueButton: DefaultButton = {
        let button = DefaultButton(buttonType: .primary)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(title: "Продолжить")
        return button
    }()
    
    var cellIdentifier = "goalCell"
    
    private var progressBar = DefaultProgressBar()
    
    private var titleLabel = DefaultLabel(text: "Укажите вашу цель",
                                          textColor: Color.neutral100.color,
                                          fontSize: 18.0,
                                          fontWeight: .bold)
    
    private var goals = [Goal(title: "Помощь с дистрибуцией", checked: false),
                         Goal(title: "Маркетинг и продвижение", checked: false),
                         Goal(title: "Организация концертов и туров", checked: false),
                         Goal(title: "Лицензирование и синхронизации", checked: false),
                         Goal(title: "Сбор роялти и учет", checked: false),
                         Goal(title: "Выход на международные рынки", checked: false),
                         Goal(title: "Юридическое сопровождение", checked: false),
                         Goal(title: "Запись и производство музыки", checked: false)
                        ]
    
    private var selectedGoalsTitles = [String]()
    
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
        let item = UIBarButtonItem(image: UIImage(named: "chevron_left"), style: .done, target: self, action: #selector(moveBack))
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
        view.addSubview(continueButton)
        progressBar.progress = 0.5
        continueButton.addTarget(self, action: #selector(nextButtonPressed), for: .touchUpInside)
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
            progressBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            progressBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            progressBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            titleLabel.topAnchor.constraint(equalTo: progressBar.bottomAnchor, constant: 40),
            titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 32),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            continueButton.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -16.0),
            continueButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            continueButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
        ])
    }
    
    func goalsChanged() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    @objc
    private func nextButtonPressed() {
        navigationController?.pushViewController(ChooseLabelViewController(), animated: false)
    }
    
    @objc
    private func moveBack() {
        navigationController?.popViewController(animated: false)
    }
}

extension GoalsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        goals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! GoalsTableViewCell
        cell.goal = goals[indexPath.row]
        cell.index = indexPath.row
        cell.onToggleChecked = { [weak self] index in
            guard let self = self else {return}
            self.goals[index].checked = !self.goals[index].checked
            self.tableView.reloadData()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        goals[indexPath.row].checked = !goals[indexPath.row].checked
        goalsChanged()
    }
    
}
