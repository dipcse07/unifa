//
//  UICollectionView+Ext.swift
//  Unifa
//
//  Created by intel on 2024/01/24.
//

import UIKit

// MARK: - UICollectionView Extension
extension UICollectionView {
    
    func register<Cell: UICollectionViewCell>(_ cell: Cell.Type) {
        let identifier = String(describing: cell)
        if Bundle.main.path(forResource: identifier, ofType: "nib") != nil {
            // Cell has associated XIB
            register(UINib(nibName: identifier, bundle: nil), forCellWithReuseIdentifier: identifier)
        } else {
            register(cell, forCellWithReuseIdentifier: identifier)
        }
    }
    
    func dequeueReusableCell<Cell: UICollectionViewCell>(with cellType: Cell.Type, for indexPath: IndexPath) -> Cell {
        return dequeueReusableCell(withReuseIdentifier: String(describing: cellType), for: indexPath) as! Cell
    }
}
