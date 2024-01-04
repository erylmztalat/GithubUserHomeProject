//
//  CacheService.swift
//  GithubUserHomeProject
//
//  Created by talate on 5.11.2023.
//

import Foundation

// Protocol defining the caching service operations.
protocol CacheServiceProtocol {
    // Saves an object conforming to Codable to cache using a specified key.
    func save<T: Codable>(_ object: T, for key: String)
    // Loads and returns an object conforming to Codable from cache using a specified key.
    func load<T: Codable>(for key: String) -> T?
}

// Cache service implementation utilizing NSCache for caching.
final class CacheService: CacheServiceProtocol {
    private let cache = NSCache<NSString, NSData>()
    
    func save<T: Codable>(_ object: T, for key: String) {
        if let data = try? JSONEncoder().encode(object) {
            cache.setObject(data as NSData, forKey: key as NSString)
        }
    }
    
    func load<T: Codable>(for key: String) -> T? {
        if let data = cache.object(forKey: key as NSString) {
            return try? JSONDecoder().decode(T.self, from: data as Data)
        }
        return nil
    }
}
