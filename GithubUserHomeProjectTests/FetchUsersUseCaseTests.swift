//
//  FetchUsersUseCaseTests.swift
//  GithubUserHomeProjectTests
//
//  Created by talate on 5.11.2023.
//

import XCTest
import Combine
@testable import GithubUserHomeProject

class FetchUsersUseCaseTests: XCTestCase {
    var usersRepository: MockUsersRepository!
    var fetchUsersUseCase: FetchUsersUseCase!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        usersRepository = MockUsersRepository()
        fetchUsersUseCase = FetchUsersUseCase(usersRepository: usersRepository)
        cancellables = []
    }

    func testFetchUsersSuccess() {
        let expectation = XCTestExpectation(description: "Fetch users succeeds")
        let mockUsers = User(login: "test", id: 1234, nodeID: "test_node_id", avatarURL: "", gravatarID: "", url: "", htmlURL: "", followersURL: "", followingURL: "", gistsURL: "", starredURL: "", subscriptionsURL: "", organizationsURL: "", reposURL: "", eventsURL: "", receivedEventsURL: "", type: UserType(rawValue: "user") ?? .user, siteAdmin: false)
        let mockUserList = [mockUsers]

        usersRepository.mockUsers = mockUserList

        fetchUsersUseCase.execute()
            .sink(receiveCompletion: { _ in },
                  receiveValue: { userList in
                    XCTAssertEqual(userList, mockUserList, "Fetched user list does not match mock data")
                    expectation.fulfill()
                  })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 1.0)
    }
}

class MockUsersRepository: UsersRepositoryProtocol {
    var mockUsers: UserList?

    func fetchUsers() -> AnyPublisher<UserList, NetworkError> {
        if let mockUsers = mockUsers {
            return Just(mockUsers)
                .setFailureType(to: NetworkError.self)
                .eraseToAnyPublisher()
        } else {
            return Fail(error: NetworkError.unexpectedResponse)
                .eraseToAnyPublisher()
        }
    }
}

