//
//  PostsDIContainer.swift
//  PostsApp
//
//  Created by Preetham Baliga on 15/09/23.
//

import Foundation
import UserPosts

protocol HasUserPostsLoader {
    var postsLoader: UserPostsLoader { get }
}

protocol HasUserService {
    var userService: UserService { get }
}

protocol HasFavouriteService {
    var favouriteService: FavouritePostService { get }
}

protocol HasLogoutService {
    var logoutService: LogoutService { get }
}

typealias PostModuleDependencies = HasUserPostsLoader &
HasUserService &
HasFavouriteService &
HasLogoutService

struct PostsDIContainer {
    let dependencies: PostModuleDependencies
}
