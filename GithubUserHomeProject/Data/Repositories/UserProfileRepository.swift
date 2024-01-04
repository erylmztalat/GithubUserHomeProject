//
//  UserProfileRepository.swift
//  GithubUserHomeProject
//
//  Created by talate on 5.11.2023.
//

import Foundation
import Combine

// Protocol defining the methods for fetching a specific GitHub user's profile.
protocol UserProfileRepositoryProtocol {
    func fetchUserProfile(userID: String) -> AnyPublisher<UserProfile, NetworkError>
}

// Repository responsible for fetching and caching the profile of a specific GitHub user.
final class UserProfileRepository: UserProfileRepositoryProtocol {
    
    private let networkService: NetworkServiceProtocol
    private let cacheService: CacheServiceProtocol
    
    init(networkService: NetworkServiceProtocol, cacheService: CacheServiceProtocol) {
        self.networkService = networkService
        self.cacheService = cacheService
    }
    
    // Fetches the profile of a GitHub user with the provided user ID. Returns cached data if available, otherwise fetches from the network.
    func fetchUserProfile(userID: String) -> AnyPublisher<UserProfile, NetworkError> {
        let cacheKey = "userProfile_\(userID)"
        
        if let cachedData: UserProfile = cacheService.load(for: cacheKey) {
            return Just(cachedData)
                .setFailureType(to: NetworkError.self)
                .eraseToAnyPublisher()
        } else {
            let request = UserProfileRequest(userID: userID)
            return networkService.perform(request)
                .map { userProfile -> UserProfile in
                    self.cacheService.save(userProfile, for: cacheKey)
                    return userProfile
                }
                .eraseToAnyPublisher()
        }
    }
}

