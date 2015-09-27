//
//  SwiftDateTests.swift
//  SwiftDateTests
//
//  Created by fhisa on 2015/09/28.
//  Copyright (C) 2015 SwiftDate. All rights reserved.
//

import XCTest
@testable import SwiftDate

class SwiftDateTests: XCTestCase {

    var before_minute: NSDate!
    var now: NSDate!
    var after_minute: NSDate!

    override func setUp() {
        now = NSDate()
        before_minute = now.dateByAddingTimeInterval(-60.0)
        after_minute = now.dateByAddingTimeInterval(60.0)
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func test_less_than() {
        XCTAssertTrue(before_minute < now)
        XCTAssertTrue(now < after_minute)
        XCTAssertFalse(after_minute < now)
        XCTAssertFalse(now < before_minute)
        XCTAssertFalse(now < now)
    }

    func test_less_than_or_equal() {
        XCTAssertTrue(before_minute <= now)
        XCTAssertTrue(now <= after_minute)
        XCTAssertFalse(after_minute <= now)
        XCTAssertFalse(now <= before_minute)
        XCTAssertTrue(now <= now)
    }

    func test_greater_than() {
        XCTAssertFalse(before_minute > now)
        XCTAssertFalse(now > after_minute)
        XCTAssertTrue(after_minute > now)
        XCTAssertTrue(now > before_minute)
        XCTAssertFalse(now > now)
    }

    func test_greater_than_or_equal() {
        XCTAssertFalse(before_minute >= now)
        XCTAssertFalse(now >= after_minute)
        XCTAssertTrue(after_minute >= now)
        XCTAssertTrue(now >= before_minute)
        XCTAssertTrue(now >= now)
    }
}
