//
//  TrackLoadViewController.swift
//  Muslink
//
//  Created by Медеу Пазылов on 18.08.2023.
//

import UIKit

class TrackLoadViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Color.primaryBgColor.color
        setupNavigationBar()
        setupViews()
        setupLayout()
        // Do any additional setup after loading the view.
    }
    
    
    private func setupNavigationBar() {
        let title = UILabel()
        title.text = NSLocalizedString("Новая заявка", comment: "")
        title.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        title.textColor = Color.neutral100.color
        navigationItem.titleView = title
        let itemleft = UIBarButtonItem(image: Image.chevronLeft.image, style: .done, target: nil, action: nil)
        itemleft.tintColor = Color.neutral72.color
        navigationItem.leftBarButtonItem = itemleft
        let itemright = UIBarButtonItem(image: Image.close.image, style: .done, target: nil, action: nil)
        itemright.tintColor = Color.neutral72.color
        navigationItem.rightBarButtonItem = itemright
    }
    
    private func addNewVC(vc: UIViewController) {
        addChild(vc)
        vc.view.translatesAutoresizingMaskIntoConstraints = false
        stack.addArrangedSubview(vc.view)

        NSLayoutConstraint.activate([
            vc.view.leftAnchor.constraint(equalTo: view.leftAnchor),
            vc.view.rightAnchor.constraint(equalTo: view.rightAnchor),
        ])
        vc.didMove(toParent: self)
    }
    
    func setupViews() {
        view.addSubview(progressView)
        view.addSubview(mainScroll)
        view.addSubview(continueButton)
        mainScroll.addSubview(stack)
        stack.addArrangedSubview(titleLabel)
        stack.addArrangedSubview(segmentedControl)
        addNewVC(vc: AudioPlayerViewController())
        stack.addArrangedSubview(trackNameTextField)
        stack.setCustomSpacing(16, after: trackNameTextField)
        stack.addArrangedSubview(trackNameTextField2)
        stack.setCustomSpacing(16, after: trackNameTextField2)
        stack.addArrangedSubview(trackNameTextField3)
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            progressView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            progressView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            progressView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            progressView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            mainScroll.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainScroll.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainScroll.topAnchor.constraint(equalTo: progressView.bottomAnchor, constant: 6.0),
            mainScroll.bottomAnchor.constraint(equalTo: continueButton.topAnchor),
        
            stack.topAnchor.constraint(equalTo: mainScroll.topAnchor, constant: 32.0),
            stack.bottomAnchor.constraint(equalTo: mainScroll.bottomAnchor, constant: -32),
            
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16.0),
            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16.0),
            segmentedControl.heightAnchor.constraint(equalToConstant: 44.0),
            
            trackNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16.0),
            trackNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16.0),
            trackNameTextField.heightAnchor.constraint(equalToConstant: 56),
            trackNameTextField2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16.0),
            trackNameTextField2.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16.0),
            trackNameTextField2.heightAnchor.constraint(equalToConstant: 56),
            trackNameTextField3.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16.0),
            trackNameTextField3.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16.0),
            trackNameTextField3.heightAnchor.constraint(equalToConstant: 56),
            
            continueButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16.0),
            continueButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16.0),
            continueButton.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -16.0),
        ])
    }
    
    //MARK: - UIElements
    private let progressView: DefaultProgressBar = {
        let progressView = DefaultProgressBar()
        progressView.updateProgress(withScreenOrder: 0)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        return progressView
    }()
    
    private let mainScroll: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.backgroundColor = Color.primaryBgColor.color
        scroll.bounces = true
        return scroll
    } ()
    
    private let stack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 32.0
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    } ()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Color.neutral100.color
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.text = "Информация о треке"
        return label
    }()
    
    private let segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["Загрузить трек", "Выбрать трек"])
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.backgroundColor = Color.elevatedBgColor.color
        segmentedControl.selectedSegmentTintColor = Color.neutral16.color
        segmentedControl.setTitleTextAttributes([
            .font : UIFont.systemFont(ofSize: 15, weight: .bold),
            .foregroundColor : Color.neutral100.color
        ], for: .selected)
        segmentedControl.setTitleTextAttributes([
            .font : UIFont.systemFont(ofSize: 15, weight: .bold),
            .foregroundColor : Color.neutral72.color
        ], for: .normal)
        return segmentedControl
    } ()
    
    lazy var trackNameTextField: DefaultTextField = {
        let textField = DefaultTextField(placeHolder: "Название трека", delegate: self, type: .special)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    } ()
    
    lazy var trackNameTextField2: DefaultTextField = {
        let textField = DefaultTextField(placeHolder: "Язык трека", delegate: self, type: .special)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    } ()
    
    lazy var trackNameTextField3: DefaultTextField = {
        let textField = DefaultTextField(placeHolder: "Основной жанр", delegate: self, type: .special)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    } ()
    
    
    private let continueButton: DefaultButton = {
        let button = DefaultButton(buttonType: .primary)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(title: "Продолжить")
        return button
    } ()
        
}

extension TrackLoadViewController: UITextFieldDelegate {
    
}
