//
//  Endpoint.swift
//  GithubUserHomeProject
//
//  Created by talate on 5.11.2023.
//

import Foundation

enum Endpoint {
    case users
    case userProfile(userID: String)
}

extension Endpoint {
    private var baseURL: URL {
        return URL(string: AppConfigurations.baseURL)!
    }

    var path: String {
        switch self {
        case .users:
            return "/users"
        case .userProfile(let userID):
            return "/users/\(userID)"
        }
    }

    var url: URL {
        return baseURL.appendingPathComponent(path)
    }
}
