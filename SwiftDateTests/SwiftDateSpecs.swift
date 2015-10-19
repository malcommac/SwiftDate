//
//  SwiftDateTests.swift
//  SwiftDateTests
//
//  Created by fhisa on 2015/09/28.
//  Copyright (C) 2015 SwiftDate. All rights reserved.
//

import Quick
import Nimble
@testable import SwiftDate

class SwiftDateSpec: QuickSpec {

    override func spec() {

        describe("SwiftDate") {

            context("Initialisaton") {

                it("should initialise with ymd specified") {
                    let testDate = NSDate(year: 2015, month: 10, day: 23)

                    expect(testDate.year) == 2015
                    expect(testDate.month) == 10
                    expect(testDate.day) == 23
                    expect(testDate.hour) == 0
                    expect(testDate.minute) == 0
                    expect(testDate.second) == 0
                }


                it("should initialise on reference date with ymd specified") {
                    let refDate = NSDate()
                    let testDate = NSDate(refDate: refDate, year: 2015, month: 10, day: 23)
                    expect(testDate.year) == 2015
                    expect(testDate.month) == 10
                    expect(testDate.day) == 23
                    expect(testDate.hour) == refDate.hour
                    expect(testDate.minute) == refDate.minute
                    expect(testDate.second) == refDate.second
                }
            }

            context("comparisons") {

                var before: NSDate!
                var now: NSDate!
                var after: NSDate!

                beforeEach {
                    now = NSDate()
                    before = now.dateByAddingTimeInterval(-60.0)
                    after = now.dateByAddingTimeInterval(60.0)
                }

                it("should compare less than properly") {
                    expect(before < now) == true
                    expect(now < after) == true
                    expect(after < now) == false
                    expect(now < before) == false
                    expect(now < now) == false
                }

                it("should compare less than or equal properly") {
                    expect(before <= now) == true
                    expect(now <= after) == true
                    expect(after <= now) == false
                    expect(now <= before) == false
                    expect(now <= now) == true
                }

                it("should compare greater than properly") {
                    expect(before > now) == false
                    expect(now > after) == false
                    expect(after > now) == true
                    expect(now > before) == true
                    expect(now > now) == false
                }

                it("should compare greater than or equal properly") {
                    expect(before >= now) == false
                    expect(now >= after) == false
                    expect(after >= now) == true
                    expect(now >= before) == true
                    expect(now >= now) == true
                }

                it("should compare equality properly") {
                    let bc2015 = NSDate.date(refDate: nil, year: -2014, month: 9, day: 29, hour: 0, minute: 0, second: 0, tz: "UTC")
                    let ac2015 = NSDate.date(refDate: nil, year: 2015, month: 9, day: 29, hour: 0, minute: 0, second: 0, tz: "UTC")

                    expect(bc2015.isEqualToDate(ac2015, ignoreTime: true)) == false
                }

                it("should compare same year properly") {
                    let endOfYear = NSDate.date(refDate: nil, year: 2015, month: 12, day: 31, hour: 23, minute: 59, second: 59, tz: nil)
                    let betweenTime = endOfYear.dateByAddingTimeInterval(0.5)
                    let beginOfYear = NSDate.date(refDate: nil, year: 2016, month: 1, day: 1, tz: nil)
                    expect(endOfYear.isSameYearOf(betweenTime)) == true
                    expect(betweenTime.isSameYearOf(endOfYear)) == true
                    expect(endOfYear.isSameYearOf(beginOfYear)) == false
                    expect(betweenTime.isSameYearOf(beginOfYear)) == false
                }
            }

            context("calulations") {

                it("should add & subtract time intervals properly") {
                    let now = NSDate()
                    let after = now + 60

                    expect(after - now) == 60
                    expect(now - now) == 0
                    expect(now - after) == -60
                }
                
                it("should add & subtract date components properly") {
                    let date = NSDate(year: 2001, month: 1, day: 1).beginningOfDay

                    expect(date + 1.days) == NSDate(year: 2001, month: 1, day: 2)
                    expect(date - 1.days) == NSDate(year: 2000, month: 12, day: 31)
                    expect(date + 14.days) == date + 2.weeks
                    expect(date - 14.days) == date - 2.weeks
                    expect(date + 14.seconds) == date.set(second: 14)
                    expect(date - 14.seconds) == NSDate(year: 2000, month: 12, day: 31, hour: 23, minute: 59, second: 46)
                }
                
                it("should differ properly") {
                    let summerTimeDay = NSDate.date(refDate: nil, year: 2015, month: 3, day: 29, tz: nil)
                    let nextDay = NSDate.date(refDate: nil, year: 2015, month: 3, day: 30, tz: nil)

                    let singleDay = NSDateComponents()
                    singleDay.day = 1

                    expect(summerTimeDay.difference(nextDay, unitFlags: NSCalendarUnit.Day)) == singleDay
                }
            }

            context("string operations") {

                it("should convert to ISO8601 strings with HM and Zulu") {
                    let expectedDate = NSDate.date(refDate: nil, year: 2015, month: 9, day: 29, hour: 0, minute: 0, second: 0, tz: "UTC")
                    let parsedDate = NSDate.date(fromString: "2015-09-29T00:00Z", format: .ISO8601)

                    expect(parsedDate) == expectedDate
                }

                it("should convert to ISO8601 strings with HMS and Zulu") {
                    let expectedDate = NSDate.date(refDate: nil, year: 2015, month: 9, day: 29, hour: 0, minute: 0, second: 0, tz: "UTC")
                    let parsedDate = NSDate.date(fromString: "2015-09-29T00:00:00Z", format: .ISO8601)

                    expect(parsedDate) == expectedDate
                }

                it("should convert to ISO8601 strings with HMS & fraction and Zulu") {
                    let expectedDate = NSDate.date(refDate: nil, year: 2015, month: 9, day: 29, hour: 0, minute: 0, second: 0, tz: "UTC")
                    let parsedDate = NSDate.date(fromString: "2015-09-29T00:00:00.000Z", format: .ISO8601)

                    expect(parsedDate) == expectedDate
                }
            }
        }
    }

}
