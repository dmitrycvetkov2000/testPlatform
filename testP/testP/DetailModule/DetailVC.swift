//
//  DetailVC.swift
//  testP
//
//  Created by Дмитрий Цветков on 15.09.2023.
//

import UIKit

protocol DetailVCProtocol: AnyObject {
    var viewModel: DetailViewModelProtocol! { get set }
    var coordinator: AppCoordinator! { get set }
    var id: Int! { get set }
    var image: UIImage! { get set }
}

class DetailVC: UIViewController, DetailVCProtocol {
    var viewModel: DetailViewModelProtocol!
    var coordinator: AppCoordinator!
    
    let mainTitle = UILabel()
    let imageView = UIImageView()
    let additionalInformationLabel = UILabel()
    
    var id: Int!
    var image: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        viewModel.getDetailInfoAboutMovie(id: id) { [weak self] in
            DispatchQueue.main.async {
                self?.createMainTitle(title: self?.viewModel.model.originalTitle ?? "")
                self?.createImage(image: self?.image ?? UIImage())
                self?.createAdditionalInformationLabel(budget: self?.viewModel.model.budget ?? 1, releaseDate: self?.viewModel.model.releaseDate ?? "")
            }
        }
    }

}

extension DetailVC {
    
    func createMainTitle(title: String) {
        mainTitle.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mainTitle)
        
        NSLayoutConstraint.activate([
            mainTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            mainTitle.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            mainTitle.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            mainTitle.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        mainTitle.text = title
    }
    
    func createImage(image: UIImage) {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: mainTitle.bottomAnchor, constant: 0),
            imageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            imageView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            imageView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1)
        ])
        imageView.contentMode = .scaleAspectFit
        imageView.image = image
    }
    
    func createAdditionalInformationLabel(budget: Int, releaseDate: String) {
        additionalInformationLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(additionalInformationLabel)
        
        NSLayoutConstraint.activate([
            additionalInformationLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 0),
            additionalInformationLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            additionalInformationLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
        ])
        
        additionalInformationLabel.text = "Бюджет: \(budget), Дата релиза: \(releaseDate)"
    }
}
