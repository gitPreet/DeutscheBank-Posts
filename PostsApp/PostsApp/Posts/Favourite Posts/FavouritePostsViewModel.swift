//
//  FavouritePostsViewModel.swift
//  PostsApp
//
//  Created by Preetham Baliga on 14/09/23.
//

import Foundation
import UserPosts

protocol FavouritePostListViewModelType {
    var onFetch: (() -> Void)? { get set }
    var onError: ((Error) -> ())? { get set }
    var favItemCount: Int { get }

    func favPost(at index: Int) -> FavouritePostItemViewModel
    func loadFavouritePosts()
}

class FavouritePostListViewModel: FavouritePostListViewModelType {

    typealias FavouritePostListViewModelDependencies = HasFavouriteService

    let favouriteService: FavouritePostService

    init(dependencies: FavouritePostListViewModelDependencies) {
        self.favouriteService = dependencies.favouriteService
    }

    private var favPostItems = [UserPost]()
    private var favItemViewModels = [FavouritePostItemViewModel]()

    var onFetch: (() -> Void)?
    var onError: ((Error) -> ())?

    var favItemCount: Int {
        return favPostItems.count
    }

    func favPost(at index: Int) -> FavouritePostItemViewModel {
        return favItemViewModels[index]
    }

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
