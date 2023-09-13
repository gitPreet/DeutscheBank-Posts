//
//  AppCoordinator.swift
//  PostsApp
//
//  Created by Preetham Baliga on 11/09/23.
//

import Foundation
import UIKit
import UserPosts

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
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!
        let remotePostsLoader = RemotePostsLoader(client: URLSessionHTTPClient(), url: url)
        let postsCoordinator = PostsCoordinator(navigationController: navigationController,
                                                postsLoader: remotePostsLoader,
                                                userService: UserServiceAdapter(userId: userId))
        postsCoordinator.showLoginScreen = { [weak self, weak postsCoordinator] in
            self?.showLoginScreen()
            self?.remove(coordinator: postsCoordinator!)
        }
        return postsCoordinator
    }
}
