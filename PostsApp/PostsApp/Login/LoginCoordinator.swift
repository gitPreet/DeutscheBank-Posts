//
//  LoginCoordinator.swift
//  PostsApp
//
//  Created by Preetham Baliga on 11/09/23.
//

import Foundation
import UIKit

final class LoginCoordinator {

    let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let loginVC = LoginViewController.instantiate(from: .main)
        loginVC.onLogin = { (userId) in
            
        }
        navigationController.setViewControllers([loginVC], animated: false)
    }
}
