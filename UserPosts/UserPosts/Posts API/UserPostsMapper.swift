//
//  UserPostsMapper.swift
//  UserPosts
//
//  Created by Preetham Baliga on 09/09/23.
//

import Foundation

internal struct RemoteUserPost: Decodable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

internal final class UserPostsMapper {

    static func map(data: Data, response: HTTPURLResponse) throws -> [RemoteUserPost] {
        guard response.statusCode == 200, let posts = try? JSONDecoder().decode([RemoteUserPost].self, from: data) else {
            throw RemotePostsLoader.RemotePostsLoaderError.invalidData
        }
        return posts
    }
}
