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

    func test_difference() {
        XCTAssertEqual(after.difference(now, unitFlags: .Minute), -1.minutes)
        XCTAssertEqual(now.difference(after, unitFlags: .Minute), 1.minutes)
        XCTAssertEqual(now.difference(now, unitFlags: .Nanosecond), 0.nanoseconds)
    }
    
    func test_secondsAfterDate() {
        let summerTimeDay = NSDate.date(year: 2015, month: 3, day: 29)
        let nextDay = NSDate.date(year: 2015, month: 3, day: 30)
        XCTAssertEqual(summerTimeDay.difference(nextDay, unitFlags: .Day).day, 1)
    }

    func test_startOfHour() {
        let date = NSDate.date(year: 2015, month: 9, day: 29, hour: 1, minute: 2, second: 3, nanosecond: 4)
        let expectedDate = NSDate.date(year: 2015, month: 9, day: 29, hour: 1, minute: 0, second: 0, nanosecond: 0)
        let testDate = date.startOf(.Hour)
        XCTAssertEqual(testDate, expectedDate)
    }

    func test_endOfHour() {
        let date = NSDate.date(year: 2015, month: 9, day: 29, hour: 1, minute: 2, second: 3, nanosecond: 4)
        let expectedDate = date.startOf(.Hour)! + 1.hours - 1.nanoseconds
        let testDate = date.endOf(.Hour)
        XCTAssertEqual(testDate, expectedDate)
    }

    func test_startOfDay() {
        let date = NSDate.date(year: 2015, month: 9, day: 29, hour: 1, minute: 2, second: 3, nanosecond: 4)
        let expectedDate = NSDate.date(year: 2015, month: 9, day: 29, hour: 0, minute: 0, second: 0, nanosecond: 0)
        let testDate = date.startOf(.Day)
        XCTAssertEqual(testDate, expectedDate)
    }

    func test_endOfDay() {
        let date = NSDate.date(year: 2015, month: 9, day: 29, hour: 1, minute: 2, second: 3, nanosecond: 4)
        let expectedDate = date.startOf(.Day)! + 1.days - 1.nanoseconds
        XCTAssertEqual(date.endOf(.Day), expectedDate)
    }

    func test_startOfMonth() {
        let date = NSDate.date(year: 2015, month: 9, day: 29, hour: 1, minute: 2, second: 3, nanosecond: 4)
        let expectedDate = NSDate.date(year: 2015, month: 9, day: 1, hour: 0, minute: 0, second: 0, nanosecond: 0)
        XCTAssertEqual(date.startOf(.Month), expectedDate)
    }

    func test_endOfMonth() {
        let date = NSDate.date(year: 2015, month: 9, day: 29, hour: 1, minute: 2, second: 3, nanosecond: 4)
        let expectedDate = date.startOf(.Month)! + 1.months - 1.nanoseconds
        XCTAssertEqual(date.endOf(.Month), expectedDate)
    }

    func test_startOfYear() {
        let date = NSDate.date(year: 2015, month: 9, day: 29, hour: 1, minute: 2, second: 3, nanosecond: 4)
        let expectedDate = NSDate.date(year: 2015, month: 1, day: 1, hour: 0, minute: 0, second: 0, nanosecond: 0)
        XCTAssertEqual(date.startOf(.Year), expectedDate)
    }

    func test_endOfYear() {
        let date = NSDate.date(year: 2015, month: 9, day: 29, hour: 1, minute: 2, second: 3, nanosecond: 4)
        let expectedDate = NSDate.date(year: 2015, month: 12, day: 31, hour: 23, minute: 59, second: 59, nanosecond: 999999999)
        let testDate = date.endOf(.Year)
        XCTAssertEqual(testDate, expectedDate)
    }
    
    func test_startOfWeek() {
        let date = NSDate.date(year: 2016, month: 1, day: 1, hour: 1, minute: 2, second: 3, nanosecond: 4)
        let expectedDate = NSDate.date(year: 2015, month: 12, day: 28, hour: 0, minute: 0, second: 0, nanosecond: 0)
        let testDate = date.startOf(.WeekOfYear)
        XCTAssertEqual(testDate, expectedDate)
    }

    func test_endOfWeek() {
        let date = NSDate.date(year: 2016, month: 1, day: 1, hour: 1, minute: 2, second: 3, nanosecond: 4)
        let expectedDate = date.startOf(.WeekOfYear)! + 1.weeks - 1.nanoseconds
        let testDate = date.endOf(.WeekOfYear)
        XCTAssertEqual(testDate, expectedDate)
    }
    
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
}
