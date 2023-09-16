//
//  FirstViewModel.swift
//  testP
//
//  Created by Дмитрий Цветков on 12.09.2023.
//

import Foundation
import CoreData
import UIKit

protocol FirstViewModelProtocol {
    var model: MovieModel! { get set }
    func getListMovie(completion: @escaping () -> Void)
}

class FirstViewModel {
    var model: MovieModel!
}

extension FirstViewModel: FirstViewModelProtocol {

    
    func getListMovie(completion: @escaping () -> Void) {
        APIManager.shared.getListOfMovie { [weak self] movie in
            guard let self = self else { return }
            if movie != nil {
                CoreDataManager.shared.deleteAllEntity(entityName: AllEnums.entityNames(name: .MovieEntity))
                movie?.results?.forEach({ res in
                    self.model!.results.append(SomeMovie(posterPath: "https://image.tmdb.org/t/p/w500/\(res.posterPath ?? "")", originalTitle: res.originalTitle ?? "", id: res.id ?? 0 ))
                })
                completion()
            } else {
                let masEntity = CoreDataManager.shared.getAllEntity(entityName: AllEnums.entityNames(name: .MovieEntity))
                let photoMas: [UIImage] = CoreDataManager.shared.getElementFromBD(findKey: AllEnums.keys(key: .photo))
                let titleMas: [String] = CoreDataManager.shared.getElementFromBD(findKey: AllEnums.keys(key: .title))
                let idMas: [Int] = CoreDataManager.shared.getElementFromBD(findKey: AllEnums.keys(key: .idOfMovie))
                for i in 0..<masEntity.count {
                    self.model!.results.append(SomeMovie(posterPath: photoMas[i], originalTitle: titleMas[i], id: idMas[i]))
                }
                completion()
            }
        }
    }
}
