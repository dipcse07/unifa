//
//  SearchImageCoordinator.swift
//  Unifa
//
//  Created by intel on 2024/01/23.
//
import UIKit

// MARK: - SearchImageCoordinator / Initial ViewController Coordinator
class SearchImageCoordinator: BaseCoordinator {
    
    private var navigationController: UINavigationController
    
    init(navigationController: UINavigationController){
        self.navigationController = navigationController
    }
    
    override func start() {
        var searchController: SearchImageViewController = .instantiate()
        let viewModel = SearchImageViewModel(apiClient: APIService())
        searchController.bind(to: viewModel)
        searchController.register(to: self)
        navigationController.setViewControllers([searchController], animated: true)
    }
    
    func showPreview(with imageSrc: Src) {
        let previewViewModel = PreviewViewModel(src: imageSrc)
        var previewViewController: PreviewViewController = .instantiate()
        previewViewController.bind(to: previewViewModel)
        navigationController.pushViewController(previewViewController, animated: true)
    }
}


