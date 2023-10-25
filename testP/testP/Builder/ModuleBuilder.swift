//
//  ModuleBuilder.swift
//  testP
//
//  Created by Дмитрий Цветков on 12.09.2023.
//

import UIKit

final class ModuleBuilder: BuilderProtocol {
    
    func createFirst(router: CoordinatorProtocol) -> FirstVC {
        let model = MovieModel()
        let viewModel = FirstViewModel(model: model, state: .offline)
        let helper = HelperForTableView(viewModel: viewModel)
        let view = FirstVC(viewModel: viewModel, helper: helper)

        return view
    }

    func createDetail(router: CoordinatorProtocol, data: ImageStr) -> UIViewController {
        let model = DetailMovieModel()
        let viewModel = DetailViewModel(model: model)
        let view = DetailVC(viewModel: viewModel, data: data)

        return view
    }
}
