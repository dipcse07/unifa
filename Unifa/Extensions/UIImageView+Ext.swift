//
//  UIImageView+Ext.swift
//  Unifa
//
//  Created by intel on 2024/01/26.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher

// MARK: - UIImageView Extension
extension UIImageView {
    func load(from url: URL?) {
        kf.indicatorType = .activity
        kf.setImage(
            with: url,
            options: [
                .transition(.fade(2))
            ]
        )
    }
}

extension Reactive where Base: UIImageView {
    var setImage: Binder<URL?> {
        Binder(base) { base, url in
            base.load(from: url)
        }
    }
    
}
