//
//  HTTPClient.swift
//  UserPosts
//
//  Created by Preetham Baliga on 09/09/23.
//

import Foundation

public protocol HTTPClient {
    func get(from url: URL)
}
