//
//  AcceptedViewController.swift
//  Muslink
//
//  Created by Aisha Nurgaliyeva on 20.08.2023.
//

import UIKit

class AcceptedViewController: UIViewController, UIScrollViewDelegate {
    
    //MARK: - UI Elements

    private let commentLabel = DefaultLabel(text: "Комментарии лейбла",
                                            textColor: Color.neutral100.color,
                                            fontSize: 16.0,
                                            fontWeight: .bold)
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Мы отправим ваши контактные данные исполнителю, и он свяжется с вами"
        label.textColor = Color.neutral72.color
        label.font = UIFont.systemFont(ofSize: 16.0, weight: .bold)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var textView: CustomTextView = {
        let textView = CustomTextView(delegate: self)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.layer.cornerRadius = 12.0
        textView.text = "Скажите исполнителю, что он молодец :)"
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

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .clear
        scrollView.frame = view.frame
        scrollView.addSubview(descriptionLabel)
        scrollView.addSubview(commentLabel)
        scrollView.addSubview(textView)
        scrollView.addSubview(letterCountLabel)
        scrollView.addSubview(sendButton)
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
    
    func setupNavigationBar() {
            let title = UILabel()
            title.text = "Это мэтч!"
            title.font = UIFont.systemFont(ofSize: 17, weight: .bold)
            title.textColor = Color.neutral100.color
            navigationItem.titleView = title
            let item = UIBarButtonItem(image: UIImage(systemName: "xmark.circle.fill"),
                                       style: .done, target: self, action: #selector(dismissController))
            item.tintColor = Color.neutral16.color
            navigationItem.rightBarButtonItem = item
        }
    
    
    func setupView() {
        setupNavigationBar()
        view.backgroundColor = Color.elevatedBgColor.color
        view.addSubview(scrollView)
        scrollView.delegate = self
        sendButton.addTarget(self, action: #selector(sendButtonPressed), for: .touchUpInside)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([

            descriptionLabel.topAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            commentLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 32),
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
        
    }
}

//MARK: - TextView Configuration

extension AcceptedViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "Скажите исполнителю, что он молодец :)" {
            textView.text = nil
        }
        textView.textColor = Color.neutral80.color
    }
        
    func textViewDidChange(_ textView: UITextView) {
        letterCountLabel.text = "\(textView.text.count)/500"
    }
        
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Скажите исполнителю, что он молодец :)"
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












