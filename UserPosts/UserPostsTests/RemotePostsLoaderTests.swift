//
//  RemotePostsLoaderTests.swift
//  UserPostsTests
//
//  Created by Preetham Baliga on 09/09/23.
//

import XCTest
import UserPosts

final class RemotePostsLoaderTests: XCTestCase {

    func test_remotePostsLoader_doesNotRequestDataOnCreation() {
        let (_, client) = makeSUT()
        XCTAssertTrue(client.requestedURLs.isEmpty)
    }

    func test_remotePostsLoader_requestsDataFromURLOnCallingFetch() {
        let (sut, client) = makeSUT()

        sut.fetchUserPosts(userId: 2) { _ in }

        XCTAssertEqual(client.requestedURLs.count, 1)
    }

    func test_remotePostsLoader_deliversError_onConnectivtyError() {
        let (sut, client) = makeSUT()

        expect(sut, toCompleteWith: .failure(RemotePostsLoader.Error.connectivity)) {
            let clientError = NSError(domain: "Error", code: 0)
            client.complete(with: clientError)
        }
    }

    func test_remotePostsLoader_deliversError_on200HTTPResponseWithInvalidJSON() {
        let (sut, client) = makeSUT()

        // status code is 200, but HTTP response is invalid
        expect(sut, toCompleteWith: .failure(RemotePostsLoader.Error.invalidData)) {
            let invalidJSON = Data("invalid JSON".utf8)
            client.complete(with: 200, data: invalidJSON)
        }
    }

    // MARK: Helpers

    func makeSUT() -> (RemotePostsLoader, HTTPClientSpy) {
        let client = HTTPClientSpy()
        let endpointService = EndpointServiceMock()
        let sut = RemotePostsLoader(client: client, endpointService: endpointService)
        return (sut, client)
    }

    private func expect(_ sut: RemotePostsLoader,
                        toCompleteWith expectedResult: RemotePostsLoader.Result,
                        when action: () -> Void, file: StaticString = #file, line: UInt = #line) {
        let exp = expectation(description: "Wait for load completion")

        sut.fetchUserPosts(userId: 1, completion: { receivedResult in
      
            switch (receivedResult, expectedResult) {

            case let(.success(receivedPosts), .success(expectedPosts)):
                XCTAssertEqual(receivedPosts, expectedPosts)

            case let (.failure(receivedError as RemotePostsLoader.Error), .failure(expectedError as RemotePostsLoader.Error)):
                XCTAssertEqual(receivedError, expectedError)

            default:
                XCTFail("Expected result \(expectedResult) got \(receivedResult) instead", file: file, line: line)
            }

            exp.fulfill()
        })

        action()

        wait(for: [exp], timeout: 1.0)
    }

    class HTTPClientSpy: HTTPClient {
        var requestedURLs = [URL]()
        var completions = [(HTTPClientResult) -> Void]()

        func get(from url: URL, completion: @escaping (HTTPClientResult) -> Void) {
            requestedURLs.append(url)
            completions.append(completion)
        }

        func complete(with error: Error, at index: Int = 0) {
            completions[index](.failure(error))
        }

        func complete(with statusCode: Int, data: Data, at index: Int = 0) {
            let response = HTTPURLResponse(url: requestedURLs[index],
                                           statusCode: statusCode,
                                           httpVersion: nil,
                                           headerFields: nil)!
            completions[index](.success(data, response))
        }
    }

    class EndpointServiceMock: EndpointService {

        func getURL(endpoint: UserPosts.Endpoint) -> URL {
            return URL(string: "http://some-url.com")!
        }
    }
}
