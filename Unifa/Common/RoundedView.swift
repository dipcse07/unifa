//
//  RoundedView.swift
//  Unifa
//
//  Created by intel on 2024/01/24.
//

import UIKit

// MARK: - Designable UIViiew
@IBDesignable
class RoundedView: UIView {
    
    @IBInspectable var backGroundColor: UIColor = .clear {
        didSet {
            roundCorners()
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            roundCorners()
        }
    }
    
    @IBInspectable var shadowColor: UIColor = UIColor.darkGray {
        didSet {
            roundCorners()
        }
    }
    
    @IBInspectable var shadowOffsetWidth: CGFloat = 0.0 {
        didSet {
            roundCorners()
        }
    }
    
    @IBInspectable var shadowOffsetHeight: CGFloat = 0.8 {
        didSet {
            roundCorners()
        }
    }
    
    @IBInspectable var shadowOpacity: Float = 0.30 {
        didSet {
            roundCorners()
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat = 3.0 {
        didSet {
            roundCorners()
        }
    }
    
    @IBInspectable var opacity: CGFloat = 1.0 {
        didSet {
            roundCorners()
        }
    }
    
    private var shadowLayer: CAShapeLayer = CAShapeLayer() {
        didSet {
            roundCorners()
        }
    }
    
    @IBInspectable private var maskClip:Bool = false {
        didSet {
            roundCorners()
        }
    }
    
    override func awakeFromNib() {
        self.roundCorners()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        roundCorners()
    }
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        roundCorners()
    }
    
    private func roundCorners() {
        layer.backgroundColor = backGroundColor.cgColor
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOffset = CGSize(width: shadowOffsetWidth,
                                    height: shadowOffsetHeight)
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = shadowRadius
        layer.cornerRadius = cornerRadius
        self.clipsToBounds = maskClip
        
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.roundCorners()
    }
    
}
