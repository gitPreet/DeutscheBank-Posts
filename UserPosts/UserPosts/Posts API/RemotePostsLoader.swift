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
    let endpointService: EndpointService

    public init(client: HTTPClient, endpointService: EndpointService) {
        self.client = client
        self.endpointService = endpointService
    }

    public enum RemotePostsLoaderError: Swift.Error {
        case connectivity
        case invalidData
    }

    func fetchUserPosts(userId: Int, completion: @escaping (Result<[UserPost], Error>) -> Void) {
        let url = endpointService.getURL(endpoint: .userPosts(userId: userId))

        client.get(from: url) { result in
            switch result {
            case .success(let data, let response):
                do {
                    let remoteUserPosts = try UserPostsMapper.map(data: data, response: response)
                    completion(.success(remoteUserPosts.toModels()))
                    
                } catch {
                    completion(.failure(RemotePostsLoaderError.invalidData))
                }

            case .failure:
                completion(.failure(RemotePostsLoaderError.connectivity))
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
