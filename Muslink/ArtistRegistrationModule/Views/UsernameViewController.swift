//
//  ViewController.swift
//  ABC
//
//  Created by Aisha on 04.08.2023.
//

import UIKit
import YandexLoginSDK

final class UsernameViewController: UIViewController {
    
    //MARK: - Properties
    
    private let viewModel: ArtistRegistrationViewModel
    private let window: UIWindow
    
    //MARK: - Lifecycle
    
    init(viewModel: ArtistRegistrationViewModel, window: UIWindow) {
        self.viewModel = viewModel
        self.window = window
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been")
    }
                   
    override func viewDidLoad() {
       super.viewDidLoad()
       view.backgroundColor = Color.primaryBgColor.color
        YXLSdk.shared.add(observer: self)
        YXLSdk.shared.authorize()
        viewModel.registerUser { result in
            switch result {
            case .success(_):
                print("success")
            case .failure(_):
                print("Error registering user")
            }
        }
        setupNavigationBar()
       setup()
    }

    //MARK: - UIKit Objects

    private var progressBar = DefaultProgressBar()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = "Как вас зовут"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = Color.neutral100.color
        label.backgroundColor = Color.primaryBgColor.color
        label.textAlignment = .left
        
        return label
    }()
    

    private var nameLabel = DefaultLabel(text: "Имя",
                                              textColor: Color.neutral72.color,
                                              fontSize: 13.0,
                                              fontWeight: .regular)
    
    private lazy var nameTextField = DefaultTextField(placeHolder: "Введите имя",
                                                      delegate: self)
    
    var nameWarningLabel = DefaultLabel(text: "Максимальное количество символов: 50", textColor: Color.dangerMain.color, fontSize: 13.0, fontWeight: .regular)
    
    private lazy var nameStack = VerticalStackView(arrangedSubviews: [nameLabel,nameTextField,nameWarningLabel])
    
    private lazy var nickLabel = DefaultLabel(text: "Ник",
                                              textColor: Color.neutral72.color,
                                              fontSize: 13,
                                              fontWeight: .regular)
    
    private lazy var nickTextField = DefaultTextField(placeHolder: "Введите ник",
                                                      delegate: self)
    
    var nickWarningLabel = DefaultLabel(text: "Максимальное количество символов: 100", textColor: Color.dangerMain.color, fontSize: 13.0, fontWeight: .regular)
    
    private lazy var nickStack = VerticalStackView(arrangedSubviews: [nickLabel,nickTextField, nickWarningLabel])
    
    
    private lazy var inputStack = VerticalStackView(arrangedSubviews: [nameStack, nickStack], spacing: 24.0)
    
    private var blankView: UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }

    private lazy var mainStack = VerticalStackView(arrangedSubviews: [progressBar,titleLabel, inputStack,blankView,continueButton], spacing: 24)
    
    
    var continueButton: DefaultButton = {
        let button = DefaultButton(buttonType: .primary)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(title: "Продолжить")
        return button
    } ()
    
    //MARK: - Setup Functions
    
    func setup() {
        view.addSubview(mainStack)
        setupConstraints()
        nameWarningLabel.isHidden = true
        nickWarningLabel.isHidden = true
        continueButton.isEnabled = false
        
        nameTextField.tag = 0
        nickTextField.tag = 1
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
        continueButton.addTarget(self, action: #selector(nextButtonPressed), for: .touchUpInside)
    }
    
    @objc
    private func nextButtonPressed() {
        viewModel.userDidEnterName(name: nameTextField.text)
        viewModel.userDidEnterNickname(nickname: nickTextField.text)
        navigationController?.pushViewController(ChooseCityView(viewModel: viewModel, window: window), animated: false)
    }
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            mainStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            mainStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            mainStack.bottomAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -12),
            mainStack.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
        ])
        NSLayoutConstraint.activate([
            progressBar.topAnchor.constraint(equalTo: mainStack.topAnchor),
            progressBar.leadingAnchor.constraint(equalTo: mainStack.leadingAnchor),
            progressBar.trailingAnchor.constraint(equalTo: mainStack.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: inputStack.topAnchor, constant: 12)
        ])
        
        NSLayoutConstraint.activate([
            inputStack.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            inputStack.leadingAnchor.constraint(equalTo: mainStack.leadingAnchor),
            inputStack.trailingAnchor.constraint(equalTo: mainStack.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: progressBar.bottomAnchor, constant: 32),
            titleLabel.leadingAnchor.constraint(equalTo: mainStack.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: mainStack.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            continueButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -12),
            continueButton.centerXAnchor.constraint(equalTo: mainStack.centerXAnchor)
        ])
    }
}

//MARK: - UITextFieldDelegate extension

extension UsernameViewController: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        checkTextLength()
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
     
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextTextField = view.viewWithTag(textField.tag + 1) as? UITextField {
            nextTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }

        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != nil {
            continueButton.isEnabled = true
        }
        textField.resignFirstResponder()
        return true
    }
    
    private func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty == false {
            continueButton.isEnabled = true
        }
    }
    
    func checkTextLength() {
        UIView.animate(withDuration: 0.1) {
            self.nameWarningLabel.isHidden = self.nameTextField.text.count <= 50 ? true : false
            self.nickWarningLabel.isHidden = self.nickTextField.text.count <= 100 ? true : false
        }
    }
}

extension UsernameViewController: YXLObserver {
    func loginDidFinish(with result: YXLLoginResult) {
        viewModel.setToken(token: result.token)
        print(result.token)
    }

    func loginDidFinishWithError(_ error: Error) {

    }
}
