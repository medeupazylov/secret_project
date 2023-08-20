//
//  RejectionViewController.swift
//  Muslink
//
//  Created by Aisha Nurgaliyeva on 19.08.2023.
//

import UIKit

class RejectedViewController: UIViewController, UIScrollViewDelegate {
    
    //MARK: - Properties

    private let commentLabel = DefaultLabel(text: "Комментарии лейбла",
                                            textColor: Color.neutral100.color,
                                            fontSize: 16.0,
                                            fontWeight: .bold)
    
    let tableView = ContentSizedTableView()
    
    private let closeButton = CloseButton()
    
    private var selectedReasonsTitles = [String]()
    
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
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .clear
        scrollView.frame = view.frame
        scrollView.isScrollEnabled = true
        scrollView.addSubview(tableView)
        scrollView.addSubview(commentLabel)
        scrollView.addSubview(textView)
        scrollView.addSubview(letterCountLabel)
        scrollView.addSubview(sendButton)
        scrollView.isUserInteractionEnabled = true
        scrollView.alwaysBounceVertical = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.keyboardDismissMode = .interactive
        scrollView.contentSize = CGSize(width: scrollView.frame.width, height: scrollView.frame.height)
        return scrollView
    }()
    
    private let sendButton: DefaultButton = {
        let button = DefaultButton(buttonType: .primary)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(title: "Отправить")
        return button
    }()
    
    //MARK: - App Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
        setupObservers()
    }
    
    
    //MARK: - Functions
    
    func reasonsChanged() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func setupNavigationBar() {
        let title = UILabel()
        title.text = "Причина отказа"
        title.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        title.textColor = Color.neutral100.color
        navigationItem.titleView = title
        let item = UIBarButtonItem(image: UIImage(systemName: "xmark.circle.fill"), style: .done, target: self, action: #selector(dismissController))
        item.tintColor = Color.neutral16.color
        navigationItem.rightBarButtonItem = item
    }
    
    func setupView() {
        setupTableView()
        setupNavigationBar()
        view.backgroundColor = Color.elevatedBgColor.color
        view.addSubview(scrollView)
        scrollView.delegate = self
        sendButton.addTarget(self, action: #selector(sendButtonPressed), for: .touchUpInside)
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
            
            tableView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 24),
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
            
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
        ])
    }
    
    
    @objc private func dismissController() {
        self.dismiss(animated: true)
    }
    
    @objc private func sendButtonPressed() {
        for reason in reasons {
            if reason.checked {
                selectedReasonsTitles.append(reason.title)
            }
        }
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
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        reasons[indexPath.row].checked = !reasons[indexPath.row].checked
        reasonsChanged()
    }
}


//MARK: - TextView Configuration

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
    
    
    //MARK: - Keyboard Handling
        
    private func setupObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
        
    @objc func keyboardWillShow(_ notification: Notification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
            return
        }
        
        let keyboardHeight = keyboardFrame.height
        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight, right: 0)
        
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }

    @objc func keyboardWillHide(_ notification: Notification) {
        scrollView.contentInset = .zero
        scrollView.scrollIndicatorInsets = .zero
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        textView.endEditing(true)
        
    }

}
