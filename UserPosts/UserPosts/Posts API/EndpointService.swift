//
//  EndpointService.swift
//  UserPosts
//
//  Created by Preetham Baliga on 09/09/23.
//

import Foundation

public enum Endpoint {
    case userPosts(userId: Int)
}

public protocol EndpointService {
    func getURL(endpoint: Endpoint) -> URL
}
