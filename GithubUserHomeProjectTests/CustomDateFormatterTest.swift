//
//  CustomDateFormatterTest.swift
//  GithubUserHomeProjectTests
//
//  Created by talate on 5.11.2023.
//

import XCTest
@testable import GithubUserHomeProject

class CustomDateFormatterTest: XCTestCase {
    var dateFormatter: CustomDateFormatter!
    
    override func setUp() {
        super.setUp()
        dateFormatter = CustomDateFormatter()
    }
    
    override func tearDown() {
        dateFormatter = nil
        super.tearDown()
    }
    
    func testJoinedString() {
        let dateString = "2020-01-15T15:44:31Z"
        guard let date = dateFormatter.joinedDate(from: dateString) else {
            XCTFail("Date conversion failed")
            return
        }
        
        let result = dateFormatter.joinedString(from: date)
        XCTAssertEqual(result, "Joined 3 years ago", "Joined date string is incorrect")
    }
}
