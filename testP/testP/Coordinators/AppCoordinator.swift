//
//  AppCoordinator.swift
//  testP
//
//  Created by Дмитрий Цветков on 12.09.2023.
//

import UIKit

final class AppCoordinator: RouterProtocol {
    
    var navigationController: UINavigationController?
    var assebleBuilder: BuilderProtocol?
    
    func showFirst() {
        if let navigationController = navigationController {
            guard let mainVC = assebleBuilder?.createFirst(router: self) else { return }
            navigationController.viewControllers = [mainVC]
        }
    }
    
    func showDetail(id: Int, image: UIImage) {
        if let navigationController = navigationController {
            guard let detailVC = assebleBuilder?.createDetail(router: self, id: id, image: image) else { return }
            navigationController.present(detailVC, animated: true)
        }
    }
    
    init(navigationController: UINavigationController, assebleBuilder: BuilderProtocol) {
        self.navigationController = navigationController
        self.navigationController?.isNavigationBarHidden = true
        self.assebleBuilder = assebleBuilder
    }
}

