//
//  StoryBoarded.swift
//  Unifa
//
//  Created by intel on 2024/01/23.
//

import UIKit

// MARK: - Storyboard Initiate Protocol
protocol Storyboarded {
    static var storyboardIdentifier: String { get }
    static func instantiate<T>() -> T where T: Storyboarded
}

extension UIViewController: Storyboarded {}
    
    

