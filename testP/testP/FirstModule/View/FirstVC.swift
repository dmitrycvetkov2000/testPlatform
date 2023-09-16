//
//  ViewController.swift
//  testP
//
//  Created by Дмитрий Цветков on 12.09.2023.
//

import UIKit
import CoreData

protocol FirstVCProtocol: AnyObject {
    var viewModel: FirstViewModelProtocol! { get set }
    var coordinator: AppCoordinator! { get set }
    var helper: HelperForTableView! { get set }
}

class FirstVC: UIViewController, FirstVCProtocol {
    var viewModel: FirstViewModelProtocol!
    var coordinator: AppCoordinator!
    var helper: HelperForTableView!
    
    private let tableView: UITableView = UITableView()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        createTableView()
        self.viewModel.getListMovie {
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }
}

extension FirstVC {
    func createTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
        
        tableView.dataSource = helper
        tableView.delegate = self
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.identificator)
        
        tableView.separatorColor = .black
    }
}

extension FirstVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let image: [UIImage] = CoreDataManager.shared.getElementFromBD(findKey: AllEnums.keys(key: .photo))
        coordinator.showDetail(id: viewModel.model.results[indexPath.row].id, image: image[indexPath.row])
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.size.height
    }
}
