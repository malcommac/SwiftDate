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

            context("component ports") {

                let date = NSDate(year: 2012, month: 3, day: 4, hour: 5, minute: 6, second: 7)!

                it("should report proper components") {
                    expect(date.era) == 1
                    expect(date.year) == 2012
                    expect(date.month) == 3
                    expect(date.day) == 4
                    expect(date.yearForWeekOfYear) == 2012
                    expect(date.weekOfYear) == 10
                    expect(date.weekday) == 1
                    expect(date.weekdayOrdinal) == 1
                    expect(date.weekOfMonth) == 2
                    expect(date.hour) == 5
                    expect(date.minute) == 6
                    expect(date.second) == 7
                    expect(date.nanosecond) == 0
                }

                it("should report leap data properly") {
                    expect(NSDate(year: 2000, month: 1, day: 10)!.leapYear) == true
                    expect(NSDate(year: 2001, month: 1, day: 10)!.leapYear) == false
                    expect(NSDate(year: 2002, month: 1, day: 10)!.leapYear) == false
                    expect(NSDate(year: 2003, month: 1, day: 10)!.leapYear) == false
                    expect(NSDate(year: 2004, month: 1, day: 10)!.leapYear) == true
                    expect(NSDate(year: 2100, month: 1, day: 10)!.leapYear) == false
                    expect(NSDate(year: 1500, month: 1, day: 10)!.leapYear) == false

                    expect(NSDate(year: 2000, month: 1, day: 10)!.leapMonth) == false
                    expect(NSDate(year: 2001, month: 1, day: 10)!.leapMonth) == false
                    expect(NSDate(year: 2002, month: 1, day: 10)!.leapMonth) == false
                    expect(NSDate(year: 2003, month: 1, day: 10)!.leapMonth) == false
                    expect(NSDate(year: 2004, month: 1, day: 10)!.leapMonth) == false
                    expect(NSDate(year: 2100, month: 1, day: 10)!.leapMonth) == false
                    expect(NSDate(year: 1500, month: 1, day: 10)!.leapMonth) == false

                    expect(NSDate(year: 2000, month: 2, day: 10)!.leapMonth) == true
                    expect(NSDate(year: 2001, month: 2, day: 10)!.leapMonth) == false
                    expect(NSDate(year: 2002, month: 2, day: 10)!.leapMonth) == false
                    expect(NSDate(year: 2003, month: 2, day: 10)!.leapMonth) == false
                    expect(NSDate(year: 2004, month: 2, day: 10)!.leapMonth) == true
                    expect(NSDate(year: 2100, month: 2, day: 10)!.leapMonth) == false
                    expect(NSDate(year: 1500, month: 2, day: 10)!.leapMonth) == false
                }
            }


            context("weekends") {

                it("should report the next weekend during the week") {
                    let date = NSDate(year: 2015, month: 11, day: 18)!
                    let weekend = date.nextWeekend()!

                    expect(weekend.startDate.day) == 21
                    expect(weekend.startDate.month) == 11
                    expect(weekend.startDate.year) == 2015
                    expect(weekend.endDate.day) == 22
                    expect(weekend.endDate.month) == 11
                    expect(weekend.endDate.year) == 2015
                }

                it("should report the previous weekend during the week") {
                    let date = NSDate(year: 2015, month: 11, day: 18)!
                    let weekend = date.previousWeekend()!

                    expect(weekend.startDate.day) == 14
                    expect(weekend.startDate.month) == 11
                    expect(weekend.startDate.year) == 2015
                    expect(weekend.endDate.day) == 15
                    expect(weekend.endDate.month) == 11
                    expect(weekend.endDate.year) == 2015
                }

                it("should report the current weekend in the weekend") {
                    let date = NSDate(year: 2015, month: 11, day: 21)!
                    let weekend = date.thisWeekend()!

                    expect(weekend.startDate.day) == 21
                    expect(weekend.startDate.month) == 11
                    expect(weekend.startDate.year) == 2015
                    expect(weekend.endDate.day) == 22
                    expect(weekend.endDate.month) == 11
                    expect(weekend.endDate.year) == 2015
                }
                
                it("should report nil outside the weekend") {
                    let date = NSDate(year: 2015, month: 11, day: 16)!
                    let weekend = date.thisWeekend()
                    expect(weekend).to(beNil())
                }
                
                it("should report the next weekend in the weekend") {
                    let date = NSDate(year: 2015, month: 11, day: 21)!
                    let weekend = date.nextWeekend()!

                    expect(weekend.startDate.day) == 28
                    expect(weekend.startDate.month) == 11
                    expect(weekend.startDate.year) == 2015
                    expect(weekend.endDate.day) == 29
                    expect(weekend.endDate.month) == 11
                    expect(weekend.endDate.year) == 2015
                }
                
                it("should report the previous weekend in the weekend") {
                    let date = NSDate(year: 2015, month: 11, day: 21)!
                    let weekend = date.previousWeekend()!

                    expect(weekend.startDate.day) == 14
                    expect(weekend.startDate.month) == 11
                    expect(weekend.startDate.year) == 2015
                    expect(weekend.endDate.day) == 15
                    expect(weekend.endDate.month) == 11
                    expect(weekend.endDate.year) == 2015
                }
            }


            context("comparisons") {

                let date1 = NSDate(year: 2001, month: 2, day: 3)
                let date1b = NSDate(year: 2001, month: 2, day: 3)
                let date2 = NSDate(year: 2001, month: 2, day: 4)

                it("less than") {
                    expect(date1 < date1) == false
                    expect(date1 < date1b) == false
                    expect(date1 < date2) == true
                    expect(date2 < date1) == false
                }

                it("greater than") {
                    expect(date1 > date1) == false
                    expect(date1 > date1b) == false
                    expect(date1 > date2) == false
                    expect(date2 > date1) == true
                }

                it("equal to") {
                    expect(date1 == date1) == true
                    expect(date1 == date1b) == true
                    expect(date1 == date2) == false
                    expect(date2 == date1) == false
                }

            }
        }
    }
    
}

