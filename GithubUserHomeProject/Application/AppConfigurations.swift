//
//  AppConfigurations.swift
//  GithubUserHomeProject
//
//  Created by talate on 5.11.2023.
//

import Foundation

final class AppConfigurations {
    static var baseURL: String = {
        guard let baseURL = Bundle.main.object(forInfoDictionaryKey: "BaseURL") as? String else {
            fatalError("BaseURL empty in plist. Please check info.plist!!!")
        }
        return baseURL
    }()
}
