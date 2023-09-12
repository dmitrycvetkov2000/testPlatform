//
//  AppCoordinator.swift
//  testP
//
//  Created by Дмитрий Цветков on 12.09.2023.
//

import UIKit

class AppCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
        
    func showFirst() {
        let vc = ModuleBuilder().createFirst()
        vc.coordinator = self
        vc.viewModel = FirstViewModel()
        navigationController.viewControllers.removeAll()
        navigationController.pushViewController(vc as! UIViewController, animated: true)
    }
}

