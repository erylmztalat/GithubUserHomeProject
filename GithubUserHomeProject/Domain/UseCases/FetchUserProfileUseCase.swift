//
//  FetchUserProfileUseCase.swift
//  GithubUserHomeProject
//
//  Created by talate on 5.11.2023.
//

import Foundation
import Combine

// Protocol defining the use case for fetching a GitHub user's profile.
protocol FetchUserProfileUseCaseProtocol {
    // Executes the use case and returns a publisher emitting a user profile.
    func execute(userID: String) -> AnyPublisher<UserProfile, NetworkError>
}

// Implementation of the use case for fetching a GitHub user's profile.
class FetchUserProfileUseCase: FetchUserProfileUseCaseProtocol {
    private let userProfileRepository: UserProfileRepositoryProtocol
    
    init(userProfileRepository: UserProfileRepositoryProtocol) {
        self.userProfileRepository = userProfileRepository
    }
    
    func execute(userID: String) -> AnyPublisher<UserProfile, NetworkError> {
        return userProfileRepository.fetchUserProfile(userID: userID)
    }
}
