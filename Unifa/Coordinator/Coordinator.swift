//
//  Coordinator.swift
//  Unifa
//
//  Created by intel on 2024/01/23.
//

// // MARK: - Coordinator Protocol
protocol Coordinator: AnyObject {
    
    var childCoordinators: [Coordinator] {get set}
    
    func start ()
}



