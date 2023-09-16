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
        self.navigationController.isNavigationBarHidden = true
    }
        
    func showFirst() {
        let vc = ModuleBuilder().createFirst()
        vc.coordinator = self
        navigationController.viewControllers.removeAll()
        navigationController.pushViewController(vc as! UIViewController, animated: true)
    }
    
    func showDetail(id: Int, image: UIImage) {
        let vc = ModuleBuilder().createDetail()
        vc.coordinator = self
        vc.id = id
        vc.image = image
        navigationController.present(vc as! UIViewController, animated: true)
    }
}

