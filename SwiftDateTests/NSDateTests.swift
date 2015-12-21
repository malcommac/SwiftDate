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
import SwiftDate

class NSDateSpec: QuickSpec {

    override func spec() {

        describe("NSDate extension") {

            let newYork = DateRegion(calendarID: NSCalendarIdentifierGregorian, timeZoneID: "America/New York", localeID: "en_US")
            let amsterdam = DateRegion(calendar: CalendarType.Gregorian.toCalendar(), timeZoneID: "CET", localeID: "nl_NL")
            let rome = DateRegion(calendarType: CalendarType.Gregorian, timeZoneRegion: TimeZones.Europe.Rome, localeID: "it_IT")

            context("initialisation") {

                let calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
                let timeZone = NSTimeZone(abbreviation: "CET")


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
                    let date = NSDate(yearForWeekOfYear: 2012, weekOfYear: 3, weekday: 4, region: newYork)

                    let components = NSDateComponents()
                    components.yearForWeekOfYear = 2012
                    components.weekOfYear = 3
                    components.weekday = 4
                    components.calendar = newYork.calendar
                    components.timeZone = newYork.timeZone
                    let expectedDate = calendar.dateFromComponents(components)

                    expect(date) == expectedDate
                }

                it("should return the specified time in the specified region") {
                    let date = NSDate(hour: 13, minute: 14, second: 15, region: rome)

                    let components = NSDateComponents()
                    components.hour = 13
                    components.minute = 14
                    components.second = 15
                    components.calendar = rome.calendar
                    components.timeZone = rome.timeZone
                    let expectedDate = calendar.dateFromComponents(components)

                    expect(date) == expectedDate
                }

                it("should return the specified time in the specified region with a fromDate") {
                    let date = NSDate(fromDate: NSDate(), hour: 13, minute: 14, second: 15, region: amsterdam)

                    let components = calendar.components([.Year, .Month, .Day], fromDate: NSDate())
                    components.hour = 13
                    components.minute = 14
                    components.second = 15
                    components.calendar = amsterdam.calendar
                    components.timeZone = amsterdam.timeZone
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

                    expect(newYorkDate.absoluteTime) == date
                    expect(newYorkDate.region) == newYork
                }

            }
            
            context("period comparisons") {
                
                let date = NSDate(year: 2015, month: 12, day: 16, region: newYork)!
                
                it("should report the proper first day of the week") {
                    let firstDay = date.firstDayOfWeek(inRegion: newYork)!
                    expect(firstDay) == 13
                }
                
                it("should report the proper last day of the week") {
                    let firstDay = date.lastDayOfWeek(inRegion: newYork)!
                    expect(firstDay) == 19
                }
                
            }
            
            context("isIn") {
                
                let date = NSDate(year: 2015, month: 12, day: 14, hour: 13, calendarType: CalendarType.Gregorian, timeZoneID: "CET")!
                
                it("should report proper results for year granularity unit") {
                    let date1 = date - 1.years
                    let date2 = date - 1.months
                    let date3 = date + 1.years
                    let unit = NSCalendarUnit.Year
                    expect(date.isIn(unit, ofDate: date1)) == false
                    expect(date.isIn(unit, ofDate: date2)) == true
                    expect(date.isIn(unit, ofDate: date3)) == false
                }
                
                it("should report proper results for month granularity unit") {
                    let date1 = date - 1.months
                    let date2 = date + 1.weeks
                    let date3 = date + 1.months
                    let unit = NSCalendarUnit.Month
                    expect(date.isIn(unit, ofDate: date1)) == false
                    expect(date.isIn(unit, ofDate: date2)) == true
                    expect(date.isIn(unit, ofDate: date3)) == false
                }
                
            }
            
            context("isBefore") {
                
                let date = DateInRegion(year: 2015, month: 12, day: 14, hour: 13, calendarType: CalendarType.Gregorian, timeZoneID: "CET")!
                
                it("should report proper results for minute granularity unit") {
                    let date1 = date - 1.minutes
                    let date2 = date + 1.seconds
                    let date3 = date + 1.minutes
                    let unit = NSCalendarUnit.Minute
                    expect(date.isBefore(unit, ofDate: date1)) == false
                    expect(date.isBefore(unit, ofDate: date2)) == false
                    expect(date.isBefore(unit, ofDate: date3)) == true
                }
                
                it("should report proper results for second granularity unit") {
                    let date1 = date - 1.seconds
                    let date2 = date + 100000.nanoseconds
                    let date3 = date + 1.seconds
                    let unit = NSCalendarUnit.Second
                    expect(date.isBefore(unit, ofDate: date1)) == false
                    expect(date.isBefore(unit, ofDate: date2)) == false
                    expect(date.isBefore(unit, ofDate: date3)) == true
                }
            }
            
            context("isAfter") {
                
                let date = DateInRegion(year: 2015, month: 12, day: 14, hour: 13, calendarType: CalendarType.Gregorian, timeZoneID: "CET")!
                
                it("should report proper results for week granularity unit") {
                    let date1 = date - 1.weeks
                    let date2 = date + 1.days
                    let date3 = date + 1.weeks
                    let unit = NSCalendarUnit.WeekOfYear
                    expect(date.isAfter(unit, ofDate: date1)) == true
                    expect(date.isAfter(unit, ofDate: date2)) == false
                    expect(date.isAfter(unit, ofDate: date3)) == false
                }
                
                it("should report proper results for hour granularity unit") {
                    let date1 = date - 1.hours
                    let date2 = date + 1.minutes
                    let date3 = date + 1.hours
                    let unit = NSCalendarUnit.Hour
                    expect(date.isAfter(unit, ofDate: date1)) == true
                    expect(date.isAfter(unit, ofDate: date2)) == false
                    expect(date.isAfter(unit, ofDate: date3)) == false
                }
                
            }
            
            context("Day comparisons") {
                
                // Note: these tests are not exhaustive as they are pretty thoroughly tested in DateInRegionComparisonTests
                
                it("should report true for isInToday with today's date") {
                    expect(NSDate().isInToday()) == true
                }
                
                it("should report false for isInToday with yesterday's date") {
                    expect((NSDate() - 1.days).isInToday()) == false
                }
                
                it("should report true for isInYesterday with yesterday's date") {
                    expect((NSDate() - 1.days).isInYesterday()) == true
                }
                
                it("should report false for isInYesterday with today's date") {
                    expect(NSDate().isInYesterday()) == false
                }
                
                it("should report true for isInTomorrow with tomorrows date") {
                    expect((NSDate() + 1.days).isInTomorrow()) == true
                }
                
                it("should report false for isInTomorrow with today's date") {
                    expect(NSDate().isInTomorrow()) == false
                }
                
                it("should report true for isSameDaysAsDate with the same day") {
                    let day = NSDate()
                    expect(day.isInSameDayAsDate(day)) == true
                }
                
                it("should report false for isWeekend with a weekday") {
                    let day = NSDate(year: 2015, month: 12, day: 15, region: amsterdam)!
                    expect(day.isInWeekend(inRegion: amsterdam)) == false
                }
                
                it("should report true for isWeekend with a saturday") {
                    let day = NSDate(year: 2015, month: 12, day: 5, region: amsterdam)!
                    expect(day.isInWeekend(inRegion: amsterdam)) == true
                }
                
            }
            
        }
    }
}

