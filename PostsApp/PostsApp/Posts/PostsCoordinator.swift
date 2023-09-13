//
//  PostsCoordinator.swift
//  PostsApp
//
//  Created by Preetham Baliga on 12/09/23.
//

import Foundation
import UIKit

final class PostsCoordinator: Coordinator {

    let navigationController: UINavigationController

    var showLoginScreen: (() -> Void)?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {

        let postVC = PostsListViewController.instantiate(from: .posts)
        postVC.tabBarItem.title = "All Posts"
        postVC.tabBarItem.image = UIImage(systemName: "newspaper")

        let favouriteVC = FavouritePostsViewController.instantiate(from: .posts)
        favouriteVC.tabBarItem.title = "Favourite Posts"
        favouriteVC.tabBarItem.image = UIImage(systemName: "star.fill")

        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [postVC, favouriteVC]

        let logoutButton = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logoutButtonTapped))
        tabBarController.navigationItem.rightBarButtonItem = logoutButton
        tabBarController.title = "My Posts"

        navigationController.setViewControllers([tabBarController], animated: true)
    }

    @objc func logoutButtonTapped() {
        showLoginScreen?()
    }
}
