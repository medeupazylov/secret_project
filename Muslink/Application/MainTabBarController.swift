//
//  MainTabBarController.swift
//  Muslink
//
//  Created by Аброрбек on 24.08.2023.
//

import UIKit

final class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Color.primaryBgColor.color
        
        setupTabBar()
    }
    
    private func setupTabBar() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = Color.primaryBgColor.color
        appearance.selectionIndicatorTintColor = Color.primaryMain.color

        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = tabBar.standardAppearance
        tabBar.tintColor = Color.primaryMain.color
        
        setViews()
    }
    
    private func setViews() {
        
        let profileViewController = ProfileViewController()
        let profileViewControllerNav = UINavigationController(rootViewController: profileViewController)
        profileViewController.tabBarItem.image = UIImage(systemName: "person")
        
        let applicationRequestViewController = TrackLoadViewController()
        let applicationRequestViewControllerNav = UINavigationController(rootViewController: applicationRequestViewController)
        applicationRequestViewController.tabBarItem.image = UIImage(named: "copy-plus")
        
        
        let myApllicationsViewModel = MyApplicationsViewModel(networkingService: ApplicationNetworkingServiceImpl())
        let myApllicationsViewController = MyApplicationsViewController(viewModel: myApllicationsViewModel)
        let myApllicationsViewControllerNav = UINavigationController(rootViewController: myApllicationsViewController)
        myApllicationsViewController.tabBarItem.image = UIImage(named: "file-audio")
        
        setViewControllers([profileViewControllerNav, applicationRequestViewControllerNav, myApllicationsViewController], animated: true)
    }
    
}
