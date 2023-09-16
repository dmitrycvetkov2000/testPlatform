//
//  FirstViewModel.swift
//  testP
//
//  Created by Дмитрий Цветков on 12.09.2023.
//

import UIKit

protocol FirstViewModelProtocol: AnyObject {
    var model: MovieModel { get set }
    var filteredData: ModelFiltered { get set }
    var isSearching: Bool { get set }
    func getListMovie(completion: @escaping () -> Void)
}

class FirstViewModel {
    var model: MovieModel
    var filteredData: ModelFiltered = ModelFiltered()
    var isSearching = false
    
    init(model: MovieModel) {
        self.model = model
    }
}

extension FirstViewModel: FirstViewModelProtocol {
    
    func getListMovie(completion: @escaping () -> Void) {
        APIManager.shared.getListOfMovie { [weak self] movie in
            
            guard let self = self else { return }
            
            if movie != nil {
                CoreDataManager.shared.deleteAllEntity(entityName: AllEnums.entityNames(name: .MovieEntity))
                movie?.results?.forEach({ res in
                    self.model.results.append(SomeMovie(posterPath: "https://image.tmdb.org/t/p/w500/\(res.posterPath ?? "")", originalTitle: res.originalTitle ?? "", id: res.id ?? 0 ))
                })
                
                completion()
            } else {
                CoreDataManager.shared.getAllEntity(entityName: AllEnums.entityNames(name: .MovieEntity)).forEach { element in
                    if let element = element as? MovieEntity {
                        self.model.results.append(SomeMovie(posterPath: element.photo as Any, originalTitle: element.title ?? "", id: Int(element.idOfMovie)))
                    }
                }
                
                completion()
            }
        }
    }
}
