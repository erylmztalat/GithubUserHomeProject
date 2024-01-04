//
//  UsersViewModel.swift
//  GithubUserHomeProject
//
//  Created by talate on 5.11.2023.
//

import Combine

// ViewModel responsible for managing the state and interactions related to a list of users.
class UsersViewModel: BaseViewModel {
    private let fetchUsersUseCase: FetchUsersUseCaseProtocol
    @Published var users = UserList()
    @Published var error: NetworkError?
    var cancellables: Set<AnyCancellable> = []

    init(fetchUsersUseCase: FetchUsersUseCaseProtocol) {
        self.fetchUsersUseCase = fetchUsersUseCase
    }

    func fetchUsers() {
        fetchUsersUseCase.execute()
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.error = error
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] userList in
                self?.users = userList
            })
            .store(in: &cancellables)
    }
}
