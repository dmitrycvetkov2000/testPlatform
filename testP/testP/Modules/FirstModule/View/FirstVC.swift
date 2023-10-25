//
//  ViewController.swift
//  testP
//
//  Created by Дмитрий Цветков on 12.09.2023.
//

import UIKit

protocol FirstVCProtocol: AnyObject {

}

final class FirstVC: UIViewController, FirstVCProtocol, FlowControllerProtocol {
    var completionHandler: ((ImageStr) -> ())?
    
    // MARK: properties
    private let viewModel: FirstViewModelProtocol
    private let helper: HelperForTableView
    private let tableView: UITableView = UITableView()
    private let searchBar: UISearchBar = UISearchBar()
    
    // MARK: lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        createSearchBar()
        createTableView()
        self.viewModel.getListMovie {
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }
    
    init(viewModel: FirstViewModelProtocol, helper: HelperForTableView) {
        self.viewModel = viewModel
        self.helper = helper
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

    // MARK: - create View
private extension FirstVC {
    
    func createSearchBar() {
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(searchBar)
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            searchBar.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            searchBar.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
        ])
        
        searchBar.delegate = self
        
    }
    
    func createTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 0),
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
        
        if viewModel.isSearching {
            if let image = self.viewModel.filteredData.results[indexPath.row].posterPath as? UIImage {
                completionHandler?(ImageStr(image: image, id: self.viewModel.filteredData.results[indexPath.row].id))
            } else {
                APIManager.shared.loadImage(urlString: viewModel.filteredData.results[indexPath.row].posterPath as? String ?? "") { image in
                    DispatchQueue.main.async {
                        self.completionHandler?(ImageStr(image: image, id: self.viewModel.filteredData.results[indexPath.row].id))
                    }
                }
            }
        } else {
            completionHandler?(ImageStr(image: image[indexPath.row], id: viewModel.model.results[indexPath.row].id))
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.size.height - searchBar.frame.size.height
    }
}
    // MARK: - UISearchBarDelegate
extension FirstVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.filteredData.results.removeAll()
        
        guard searchText != "" || searchText != " " else {
            print("empty search")
            return
        }
        
        for elementOfSearch in viewModel.model.results {
            let text = searchText.lowercased()
            let isDataContain = elementOfSearch.originalTitle.lowercased().ranges(of: text)
            
            if !isDataContain.isEmpty {
                print("Search complete")
                viewModel.filteredData.results.append(elementOfSearch)
                print("Append = \(elementOfSearch.originalTitle)")
            }
        }
        
        if searchText.lowercased() == "" {
            viewModel.isSearching = false
            tableView.reloadData()
        } else {
            viewModel.isSearching = true
            viewModel.filteredData.results = viewModel.model.results.filter { $0.originalTitle.lowercased().contains(searchText.lowercased()) }
            tableView.reloadData()
        }
    }
}
