//
//  ObservableType+Ext.swift
//  Unifa
//
//  Created by intel on 2024/01/24.
//

import Foundation
import RxSwift
import RxCocoa

// MARK: - ObservableType Extension
extension ObservableType {
    func mapToVoid() -> Observable<Void> {
        map { _ in }
    }
}

// MARK: - Shared Sequence Convertible Type Extension
extension SharedSequenceConvertibleType {
    func mapToVoid() -> SharedSequence<SharingStrategy, Void> {
        return map { _ in }
    }
}
