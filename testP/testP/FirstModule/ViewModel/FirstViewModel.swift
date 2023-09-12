//
//  FirstViewModel.swift
//  testP
//
//  Created by Дмитрий Цветков on 12.09.2023.
//

import Foundation

protocol FirstViewModelProtocol {
    func getListMovie(completion: () -> Void)
    func getDetailInfoAboutMovie(completion: () -> Void)
}

class FirstViewModel: FirstViewModelProtocol {
    func getListMovie(completion: () -> Void) {
        APIManager.shared.getListOfMovie { [weak self] movie in
            guard let self = self else { return }
            

        }
    }
    
    func getDetailInfoAboutMovie(completion: () -> Void) {
        APIManager.shared.getDetailInfoAboutMovie(id: 157336) { [weak self] detail in
            guard let self = self else { return }
            
        }
    }
}
