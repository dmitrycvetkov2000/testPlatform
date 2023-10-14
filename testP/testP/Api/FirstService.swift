//
//  FirstService.swift
//  testP
//
//  Created by Дмитрий Цветков on 14.10.2023.
//

import Foundation

protocol FirstServiceProtocol {
    func getFirstData(completion: @escaping ([SomeMovie], State) -> Void)
}

final class FirstService: FirstServiceProtocol {

    var firstMas: [SomeMovie] = []
    var state: State = .offline
    
    func checkResult(result: (Result<Movie, NetworkError>)) {
        switch result {
        case .success(let movie):
            self.state = .online
            CoreDataManager.shared.deleteAllEntity(entityName: AllEnums.entityNames(name: .MovieEntity))
            movie.results?.forEach { res in
                self.firstMas.append(SomeMovie(posterPath: res.posterPath as Any, originalTitle: res.originalTitle ?? "", id: res.id ?? 0 ))
            }

        case .failure(let error):
            self.state = .offline

            CoreDataManager.shared.getAllEntity(entityName: AllEnums.entityNames(name: .MovieEntity)).forEach { element in
                if let element = element as? MovieEntity {
                    self.firstMas.append(SomeMovie(posterPath: element.photo as Any, originalTitle: element.title ?? "", id: Int(element.idOfMovie)))
                }
            }

            switch error {
            case .badURL:
                print("Проблема с URL")
            case .noData:
                print("data = nil")
            case .noDecode:
                print("Проблема с декодированием")
            case .otherError(let statusCode):
                checkStatusCodeOfError(statusCode: statusCode)
            }
        }
    }
    
    func checkStatusCodeOfError(statusCode: Int) {
        let firstNum = statusCode / 100
        switch firstNum {
        case 1:
            print("Информационная ошибка")
        case 2:
            print("success")
        case 3:
            print("Перенаправление")
        case 4:
            print("Ошибка клиента")
        case 5:
            print("Ошибка сервера")
        default:
            print("Возможно необходимо включить VPN")
        }
    }

    func getFirstData(completion: @escaping ([SomeMovie], State) -> Void) {
        APIManager.shared.getListOfMovie { [weak self] result in
            
            guard let self = self else { return }
            
            self.firstMas = []
            checkResult(result: result)

            completion(firstMas, state)
        }
    }
}
