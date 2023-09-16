//
//  CustomTableViewCell.swift
//  testP
//
//  Created by Дмитрий Цветков on 12.09.2023.
//

import UIKit

final class CustomTableViewCell: UITableViewCell {
// MARK: properties
    static let identificator = "CustomCell"
    
    private let label = UILabel()
    private let customImageView = UIImageView()
}

// MARK: - create views for cell
extension CustomTableViewCell {
    func configureCell(image: Any, text: String) {
        createImage(image: image)
        createLabel(text: text)
    }
    
    func createImage(image: Any) {
        customImageView.translatesAutoresizingMaskIntoConstraints = false
        customImageView.contentMode = .scaleAspectFit
        self.addSubview(customImageView)
        NSLayoutConstraint.activate([
            customImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            customImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0),
            customImageView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0),
            customImageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.7)
        ])
        
        if let image = image as? String {
            customImageView.load(urlString: image)
        } else {
            customImageView.image = image as? UIImage
        }
    }
    
    func createLabel(text: String) {
        label.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: customImageView.bottomAnchor, constant: 0),
            label.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0),
            label.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0),
            label.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
        ])
        
        label.text = text
        label.textAlignment = .center
    }
}
