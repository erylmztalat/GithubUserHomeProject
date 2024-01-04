//
//  UserProfileDateFormatter.swift
//  GithubUserHomeProject
//
//  Created by talate on 5.11.2023.
//

import Foundation

class CustomDateFormatter {
    private let iso8601Formatter: ISO8601DateFormatter
    private let calendar: Calendar
    
    init() {
        iso8601Formatter = ISO8601DateFormatter()
        calendar = Calendar.current
    }
    
    func joinedDate(from createdAt: String) -> Date? {
        return iso8601Formatter.date(from: createdAt)
    }
    
    func yearsSinceJoining(from date: Date) -> Int {
        return calendar.dateComponents([.year], from: date, to: Date()).year ?? 0
    }
    
    func joinedString(from date: Date) -> String {
        let years = yearsSinceJoining(from: date)
        return "Joined \(years) \(years == 1 ? "year" : "years") ago"
    }
}
