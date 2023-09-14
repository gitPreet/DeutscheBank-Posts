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
    let favouriteService: FavouritePostService

    var showLoginScreen: (() -> Void)?

    init(navigationController: UINavigationController,
         postsLoader: UserPostsLoader,
         userService: UserService,
         favouriteService: FavouritePostService) {
        self.navigationController = navigationController
        self.postsLoader = postsLoader
        self.userService = userService
        self.favouriteService = favouriteService
    }

    func start() {

        let postVC = makePostListViewController()
        let favouriteVC = makeFavouritesListController()
        let tabBarController = makeTabBarController(with: postVC, second: favouriteVC)

        navigationController.setViewControllers([tabBarController], animated: true)
    }

    private func makePostListViewController() -> PostsListViewController {
        let postVC = PostsListViewController.instantiate(from: .posts)
        let postListVM = PostListViewModel(postsLoader: postsLoader,
                                           userService: userService,
                                           favouriteService: favouriteService)
        postVC.viewModel = postListVM
        postVC.tabBarItem.title = "All Posts"
        postVC.tabBarItem.image = UIImage(systemName: "newspaper")
        return postVC
    }

    private func makeFavouritesListController() -> FavouritePostsViewController {
        let favouriteVC = FavouritePostsViewController.instantiate(from: .posts)
        let favPostListVM = FavouritePostListViewModel(favouriteService: favouriteService)
        favouriteVC.viewModel = favPostListVM
        favouriteVC.tabBarItem.title = "Favourite Posts"
        favouriteVC.tabBarItem.image = UIImage(systemName: "star.fill")
        return favouriteVC
    }

    private func makeTabBarController(with first: UIViewController, second: UIViewController) -> UITabBarController {
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [first, second]

        let logoutButton = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logoutButtonTapped))
        tabBarController.navigationItem.rightBarButtonItem = logoutButton
        tabBarController.title = "My Posts"

        return tabBarController
    }

    @objc func logoutButtonTapped() {
        showLoginScreen?()
    }
}
