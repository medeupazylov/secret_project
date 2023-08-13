//
//  ProfileViewController.swift
//  Muslink
//
//  Created by Медеу Пазылов on 12.08.2023.
//

import UIKit

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupView()
        setupLayout()
        addChildViewControllers()
    }
    
    func addChildViewControllers() {
        addNewVC(vc: ProfileHeaderViewController())
        addNewVC(vc: PopularTracksViewController())
        
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
    
    private func setupNavigationBar() {
        let title = UILabel()
        title.text = NSLocalizedString("Профиль музыканта", comment: "")
        title.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        title.textColor = Color.neutral100.color
        navigationItem.titleView = title
        let item = UIBarButtonItem(image: UIImage(named: "chevron_left"), style: .done, target: nil, action: nil)
        item.tintColor = Color.neutral72.color
        navigationItem.leftBarButtonItem = item
        navigationController?.navigationBar.barTintColor = .clear
    }

    func setupView() {
        view.addSubview(mainScroll)
        mainScroll.addSubview(stack)
    }

    func setupLayout() {
        NSLayoutConstraint.activate([
            mainScroll.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainScroll.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainScroll.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainScroll.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            stack.leftAnchor.constraint(equalTo: mainScroll.leftAnchor),
            stack.rightAnchor.constraint(equalTo: mainScroll.rightAnchor),
            stack.topAnchor.constraint(equalTo: mainScroll.topAnchor),
            stack.bottomAnchor.constraint(equalTo: mainScroll.bottomAnchor),
        ])
    }
    
    private let mainScroll: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    } ()
    
    private let stack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    } ()
    

  

}
