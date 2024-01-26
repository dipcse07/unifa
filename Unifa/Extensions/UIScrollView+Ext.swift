//
//  UIScrollView+Ext.swift
//  Unifa
//
//  Created by intel on 2024/01/26.
//

import RxSwift
import RxCocoa

// MARK: - Extends UIScrollView
extension Reactive where Base: UIScrollView {
    
    func reachedBottom() -> ControlEvent<Bool> {
        let offset: CGFloat = 0.0
        let source = contentOffset.map { contentOffset in
            let visibleHeight = self.base.frame.height - self.base.contentInset.top - self.base.contentInset.bottom
            let y = contentOffset.y + self.base.contentInset.top
            let threshold = max(offset, self.base.contentSize.height - visibleHeight)
            return y >= threshold
        }
        .distinctUntilChanged()
        .filter { $0 }
        return ControlEvent(events: source)
    }
}
