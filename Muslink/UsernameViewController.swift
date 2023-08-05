//
//  ViewController.swift
//  ABC
//
//  Created by Аброрбек on 04.08.2023.
//

import UIKit

final class UsernameViewController: UIViewController {

    //MARK: - Properties

    private var progressBar = DefaultProgressBar()
    
    private lazy var titleLabel = getLabel(text: "Как вас зовут",
                                           textColor: Color.neutral100.color,
                                           fontSize: 18,
                                           fontWeight: 700)
    
    private lazy var nameLabel = getLabel(text: "Имя",
                                          textColor: Color.neutral72.color,
                                          fontSize: 13,
                                          fontWeight: 400)
    
    private lazy var nameTextField = DefaultTextField(placeHolder: "Введите имя",
                                                      delegate: self)
    
    private lazy var nameStack = getTextFieldStack(label: nameLabel,
                                                   textField: nameTextField)
    
    
    private lazy var nickLabel = getLabel(text: "Ник",
                                          textColor: Color.neutral72.color,
                                          fontSize: 13,
                                          fontWeight: 400)
    
    private lazy var nickTextField = DefaultTextField(placeHolder: "Введите ник",
                                                      delegate: self)
    private lazy var nickStack = getTextFieldStack(label: nickLabel,
                                                   textField: nickTextField)
    
    private lazy var inputStack = getStack(spacing: 8, arrangedSubviews: [titleLabel, nameStack, nickStack])
    
    private var blankView = UIView()

    private lazy var mainStack = getStack(spacing: 24, arrangedSubviews: [progressBar,inputStack,blankView,continueButton])
    
    private let continueButton: DefaultButton = {
        let button = DefaultButton(buttonType: .primary)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(title: "Продолжить")
        return button
    } ()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Color.primaryBgColor.color
        setupNavigationBar()
        setup()
    }
    
    //MARK: - Setup Functions
    
    func setup() {
        [
    
        ].forEach{ mainStack.addArrangedSubview($0) }
        view.addSubview(mainStack)
        setupConstraints()
        
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
    
    func getLabel(text: String, textColor: UIColor, fontSize: CGFloat, fontWeight: CGFloat) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = textColor
        label.font = UIFont.systemFont(ofSize: fontSize, weight: UIFont.Weight(rawValue: fontWeight))
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    func getTextFieldStack(label: UILabel, textField: DefaultTextField) -> UIStackView {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.addArrangedSubview(label)
        stack.addArrangedSubview(textField)
        stack.spacing = 8
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }
    
    func getStack(spacing: CGFloat, arrangedSubviews: [UIView]) -> UIStackView {
        let stack = UIStackView()
        stack.backgroundColor = .clear
        stack.spacing = spacing
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        for i in arrangedSubviews {
            stack.addArrangedSubview(i)
        }
        return stack
    }
    
    @IBAction func goForward() {
        
    }
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 44),
            mainStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            mainStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            mainStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -12),
            mainStack.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
        ])
        NSLayoutConstraint.activate([
            progressBar.topAnchor.constraint(equalTo: mainStack.topAnchor, constant: 24),
            progressBar.leadingAnchor.constraint(equalTo: mainStack.leadingAnchor, constant: 16),
            progressBar.trailingAnchor.constraint(equalTo: mainStack.trailingAnchor, constant: -16)
        ])
        NSLayoutConstraint.activate([
            progressBar.topAnchor.constraint(equalTo: mainStack.topAnchor, constant: -24),
            progressBar.leadingAnchor.constraint(equalTo: mainStack.leadingAnchor, constant: 16),
            progressBar.trailingAnchor.constraint(equalTo: mainStack.trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            continueButton.bottomAnchor.constraint(equalTo: mainStack.bottomAnchor, constant: 12)
        ])
        
        NSLayoutConstraint.activate([
            blankView.widthAnchor.constraint(greaterThanOrEqualToConstant: 375),
            blankView.heightAnchor.constraint(greaterThanOrEqualToConstant: 134)
        ])

        
    }

    
    
    
    
}

