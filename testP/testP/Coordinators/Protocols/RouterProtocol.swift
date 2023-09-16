//
//  RouterProtocol.swift
//  testP
//
//  Created by Дмитрий Цветков on 16.09.2023.
//

import UIKit

protocol RouterProtocol: RouterMainProtocol {
    func showFirst()
    func showDetail(id: Int, image: UIImage)
}
