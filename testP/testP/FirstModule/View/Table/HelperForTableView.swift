//
//  HelperForTableView.swift
//  testP
//
//  Created by Дмитрий Цветков on 12.09.2023.
//

import UIKit

class HelperForTableView: NSObject {
    var viewModel: FirstViewModelProtocol
    
    init(viewModel: FirstViewModelProtocol) {
        self.viewModel = viewModel
    }
}

extension HelperForTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.model.results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = (tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identificator, for: indexPath) as? CustomTableViewCell) else {
            return UITableViewCell()
        }
        cell.createImage(image: viewModel.model.results[indexPath.row].posterPath)
        cell.createLabel(text: viewModel.model?.results[indexPath.row].originalTitle ?? "")
        
        if let urlString = viewModel.model.results[indexPath.row].posterPath as? String {
            CoreDataManager.shared.cacheMovie(urlString: urlString, text: self.viewModel.model?.results[indexPath.row].originalTitle ?? "")
        }
        
        return cell
    }
}

