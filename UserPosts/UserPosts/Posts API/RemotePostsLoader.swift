//
//  RemotePostsLoader.swift
//  UserPosts
//
//  Created by Preetham Baliga on 09/09/23.
//

import Foundation

public class RemotePostsLoader {

    let client: HTTPClient

    public init(client: HTTPClient) {
        self.client = client
    }
}
