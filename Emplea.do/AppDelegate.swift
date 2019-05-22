//
//  AppDelegate.swift
//  Emplea.do
//
//  Created by Eleazar Estrella GB on 5/16/19.
//  Copyright © 2019 Eleazar Estrella. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let jobsViewController = JobsViewController.initFromNib()
        
        let viewModel = JobsViewModel()
        
        jobsViewController.viewModel = viewModel
        jobsViewController.title = "Emplea.do"
        
        let rootViewController = UINavigationController(rootViewController: jobsViewController)
        
        window?.rootViewController = rootViewController
        
        window?.makeKeyAndVisible()
        
        setAppearance()
        
        return true
    }
    
    func setAppearance(){
        UINavigationBar.appearance().barTintColor = UIColor.hexStringToUIColor(hex: "#4FAEB9")
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        UINavigationBar.appearance().isTranslucent = false
    }
}

