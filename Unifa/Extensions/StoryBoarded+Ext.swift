//
//  StoryBoarded+Ext.swift
//  Unifa
//
//  Created by intel on 2024/01/24.
//

import UIKit

// MARK: - StoryBoard Extension
extension Storyboarded where Self: UIViewController {
    
    static var storyboardIdentifier: String {
        "\(Self.self)"
    }
    
    static var storyboard: UIStoryboard {
        UIStoryboard(name: storyboardIdentifier, bundle: nil)
    }
    
    static func instantiate<T>() -> T where T: Storyboarded {
        storyboard.instantiateViewController(withIdentifier: T.storyboardIdentifier) as! T
    }
}
