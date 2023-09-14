//
//  URLSessionHTTPClient.swift
//  PostsApp
//
//  Created by Preetham Baliga on 13/09/23.
//

import Foundation
import UserPosts

public class URLSessionHTTPClient {

    let session: URLSession

    public init(session: URLSession = .shared) {
        self.session = session
    }

    private struct UnexpectedValuesRepresentation: Error {}

    public func download(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let task = session.dataTask(with: url) { data, response, error in
            completion(data, response, error)
        }
        task.resume()
    }
}

