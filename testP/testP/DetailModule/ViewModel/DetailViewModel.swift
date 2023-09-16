//
//  DetailViewModel.swift
//  testP
//
//  Created by Дмитрий Цветков on 15.09.2023.
//

import Foundation

protocol DetailViewModelProtocol {
    var model: DetailMovieModel { get set }
    func getDetailInfoAboutMovie(id: Int, completion: @escaping () -> Void)
}

final class DetailViewModel {
    var model: DetailMovieModel
    
    init(model: DetailMovieModel) {
        self.model = model
    }
}

extension DetailViewModel: DetailViewModelProtocol {
    func getDetailInfoAboutMovie(id: Int, completion: @escaping () -> Void) {
        
        APIManager.shared.getDetailInfoAboutMovie(id: id) { [weak self] detail in
            guard let self = self else { return }
            if detail != nil {
                model.originalTitle = detail?.originalTitle ?? ""
                model.budget = detail?.budget ?? 1
                model.releaseDate = detail?.releaseDate ?? ""
                
                let _ = CoreDataManager.shared.getAllEntity(entityName: AllEnums.entityNames(name: .MovieEntity)).first { element in
                    if let element = element as? MovieEntity {
                        if element.idOfMovie == id {
                            element.budget = Int64(detail?.budget ?? 0)
                            element.releaseDate = detail?.releaseDate
                            
                            CoreDataManager.shared.saveContext()
                            return true
                        }
                    }
                    return false
                }
                
                completion()
            } else {
                let masEntity = CoreDataManager.shared.getAllEntity(entityName: AllEnums.entityNames(name: .MovieEntity)).first { element in
                    if let element = element as? MovieEntity {
                        if element.idOfMovie == id {
                            return true
                        }
                    }
                    return false
                }
                self.model.originalTitle = masEntity?.title ?? ""
                self.model.budget = Int(masEntity?.budget ?? 1)
                self.model.releaseDate = masEntity?.releaseDate ?? ""
                
                completion()
            }
        }
    }
}
