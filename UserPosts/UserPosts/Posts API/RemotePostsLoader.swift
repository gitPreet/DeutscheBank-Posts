//
//  RemotePostsLoader.swift
//  UserPosts
//
//  Created by Preetham Baliga on 09/09/23.
//

import Foundation

// Represents the loading posts from Remote Use case.
public class RemotePostsLoader: UserPostsLoader {

    let client: HTTPClient
    let url: URL

    public init(client: HTTPClient, url: URL) {
        self.client = client
        self.url = url
    }

    public enum Error: Swift.Error {
        case connectivity
        case invalidData
    }

    public typealias Result = PostLoadResult

    public func fetchUserPosts(userId: Int, completion: @escaping (Result) -> Void) {
        let queryItem = URLQueryItem(name: "userId", value: "\(userId)")
        let fetchURL = url.appending(queryItems: [queryItem])

        client.get(from: fetchURL) { result in
            switch result {
            case .success(let data, let response):
                do {
                    let remoteUserPosts = try UserPostsMapper.map(data: data, response: response)
                    completion(.success(remoteUserPosts.toModels()))
                    
                } catch {
                    completion(.failure(RemotePostsLoader.Error.invalidData))
                }

            case .failure:
                completion(.failure(RemotePostsLoader.Error.connectivity))
            }
        }
    }
}

private extension Array where Element == RemoteUserPost {

    func toModels() -> [UserPost] {
        return map {
            UserPost(userId: $0.userId, id: $0.id, title: $0.title, body: $0.body)
        }
    }
}
