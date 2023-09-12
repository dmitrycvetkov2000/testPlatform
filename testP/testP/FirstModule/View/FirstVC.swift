//
//  ViewController.swift
//  testP
//
//  Created by Дмитрий Цветков on 12.09.2023.
//

import UIKit

class FirstVC: UIViewController {
    var viewModel: FirstViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .brown
        self.viewModel = FirstViewModel()
    }


}

