//
//  BaseViewModel.swift
//  GithubUserHomeProject
//
//  Created by talate on 5.11.2023.
//

import Combine

// Protocol defining the base requirements for a ViewModel.
protocol BaseViewModel: ObservableObject {
    var error: NetworkError? { get set }
    var cancellables: Set<AnyCancellable> { get set }
}
