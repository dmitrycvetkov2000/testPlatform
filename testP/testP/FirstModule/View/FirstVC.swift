//
//  ViewController.swift
//  testP
//
//  Created by Дмитрий Цветков on 12.09.2023.
//

import UIKit

protocol FirstVCProtocol: AnyObject {
    var viewModel: FirstViewModelProtocol! { get set }
    var coordinator: AppCoordinator! { get set }
}

class FirstVC: UIViewController, FirstVCProtocol {
    var viewModel: FirstViewModelProtocol!
    var coordinator: AppCoordinator!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .brown
    }


}


