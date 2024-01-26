//
//  PreviewViewController.swift
//  Unifa
//
//  Created by intel on 2024/01/23.
//

import UIKit
import RxSwift
import RxCocoa
import NSObject_Rx

// MARK: - Image Preview View Controller
class PreviewViewController: ViewController,
                             ViewModelBindableProtocol {
    
    @IBOutlet weak var previewImageView: UIImageView!
    
    var viewModel: PreviewViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
    }
}

// MARK: - Bindings
private extension PreviewViewController {
    func setupBindings() {
        rx.viewDidAppear
            .mapToVoid()
            .bind(to: viewModel.input.viewDidAppear)
            .disposed(by: rx.disposeBag)
        
        viewModel.output
            .imageUrl
            .filter { !$0.isEmpty }
            .map { URL(string: $0) }
            .drive(previewImageView.rx.setImage)
            .disposed(by: rx.disposeBag)
    }
}


