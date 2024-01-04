//
//  UserProfileViewModel.swift
//  GithubUserHomeProject
//
//  Created by talate on 5.11.2023.
//

import Combine

// ViewModel responsible for managing the state and interactions related to a user's profile.
class UserProfileViewModel: BaseViewModel {
    private let fetchUserProfileUseCase: FetchUserProfileUseCaseProtocol
    @Published var userProfile: UserProfile?
    @Published var error: NetworkError?
    var cancellables: Set<AnyCancellable> = []
    
    init(fetchUserProfileUseCase: FetchUserProfileUseCaseProtocol) {
        self.fetchUserProfileUseCase = fetchUserProfileUseCase
    }

    func fetchUserProfile(userID: String) {
        fetchUserProfileUseCase.execute(userID: userID)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    self.error = error
                case .finished:
                    break
                }
            }, receiveValue: { userProfile in
                self.userProfile = userProfile
            })
            .store(in: &cancellables)
    }
}

