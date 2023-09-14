//
//  URLSessionHTTPClientAdapter.swift
//  PostsApp
//
//  Created by Preetham Baliga on 14/09/23.
//

import Foundation
import UserPosts

extension URLSessionHTTPClient: HTTPClient {

    private struct UnexpectedValuesRepresentation: Error {}

    public func get(from url: URL, completion: @escaping (HTTPClientResult) -> Void) {
        download(from: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data, let response = response as? HTTPURLResponse {
                completion(.success(data, response))
            } else {
                completion(.failure(UnexpectedValuesRepresentation()))
            }
        }
    }
}
