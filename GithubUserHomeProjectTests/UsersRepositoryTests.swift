//
//  UsersRepositoryTests.swift
//  GithubUserHomeProjectTests
//
//  Created by talate on 5.11.2023.
//

import XCTest
import Combine
@testable import GithubUserHomeProject

final class UsersRepositoryTests: XCTestCase {
    
    var mockNetworkService: NetworkService!
    var mockURLSession: MockURLSession!
    var mockCacheService: MockCacheService!
    var usersRepository: UsersRepository!
    var cancellables = Set<AnyCancellable>()
    
    override func setUp() {
        super.setUp()
        mockURLSession = MockURLSession()
        mockNetworkService = NetworkService(urlSession: mockURLSession)
        mockCacheService = MockCacheService()
        usersRepository = UsersRepository(networkService: mockNetworkService, cacheService: mockCacheService)
    }
    
    override func tearDown() {
        usersRepository = nil
        mockCacheService = nil
        mockNetworkService = nil
        mockURLSession = nil
        cancellables.removeAll()
        super.tearDown()
    }
    
    func testFetchUsers_CacheMiss_NetworkSuccess() {
        let mockUsers = User(login: "test", id: 1234, nodeID: "test_node_id", avatarURL: "", gravatarID: "", url: "", htmlURL: "", followersURL: "", followingURL: "", gistsURL: "", starredURL: "", subscriptionsURL: "", organizationsURL: "", reposURL: "", eventsURL: "", receivedEventsURL: "", type: UserType(rawValue: "user") ?? .user, siteAdmin: false)
        let mockUserList = [mockUsers]
        let mockData = try! JSONEncoder().encode(mockUserList)
        let mockURLResponse = HTTPURLResponse(url: URL(string: "https://test.com")!,
                                              statusCode: 200,
                                              httpVersion: nil,
                                              headerFields: nil)!
        mockURLSession.data = mockData
        mockURLSession.response = mockURLResponse
        
        let expectation = XCTestExpectation(description: "Fetch users from network and cache succeeds")
        
        usersRepository.fetchUsers()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished: break
                case .failure(let error):
                    XCTFail("Unexpected error: \(error)")
                }
                expectation.fulfill()
            }, receiveValue: { userList in
                XCTAssertEqual(userList, mockUserList, "Fetched user list does not match mock data")
                XCTAssertEqual(self.mockCacheService.cachedUserList, mockUserList, "Cached user list does not match mock data")
            })
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testFetchUsers_CacheHit() {
        let mockUser = User(login: "test2", id: 12345, nodeID: "test_node_id_2", avatarURL: "", gravatarID: "", url: "", htmlURL: "", followersURL: "", followingURL: "", gistsURL: "", starredURL: "", subscriptionsURL: "", organizationsURL: "", reposURL: "", eventsURL: "", receivedEventsURL: "", type: UserType(rawValue: "user") ?? .user, siteAdmin: false)
        let mockUserList = [mockUser]
        mockCacheService.save(mockUserList, for: "usersKey")
        
        let expectation = XCTestExpectation(description: "Fetch users from cache succeeds")
        
        usersRepository.fetchUsers()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished: break
                case .failure(let error):
                    XCTFail("Unexpected error: \(error)")
                }
                expectation.fulfill()
            }, receiveValue: { userList in
                XCTAssertEqual(userList, mockUserList, "Fetched user list does not match cached data")
            })
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testFetchUsers_CacheMiss_NetworkFailure() {
        let error = URLError(.notConnectedToInternet)
        mockURLSession.error = error

        let expectation = XCTestExpectation(description: "Fetch users from network fails")

        usersRepository.fetchUsers()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    XCTFail("Expected failure but got success")
                case .failure(let receivedError):
                    guard case NetworkError.noInternet = receivedError else {
                        XCTFail("Unexpected error: \(receivedError)")
                        return
                    }
                }
                expectation.fulfill()
            }, receiveValue: { _ in
                XCTFail("Expected failure but got success")
            })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 1.0)
    }
}

class MockCacheService: CacheServiceProtocol {
    var cachedUserList: UserList?
    
    func save<T>(_ object: T, for key: String) where T : Decodable, T : Encodable {
        cachedUserList = object as? UserList
    }
    
    func load<T>(for key: String) -> T? where T : Decodable, T : Encodable {
        return cachedUserList as? T
    }
}
