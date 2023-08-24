//
//  ProfileViewController.swift
//  Muslink
//
//  Created by Медеу Пазылов on 12.08.2023.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private let profile: ProfileModel 
    
    init(profile: ProfileModel) {
        self.profile = profile
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupView()
        setupLayout()
        addChildViewControllers()
    }
    
    //MARK: - Setup Methods
    private func addChildViewControllers() {
        addNewVC(vc: ProfileHeaderViewController())
        addNewVC(vc: PopularTracksViewController())
        addNewVC(vc: MusicianInfoViewController())
        
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
        let item = UIBarButtonItem(image: Image.settings.image, style: .plain, target: nil, action: nil)
        item.tintColor = Color.neutral100.color
        navigationItem.rightBarButtonItem = item
        navigationController?.navigationBar.barTintColor = Color.primaryBgColor.color
    }

    private func setupView() {
        view.addSubview(mainScroll)
        mainScroll.addSubview(stack)
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            mainScroll.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainScroll.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainScroll.topAnchor.constraint(equalTo: view.topAnchor),
            mainScroll.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            stack.leftAnchor.constraint(equalTo: mainScroll.leftAnchor),
            stack.rightAnchor.constraint(equalTo: mainScroll.rightAnchor),
            stack.topAnchor.constraint(equalTo: mainScroll.topAnchor),
            stack.bottomAnchor.constraint(equalTo: mainScroll.bottomAnchor),
        ])
    }
    
    //MARK: - UIElements
    private let mainScroll: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.backgroundColor = Color.primaryBgColor.color
        return scroll
    } ()
    
    private let stack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 32.0
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    } ()
    

  

}
