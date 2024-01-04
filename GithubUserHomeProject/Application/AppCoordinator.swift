//
//  AppRouter.swift
//  GithubUserHomeProject
//
//  Created by talate on 5.11.2023.
//

import UIKit

// Coordinator class responsible for managing the navigation flow of the application.
class AppCoordinator {
    private var window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() -> UIWindow {
        let navigationController = UINavigationController()
        let userRepository = UsersRepository(networkService: NetworkService(), cacheService: CacheService())
        let fetchUsersUseCase = FetchUsersUseCase(usersRepository: userRepository)
        let viewModel = UsersViewModel(fetchUsersUseCase: fetchUsersUseCase)
        let viewController = UsersViewController(viewModel: viewModel)
        viewController.navigationDelegate = self
        navigationController.setViewControllers([viewController], animated: false)
        window.rootViewController = navigationController
        return window
    }
    
    func navigateToUserProfile(user: User) {
        guard let navigationController = window.rootViewController as? UINavigationController else {
            return
        }
        let userProfileViewModel = UserProfileViewModel(fetchUserProfileUseCase: FetchUserProfileUseCase(userProfileRepository: UserProfileRepository(networkService: NetworkService(), cacheService: CacheService())))
        let userProfileViewController = UserProfileViewController(viewModel: userProfileViewModel, userID: user.login, userType: user.type)
        navigationController.pushViewController(userProfileViewController, animated: true)
    }
}

extension AppCoordinator: UsersViewNavigationDelegate {
    func didSelectUser(_ user: User) {
        navigateToUserProfile(user: user)
    }
}
