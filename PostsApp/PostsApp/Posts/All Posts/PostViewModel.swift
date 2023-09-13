//
//  PostViewModel.swift
//  PostsApp
//
//  Created by Preetham Baliga on 13/09/23.
//

import Foundation
import UserPosts

final class PostsViewModel {

    let postsLoader: UserPostsLoader
    let userService: UserService

    var onFetch: (([PostListViewModel]) -> Void)?
    var onError: ((Error) -> ())?

    init(postsLoader: UserPostsLoader, userService: UserService) {
        self.postsLoader = postsLoader
        self.userService = userService
    }

    func fetchAllPosts() {
        postsLoader.fetchUserPosts(userId: userService.userId) { [weak self] result in
            switch result {
            case .success(let posts):
                let viewModels = posts.map {
                    PostListViewModel(titleText: $0.title, bodyText: $0.body)
                }
                self?.onFetch?(viewModels)

            case .failure(let error):
                self?.onError?(error)
            }
        }
    }
}
