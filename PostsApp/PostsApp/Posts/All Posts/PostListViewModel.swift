//
//  PostListViewModel.swift
//  PostsApp
//
//  Created by Preetham Baliga on 13/09/23.
//

import Foundation
import UserPosts

final class PostListViewModel {

    typealias PostListViewModelDependencies = HasUserPostsLoader & HasUserService & HasFavouriteService

    let postsLoader: UserPostsLoader
    let userService: UserService
    let favouriteService: FavouritePostService

    init(dependencies: PostListViewModelDependencies) {
        self.postsLoader = dependencies.postsLoader
        self.userService = dependencies.userService
        self.favouriteService = dependencies.favouriteService
    }

    var onFetch: (() -> Void)?
    var refreshData: (() -> Void)?
    var onEmptyList: (() -> ())?
    var onError: ((Error) -> ())?

    private var postItems = [UserPost]()
    var itemViewModels = [PostItemViewModel]()

    func fetchAllPosts() {
        postsLoader.fetchUserPosts(userId: userService.userId) { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let posts):
                self.postItems = posts
                for post in posts {
                    let itemViewModel = PostItemViewModel(titleText: post.title,
                                                          bodyText: post.body,
                                                          isFavourited: false) {
                        self.favourite(post: post)
                    }
                    self.itemViewModels.append(itemViewModel)
                }

                if self.itemViewModels.isEmpty {
                    self.onEmptyList?()
                } else {
                    self.onFetch?()
                }

            case .failure(let error):
                self.onError?(error)
            }
        }
    }

    private func favourite(post: UserPost) {
        self.favouriteService.favouriteUserPost(post: post) { [weak self] error in
            if error == nil {
                if let index = self?.postItems.firstIndex(of: post) {
                    self?.itemViewModels[index].isFavourited = true
                    self?.refreshData?()
                }
            }
        }
    }
}
