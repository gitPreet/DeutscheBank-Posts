//
//  PostsCoordinator.swift
//  PostsApp
//
//  Created by Preetham Baliga on 12/09/23.
//

import Foundation
import UIKit

final class PostsCoordinator {

    let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let postVC = PostsListViewController.instantiate(from: .posts)
        navigationController.setViewControllers([postVC], animated: true)
    }
}
