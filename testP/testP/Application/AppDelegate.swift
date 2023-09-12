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

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow()
        let vc = FirstVC()
        window.rootViewController = vc
        window.makeKeyAndVisible()
        self.window = window
        return true
    }
}

