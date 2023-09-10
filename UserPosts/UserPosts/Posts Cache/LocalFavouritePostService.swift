//
//  LocalFavouriteService.swift
//  UserPosts
//
//  Created by Preetham Baliga on 10/09/23.
//

import Foundation

class LocalFavouritePostService: FavouritePostService {

    let store: UserPostStore

    init(store: UserPostStore) {
        self.store = store
    }

    func favouriteUserPost(post: UserPost, completion: @escaping () -> Void) {

    }
    
    func unfavouriteUserPost(post: UserPost, completion: @escaping () -> Void) {

    }
    
    func getAllFavouritePosts(completion: @escaping (FavouritePostResult) -> Void) {

    }
}
