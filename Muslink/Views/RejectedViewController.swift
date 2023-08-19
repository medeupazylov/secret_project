//
//  RejectionViewController.swift
//  Muslink
//
//  Created by Aisha Nurgaliyeva on 19.08.2023.
//

import UIKit

class RejectedViewController: UIViewController {
    
    //MARK: - Properties
    
    private let titleLabel = DefaultLabel(text: "Причина отказа",
                                  textColor: Color.neutral100.color,
                                  fontSize: 20.0,
                                  fontWeight: .bold)
    
    private let sendButton: DefaultButton = {
        let button = DefaultButton(buttonType: .primary)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(title: "Отправить")
        return button
    }()

    private let commentLabel = DefaultLabel(text: "Комментарии лейбла",
                                            textColor: Color.neutral100.color,
                                            fontSize: 16.0,
                                            fontWeight: .bold)
    
    let tableView = ContentSizedTableView()
    
    private lazy var textView: CustomTextView = {
        let textView = CustomTextView(delegate: self)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.layer.cornerRadius = 12.0
        textView.text = "Подскажите исполнителю как стать лучше"
        textView.setTextColor(color: Color.neutral32.color)
        return textView
    }()
    
    private let letterCountLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = UIFont.systemFont(ofSize: 14)
            label.textColor = Color.neutral72.color
            label.textAlignment = .right
            label.text = "0/500"
            return label
        }()


    
    var cellId = "reasonsCell"
    
    private var reasons = [Reason(title: "Плохое качество записи", checked: false),
                           Reason(title: "Нереалистичные цели", checked: false),
                           Reason(title: "Не соответствие тематике лейбла", checked: false),
                           Reason(title: "Самопрезентация", checked: false),
                           Reason(title: "Качество исполнения", checked: false)
                        ]
    
    
    //MARK: - App Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
    }
    
    
    //MARK: - Functions
    
    func setupView() {
        view.backgroundColor = Color.elevatedBgColor.color
        view.addSubview(titleLabel)
        view.addSubview(tableView)
        view.addSubview(commentLabel)
        view.addSubview(textView)
        view.addSubview(letterCountLabel)
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
            
            commentLabel.topAnchor.constraint(lessThanOrEqualTo: tableView.bottomAnchor, constant: 24),
            commentLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            commentLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            textView.topAnchor.constraint(equalTo: commentLabel.bottomAnchor, constant: 12),
            textView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            textView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            textView.heightAnchor.constraint(equalToConstant: 150),

            letterCountLabel.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: 8),
            letterCountLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            letterCountLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
        
            sendButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -32),
            sendButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            sendButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
        ])
    }
}


//MARK: - TableView Configuration

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

extension RejectedViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
            if textView.text == "Подскажите исполнителю как стать лучше" {
                textView.text = nil
            }
            textView.textColor = Color.neutral80.color
        }
        
        func textViewDidChange(_ textView: UITextView) {
            letterCountLabel.text = "\(textView.text.count)/500"
        }
        
        func textViewDidEndEditing(_ textView: UITextView) {
            if textView.text.isEmpty {
                textView.text = "Подскажите исполнителю как стать лучше"
                textView.textColor = Color.neutral32.color
            }
        }

}
