//
//  ChooseMoodViewController.swift
//  Muslink
//
//  Created by Аброрбек on 05.08.2023.
//

import UIKit

final class DescriptionViewController: UIViewController {
    
    //MARK: - Properties
    
    //MARK: - Lifecycle
    
//    init(viewModel: ArtistRegistrationViewModel) {
//        self.viewModel = viewModel
//        super.init(nibName: nil, bundle: nil)
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupObservers()
//        hideKeyboardWhenTappedAround()
        setupLayout()
        setupNavigationBar()
    }
    
    //MARK: - UI elements
    
    private let scrollView: UIScrollView = {
         let scroll = UIScrollView()
         scroll.translatesAutoresizingMaskIntoConstraints = false
         scroll.showsVerticalScrollIndicator = false
         scroll.alwaysBounceVertical = true
         
         return scroll
     }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = "Расскажите о треке"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = Color.neutral100.color
        label.backgroundColor = Color.primaryBgColor.color
        label.textAlignment = .left
        label.numberOfLines = 2
        
        return label
    }()
    
    private let progressView: DefaultProgressBar = {
        let progressView = DefaultProgressBar()
        progressView.updateProgress(withScreenOrder: 1)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        return progressView
    }()
    
    
    private lazy var continueButton: DefaultButton = {
        let button = DefaultButton(buttonType: .primary)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(title: "Продолжить")
        button.addTarget(self, action: #selector(nextButtonPressed), for: .touchUpInside)
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.5
        button.layer.shadowOffset = CGSize(width: 2, height: 2)
        button.layer.shadowRadius = 4
        return button
    }()
    
    private lazy var descriptionTextView: CustomTextView = {
        let textView = CustomTextView(delegate: self)
        textView.translatesAutoresizingMaskIntoConstraints = false

        textView.layer.cornerRadius = 10

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

    //MARK: - Setup

    private func setupLayout() {
        view.backgroundColor = Color.primaryBgColor.color
        view.addSubview(progressView)
        view.addSubview(scrollView)
        view.addSubview(continueButton)

        // Add UI elements to the scrollView
        scrollView.addSubview(titleLabel)
        scrollView.addSubview(descriptionTextView)
        scrollView.addSubview(letterCountLabel)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: progressView.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            progressView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            progressView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 16),
            progressView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            progressView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 30),
        ])
        
        NSLayoutConstraint.activate([
            descriptionTextView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            descriptionTextView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            descriptionTextView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            descriptionTextView.heightAnchor.constraint(greaterThanOrEqualToConstant: 200)
        ])
        
        NSLayoutConstraint.activate([
            continueButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16.0),
            continueButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16.0),
            continueButton.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -16.0),
        ])
        
        NSLayoutConstraint.activate([
            letterCountLabel.topAnchor.constraint(equalTo: descriptionTextView.bottomAnchor, constant: 8),
            letterCountLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            letterCountLabel.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
    }
    
    func setupNavigationBar() {
        let title = UILabel()
        title.text = "Профиль музыканта"
        title.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        title.textColor = Color.neutral100.color
        navigationItem.titleView = title
        let item = UIBarButtonItem(image: UIImage(named: "chevron_left"), style: .done, target: self, action: #selector(moveBack))
        item.tintColor = Color.neutral72.color
        navigationItem.leftBarButtonItem = item
    }
    
    //MARK: - Objective-c methods
    
    private func setupObservers() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    @objc func keyboardWillShow(notification:NSNotification) {

        guard let userInfo = notification.userInfo else { return }
        var keyboardFrame:CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)

        var contentInset:UIEdgeInsets = self.scrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height + 20
        scrollView.contentInset = contentInset

    }

    @objc func keyboardWillHide(notification:NSNotification) {

        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInset
    }
    
    @objc
    private func nextButtonPressed() {
        print("heerreer")
        navigationController?.pushViewController(GoalsViewController(), animated: false)
    }
    
    @objc
    private func moveBack() {
        navigationController?.popViewController(animated: false)
    }
}

//MARK: - UITextViewDelegate

extension DescriptionViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "История написания, чем вы вдохновлялись и другие детали" {
            textView.text = nil
        }
        textView.textColor = Color.neutral80.color
    }
    
    func textViewDidChange(_ textView: UITextView) {
        letterCountLabel.text = "\(textView.text.count)/500"
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "История написания, чем вы вдохновлялись и другие детали"
            textView.textColor = Color.neutral32.color
        }
    }
}
