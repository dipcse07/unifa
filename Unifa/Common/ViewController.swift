//
//  ViewController.swift
//  Unifa
//
//  Created by intel on 2024/01/24.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {}

// MARK: - Reactive
extension Reactive where Base: UIViewController {
    
    var viewDidAppear: Observable<Void> {
        methodInvoked(#selector(UIViewController.viewDidAppear(_:))).mapToVoid()
    }

}
