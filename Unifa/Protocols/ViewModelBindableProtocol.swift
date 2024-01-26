//
//  ViewModelBindableProtocol.swift
//  Unifa
//
//  Created by intel on 2024/01/25.
//

import UIKit

// MARK: - View Model Bindable Protocol
protocol ViewModelBindableProtocol {
    associatedtype ViewModelType
    var viewModel: ViewModelType! { get set }
    mutating func bind(to viewModel: ViewModelType)
}

extension ViewModelBindableProtocol where Self: UIViewController {
    mutating func bind(to viewModel: ViewModelType) {
        self.viewModel = viewModel
    }
}
