//
//  FirstViewModel.swift
//  testP
//
//  Created by Дмитрий Цветков on 12.09.2023.
//

import UIKit

enum State {
    case online
    case offline
}

protocol FirstViewModelProtocol: AnyObject {
    var model: MovieModel { get set }
    var filteredData: ModelFiltered { get set }
    var isSearching: Bool { get set }
    func getListMovie(completion: @escaping () -> Void)
    
    var state: State { get set }
}

class FirstViewModel {
    var model: MovieModel
    var filteredData: ModelFiltered = ModelFiltered()
    var isSearching = false
    
    var service: FirstServiceProtocol = FirstService()
    
    var state: State
    
    init(model: MovieModel, state: State) {
        self.model = model
        self.state = state
    }
}

extension FirstViewModel: FirstViewModelProtocol {
    
    func getListMovie(completion: @escaping () -> Void) {
        
        service.getFirstData { someMovie, state  in
            self.state = state
            self.model.results = someMovie 
            completion()
        }
    }
}
