//
//  AppCoordinator.swift
//  PostsApp
//
//  Created by Preetham Baliga on 11/09/23.
//

import Foundation
import UIKit
import UserPosts
import CoreData

public protocol Coordinator: AnyObject {
    func start()
}

final class AppCoordinator: Coordinator {

    let navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        showLoginScreen()
    }

    func showLoginScreen() {
        let loginCoordinator = LoginCoordinator(navigationController: navigationController)
        loginCoordinator.showPosts = { [weak self, weak loginCoordinator] (userId) in
            self?.showUserPosts(userId: userId)
            self?.remove(coordinator: loginCoordinator!)
        }
        childCoordinators.append(loginCoordinator)
        loginCoordinator.start()
    }

    func showUserPosts(userId: Int) {
        let postsCoordinator = makePostsCoordinator(userId: userId)
        childCoordinators.append(postsCoordinator)
        postsCoordinator.start()
    }

    func remove(coordinator: Coordinator) {
        if let index = childCoordinators.firstIndex(where: { $0 === coordinator }) {
            childCoordinators.remove(at: index)
        }
    }
}

extension AppCoordinator {

    private func makePostsCoordinator(userId: Int) -> PostsCoordinator {
        let remoteUrl = URL(string: "https://jsonplaceholder.typicode.com/posts")!
        let localStoreURL = NSPersistentContainer
            .defaultDirectoryURL()
            .appendingPathComponent("UserPostsStore.sqlite")

        let remotePostsLoader = RemotePostsLoader(client: URLSessionHTTPClient(), url: remoteUrl)
        let coreDataStore = try! CoreDataStore(storeURL: localStoreURL)
        let localPostsService = LocalFavouritePostService(store: coreDataStore)

        let postsModuleDependencies = PostsCoordinator.Dependencies(postsLoader: remotePostsLoader,
                                                                    userService: UserServiceAdapter(userId: userId),
                                                                    favouriteService: localPostsService,
                                                                    logoutService: coreDataStore)

        let postsCoordinator = PostsCoordinator(navigationController: navigationController,
                                                dependencies: postsModuleDependencies)

        postsCoordinator.showLoginScreen = { [weak self, weak postsCoordinator] in
            self?.showLoginScreen()
            self?.remove(coordinator: postsCoordinator!)
        }
        return postsCoordinator
    }
}
