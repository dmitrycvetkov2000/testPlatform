//
//  ModuleBuilder.swift
//  testP
//
//  Created by Дмитрий Цветков on 12.09.2023.
//

import UIKit

final class ModuleBuilder: BuilderProtocol {
    
    func createFirst(router: RouterProtocol) -> UIViewController {
        let model = MovieModel()
        let viewModel = FirstViewModel(model: model)
        let helper = HelperForTableView(viewModel: viewModel)
        let view = FirstVC(viewModel: viewModel, coordinator: router, helper: helper)
        
        return view
    }
    
    func createDetail(router: RouterProtocol, id: Int, image: UIImage) -> UIViewController {
        let model = DetailMovieModel()
        let viewModel = DetailViewModel(model: model)
        let view = DetailVC(viewModel: viewModel, coordinator: router, id: id, image: image)
                
        return view
    }
}
