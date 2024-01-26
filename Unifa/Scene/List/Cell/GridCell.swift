//
//  GridCell.swift
//  Unifa
//
//  Created by intel on 2024/01/24.
//

import UIKit
import Kingfisher

// MARK: - Grid Cell for Search CollectionView
class GridCell: UICollectionViewCell {
    
    @IBOutlet weak var photographerNameLabe: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    func setup(with item: Photo) {
        photographerNameLabe.text = item.photographer
        imageView.load(from: URL(string: item.src.medium))
    }
}
