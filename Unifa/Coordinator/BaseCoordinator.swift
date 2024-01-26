//
//  BaseCoordinator.swift
//  Unifa
//
//  Created by intel on 2024/01/23.
//

import Foundation

// MARK: - Base Coordinator Class
class BaseCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    
    func start(){
        fatalError( "Children should implement 'start'.")
    }
}
