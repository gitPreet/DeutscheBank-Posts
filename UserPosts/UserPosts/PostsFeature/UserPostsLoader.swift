//
//  UserPostsLoader.swift
//  UserPosts
//
//  Created by Preetham Baliga on 09/09/23.
//

import Foundation

protocol UserPostsLoader {
    func fetchUserPosts(userId: Int, completion: @escaping (Result<[UserPost], Error>) -> Void)
}
