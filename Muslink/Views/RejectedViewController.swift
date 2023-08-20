//
//  RejectionViewController.swift
//  Muslink
//
//  Created by Aisha Nurgaliyeva on 19.08.2023.
//

import UIKit

class RejectedViewController: UIViewController {
    
    let titleLabel = DefaultLabel(text: "Причина отказа",
                                  textColor: Color.neutral100.color,
                                  fontSize: 20.0,
                                  fontWeight: .bold)
    
    private let sendButton: DefaultButton = {
        let button = DefaultButton(buttonType: .primary)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(title: "Отправить")
        return button
    }()

    let tableView = ContentSizedTableView()
    
    var cellId = "reasonsCell"
    
    private var reasons = [Reason(title: "Плохое качество записи", checked: false),
                           Reason(title: "Нереалистичные цели", checked: false),
                           Reason(title: "Не соответствие тематике лейбла", checked: false),
                           Reason(title: "Самопрезентация", checked: false),
                           Reason(title: "Качество исполнения", checked: false)
                        ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
    }
    
    func setupView() {
        view.backgroundColor = Color.elevatedBgColor.color
        view.addSubview(titleLabel)
        view.addSubview(tableView)
        view.addSubview(sendButton)
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.separatorColor = .clear
        tableView.backgroundColor = .clear
        tableView.register(ReasonsTableViewCell.self, forCellReuseIdentifier: cellId)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isScrollEnabled = false
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            titleLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 24),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            sendButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -32),
            sendButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            sendButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
        ])
    }
}

extension RejectedViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        reasons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ReasonsTableViewCell
        cell.reason = reasons[indexPath.row]
        cell.index = indexPath.row
        cell.onToggleChecked = { [weak self] index in
            guard let self = self else {return}
            self.reasons[index].checked = !reasons[index].checked
            self.tableView.reloadData()
            print("AAAAAA")
            print(reasons)
        }
        return cell
    }
    
    
}
