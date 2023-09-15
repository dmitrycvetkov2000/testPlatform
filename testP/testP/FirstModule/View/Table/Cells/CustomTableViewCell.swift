//
//  CustomTableViewCell.swift
//  testP
//
//  Created by Дмитрий Цветков on 12.09.2023.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    static let identificator = "CustomCell"
    
    let label = UILabel()
    let image = UIImageView()
}

// MARK: - create views for cell
extension CustomTableViewCell {
    func createImage(urlImageString: String) {
        image.translatesAutoresizingMaskIntoConstraints = false
        image.load(urlString: urlImageString)
        image.contentMode = .scaleAspectFit
        self.addSubview(image)
        
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            image.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0),
            image.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0),
            image.heightAnchor.constraint(equalTo: self.widthAnchor)
        ])
    }
    
    func createLabel(text: String) {
        label.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: self.image.bottomAnchor, constant: 0),
            label.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
        ])
        
        label.text = text
    }
}
