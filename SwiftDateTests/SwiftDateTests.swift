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

    func test_init() {
        let testDate = NSDate(year: 2015, month: 10, day: 23)
        XCTAssertEqual(testDate.year, 2015)
        XCTAssertEqual(testDate.month, 10)
        XCTAssertEqual(testDate.day, 23)
        XCTAssertEqual(testDate.hour, 0)
        XCTAssertEqual(testDate.minute, 0)
        XCTAssertEqual(testDate.second, 0)
    }

    
    func test_initRefdate() {
        let refDate = NSDate()
        let testDate = NSDate(refDate: refDate, year: 2015, month: 10, day: 23)
        XCTAssertEqual(testDate.year, 2015)
        XCTAssertEqual(testDate.month, 10)
        XCTAssertEqual(testDate.day, 23)
        XCTAssertEqual(testDate.hour, refDate.hour)
        XCTAssertEqual(testDate.minute, refDate.minute)
        XCTAssertEqual(testDate.second, refDate.second)
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
      
      let singleDay:NSDateComponents = NSDateComponents()
      singleDay.day = 1
      
      XCTAssertEqual(summerTimeDay.difference(nextDay, unitFlags: NSCalendarUnit.Day), singleDay)
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
    
    func test_isSmaeYearOf() {
        let endOfYear = NSDate.date(refDate: nil, year: 2015, month: 12, day: 31, hour: 23, minute: 59, second: 59, tz: nil)
        let betweenTime = endOfYear.dateByAddingTimeInterval(0.5)
        let beginOfYear = NSDate.date(refDate: nil, year: 2016, month: 1, day: 1, tz: nil)
        XCTAssert(endOfYear.isSameYearOf(betweenTime))
        XCTAssert(betweenTime.isSameYearOf(endOfYear))
        XCTAssertFalse(endOfYear.isSameYearOf(beginOfYear))
        XCTAssertFalse(betweenTime.isSameYearOf(beginOfYear))
    }
}
