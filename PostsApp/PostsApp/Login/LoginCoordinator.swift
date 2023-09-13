//
//  LoginCoordinator.swift
//  PostsApp
//
//  Created by Preetham Baliga on 11/09/23.
//

import Foundation
import UIKit

final class LoginCoordinator: Coordinator {

    let navigationController: UINavigationController

    var showPosts: ((Int) -> Void)?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let loginVC = LoginViewController.instantiate(from: .main)
        loginVC.onLogin = { [weak self] (userId) in
            self?.showPosts?(userId)
        }
        navigationController.setViewControllers([loginVC], animated: false)
    }
}
