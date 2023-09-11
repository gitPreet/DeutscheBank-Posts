//
//  LocalFavouritePostServiceTests.swift
//  UserPostsTests
//
//  Created by Preetham Baliga on 10/09/23.
//

import XCTest
import UserPosts

final class LocalFavouritePostServiceTests: XCTestCase {

    func test_localFavouritePostService_returnsError_whenStoreRetrievalFails() {
        let store = UserPostStoreSpy()
        let sut = LocalFavouritePostService(store: store)

        let expecation = expectation(description: "Wait for fetching favourite posts")
        let storeError = NSError(domain: "Test", code: 0)

        sut.getAllFavouritePosts { result in

            switch result {
            case .success: XCTFail("Expected store retrieval to fail")
            case .failure(let error):
                XCTAssertEqual(storeError, error as NSError)
            }
            expecation.fulfill()
        }

        wait(for: [expecation], timeout: 1.0)
        print("After wait")
        store.completeRetrievalWithError(error: storeError)
    }

    func test_localFavouritePostService_returnsEmptyArray_whenThereAreNoFavouritePosts() {
        let store = UserPostStoreSpy()
        let sut = LocalFavouritePostService(store: store)

        let expecation = expectation(description: "Wait for fetching favourite posts")
        sut.getAllFavouritePosts { result in

            switch result {
            case .success(let posts):
                XCTAssertTrue(posts.isEmpty)
            default:
                XCTFail("Expected to return a empty array")
            }
            expecation.fulfill()
        }

        store.completeRetrievalWithEmptyCache()
        wait(for: [expecation], timeout: 1.0)
    }

    func test_localFavouritePostService_returnsFavouritedPost_onFavouritingSuccessfully() {
        let store = UserPostStoreSpy()
        let sut = LocalFavouritePostService(store: store)

        let expecation = expectation(description: "Wait for fetching favourite posts")
        let favouritedPost = UserPost(userId: 123, id: 12, title: "title", body: "body")

        sut.favouriteUserPost(post: favouritedPost) { _ in
            sut.getAllFavouritePosts { result in
                switch result {
                case .success(let posts):
                    XCTAssertEqual(posts.count, 1)
                    XCTAssertEqual(posts.first, favouritedPost)

                default: XCTFail("Expected successful retrieval")
                }
                expecation.fulfill()
            }
        }

        store.completeInsertionSuccessfully()
        store.completeRetrieval(with: [favouritedPost.toLocal()])
        wait(for: [expecation], timeout: 1.0)
    }

    func test_localFavouritePostService_returnsEmptyArray_onUnFavouritingAlreadyFavouritedPost() {
        let store = UserPostStoreSpy()
        let sut = LocalFavouritePostService(store: store)

        let expecation = expectation(description: "Wait for fetching favourite posts")
        let favouritedPost = UserPost(userId: 123, id: 12, title: "title", body: "body")

        sut.favouriteUserPost(post: favouritedPost) { _ in
            sut.unfavouriteUserPost(post: favouritedPost) { _ in
                sut.getAllFavouritePosts { result in
                    switch result {
                    case .success(let posts):
                        XCTAssertEqual(posts.count, 0)

                    default: XCTFail("Expected successful retrieval")
                    }
                    expecation.fulfill()
                }
            }
        }

        store.completeInsertionSuccessfully()
        store.completeDeletionSuccessfully()
        store.completeRetrievalWithEmptyCache()

        wait(for: [expecation], timeout: 1.0)
    }

    // MARK: Helpers

    private func anyUserPost() -> UserPost  {
        return UserPost(userId: 1, id: 123, title: "any title", body: "any body")
    }

    class UserPostStoreSpy: UserPostStore {

        private var insertionCompletions = [InsertionCompletion]()
        private var deletionCompletions = [DeletionCompletion]()
        private var retrievalCompletions = [RetrievalCompletion]()

        func insert(post: LocalUserPost, completion: @escaping InsertionCompletion) {
            insertionCompletions.append(completion)
        }

        func completeInsertionSuccessfully(at index: Int = 0) {
            insertionCompletions[index](nil)
        }

        func delete(post: UserPosts.LocalUserPost, completion: @escaping DeletionCompletion) {
            deletionCompletions.append(completion)
        }
        
        func completeDeletionSuccessfully(at index: Int = 0) {
            deletionCompletions[index](nil)
        }

        func retrieveFavouritePosts(completion: @escaping RetrievalCompletion) {
            retrievalCompletions.append(completion)
        }

        func completeRetrievalWithEmptyCache(at index: Int = 0) {
            retrievalCompletions[index](.empty)
        }

        func completeRetrievalWithError(error: NSError, at index: Int = 0) {
            retrievalCompletions[index](.failure(error))
        }

        func completeRetrieval(with posts: [LocalUserPost], at index: Int = 0) {
            retrievalCompletions[index](.found(posts: posts))
        }
    }
}
