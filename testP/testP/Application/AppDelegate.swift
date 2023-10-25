//
//  AppDelegate.swift
//  testP
//
//  Created by Дмитрий Цветков on 12.09.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var appCoordinator: AppCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        URLCache.shared.removeAllCachedResponses()
        let window = UIWindow()
        let navController = UINavigationController()
        
        let assebleBuilder = ModuleBuilder()
        appCoordinator = CoordinatorFactory().createAppCoordinator(navController: navController, assebleBuilder: assebleBuilder) 
        
        appCoordinator?.start()
        
        window.rootViewController = navController
        window.makeKeyAndVisible()
        self.window = window
        return true
    }
}

