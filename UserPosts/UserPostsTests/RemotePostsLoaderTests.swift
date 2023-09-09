//
//  RemotePostsLoaderTests.swift
//  UserPostsTests
//
//  Created by Preetham Baliga on 09/09/23.
//

import XCTest

protocol HTTPClient {
    func get(from url: URL)
}

class RemotePostsLoader {

    let client: HTTPClient

    init(client: HTTPClient) {
        self.client = client
    }
}

final class RemotePostsLoaderTests: XCTestCase {

    func test_remotePostLoader_doesNotRequestDataFromURLUponCreation() {
        let client = HTTPClientSpy()
        let _ = RemotePostsLoader(client: client)

        XCTAssertTrue(client.requestedURL.isEmpty)
    }

    // MARK: Helpers

    class HTTPClientSpy: HTTPClient {

        var requestedURL = [URL]()

        func get(from url: URL) {
            requestedURL.append(url)
        }
    }
}
