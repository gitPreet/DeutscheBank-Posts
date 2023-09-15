//
//  FavouritePostsViewModel.swift
//  PostsApp
//
//  Created by Preetham Baliga on 14/09/23.
//

import Foundation
import UserPosts

class FavouritePostListViewModel {

    let favouriteService: FavouritePostService

    var onFetch: (([FavouritePostItemViewModel]) -> Void)?
    var onError: ((Error) -> ())?

    typealias FavouritePostListViewModelDependencies = HasFavouriteService

    init(dependencies: FavouritePostListViewModelDependencies) {
        self.favouriteService = dependencies.favouriteService
    }

    func loadFavouritePosts() {
        favouriteService.getAllFavouritePosts { [weak self] result in
            switch result {
            case .success(let posts):
                var viewModels = [FavouritePostItemViewModel]()
                for post in posts {
                    let vm = FavouritePostItemViewModel(titleText: post.title, bodyText: post.body)
                    viewModels.append(vm)
                }
                self?.onFetch?(viewModels)

            case .failure(let error):
                self?.onError?(error)
                
            }
        }
    }
}
