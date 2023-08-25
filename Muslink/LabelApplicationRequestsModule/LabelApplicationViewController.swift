//
//  LabelApplicationViewController.swift
//  Muslink
//
//  Created by Aisha Nurgaliyeva on 24.08.2023.
//

import UIKit

class LabelApplicationViewController: UIViewController {
    
    var artistName: String
    var locationName: String
    var trackName: String
    var artistImageName: String
   
    //MARK: - Lifecycle
    
    init(artistName: String = "",
         locationName: String = "",
         trackName: String = "",
         artistPhotoName: String = "") {
        self.artistName = artistName
        self.locationName = locationName
        self.trackName = trackName
        self.artistImageName = artistPhotoName
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupView()
        setupLayout()
        addChildViewControllers()
    }
    
    //MARK: - Setup Methods
    private func addChildViewControllers() {
        addNewVC(vc: ApplicationHeaderViewController(artistName: artistName, locationName: locationName, artistImageName: artistImageName))
        addNewVC(vc: TrackDescriptionViewController(trackName: trackName))
        addNewVC(vc: ApplicationFooterInfoViewController())
        
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
        let item = UIBarButtonItem(image: Image.close.image, style: .plain, target: self, action: #selector(dismissVC))
        item.tintColor = Color.neutral72.color
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
    

    @objc func dismissVC() {
        self.dismiss(animated: true)
    }
  

}
