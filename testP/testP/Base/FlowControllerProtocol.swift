//
//  FlowController.swift
//  testP
//
//  Created by Дмитрий Цветков on 23.10.2023.
//

import Foundation

protocol FlowControllerProtocol {
    associatedtype T
    var completionHandler: ((T) -> ())? { get set }
}
