//
//  Coordinator.swift
//  testP
//
//  Created by Дмитрий Цветков on 23.10.2023.
//

import UIKit

typealias CoordinatorHandler = () -> ()

protocol CoordinatorBaseProtocol: AnyObject {
    var navigationController: UINavigationController? { get set }
    var flowCompletionHandler: CoordinatorHandler? { get set }
    var assebleBuilder: BuilderProtocol? { get set }
}

protocol CoordinatorProtocol: CoordinatorBaseProtocol {
    func start()
}
