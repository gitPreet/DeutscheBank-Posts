//
//  Storyboard+App.swift
//  PostsApp
//
//  Created by Preetham Baliga on 11/09/23.
//

import Foundation
import UIKit

protocol Storyboarded {
    static func instantiate(from storyboard: Storyboard) -> Self
}

enum Storyboard: String {
    case main = "Main"
    case posts = "Posts"
}

extension Storyboarded where Self: UIViewController {

    static func instantiate(from storyboard: Storyboard) -> Self {
        let className = String(describing: self)
        let storyboard = UIStoryboard(name: storyboard.rawValue, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: className) as! Self
    }
}
