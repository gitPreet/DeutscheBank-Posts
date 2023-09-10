//
//  UserPostStore.swift
//  UserPosts
//
//  Created by Preetham Baliga on 10/09/23.
//

import Foundation

public enum RetrieveFavouritePostsResult {
    case empty
    case found(feed: [UserPost])
    case failure(Error)
}

protocol UserPostStore {

    typealias InsertionCompletion = (Error?) -> Void
    typealias DeletionCompletion = (Error?) -> Void
    typealias RetrievalCompletion = (RetrieveFavouritePostsResult) -> Void

    func insert(post: UserPost, completion: @escaping InsertionCompletion)

    func delete(post: UserPost, completion: @escaping DeletionCompletion)

    func retrieveFavouritePosts(completion: @escaping RetrievalCompletion)
}
