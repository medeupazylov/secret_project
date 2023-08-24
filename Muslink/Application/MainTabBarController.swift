//
//  MainTabBarController.swift
//  Muslink
//
//  Created by Аброрбек on 24.08.2023.
//

import UIKit

final class MainTabBarController: UITabBarController {
    
    var profile: ProfileModel?
    
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
    
        let profileViewController = ProfileViewController(profile: profile!)
        let profileViewControllerNav = UINavigationController(rootViewController: profileViewController)
        profileViewController.tabBarItem.image = UIImage(systemName: "person")
        
        let applicationRequestViewController = TrackLoadViewController()
        let applicationRequestViewControllerNav = UINavigationController(rootViewController: applicationRequestViewController)
        applicationRequestViewController.tabBarItem.image = UIImage(named: "copy-plus")
        
        
        let myApplicationsViewModel = MyApplicationsViewModel(networkingService: DefaultNetworkingService())
        let myApplicationsViewController = MyApplicationsViewController(viewModel: myApplicationsViewModel)
        let myApplicationsViewControllerNav = UINavigationController(rootViewController: myApplicationsViewController)
        myApplicationsViewController.tabBarItem.image = UIImage(named: "file-audio")
        
        let chooseLabelViewController = ChooseLabelViewController()
        let chooseLabelViewControllerNav = UINavigationController(rootViewController: chooseLabelViewController)
        chooseLabelViewController.tabBarItem.image = UIImage(named: "activity")
        
        setViewControllers([profileViewControllerNav, applicationRequestViewControllerNav, chooseLabelViewControllerNav, myApplicationsViewControllerNav], animated: true)
    }
    
}
