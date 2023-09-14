//
//  FavouritePostService.swift
//  UserPosts
//
//  Created by Preetham Baliga on 10/09/23.
//

import Foundation

public enum FavouritePostResult {
    case success([UserPost])
    case failure(Error)
}

public protocol FavouritePostService {

    func favouriteUserPost(post: UserPost, completion: @escaping (Error?) -> Void)

    func unfavouriteUserPost(post: UserPost, completion: @escaping (Error?) -> Void)

    func getAllFavouritePosts(completion: @escaping (FavouritePostResult) -> Void)
}

