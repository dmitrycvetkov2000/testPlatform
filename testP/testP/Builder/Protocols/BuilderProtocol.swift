//
//  BuilderProtocol.swift
//  testP
//
//  Created by Дмитрий Цветков on 12.09.2023.
//

import UIKit

protocol BuilderProtocol: AnyObject {
    func createFirst() -> FirstVCProtocol
}
