//
//  AppDelegate.swift
//  ABC
//
//  Created by Аброрбек on 04.08.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        if url.scheme == "photos-redirect" {
            // Handle the case when the user returns from the Photos app
            // Your logic to handle the selected photo goes here
            
            // For example, you can access the selected photo using the URL passed from the Photos app:
            // let photoURL = url
            
            // And then, update the imageView with the selected photo
            // imageView.image = UIImage(contentsOfFile: photoURL.path)
            
            // Make sure to dismiss any presented view controllers or do any other necessary UI updates.
            print("DAa")
            return true
        }
        return false
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    // MARK: UISceneSession Lifecycle
    
    

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

