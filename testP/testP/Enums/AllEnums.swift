//
//  AllEnums.swift
//  testP
//
//  Created by Дмитрий Цветков on 14.09.2023.
//

import Foundation

enum AllEnums {
    case keys(key: Keys)
    case entityNames(name: Names)
    
    var value: String {
        switch self {
        case .keys(key: let key):
            switch key {
            case .photo:
                return "photo"
            case .title:
                return "title"
                
            }
        case .entityNames(name: let name):
            switch name {
            case .MovieEntity:
                return "MovieEntity"
            }
        }
    }
}
        
enum Keys {
    case photo
    case title
}
        
enum Names: String {
    case MovieEntity
}


