//
//  ModuleBuilder.swift
//  testP
//
//  Created by Дмитрий Цветков on 12.09.2023.
//

import UIKit

class ModuleBuilder: BuilderProtocol {
    func createFirst() -> FirstVCProtocol {
        let view = FirstVC()
        let viewModel = FirstViewModel()
        viewModel.model = MovieModel()
        
        let helper = HelperForTableView(viewModel: viewModel)
        view.viewModel = viewModel
        view.helper = helper
        
        return view
    }
    
    func createDetail() -> DetailVCProtocol {
        let view = DetailVC()
        let viewModel = DetailViewModel()
        viewModel.model = DetailMovieModel()
        view.viewModel = viewModel
        
        return view
    }
}
