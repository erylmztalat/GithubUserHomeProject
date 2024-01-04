//
//  UsersViewModelTests.swift
//  GithubUserHomeProjectTests
//
//  Created by talate on 5.11.2023.
//

import XCTest
import Combine
@testable import GithubUserHomeProject

class UsersViewModelTests: XCTestCase {
    
    var cancellables = Set<AnyCancellable>()

    func testFetchUsers_Success() {
        let mockUsersUseCase = MockFetchUsersUseCase()
        let viewModel = UsersViewModel(fetchUsersUseCase: mockUsersUseCase)
        let mockUserList = mockUserList()
        mockUsersUseCase.mockUserList = mockUserList

        viewModel.fetchUsers()

        XCTAssertEqual(viewModel.users, mockUserList, "Fetched user list does not match mock data")
    }

    func testFetchUsers_Failure() {
        let mockUsersUseCase = MockFetchUsersUseCase()
        let viewModel = UsersViewModel(fetchUsersUseCase: mockUsersUseCase)
        let expectedError = NetworkError.noInternet
        mockUsersUseCase.mockError = expectedError

        viewModel.fetchUsers()

        XCTAssertEqual(viewModel.error?.localizedDescription, expectedError.localizedDescription, "Error does not match expected error")
    }
    
    func mockUserList() -> UserList {
        let mockUser = User(login: "test1", id: 123456, nodeID: "test_node_id_1", avatarURL: "", gravatarID: "", url: "", htmlURL: "", followersURL: "", followingURL: "", gistsURL: "", starredURL: "", subscriptionsURL: "", organizationsURL: "", reposURL: "", eventsURL: "", receivedEventsURL: "", type: UserType(rawValue: "user") ?? .user, siteAdmin: false)
        let mockUser2 = User(login: "test2", id: 1234567, nodeID: "test_node_id_2", avatarURL: "", gravatarID: "", url: "", htmlURL: "", followersURL: "", followingURL: "", gistsURL: "", starredURL: "", subscriptionsURL: "", organizationsURL: "", reposURL: "", eventsURL: "", receivedEventsURL: "", type: UserType(rawValue: "user") ?? .user, siteAdmin: false)
        let mockUser3 = User(login: "test3", id: 12345678, nodeID: "test_node_id_3", avatarURL: "", gravatarID: "", url: "", htmlURL: "", followersURL: "", followingURL: "", gistsURL: "", starredURL: "", subscriptionsURL: "", organizationsURL: "", reposURL: "", eventsURL: "", receivedEventsURL: "", type: UserType(rawValue: "organization") ?? .organization, siteAdmin: false)
        return [mockUser, mockUser2, mockUser3]
    }
}

class MockFetchUsersUseCase: FetchUsersUseCaseProtocol {
    
    var mockUserList: UserList?
    var mockError: NetworkError?

    func execute() -> AnyPublisher<UserList, NetworkError> {
        if let mockError = mockError {
            return Fail(error: mockError).eraseToAnyPublisher()
        } else if let mockUserList = mockUserList {
            return Just(mockUserList)
                .setFailureType(to: NetworkError.self)
                .eraseToAnyPublisher()
        } else {
            fatalError("Either mockError or mockUserList must be set")
        }
    }
}

