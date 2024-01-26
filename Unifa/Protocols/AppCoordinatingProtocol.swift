//
//  UIViewControllerCoordinatingProtocol.swift
//  Unifa
//
//  Created by intel on 2024/01/25.
//

import UIKit

// MARK: - UIViewController Coordinating Protocol
protocol UIViewControllerCoordinatingProtocol {
    associatedtype CoordinatorType
    var coordinator: CoordinatorType? { get set }
    mutating func register(to coordinator: CoordinatorType)
}

extension UIViewControllerCoordinatingProtocol where Self: UIViewController {
    mutating func register(to coordinator: CoordinatorType) {
        self.coordinator = coordinator
    }
}
