//
//  UIImageView+Extensions.swift
//  testP
//
//  Created by Дмитрий Цветков on 12.09.2023.
//

import UIKit

extension UIImageView {
    
    func load(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        if let image = CacheManager.shared.getData(key: urlString as NSString) as? UIImage {
            self.image = image
            return
        }
        
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                    CacheManager.shared.saveData(obj: image, urlStrImageKey: urlString as NSString)
                }
            }
        }
    }
}
