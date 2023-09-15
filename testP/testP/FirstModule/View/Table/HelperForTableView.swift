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
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = (tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identificator, for: indexPath) as? CustomTableViewCell) else {
            return UITableViewCell()
        }
        cell.createImage(urlImageString: "https://image.tmdb.org/t/p/w500/gEU2QniE6E77NI6lCU6MxlNBvIx.jpg")
        cell.createLabel(text: "No")
        
        return cell
    }
}
