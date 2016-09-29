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

            var date: NSDate!
            var newYork: Region!
            var amsterdam: Region!
            var rome: Region!
            beforeEach {
                date = NSDate(year: 2001, month: 2, day: 3, region: amsterdam)
                newYork = Region(calendarName: .Gregorian, timeZoneName: .AmericaNewYork, localeName: .EnglishUnitedStates)
                amsterdam = Region(calendarName: .Gregorian, timeZoneName: .EuropeAmsterdam, localeName: .DutchNetherlands)
                rome = Region(calendarName: .Gregorian, timeZoneName: .EuropeRome, localeName: .ItalianItaly)
            }

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
                    let date = NSDate(year: 2015, month: 12, day: 25, hour: 13, minute: 14, second: 15, region: rome)

                    let components = NSDateComponents()
                    components.year = 2015
                    components.month = 12
                    components.day = 25
                    components.hour = 13
                    components.minute = 14
                    components.second = 15
                    components.calendar = rome.calendar
                    components.timeZone = rome.timeZone
                    let expectedDate = calendar.dateFromComponents(components)

                    expect(date) == expectedDate
                }

                it("should return the specified time in the specified region with a fromDate") {
                    let date0 = NSDate(year: 2015, month: 12, day: 25, region: rome)
                    let date1 = NSDate(fromDate: date0)

                    expect(date1) == date0
                }


                it("should return the specified time in the specified region with a fromDate") {
                    let date0 = NSDate(year: 2015, month: 12, day: 25, region: rome)
                    let date1 = NSDate(fromDate: date0, hour: 13, minute: 14, second: 15, region: amsterdam)

                    let components = calendar.components([.Year, .Month, .Day], fromDate: date1)
                    components.year = 2015
                    components.month = 12
                    components.day = 25
                    components.hour = 13
                    components.minute = 14
                    components.second = 15
                    components.calendar = amsterdam.calendar
                    components.timeZone = amsterdam.timeZone
                    let expectedDate = calendar.dateFromComponents(components)

                    expect(date1) == expectedDate
                }


                it("should return the specified time in the specified region with a refDate") {
                    let date0 = NSDate(year: 2015, month: 12, day: 25, region: rome)
                    let date = NSDate(refDate: date0)

                    expect(date) == date0
                }

                it("should return the specified time with a componect dictionary") {
                    let date = NSDate(dateComponentDictionary: [.Year: 2015, .Month: 2, .Day: 3])

                    let expectedDate = NSDate(year: 2015, month: 2, day: 3)

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

                    let newYorkDate = date.inRegion(newYork)

                    expect(newYorkDate.absoluteTime) == date
                    expect(newYorkDate.region) == newYork
                }

            }

            context("period comparisons") {

                let date = NSDate(year: 2015, month: 12, day: 16, region: newYork)

                it("should report the proper first day of the week") {
                    let firstDay = date.firstDayOfWeek(inRegion: newYork)!
                    expect(firstDay) == 13
                }

                it("should report the proper last day of the week") {
                    let firstDay = date.lastDayOfWeek(inRegion: newYork)
                    expect(firstDay) == 19
                }

            }

            context("isIn") {

                let date = NSDate(year: 2015, month: 12, day: 14, hour: 13, region: amsterdam)

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

                let date = NSDate(year: 2015, month: 12, day: 14, hour: 13, region: amsterdam)

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

                let date = NSDate(year: 2015, month: 12, day: 14, hour: 13, region: amsterdam)

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

            context("Leap year") {

                it("should report proper leap months") {
                    expect(date.isInLeapMonth()) == false
                }

                it("should report proper leap months") {
                    let date = NSDate(year: 2004, month: 2, day: 2)
                    expect(date.isInLeapMonth()) == true
                }

                it("should report proper leap year") {
                    let date = NSDate(year: 2004, month: 2, day: 2)
                    expect(date.isInLeapYear()) == true
                }

                it("should report proper leap year") {
                    expect(date.isInLeapYear()) == false
                }

            }

            context("Comparisons") {

                var date1: NSDate!
                beforeEach {
                    date1 = date + 1.days
                }

                it("should compare less than with a date less than") {
                    expect(date < date1) == true
                }

                it("should compare less than with a date greater than") {
                    expect(date1 < date) == false
                }

                it("should compare less than with a date equal to") {
                    expect(date < date) == false
                }

                it("should compare greater than with a date greater than") {
                    expect(date1 > date) == true
                }

                it("should compare greater than with a date less than") {
                    expect(date > date1) == false
                }

                it("should compare greater than with a date equal to") {
                    expect(date > date) == false
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

                it("should report today") {
                    let day = NSDate.today()
                    let now = NSDate()

                    expect(day.year) == now.year
                    expect(day.month) == now.month
                    expect(day.day) == now.day
                    expect(day.hour) == 0
                    expect(day.minute) == 0
                    expect(day.second) == 0
                    expect(day.nanosecond) == 0
                }

                it("should report yesterday") {
                    let day = NSDate.yesterday()
                    let now = NSDate() - 1.days

                    expect(day.year) == now.year
                    expect(day.month) == now.month
                    expect(day.day) == now.day
                    expect(day.hour) == 0
                    expect(day.minute) == 0
                    expect(day.second) == 0
                    expect(day.nanosecond) == 0
                }

                it("should report tomorrow") {
                    let day = NSDate.tomorrow()
                    let now = NSDate() + 1.days

                    expect(day.year) == now.year
                    expect(day.month) == now.month
                    expect(day.day) == now.day
                    expect(day.hour) == 0
                    expect(day.minute) == 0
                    expect(day.second) == 0
                    expect(day.nanosecond) == 0
                }

                it("should report false for isWeekend with a weekday") {
                    let day = NSDate(year: 2015, month: 12, day: 15, region: amsterdam)
                    expect(day.isInWeekend(inRegion: amsterdam)) == false
                }

                it("should report true for isWeekend with a saturday") {
                    let day = NSDate(year: 2015, month: 12, day: 5, region: amsterdam)
                    expect(day.isInWeekend(inRegion: amsterdam)) == true
                }

                it("should report proper startOf without region") {
                    let day = NSDate()
                    expect(day.startOf(.Day)) == NSDate.today()
                }

                it("should report proper endOf without region") {
                    let day = NSDate()
                    expect(day.endOf(.Day).timeIntervalSinceReferenceDate).to(beCloseTo(NSDate.tomorrow().timeIntervalSinceReferenceDate, within: 1))
                }

                it("should report proper startOf") {
                    let day = NSDate(year: 2015, month: 12, day: 5, region: amsterdam)
                    expect(day.startOf(.Month, inRegion: amsterdam)) == NSDate(year: 2015, month: 12, day: 1, region: amsterdam)
                }

                it("should report proper endOf") {
                    let day = NSDate(year: 2015, month: 12, day: 5, region: amsterdam)
                    expect(day.endOf(.Month, inRegion: amsterdam)) == NSDate(year: 2016, month: 1, day: 1, region: amsterdam) - 1000000.nanoseconds
                }

            }

            context("Calculations") {

                let date = NSDate(year: 2001, month: 2, day: 3)

                it("should add zero") {
                    expect(date.add()) == date
                }

                it("should add one day") {
                    expect(date.add(1.days)) == NSDate(year: 2001, month: 2, day: 4)
                }

                it("should get components") {
                    let components = date.components

                    expect(components.year) == 2001
                    expect(components.month) == 2
                    expect(components.day) == 3
                }

                it("should calculate difference with the same date and no flags") {
                    let date2 = NSDate(fromDate: date)
                    let difference = date.difference(date2, unitFlags: [])

                    expect(difference) == NSDateComponents()
                }

                it("should calculate difference with the same date and flags") {
                    let date2 = NSDate(fromDate: date)
                    let difference = date.difference(date2, unitFlags: [.Day, .Month, .Year])

                    expect(difference) == 0.days + 0.months + 0.years
                }

            }

            context("Strings") {

                it("should return toString") {
                    expect(date.toString(inRegion: amsterdam)) == "3 feb. 2001 00:00:00"
                }

                it("should return toString with custom format") {
                    expect(date.toString(.Custom("dd-MMM-yy"), inRegion: amsterdam)) == "03-feb.-01"
                }

                it("should return toString with ISO8601 year format") {
                    expect(date.toString(.ISO8601Format(.Year), inRegion: amsterdam)) == "2001"
                }

                it("should return toString with ISO8601 year month format") {
                    expect(date.toString(.ISO8601Format(.YearMonth), inRegion: amsterdam)) == "2001-02"
                }

                it("should return toString with ISO8601 date format") {
                    expect(date.toString(.ISO8601Format(.Date), inRegion: amsterdam)) == "2001-02-03"
                }

                it("should return toString with ISO8601 date time format") {
                    expect(date.toString(.ISO8601Format(.DateTime), inRegion: amsterdam)) == "2001-02-03T00:00+01:00"
                }

                it("should return toString with full ISO8601 format") {
                    expect(date.toString(.ISO8601Format(.Full), inRegion: amsterdam)) == "2001-02-03T00:00:00+01:00"
                }

                it("should return toString with extended ISO8601 format") {
                    expect(date.toString(.ISO8601Format(.Extended), inRegion: amsterdam)) == "2001-02-03T00:00:00.000+01:00"
                }

                it("should return toString with RSS format") {
                    expect(date.toString(.RSS, inRegion: amsterdam)) == "za, 3 feb. 2001 00:00:00 +0100"
                }

                it("should return toString with AltRSS format") {
                    expect(date.toString(.AltRSS, inRegion: amsterdam)) == "3 feb. 2001 00:00:00 +0100"
                }

                it("should return toString with extended format") {
                    expect(date.toString(.Extended, inRegion: amsterdam)) == "za 03-feb.-2001 n.Chr. 00:00:00.000 +0100"
                }

            }

            context("components") {

                it("should report proper month names") {
                    expect(date.monthName) == "February"
                }

                it("should report proper week of month") {
                    expect(date.weekOfMonth) == 1
                }

                it("should report proper weekday ordinal") {
                    expect(date.weekdayOrdinal) == 1
                }

                it("should report proper monthdays") {
                    expect(date.monthDays) == 28
                }
            }

            context("region") {

                let date = NSDate(year: 2001, month: 2, day: 3)

                it("should get default region") {

                    expect(date.inDefaultRegion()) == date.inRegion()

                }

            }

        }
    }
}
