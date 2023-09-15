//
//  PostListViewModel.swift
//  PostsApp
//
//  Created by Preetham Baliga on 13/09/23.
//

import Foundation
import UserPosts

protocol PostListViewModelType {

    var onFetch: (() -> Void)? { get set }
    var refreshData: (() -> Void)? { get set }
    var onEmptyList: (() -> ())? { get set }
    var onError: ((Error) -> ())? { get set }
    var itemCount: Int { get }

    func item(at index: Int) -> PostItemViewModel
    func fetchAllPosts()
}

final class PostListViewModel: PostListViewModelType {

    typealias PostListViewModelDependencies = HasUserPostsLoader & HasUserService & HasFavouriteService

    let postsLoader: UserPostsLoader
    let userService: UserService
    let favouriteService: FavouritePostService

    init(dependencies: PostListViewModelDependencies) {
        self.postsLoader = dependencies.postsLoader
        self.userService = dependencies.userService
        self.favouriteService = dependencies.favouriteService
    }

    private var postItems = [UserPost]()
    private var itemViewModels = [PostItemViewModel]()

    var onFetch: (() -> Void)?
    var refreshData: (() -> Void)?
    var onEmptyList: (() -> ())?
    var onError: ((Error) -> ())?

    var itemCount: Int {
        return itemViewModels.count
    }
    
    func item(at index: Int) -> PostItemViewModel {
        return itemViewModels[index]
    }

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
