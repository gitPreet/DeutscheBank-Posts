//
//  LocalUserPost.swift
//  UserPosts
//
//  Created by Preetham Baliga on 10/09/23.
//

import Foundation

public struct LocalUserPost {
    public let userId: Int
    public let id: Int
    public let title: String
    public let body: String

    public init(userId: Int, id: Int, title: String, body: String) {
        self.userId = userId
        self.id = id
        self.title = title
        self.body = body
    }
}
