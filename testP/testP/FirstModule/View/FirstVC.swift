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
        view.backgroundColor = .brown
        self.viewModel.getListMovie {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        createTableView()
    }
}

extension FirstVC {
    func createTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 0),
            tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
        
        tableView.dataSource = helper
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.identificator)
    }
}

