//
//  FavouritePostsViewModel.swift
//  PostsApp
//
//  Created by Preetham Baliga on 14/09/23.
//

import Foundation
import UserPosts

class FavouritePostListViewModel {

    typealias FavouritePostListViewModelDependencies = HasFavouriteService

    let favouriteService: FavouritePostService

    init(dependencies: FavouritePostListViewModelDependencies) {
        self.favouriteService = dependencies.favouriteService
    }

    var onFetch: (() -> Void)?
    var onError: ((Error) -> ())?

    private var favPostItems = [UserPost]()
    var favItemViewModels = [FavouritePostItemViewModel]()

    func loadFavouritePosts() {
        favouriteService.getAllFavouritePosts { [weak self] result in
            switch result {
            case .success(let posts):
                
                self?.favItemViewModels.removeAll()
                self?.favPostItems.removeAll()

                self?.favPostItems = posts
                for post in posts {
                    let vm = FavouritePostItemViewModel(titleText: post.title, bodyText: post.body)
                    self?.favItemViewModels.append(vm)
                }
                self?.onFetch?()

            case .failure(let error):
                self?.onError?(error)
                
            }
        }
    }
}
