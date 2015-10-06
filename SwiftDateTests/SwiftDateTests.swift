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

    func test_date_subtract_date() {
        XCTAssertEqual(after - now, NSTimeInterval(60))
        XCTAssertEqual(now - now, NSTimeInterval(0))
        XCTAssertEqual(now - after, NSTimeInterval(-60))
    }
    
    func test_secondsAfterDate() {
        let summerTimeDay = NSDate.date(refDate: nil, year: 2015, month: 3, day: 29, tz: nil)
        let nextDay = NSDate.date(refDate: nil, year: 2015, month: 3, day: 30, tz: nil)
        XCTAssertEqual(summerTimeDay.daysAfterDate(nextDay), -1)
    }

    func test_toDateISO8601ParsesDateWithHoursMinutesAndZ() {
        let expectedDate = NSDate.date(refDate: nil, year: 2015, month: 9, day: 29, hour: 0, minute: 0, second: 0, tz: "UTC")

        let parsedDate = NSDate.date(fromString: "2015-09-29T00:00Z", format: .ISO8601)

        XCTAssertEqual(parsedDate, expectedDate)
    }

    func test_toDateISO8601ParsesDateWithHoursMinutesSecondsAndZ() {
        let expectedDate = NSDate.date(refDate: nil, year: 2015, month: 9, day: 29, hour: 0, minute: 0, second: 0, tz: "UTC")

        let parsedDate = NSDate.date(fromString: "2015-09-29T00:00:00Z", format: .ISO8601)

        XCTAssertEqual(parsedDate, expectedDate)
    }

    func test_toDateISO8601ParsesDateWithHoursMinutesSecondsAndFractionAndZ() {
        let expectedDate = NSDate.date(refDate: nil, year: 2015, month: 9, day: 29, hour: 0, minute: 0, second: 0, tz: "UTC")

        let parsedDate = NSDate.date(fromString: "2015-09-29T00:00:00.000Z", format: .ISO8601)

        XCTAssertEqual(parsedDate, expectedDate)
    }
    
    func test_isEqualToDate() {
        let bc2015 = NSDate.date(refDate: nil, year: -2014, month: 9, day: 29, hour: 0, minute: 0, second: 0, tz: "UTC")
        let ac2015 = NSDate.date(refDate: nil, year: 2015, month: 9, day: 29, hour: 0, minute: 0, second: 0, tz: "UTC")
        XCTAssertFalse(bc2015.isEqualToDate(ac2015, ignoreTime: true) , "not eq B.C. and A.C.")
    }
}
