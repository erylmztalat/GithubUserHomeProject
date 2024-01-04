//
//  UserProfileRequest.swift
//  GithubUserHomeProject
//
//  Created by talate on 5.11.2023.
//

import Foundation

// Struct representing a network request to fetch the profile of a specific GitHub user.
struct UserProfileRequest: NetworkRequest {
    typealias Response = UserProfile
    
    var userID: String
    
    init(userID: String) {
        self.userID = userID
    }

    var endpoint: URL? {
        return Endpoint.userProfile(userID: self.userID).url
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
