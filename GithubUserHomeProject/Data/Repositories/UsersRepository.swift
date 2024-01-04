//
//  UsersRepository.swift
//  GithubUserHomeProject
//
//  Created by talate on 5.11.2023.
//

import Foundation
import Combine

// Protocol defining the methods for fetching a list of GitHub users.
protocol UsersRepositoryProtocol {
    func fetchUsers() -> AnyPublisher<UserList, NetworkError>
}

// Repository responsible for fetching and caching a list of GitHub users.
final class UsersRepository: UsersRepositoryProtocol {
    private let networkService: NetworkServiceProtocol
    private let cacheService: CacheServiceProtocol
    
    init(networkService: NetworkServiceProtocol, cacheService: CacheServiceProtocol) {
        self.networkService = networkService
        self.cacheService = cacheService
    }
    
    // Fetches a list of GitHub users. Returns cached data if available, otherwise fetches from the network.
    func fetchUsers() -> AnyPublisher<UserList, NetworkError> {
        if let cachedData: UserList = cacheService.load(for: "usersKey") {
            return Just(cachedData)
                .setFailureType(to: NetworkError.self)
                .eraseToAnyPublisher()
        } else {
            let request = UsersRequest()
            return networkService.perform(request)
                .map { userList -> UserList in
                    self.cacheService.save(userList, for: "usersKey")
                    return userList
                }
                .eraseToAnyPublisher()
        }
    }
}
