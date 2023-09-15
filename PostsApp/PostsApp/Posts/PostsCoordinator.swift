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

    struct Dependencies: PostModuleDependencies {
        var postsLoader: UserPostsLoader
        var userService: UserService
        var favouriteService: FavouritePostService
        var logoutService: LogoutService
    }

    let navigationController: UINavigationController
    let diContainer: PostsDIContainer

    init(navigationController: UINavigationController, dependencies: Dependencies) {
        self.navigationController = navigationController
        self.diContainer = PostsDIContainer(dependencies: dependencies)
    }

    var showLoginScreen: (() -> Void)?

    func start() {
        let postVC = makePostListViewController()
        let favouriteVC = makeFavouritesListController()
        let tabBarController = makeTabBarController(with: postVC, second: favouriteVC)

        navigationController.setViewControllers([tabBarController], animated: true)
    }

    private func makePostListViewController() -> PostsListViewController {
        let postVC = PostsListViewController.instantiate(from: .posts)
        let postListVM = PostListViewModel(dependencies: diContainer.dependencies)
        postVC.viewModel = postListVM
        postVC.tabBarItem.title = "All Posts"
        postVC.tabBarItem.image = UIImage(systemName: "newspaper")
        return postVC
    }

    private func makeFavouritesListController() -> FavouritePostsViewController {
        let favouriteVC = FavouritePostsViewController.instantiate(from: .posts)
        let favPostListVM = FavouritePostListViewModel(dependencies: diContainer.dependencies)
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
        diContainer.dependencies.logoutService.clearStoredData()
        showLoginScreen?()
    }
}
