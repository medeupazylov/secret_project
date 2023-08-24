//
//  ChooseLabelViewController.swift
//  Muslink
//
//  Created by Медеу Пазылов on 23.08.2023.
//

import UIKit

class ChooseLabelViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupView()
        setConstraints()
        view.backgroundColor = Color.primaryBgColor.color
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
        view.addSubview(progressBar)
        view.addSubview(tableView)
        view.addSubview(continueButton)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(LabelsCell.self, forCellReuseIdentifier: LabelsCell.identifier)
        continueButton.addTarget(self, action: #selector(nextButtonPressed), for: .touchUpInside)
    }
    
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            progressBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            progressBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            progressBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: progressBar.bottomAnchor, constant: 16),
            tableView.bottomAnchor.constraint(equalTo: continueButton.topAnchor),
            
            continueButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16.0),
            continueButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16.0),
            continueButton.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -16.0),
        ])
    }
    
    
    @objc
    private func nextButtonPressed() {
        progressBar.updateProgress(withScreenOrder: 4)
        let popupViewController = TrackSentViewController()
        popupViewController.modalPresentationStyle = .overCurrentContext
//        popupViewController.transitioningDelegate = self
        present(popupViewController, animated: true, completion: nil)

    }
    
    @objc
    private func moveBack() {
        navigationController?.popViewController(animated: false)
    }
    
    private let progressBar: DefaultProgressBar = {
        let progressView = DefaultProgressBar()
        progressView.updateProgress(withScreenOrder: 3)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        return progressView
    }()
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = .clear
        table.showsVerticalScrollIndicator = false
        return table
    }()
    
    private let continueButton: DefaultButton = {
        let button = DefaultButton(buttonType: .primary)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(title: "Продолжить")
        return button
    } ()
    
}

extension ChooseLabelViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        326
    }
}

extension ChooseLabelViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LabelsCell.identifier) as? LabelsCell else {
            print("here")
            return UITableViewCell()
        }
        print("here")
        return cell
    }
    
    
}


extension ChooseLabelViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return CustomModalPresentationController(presentedViewController: presented, presenting: presenting)
    }
}

class CustomModalPresentationController: UIPresentationController {
    override var frameOfPresentedViewInContainerView: CGRect {
        // Customize the frame of the presented view here
        // For example, center it in the container view
        let containerViewBounds = containerView?.bounds ?? CGRect.zero
        let targetSize = CGSize(width: 340, height: 500) // Adjust the size as needed
        let origin = CGPoint(x: (containerViewBounds.width - targetSize.width) / 2,
                             y: (containerViewBounds.height - targetSize.height) / 2)
        return CGRect(origin: origin, size: targetSize)
    }
}






