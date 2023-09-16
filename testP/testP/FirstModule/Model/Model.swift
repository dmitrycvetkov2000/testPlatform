//
//  Model.swift
//  testP
//
//  Created by Дмитрий Цветков on 12.09.2023.
//

import Foundation

struct MovieModel {
    var results: [SomeMovie] = []
}

struct SomeMovie {
    var posterPath: Any
    var originalTitle: String
    var id: Int
}
