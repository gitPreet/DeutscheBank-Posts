//
//  CoreDataAdapter.swift
//  PostsApp
//
//  Created by Preetham Baliga on 14/09/23.
//

import Foundation
import UserPosts
import CoreData

extension CoreDataStore: UserPostStore {

    public func insert(post: LocalUserPost, completion: @escaping InsertionCompletion) {
        perform { context in
            do {
                let postMO = PostMO(context: context)
                postMO.id = Int16(post.id)
                postMO.userId = Int16(post.userId)
                postMO.title = post.title
                postMO.body = post.body
                try context.save()
                completion(nil)
            } catch {
                completion(error)
            }
        }
    }
    
    public func delete(post: LocalUserPost, completion: @escaping DeletionCompletion) {

    }
    
    public func retrieveFavouritePosts(completion: @escaping RetrievalCompletion) {
        perform { context in
            do {
                let request = PostMO.fetchRequest()
                let cachedPosts = try context.fetch(request)
                let localPosts = cachedPosts.map {
                    LocalUserPost(userId: Int($0.userId),
                                  id: Int($0.id),
                                  title: $0.title ?? "",
                                  body: $0.body ?? "")
                }
                if localPosts.isEmpty {
                    completion(.empty)
                } else {
                    completion(.found(posts: localPosts))
                }
            } catch {
                completion(.failure(error))
            }
        }
    }
}
