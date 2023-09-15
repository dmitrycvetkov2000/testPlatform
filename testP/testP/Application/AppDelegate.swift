//
//  AppDelegate.swift
//  testP
//
//  Created by Дмитрий Цветков on 12.09.2023.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var coordinator: AppCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        URLCache.shared.removeAllCachedResponses()
        let window = UIWindow()
        let navController = UINavigationController()
        coordinator = AppCoordinator(navigationController: navController)
        coordinator?.showFirst()
        window.rootViewController = navController
        window.makeKeyAndVisible()
        self.window = window
        return true
    }
}

