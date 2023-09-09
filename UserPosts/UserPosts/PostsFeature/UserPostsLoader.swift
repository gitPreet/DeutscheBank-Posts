//
//  UserPostsLoader.swift
//  UserPosts
//
//  Created by Preetham Baliga on 09/09/23.
//

import Foundation

public enum PostLoadResult {
    case success([UserPost])
    case failure(Error)
}

protocol UserPostsLoader {
    func fetchUserPosts(userId: Int, completion: @escaping (PostLoadResult) -> Void)
}
