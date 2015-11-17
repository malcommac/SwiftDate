//
//  DateInRegionSpec.swift
//  DateInRegion
//
//  Created by Jeroen Houtzager on 12/10/15.
//  Copyright © 2015 Jeroen Houtzager. All rights reserved.
//
// https://github.com/Quick/Quick


import Quick
import Nimble
@testable import DateInRegion

class NSDateSpec: QuickSpec {

    override func spec() {

        describe("NSDate extension") {

            context("initialisation") {

                let calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
                let timeZone = NSTimeZone(abbreviation: "CET")
                let region = DateRegion(calendar: calendar, timeZone: timeZone, localeID: "nl_NL")


                it("should return the specified YMD date in the default region") {
                    let date = NSDate(year: 2012, month: 3, day: 4)

                    let calendar = NSCalendar.currentCalendar()
                    let components = NSDateComponents()
                    components.year = 2012
                    components.month = 3
                    components.day = 4
                    components.calendar = calendar
                    components.timeZone = NSTimeZone.defaultTimeZone()
                    let expectedDate = calendar.dateFromComponents(components)

                    expect(date) == expectedDate
                }
                
                it("should return the specified YWD date in the specified region") {
                    let date = NSDate(yearForWeekOfYear: 2012, weekOfYear: 3, weekday: 4, inRegion: region)

                    let components = NSDateComponents()
                    components.yearForWeekOfYear = 2012
                    components.weekOfYear = 3
                    components.weekday = 4
                    components.calendar = calendar
                    components.timeZone = timeZone
                    let expectedDate = calendar.dateFromComponents(components)

                    expect(date) == expectedDate
                }

                it("should return the specified time in the specified region") {
                    let date = NSDate(hour: 13, minute: 14, second: 15, inRegion: region)

                    let components = NSDateComponents()
                    components.hour = 13
                    components.minute = 14
                    components.second = 15
                    components.calendar = calendar
                    components.timeZone = timeZone
                    let expectedDate = calendar.dateFromComponents(components)

                    expect(date) == expectedDate
                }

                it("should return the specified time in the specified region with a fromDate") {
                    let date = NSDate(fromDate: NSDate(), hour: 13, minute: 14, second: 15, inRegion: region)

                    let components = calendar.components([.Year, .Month, .Day], fromDate: NSDate())
                    components.hour = 13
                    components.minute = 14
                    components.second = 15
                    components.calendar = calendar
                    components.timeZone = timeZone
                    let expectedDate = calendar.dateFromComponents(components)

                    expect(date) == expectedDate
                }

                it("should return the specified time in the specified region with components") {
                    let components = NSDateComponents()
                    components.year = 2012
                    components.month = 3
                    components.day = 4
                    components.hour = 13
                    components.minute = 14
                    components.second = 15
                    components.calendar = calendar
                    components.timeZone = timeZone
                    let date = NSDate(components: components)
                    let expectedDate = calendar.dateFromComponents(components)

                    expect(date) == expectedDate
                }
            }

            context("Region") {

                it("Should convert to the right region") {
                    let date = NSDate()

                    let newYork = DateRegion(calendarID: NSCalendarIdentifierGregorian, timeZoneID: "America/New York", localeID: "en_US")
                    let newYorkDate = date.inRegion(newYork)

                    expect(newYorkDate.date) == date
                    expect(newYorkDate.region) == newYork
                }

            }

        }
    }
}

