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
    let favouriteService: FavouritePostService

    typealias PostListViewModelDependencies = HasUserPostsLoader & HasUserService & HasFavouriteService

    var onFetch: (([PostItemViewModel]) -> Void)?
    var onError: ((Error) -> ())?

    init(dependencies: PostListViewModelDependencies) {
        self.postsLoader = dependencies.postsLoader
        self.userService = dependencies.userService
        self.favouriteService = dependencies.favouriteService
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
        self.favouriteService.favouriteUserPost(post: post) { error in
            print("Completed favourite post with error = \(String(describing: error?.localizedDescription))")
        }
    }
}
