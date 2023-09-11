//
//  Storyboard+App.swift
//  PostsApp
//
//  Created by Preetham Baliga on 11/09/23.
//

import Foundation
import UIKit

protocol Storyboarded {
    static func instantiate() -> Self
}

extension Storyboarded where Self: UIViewController {

    static func instantiate() -> Self {
        let fileName = NSStringFromClass(self)
        let className = fileName.components(separatedBy: ".")[1]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: className) as! Self
    }
}
