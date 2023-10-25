//
//  CoordinatorFactory.swift
//  testP
//
//  Created by Дмитрий Цветков on 23.10.2023.
//

import UIKit

class CoordinatorFactory {
    
    func createAppCoordinator(navController: UINavigationController, assebleBuilder: BuilderProtocol) -> AppCoordinator {
        AppCoordinator(navigationController: navController, assebleBuilder: assebleBuilder)
    }
    
    func createFirstCoordinator(navController: UINavigationController, assebleBuilder: BuilderProtocol) -> FirstCoordinator {
        FirstCoordinator(navigationController: navController, assebleBuilder: assebleBuilder)
    }
}
