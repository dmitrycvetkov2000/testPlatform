//
//  HelperForTableView.swift
//  testP
//
//  Created by Дмитрий Цветков on 12.09.2023.
//

import UIKit

final class HelperForTableView: NSObject {
    // MARK: properties
    var viewModel: FirstViewModelProtocol
    
    init(viewModel: FirstViewModelProtocol) {
        self.viewModel = viewModel
    }
}

    // MARK: - UITableViewDataSourcees
extension HelperForTableView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.model.results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = (tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identificator, for: indexPath) as? CustomTableViewCell) else {
            return UITableViewCell()
        }
        cell.createImage(image: viewModel.model.results[indexPath.row].posterPath)
        cell.createLabel(text: viewModel.model.results[indexPath.row].originalTitle)
        
        if let urlString = self.viewModel.model.results[indexPath.row].posterPath as? String {
            DispatchQueue.global().sync {
                CoreDataManager.shared.cacheMovie(urlString: urlString, text: self.viewModel.model.results[indexPath.row].originalTitle, id: self.viewModel.model.results[indexPath.row].id)
            }
        }
        return cell
    }
    
}


