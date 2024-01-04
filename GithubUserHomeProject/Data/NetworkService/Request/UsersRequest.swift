//
//  UserRequest.swift
//  GithubUserHomeProject
//
//  Created by talate on 5.11.2023.
//

import Foundation

// Struct representing a network request to fetch a list of GitHub users.
struct UsersRequest: NetworkRequest {
    typealias Response = UserList

    var endpoint: URL? {
        return Endpoint.users.url
    }

    var method: RequestMethod {
        return .get
    }

    var headers: [String : String]? {
        ["Accept": "application/vnd.github.v3+json"]
    }

    var parameters: [String: Any]? {
        return nil
    }

    var rawBody: Data? {
        return nil
    }
}
