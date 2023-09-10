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

    func favouriteUserPost(post: UserPost, completion: @escaping (Error?) -> Void) {

        store.insert(post: post) { error in
            completion(error)
        }
    }
    
    func unfavouriteUserPost(post: UserPost, completion: @escaping (Error?) -> Void) {
        store.delete(post: post) { error in
            completion(error)
        }
    }
    
    func getAllFavouritePosts(completion: @escaping (FavouritePostResult) -> Void) {
        store.retrieveFavouritePosts { result in
            switch result {
            case .empty: completion(.success([]))
            case .found(let posts): completion(.success(posts))
            case .failure(let error): completion(.failure(error))
            }
        }
    }
}
