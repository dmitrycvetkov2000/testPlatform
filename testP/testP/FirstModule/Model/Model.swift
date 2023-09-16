//
//  Model.swift
//  testP
//
//  Created by Дмитрий Цветков on 12.09.2023.
//

import UIKit

class MovieModel {
    var results: [SomeMovie] = []
}

class SomeMovie {
    var posterPath: Any
    var originalTitle: String
    var id: Int
    
    init(posterPath: Any, originalTitle: String, id: Int) {
        self.posterPath = posterPath
        self.originalTitle = originalTitle
        self.id = id
    }
}
