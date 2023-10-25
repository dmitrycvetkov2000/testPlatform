//
//  AppCoordinatorr.swift
//  testP
//
//  Created by Дмитрий Цветков on 23.10.2023.
//

import UIKit

class AppCoordinator: CoordinatorProtocol {
    var navigationController: UINavigationController?
    
    var flowCompletionHandler: CoordinatorHandler?
    
    var assebleBuilder: BuilderProtocol?
    
    private var childCoordinators: [CoordinatorProtocol] = []
    
    init(navigationController: UINavigationController, assebleBuilder: BuilderProtocol? ) {
        self.navigationController = navigationController
        self.assebleBuilder = assebleBuilder
    }
    
    func start() {
        showFirstFlow()
    }
    
    private func showFirstFlow() {
        if let navigationController = navigationController, let assebleBuilder = assebleBuilder {
            let firstCoordinator = CoordinatorFactory().createFirstCoordinator(navController: navigationController, assebleBuilder: assebleBuilder)
            childCoordinators.append(firstCoordinator)
            firstCoordinator.start()
        }
    }
}
