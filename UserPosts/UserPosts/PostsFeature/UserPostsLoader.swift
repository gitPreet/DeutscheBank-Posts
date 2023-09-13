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

public protocol UserPostsLoader {
    func fetchUserPosts(userId: Int, completion: @escaping (PostLoadResult) -> Void)
}

public protocol UserService {
    var userId: Int { get }
}
