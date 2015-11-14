//
//  NSDateComponentPortTests.swift
//  NSDate
//
//  Created by Jeroen Houtzager on 07/11/15.
//  Copyright © 2015 CocoaPods. All rights reserved.
//
// https://github.com/Quick/Quick


import Quick
import Nimble
import DateInRegion

class NSDateComponentPortSpec: QuickSpec {

    override func spec() {

        describe("NSDateComponentPort") {

            context("component initialisation") {

                it("should return a midnight date YMD initialisation (summer)") {
                    let date = NSDate(year: 2002, month: 6, day: 23)

                    expect(date).toNot(beNil())
                    expect(date!.year) == 2002
                    expect(date!.month) == 6
                    expect(date!.day) == 23
                    expect(date!.hour) == 0
                    expect(date!.minute) == 0
                    expect(date!.second) == 0
                    expect(date!.nanosecond) == 0
                }
                
                it("should return a midnight date YMD initialisation (winter)") {
                    let date = NSDate(year: 2002, month: 12, day: 23)

                    expect(date!.year) == 2002
                    expect(date!.month) == 12
                    expect(date!.day) == 23
                    expect(date!.hour) == 0
                    expect(date!.minute) == 0
                    expect(date!.second) == 0
                    expect(date!.nanosecond) == 0
                }
                
                it("should return a midnight date with nil YMD initialisation") {
                    let date = NSDate(year: 1912, month: 6, day: 23)!

                    expect(date.year) == 1912
                    expect(date.month) == 6
                    expect(date.day) == 23
                    expect(date.hour) == 0
                    expect(date.minute) == 0
                    expect(date.second) == 0
                    expect(date.nanosecond) == 0
                }


                it("should return a midnight date with nil YWD initialisation") {

                    // TODO: Mock timezone & calendar in region

                    let date = NSDate(yearForWeekOfYear: 1492, weekOfYear: 15, weekday: 4)!

                    expect(date.year) == 1492
                    expect(date.month) == 4
                    expect(date.day) == 13
                    expect(date.hour) == 0
                    expect(date.minute) == 0
                    expect(date.second) == 0
                    expect(date.nanosecond) == 0
                }


                it("should return a 123 date for YMD initialisation") {
                    let date = NSDate(year: 1999, month: 12, day: 31)!

                    expect(date.year) == 1999
                    expect(date.month) == 12
                    expect(date.day) == 31
                }

                it("should return a 123 date for YWD initialisation") {
                    let date = NSDate(yearForWeekOfYear: 2016, weekOfYear: 1, weekday: 1)!

                    expect(date.yearForWeekOfYear) == 2016
                    expect(date.weekOfYear) == 1
                    expect(date.weekday) == 1
                }

                it("should return a date of 0001-01-01 00:00:00.000 in the default region for component initialisation") {
                    let components = NSDateComponents()
                    let date = NSDate(components: components)!

                    expect(date.year) == 1
                    expect(date.month) == 1
                    expect(date.day) == 1
                    expect(date.hour) == 0
                    expect(date.minute) == 0
                    expect(date.second) == 0
                    expect(date.nanosecond) == 0
                }

            }

            context("In Gregorian weekends") {

                it("should return a proper weekend value for a Saturday") {
                    let date = NSDate(year: 2015, month: 11, day: 7)!
                    expect(date.isInWeekend()) == true
                }

                it("should return a proper weekend value for a Sunday") {
                    let date = NSDate(year: 2015, month: 11, day: 8)!
                    expect(date.isInWeekend()) == true
                }

                it("should return a proper weekend value for a Monday") {
                    let date = NSDate(year: 2015, month: 11, day: 9)!
                    expect(date.isInWeekend()) == false
                }

                it("should return a proper weekend value for a Tuesday") {
                    let date = NSDate(year: 2015, month: 11, day: 10)!
                    expect(date.isInWeekend()) == false
                }

                it("should return a proper weekend value for a Wednesday") {
                    let date = NSDate(year: 2015, month: 11, day: 11)!
                    expect(date.isInWeekend()) == false
                }

                it("should return a proper weekend value for a Thursday") {
                    let date = NSDate(year: 2015, month: 11, day: 12)!
                    expect(date.isInWeekend()) == false
                }

                it("should return a proper weekend value for a Friday") {
                    let date = NSDate(year: 2015, month: 11, day: 13)!
                    expect(date.isInWeekend()) == false
                }

            }

            context("Next weekend") {

                var expectedStartDate: NSDate!
                var expectedEndDate: NSDate!
                beforeEach {
                    expectedStartDate = NSDate(year: 2015, month: 11, day: 7)!
                    expectedEndDate = (expectedStartDate + 1.days)!.endOf(.Day)!
                }

                it("should return next weekend on Friday") {
                    let date = NSDate(year: 2015, month: 11, day: 6)!

                    let weekend = date.nextWeekend()!

                    expect(weekend.startDate) == expectedStartDate
                    expect(weekend.endDate) == expectedEndDate
                }

                it("should return next weekend on Thursday") {
                    let date = NSDate(year: 2015, month: 11, day: 5)!

                    let weekend = date.nextWeekend()!

                    expect(weekend.startDate) == expectedStartDate
                    expect(weekend.endDate) == expectedEndDate
                }

                it("should return next weekend on Wednesday") {
                    let date = NSDate(year: 2015, month: 11, day: 4)!

                    let weekend = date.nextWeekend()!

                    expect(weekend.startDate) == expectedStartDate
                    expect(weekend.endDate) == expectedEndDate
                }

                it("should return next weekend on Tuesday") {
                    let date = NSDate(year: 2015, month: 11, day: 3)!

                    let weekend = date.nextWeekend()!

                    expect(weekend.startDate) == expectedStartDate
                    expect(weekend.endDate) == expectedEndDate
                }

                it("should return week's weekend on Monday") {
                    let date = NSDate(year: 2015, month: 11, day: 2)!
                    
                    let weekend = date.nextWeekend()!
                    
                    expect(weekend.startDate) == expectedStartDate
                    expect(weekend.endDate) == expectedEndDate
                }

                it("should return next week's weekend on Sunday") {
                    let date = NSDate(year: 2015, month: 11, day: 1)!

                    let weekend = date.nextWeekend()!

                    expect(weekend.startDate) == expectedStartDate
                    expect(weekend.endDate) == expectedEndDate
                }

                it("should return next week's weekend on Saturday") {
                    let date = NSDate(year: 2015, month: 10, day: 31)!

                    let weekend = date.nextWeekend()!

                    expect(weekend.startDate) == expectedStartDate
                    expect(weekend.endDate) == expectedEndDate
                }
                
            }

            context("Previous weekend") {

                var expectedStartDate: NSDate!
                var expectedEndDate: NSDate!
                beforeEach {
                    expectedStartDate = NSDate(year: 2015, month: 10, day: 31)!
                    expectedEndDate = (expectedStartDate + 1.days)!.endOf(.Day)!
                }

                it("should return last week's weekend on Sunday") {
                    let date = NSDate(year: 2015, month: 11, day: 8)!

                    let weekend = date.previousWeekend()!

                    expect(weekend.startDate) == expectedStartDate
                    expect(weekend.endDate) == expectedEndDate
                }

                it("should return last week's weekend on Saturday") {
                    let date = NSDate(year: 2015, month: 11, day: 7)!

                    let weekend = date.previousWeekend()!

                    expect(weekend.startDate) == expectedStartDate
                    expect(weekend.endDate) == expectedEndDate
                }

                it("should return last weekend on Friday") {
                    let date = NSDate(year: 2015, month: 11, day: 7)!

                    let weekend = date.previousWeekend()!

                    expect(weekend.startDate) == expectedStartDate
                    expect(weekend.endDate) == expectedEndDate
                }

                it("should return last weekend on Thursday") {
                    let date = NSDate(year: 2015, month: 11, day: 5)!

                    let weekend = date.previousWeekend()!

                    expect(weekend.startDate) == expectedStartDate
                    expect(weekend.endDate) == expectedEndDate
                }

                it("should return last weekend on Wednesday") {
                    let date = NSDate(year: 2015, month: 11, day: 4)!

                    let weekend = date.previousWeekend()!

                    expect(weekend.startDate) == expectedStartDate
                    expect(weekend.endDate) == expectedEndDate
                }

                it("should return last weekend on Tuesday") {
                    let date = NSDate(year: 2015, month: 11, day: 3)!

                    let weekend = date.previousWeekend()!

                    expect(weekend.startDate) == expectedStartDate
                    expect(weekend.endDate) == expectedEndDate
                }

                it("should return week's weekend on Monday") {
                    let date = NSDate(year: 2015, month: 11, day: 2)!

                    let weekend = date.previousWeekend()!

                    expect(weekend.startDate) == expectedStartDate
                    expect(weekend.endDate) == expectedEndDate
                }
            }
        }
    }
}

