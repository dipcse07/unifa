//
//  AppCooridnator.swift
//  Unifa
//
//  Created by intel on 2024/01/23.
//

import UIKit

// MARK: - App Coordinator
class AppCoordinator: BaseCoordinator {
    
    private let window: UIWindow?
    
    private let navigationController: UINavigationController = {
        let navigationController = UINavigationController()
        return navigationController
    }()
    
    init(window: UIWindow?) {
        self.window = window
    }
    
    override func start() {
        let searchImageCoordinator = SearchImageCoordinator(navigationController: navigationController)
        add(coodinator: searchImageCoordinator)
        searchImageCoordinator.start()
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}
