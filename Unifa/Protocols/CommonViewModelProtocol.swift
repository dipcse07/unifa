//
//  CommonViewModelProtocol.swift
//  Unifa
//
//  Created by intel on 2024/01/24.
//

import Foundation

// MARK: - CommonViewModel Protocol
protocol CommonViewModelProtocol {
    associatedtype Input
    
    associatedtype Output
    
    var input: Input! { get set }
    
    var output: Output! { get set }
    
    func bind()
}
