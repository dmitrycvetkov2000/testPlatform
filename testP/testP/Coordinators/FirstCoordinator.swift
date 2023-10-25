//
//  FirstCoordinator.swift
//  testP
//
//  Created by Дмитрий Цветков on 23.10.2023.
//

import UIKit

class FirstCoordinator: CoordinatorProtocol {
    
    var navigationController: UINavigationController?
    
    var flowCompletionHandler: CoordinatorHandler?
    
    var assebleBuilder: BuilderProtocol?
    
    init(navigationController: UINavigationController, assebleBuilder: BuilderProtocol) {
        self.navigationController = navigationController
        self.assebleBuilder = assebleBuilder
    }
    
    func start() {
        showFirstModule()
    }
    
    private func showFirstModule() {
        if let navigationController = navigationController {
            guard let firstVC = assebleBuilder?.createFirst(router: self) else { return }
            
            firstVC.completionHandler = { data in
                self.showDetailModule(data: data)
            }
            
            navigationController.pushViewController(firstVC, animated: true)
        }
    }
    
    private func showDetailModule(data: ImageStr) {
        if let navigationController = navigationController {
            guard let detailVC = assebleBuilder?.createDetail(router: self, data: data) else { return }
            
            navigationController.present(detailVC, animated: true)
        }
    }
}
