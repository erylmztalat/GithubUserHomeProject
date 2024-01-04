//
//  FetchUsersUseCase.swift
//  GithubUserHomeProject
//
//  Created by talate on 5.11.2023.
//

import Foundation
import Combine

// Protocol defining the use case for fetching a list of GitHub users.
protocol FetchUsersUseCaseProtocol {
    // Executes the use case and returns a publisher emitting a list of users.
    func execute() -> AnyPublisher<UserList, NetworkError>
}

// Implementation of the use case for fetching a list of GitHub users.
class FetchUsersUseCase: FetchUsersUseCaseProtocol {
    private let usersRepository: UsersRepositoryProtocol
    
    init(usersRepository: UsersRepositoryProtocol) {
        self.usersRepository = usersRepository
    }
    
    func execute() -> AnyPublisher<UserList, NetworkError> {
        return usersRepository.fetchUsers()
    }
}
