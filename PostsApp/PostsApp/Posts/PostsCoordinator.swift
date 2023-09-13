//
//  PostsCoordinator.swift
//  PostsApp
//
//  Created by Preetham Baliga on 12/09/23.
//

import Foundation
import UIKit
import UserPosts

final class PostsCoordinator: Coordinator {

    let navigationController: UINavigationController
    let postsLoader: UserPostsLoader
    let userService: UserService

    var showLoginScreen: (() -> Void)?

    init(navigationController: UINavigationController, postsLoader: UserPostsLoader, userService: UserService) {
        self.navigationController = navigationController
        self.postsLoader = postsLoader
        self.userService = userService
    }

    func start() {

        let postVC = makePostListViewController()

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

    private func makePostListViewController() -> PostsListViewController {
        let postVC = PostsListViewController.instantiate(from: .posts)
        let postVM = PostsViewModel(postsLoader: postsLoader, userService: userService)
        postVC.viewModel = postVM
        postVC.tabBarItem.title = "All Posts"
        postVC.tabBarItem.image = UIImage(systemName: "newspaper")
        return postVC
    }

    @objc func logoutButtonTapped() {
        showLoginScreen?()
    }
}
