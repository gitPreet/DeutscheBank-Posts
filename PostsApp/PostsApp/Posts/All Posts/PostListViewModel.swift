//
//  PostListViewModel.swift
//  PostsApp
//
//  Created by Preetham Baliga on 13/09/23.
//

import Foundation
import UserPosts

final class PostListViewModel {

    let postsLoader: UserPostsLoader
    let userService: UserService

    var onFetch: (([PostItemViewModel]) -> Void)?
    var onError: ((Error) -> ())?

    init(postsLoader: UserPostsLoader, userService: UserService) {
        self.postsLoader = postsLoader
        self.userService = userService
    }

    func fetchAllPosts() {
        postsLoader.fetchUserPosts(userId: userService.userId) { [weak self] result in
            switch result {
            case .success(let posts):
                var viewModels = [PostItemViewModel]()
                for post in posts {
                    let itemViewModel = PostItemViewModel(titleText: post.title,
                                                          bodyText: post.body) {
                        self?.favourite(post: post)
                    }
                    viewModels.append(itemViewModel)
                }
                self?.onFetch?(viewModels)

            case .failure(let error):
                self?.onError?(error)
            }
        }
    }

    private func favourite(post: UserPost) {
       print("Favourite post")
    }
}
