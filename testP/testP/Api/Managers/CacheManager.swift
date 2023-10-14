//
//  CacheManager.swift
//  testP
//
//  Created by Дмитрий Цветков on 13.09.2023.
//

import Foundation

final class CacheManager {
    static let shared = CacheManager()
    private init() {}
    var cache = NSCache<AnyObject, AnyObject>()
    
    func saveData(obj: AnyObject, urlStrImageKey: AnyObject) {
        cache.setObject(obj, forKey: urlStrImageKey)
    }
    
    func getData(key: AnyObject) -> AnyObject? {
        return cache.object(forKey: key)
    }
}
