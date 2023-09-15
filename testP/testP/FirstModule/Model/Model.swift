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
    
    init(posterPath: Any, originalTitle: String) {
        self.posterPath = posterPath
        self.originalTitle = originalTitle
    }
}
