//
//  Coordinator+Ext.swift
//  Unifa
//
//  Created by intel on 2024/01/24.
//

// MARK: - Coordinator Extension
extension Coordinator {
    func add (coodinator: Coordinator) -> Void { childCoordinators.append(coodinator)
    }

    func remove (coordinator: Coordinator) -> Void {
        childCoordinators = childCoordinators.filter({ $0 !== coordinator  })
    }
}
