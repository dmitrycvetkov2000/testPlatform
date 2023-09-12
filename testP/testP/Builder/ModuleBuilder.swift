//
//  ModuleBuilder.swift
//  testP
//
//  Created by Дмитрий Цветков on 12.09.2023.
//

import UIKit

class ModuleBuilder: BuilderProtocol {
        func createFirst() -> UIViewController {
        let view = FirstVC()
        let viewModel = FirstViewModel()
        view.viewModel = viewModel
        
        return view
    }
}
