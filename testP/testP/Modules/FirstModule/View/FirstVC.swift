//
//  ViewController.swift
//  testP
//
//  Created by Дмитрий Цветков on 12.09.2023.
//

import UIKit

protocol FirstVCProtocol: AnyObject {

}

final class FirstVC: UIViewController, FirstVCProtocol {
    // MARK: properties
    private var viewModel: FirstViewModelProtocol
    private var coordinator: RouterProtocol
    private var helper: HelperForTableView
    private var tableView: UITableView = UITableView()
    
    // MARK: lifecycle
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
    
    init(viewModel: FirstViewModelProtocol, coordinator: RouterProtocol, helper: HelperForTableView) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        self.helper = helper
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

    // MARK: - create View
private extension FirstVC {
    
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

    // MARK: - UITableViewDelegate
extension FirstVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let image: [UIImage] = CoreDataManager.shared.getElementFromBD(findKey: AllEnums.keys(key: .photo))
        coordinator.showDetail(id: viewModel.model.results[indexPath.row].id, image: image[indexPath.row])
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.size.height
    }
}
