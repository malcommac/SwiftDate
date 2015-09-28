//
//  SwiftDateTests.swift
//  SwiftDateTests
//
//  Created by fhisa on 2015/09/28.
//  Copyright (C) 2015 SwiftDate. All rights reserved.
//

import XCTest
import SwiftDate

class SwiftDateTests: XCTestCase {

    var before: NSDate!
    var now: NSDate!
    var after: NSDate!

    override func setUp() {
        super.setUp()
        now = NSDate()
        before = now.dateByAddingTimeInterval(-60.0)
        after = now.dateByAddingTimeInterval(60.0)
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func test_less_than() {
        XCTAssertTrue(before < now)
        XCTAssertTrue(now < after)
        XCTAssertFalse(after < now)
        XCTAssertFalse(now < before)
        XCTAssertFalse(now < now)
    }

    func test_less_than_or_equal() {
        XCTAssertTrue(before <= now)
        XCTAssertTrue(now <= after)
        XCTAssertFalse(after <= now)
        XCTAssertFalse(now <= before)
        XCTAssertTrue(now <= now)
    }

    func test_greater_than() {
        XCTAssertFalse(before > now)
        XCTAssertFalse(now > after)
        XCTAssertTrue(after > now)
        XCTAssertTrue(now > before)
        XCTAssertFalse(now > now)
    }

    func test_greater_than_or_equal() {
        XCTAssertFalse(before >= now)
        XCTAssertFalse(now >= after)
        XCTAssertTrue(after >= now)
        XCTAssertTrue(now >= before)
        XCTAssertTrue(now >= now)
    }
}
