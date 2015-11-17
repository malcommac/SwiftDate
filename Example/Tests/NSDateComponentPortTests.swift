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
                    let calendar = NSCalendar.currentCalendar()
                    let components = calendar.components([.Year, .Month, .Day], fromDate: date!)
                    expect(components.year) == 2002
                    expect(components.month) == 6
                    expect(components.day) == 23
                    expect(components.hour) == NSDateComponentUndefined
                    expect(components.minute) == NSDateComponentUndefined
                }
                
                it("should return a midnight date YMD initialisation (winter)") {
                    let date = NSDate(year: 2002, month: 12, day: 23)

                    expect(date).toNot(beNil())
                    let calendar = NSCalendar.currentCalendar()
                    let components = calendar.components([.Year, .Month, .Day], fromDate: date!)
                    expect(components.year) == 2002
                    expect(components.month) == 12
                    expect(components.day) == 23
                }
                
                it("should return a midnight date with nil YMD initialisation") {
                    let date = NSDate(year: 1912, month: 6, day: 23)!

                    let calendar = NSCalendar.currentCalendar()
                    let components = calendar.components([.Year, .Month, .Day], fromDate: date)
                    expect(components.year) == 1912
                    expect(components.month) == 6
                    expect(components.day) == 23
                }


                it("should return a midnight date with nil YWD initialisation") {
                    let newYork = DateRegion(localeID: "en_US")
                    let date = NSDate(yearForWeekOfYear: 1492, weekOfYear: 15, weekday: 4, inRegion: newYork)!
                    let components = NSDateComponents()
                    components.yearForWeekOfYear = 1492
                    components.weekOfYear = 15
                    components.weekday = 4
                    components.calendar = newYork.calendar
                    components.timeZone = newYork.timeZone
                    let expectedDate = newYork.calendar.dateFromComponents(components)!

                    expect(date) == expectedDate
                }


                it("should return a date of 0001-01-01 00:00:00.000 in the default region for component initialisation") {
                    let components = NSDateComponents()
                    let date = NSDate(components: components)!

                    expect(date).toNot(beNil())
                    let calendar = NSCalendar.currentCalendar()
                    let testComponents = calendar.components([.Year, .Month, .Day, .Hour, .Minute, .Second], fromDate: date)
                    expect(testComponents.year) == 1
                    expect(testComponents.month) == 1
                    expect(testComponents.day) == 1
                    expect(testComponents.hour) == 0
                    expect(testComponents.minute) == 0
                    expect(testComponents.second) == 0
                }

            }
        }
    }
}

