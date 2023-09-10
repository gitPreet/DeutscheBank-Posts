//
//  FavouritePostService.swift
//  UserPosts
//
//  Created by Preetham Baliga on 10/09/23.
//

import Foundation

enum FavouritePostResult {
    case success([UserPost])
    case failure(Error)
}

protocol FavouritePostService {

    func favouriteUserPost(post: UserPost, completion: @escaping () -> Void)

    func unfavouriteUserPost(post: UserPost, completion: @escaping () -> Void)

    func getAllFavouritePosts(completion: @escaping (FavouritePostResult) -> Void)
}

