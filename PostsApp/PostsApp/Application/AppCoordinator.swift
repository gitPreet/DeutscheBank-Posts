//
//  AppCoordinator.swift
//  PostsApp
//
//  Created by Preetham Baliga on 11/09/23.
//

import Foundation
import UIKit

final class AppCoordinator {

    let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
//        let loginCoordinator = LoginCoordinator(navigationController: navigationController)
//        loginCoordinator.start()
        
        let postCoordinator = PostsCoordinator(navigationController: navigationController)
        postCoordinator.start()
    }
}
