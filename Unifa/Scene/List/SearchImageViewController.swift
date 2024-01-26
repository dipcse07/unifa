//
//  SearchImageViewController.swift
//  Unifa
//
//  Created by intel on 2024/01/23.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import NSObject_Rx

// MARK: - Search ImageViewController / Initial View Controller
class SearchImageViewController: ViewController,
                                 UIViewControllerCoordinatingProtocol,
                                 ViewModelBindableProtocol {

    // MARK: - IBOutlet
    @IBOutlet private weak var collectionView: GridCollectionView! {
        didSet {
            collectionView.register(GridCell.self)
            collectionView.keyboardDismissMode = .onDrag
        }
    }
    
    var viewModel: SearchImageViewModel!
    var coordinator: SearchImageCoordinator?
    
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = Constants.searchPlaceholder
        return searchController
    }()
    
    private var dataSource: RxCollectionViewSectionedAnimatedDataSource<PhotoSection>?
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationItem()
        setupObserver()
    }
}

// MARK: - Setup Observer
extension SearchImageViewController {
    
    private func setupObserver() {
        
        setupDataSource()
        guard let dataSource else { return }
        
        // input
        searchController.searchBar
            .rx.text.orEmpty
            .throttle(.microseconds(300), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .filter { $0.count >= 2 }
            .bind(to: viewModel.input.searchText)
            .disposed(by: rx.disposeBag)
        
        collectionView.rx.reachedBottom()
            .mapToVoid()
            .bind(to: viewModel.input.nextPageRequest)
            .disposed(by: rx.disposeBag)
        
        // Handle cell selection
          collectionView.rx.modelSelected(Photo.self)
              .bind(to: viewModel.input.selectedImage)
              .disposed(by: rx.disposeBag)
        
        // output
        viewModel.output
            .sections
            .drive(collectionView.rx.items(dataSource: dataSource))
            .disposed(by: rx.disposeBag)
        
        viewModel.output
            .didPreviewScreenRequest
            .drive(rx.previewRequest)
            .disposed(by: rx.disposeBag)
        
    }
}

// MARK: - Utility
extension SearchImageViewController {
    private func setupNavigationItem() {
        navigationItem.title = Constants.imageSearch
        navigationItem.searchController = searchController
    }
}

// MARK: - Data Source
extension SearchImageViewController {
    private func setupDataSource() {
        dataSource = RxCollectionViewSectionedAnimatedDataSource(configureCell: { _, collectionView, indexPath, item in
            let cell = collectionView.dequeueReusableCell(with: GridCell.self, for: indexPath)
            cell.setup(with: item)
            return cell
        })
    }
}

extension Reactive where Base: SearchImageViewController {
    var previewRequest: Binder<Src> {
        Binder(base) { base, src in
            base.coordinator?.showPreview(with: src)
        }
    }
}


