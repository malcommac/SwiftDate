//
//  TestDate.swift
//  SwiftDate-macOS Tests
//
//  Created by Imthath M on 30/05/19.
//  Copyright © 2019 SwiftDate. All rights reserved.
//

import XCTest

class TestDate: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDifferencesBetweenDates() {
        let date = Date()
        let date2 = "2019-01-05".toDate()!.date
        let result = date.differences(in: [.hour, .day, .month], from: date2)
        print(result)
    }

    func testDifferenceBetweenDates() {
        let date = Date()
        let date2 = "2019-01-05".toDate()!.date
        let result = date.difference(in: .day, from: date2)
        print(result!)
    }

}
