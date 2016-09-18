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

        describe("Date extension") {

            var date: Date!
            var newYork: Region!
            var amsterdam: Region!
            var rome: Region!
            beforeEach {
                date = Date(year: 2001, month: 2, day: 3, region: amsterdam)
                newYork = Region(calendarName: .gregorian, timeZoneName: .americaNewYork, localeName: .englishUnitedStates)
                amsterdam = Region(calendarName: .gregorian, timeZoneName: .europeAmsterdam, localeName: .dutchNetherlands)
                rome = Region(calendarName: .gregorian, timeZoneName: .europeRome, localeName: .italianItaly)
            }

            context("initialisation") {

                let calendar = Calendar(identifier: Calendar.Identifier.gregorian)
                let timeZone = TimeZone(abbreviation: "CET")

                it("should return the specified YMD date in the default region") {
                    let date = Date(year: 2012, month: 3, day: 4)

                    let calendar = Calendar.current
                    var components = DateComponents()
                    components.year = 2012
                    components.month = 3
                    components.day = 4
                    components.calendar = calendar
                    components.timeZone = NSTimeZone.default
                    let expectedDate = calendar.date(from: components)

                    expect(date) == expectedDate
                }

                it("should return the specified YWD date in the specified region") {
                    let date = Date(yearForWeekOfYear: 2012, weekOfYear: 3, weekday: 4, region: newYork)

                    var components = DateComponents()
                    components.yearForWeekOfYear = 2012
                    components.weekOfYear = 3
                    components.weekday = 4
                    components.calendar = newYork.calendar
                    components.timeZone = newYork.timeZone
                    let expectedDate = calendar.date(from: components as DateComponents)

                    expect(date) == expectedDate
                }

                it("should return the specified time in the specified region") {
                    let date = Date(year: 2015, month: 12, day: 25, hour: 13, minute: 14, second: 15, region: rome)

                    var components = DateComponents()
                    components.year = 2015
                    components.month = 12
                    components.day = 25
                    components.hour = 13
                    components.minute = 14
                    components.second = 15
                    components.calendar = rome.calendar
                    components.timeZone = rome.timeZone
                    let expectedDate = calendar.date(from: components as DateComponents)

                    expect(date) == expectedDate
                }

                it("should return the specified time in the specified region with a fromDate") {
                    let date0 = Date(year: 2015, month: 12, day: 25, region: rome)
                    let date1 = Date(fromDate: date0)

                    expect(date1) == date0
                }

                it("should return the specified time in the specified region with a fromDate") {
                    let date0 = Date(year: 2015, month: 12, day: 25, region: rome)
                    let date1 = Date(fromDate: date0, hour: 13, minute: 14, second: 15, region: amsterdam)

                    var components = calendar.dateComponents([.year, .month, .day], from: date1)
                    components.year = 2015
                    components.month = 12
                    components.day = 25
                    components.hour = 13
                    components.minute = 14
                    components.second = 15
                    components.calendar = amsterdam.calendar
                    components.timeZone = amsterdam.timeZone
                    let expectedDate = calendar.date(from: components)

                    expect(date1) == expectedDate
                }


                it("should return the specified time in the specified region with a refDate") {
                    let date0 = Date(year: 2015, month: 12, day: 25, region: rome)
                    let date = Date(refDate: date0)

                    expect(date) == date0
                }

                it("should return the specified time with a componect dictionary") {
                    let date = Date(dateComponentDictionary: [.year: 2015, .month: 2, .day: 3])

                    let expectedDate = Date(year: 2015, month: 2, day: 3)

                    expect(date) == expectedDate
                }

                it("should return the specified time in the specified region with components") {
                    var components = DateComponents()
                    components.year = 2012
                    components.month = 3
                    components.day = 4
                    components.hour = 13
                    components.minute = 14
                    components.second = 15
                    components.calendar = calendar as Calendar
                    components.timeZone = timeZone as TimeZone?
                    let date = Date(components: components)
                    let expectedDate = calendar.date(from: components as DateComponents)

                    expect(date) == expectedDate
                }

            }

            context("Region") {

                it("Should convert to the right region") {
                    let date = Date()

                    let newYorkDate = date.inRegion(newYork)

                    expect(newYorkDate.absoluteTime) == date
                    expect(newYorkDate.region) == newYork
                }

            }

            context("period comparisons") {

                let date = Date(year: 2015, month: 12, day: 16, region: newYork)

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

                let date = Date(year: 2015, month: 12, day: 14, hour: 13, region: amsterdam)

                it("should report proper results for year granularity unit") {
                    let date1 = date - 1.years
                    let date2 = date - 1.months
                    let date3 = date + 1.years
                    let unit = Calendar.Component.year
                    expect(date.isIn(component: unit, ofDate: date1)) == false
                    expect(date.isIn(component: unit, ofDate: date2)) == true
                    expect(date.isIn(component: unit, ofDate: date3)) == false
                }

                it("should report proper results for month granularity unit") {
                    let date1 = date - 1.months
                    let date2 = date + 1.weeks
                    let date3 = date + 1.months
                    let unit = Calendar.Component.month
                    expect(date.isIn(component: unit, ofDate: date1)) == false
                    expect(date.isIn(component: unit, ofDate: date2)) == true
                    expect(date.isIn(component: unit, ofDate: date3)) == false
                }

            }

            context("isBefore") {

                let date = Date(year: 2015, month: 12, day: 14, hour: 13, region: amsterdam)

                it("should report proper results for minute granularity unit") {
                    let date1 = date - 1.minutes
                    let date2 = date + 1.seconds
                    let date3 = date + 1.minutes
                    let unit = Calendar.Component.minute
                    expect(date.isBefore(component: unit, ofDate: date1)) == false
                    expect(date.isBefore(component: unit, ofDate: date2)) == false
                    expect(date.isBefore(component: unit, ofDate: date3)) == true
                }

                it("should report proper results for second granularity unit") {
                    let date1 = date - 1.seconds
                    let date2 = date + 100000.nanoseconds
                    let date3 = date + 1.seconds
                    let unit = Calendar.Component.second
                    expect(date.isBefore(component: unit, ofDate: date1)) == false
                    expect(date.isBefore(component: unit, ofDate: date2)) == false
                    expect(date.isBefore(component: unit, ofDate: date3)) == true
                }
            }

            context("isAfter") {

                let date = Date(year: 2015, month: 12, day: 14, hour: 13, region: amsterdam)

                it("should report proper results for week granularity unit") {
                    let date1 = date - 1.weeks
                    let date2 = date + 1.days
                    let date3 = date + 1.weeks
                    let unit = Calendar.Component.weekOfYear
                    expect(date.isAfter(component: unit, ofDate: date1)) == true
                    expect(date.isAfter(component: unit, ofDate: date2)) == false
                    expect(date.isAfter(component: unit, ofDate: date3)) == false
                }

                it("should report proper results for hour granularity unit") {
                    let date1 = date - 1.hours
                    let date2 = date + 1.minutes
                    let date3 = date + 1.hours
                    let unit = Calendar.Component.hour
                    expect(date.isAfter(component: unit, ofDate: date1)) == true
                    expect(date.isAfter(component: unit, ofDate: date2)) == false
                    expect(date.isAfter(component: unit, ofDate: date3)) == false
                }

            }

            context("Leap year") {

                it("should report proper leap months") {
                    expect(date.isInLeapMonth()) == false
                }

                it("should report proper leap months") {
                    let date = Date(year: 2004, month: 2, day: 2)
                    expect(date.isInLeapMonth()) == true
                }

                it("should report proper leap year") {
                    let date = Date(year: 2004, month: 2, day: 2)
                    expect(date.isInLeapYear()) == true
                }

                it("should report proper leap year") {
                    expect(date.isInLeapYear()) == false
                }

            }

            context("Comparisons") {

                var date1: Date!
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
                    expect(Date().isInToday()) == true
                }

                it("should report false for isInToday with yesterday's date") {
                    expect((Date() - 1.days).isInToday()) == false
                }

                it("should report true for isInYesterday with yesterday's date") {
                    expect((Date() - 1.days).isInYesterday()) == true
                }

                it("should report false for isInYesterday with today's date") {
                    expect(Date().isInYesterday()) == false
                }

                it("should report true for isInTomorrow with tomorrows date") {
                    expect((Date() + 1.days).isInTomorrow()) == true
                }

                it("should report false for isInTomorrow with today's date") {
                    expect(Date().isInTomorrow()) == false
                }

                it("should report true for isSameDaysAsDate with the same day") {
                    let day = Date()
                    expect(day.isInSameDayAsDate(date: day)) == true
                }

                it("should report today") {
                    let day = Date.today()
                    let now = Date()

                    expect(day.year) == now.year
                    expect(day.month) == now.month
                    expect(day.day) == now.day
                    expect(day.hour) == 0
                    expect(day.minute) == 0
                    expect(day.second) == 0
                    expect(day.nanosecond) == 0
                }

                it("should report yesterday") {
                    let day = Date.yesterday()
                    let now = Date() - 1.days

                    expect(day.year) == now.year
                    expect(day.month) == now.month
                    expect(day.day) == now.day
                    expect(day.hour) == 0
                    expect(day.minute) == 0
                    expect(day.second) == 0
                    expect(day.nanosecond) == 0
                }

                it("should report tomorrow") {
                    let day = Date.tomorrow()
                    let now = Date() + 1.days

                    expect(day.year) == now.year
                    expect(day.month) == now.month
                    expect(day.day) == now.day
                    expect(day.hour) == 0
                    expect(day.minute) == 0
                    expect(day.second) == 0
                    expect(day.nanosecond) == 0
                }

                it("should report false for isWeekend with a weekday") {
                    let day = Date(year: 2015, month: 12, day: 15, region: amsterdam)
                    expect(day.isInWeekend(inRegion: amsterdam)) == false
                }

                it("should report true for isWeekend with a saturday") {
                    let day = Date(year: 2015, month: 12, day: 5, region: amsterdam)
                    expect(day.isInWeekend(inRegion: amsterdam)) == true
                }

                it("should report proper startOf without region") {
                    let day = Date()
                    expect(day.startOf(component: .day)) == Date.today()
                }

                it("should report proper endOf without region") {
                    let day = Date()
                    expect(day.endOf(component: .day).timeIntervalSinceReferenceDate).to(beCloseTo(Date.tomorrow().timeIntervalSinceReferenceDate, within: 1))
                }

                it("should report proper startOf") {
                    let day = Date(year: 2015, month: 12, day: 5, region: amsterdam)
                    expect(day.startOf(component: .month, in: amsterdam)) == Date(year: 2015, month: 12, day: 1, region: amsterdam)
                }

                it("should report proper endOf") {
                    let day = Date(year: 2015, month: 12, day: 5, region: amsterdam)
                    expect(day.endOf(component: .month, in: amsterdam)) == Date(year: 2016, month: 1, day: 1, region: amsterdam) - 1000000.nanoseconds
                }

                it("should report true for isInPast with a date in the past") {
                    expect(5.seconds.ago.isInPast()) == true
                }

                it("should report false for isInPast with a date in the future") {
                    expect(5.seconds.fromNow.isInPast()) == false
                }

                it("should report false for isInFuture with a date in the past") {
                    expect(5.seconds.ago.isInFuture()) == false
                }

                it("should report true for isInFuture with a date in the future") {
                    expect(5.seconds.fromNow.isInFuture()) == true
                }

            }

            context("Calculations") {

                let date = Date(year: 2001, month: 2, day: 3)

                it("should add zero") {
                    expect(date.add()) == date
                }

                it("should add one day") {
                    expect(date.add(components: 1.days)) == Date(year: 2001, month: 2, day: 4)
                }

                it("should get components") {
                    let components = date.components

                    expect(components.year) == 2001
                    expect(components.month) == 2
                    expect(components.day) == 3
                }

                it("should calculate difference with the same date and no flags") {
                    let date2 = Date(fromDate: date)
                    let difference = date.difference(to: date2, componentFlags: [])

                    expect(difference) == DateComponents()
                }

                it("should calculate difference with the same date and flags") {
                    let date2 = Date(fromDate: date)
                    let difference = date.difference(to: date2, componentFlags: [.day, .month, .year])

                    expect(difference) == 0.days + 0.months + 0.years
                }

            }

            context("Strings") {

                it("should return toString") {
                    expect(date.toString(inRegion: amsterdam)) == "3 feb. 2001 00:00:00"
                }

                it("should return toString with custom format") {
                    expect(date.toString(format: .custom("dd-MMM-yy"), in: amsterdam)) == "03-feb.-01"
                }

                it("should return toString with ISO8601 year format") {
                    expect(date.toString(format: .iso8601Format(.year), in: amsterdam)) == "2001"
                }

                it("should return toString with ISO8601 year month format") {
                    expect(date.toString(format: .iso8601Format(.yearMonth), in: amsterdam)) == "2001-02"
                }

                it("should return toString with ISO8601 date format") {
                    expect(date.toString(format: .iso8601Format(.date), in: amsterdam)) == "2001-02-03"
                }
				
				it("should return proper ISO 8601 (hour minute) string") {
					expect(date.toString(format: DateFormat.iso8601Format(.hourMinute))) == "22:10"
				}
				
				it("should return proper ISO 8601 (time) string") {
					expect(date.toString(format: DateFormat.iso8601Format(.time))) == "22:10:00"
				}

                it("should return toString with ISO8601 date time format") {
                    expect(date.toString(format: .iso8601Format(.dateTime), in: amsterdam)) == "2001-02-03T00:00+01:00"
                }

                it("should return toString with full ISO8601 format") {
                    expect(date.toString(format: .iso8601Format(.full), in: amsterdam)) == "2001-02-03T00:00:00+01:00"
                }

                it("should return toString with extended ISO8601 format") {
                    expect(date.toString(format: .iso8601Format(.extended), in: amsterdam)) == "2001-02-03T00:00:00.000+01:00"
                }

                it("should return toString with RSS format") {
                    expect(date.toString(format: .rss, in: amsterdam)) == "za, 3 feb. 2001 00:00:00 +0100"
                }

                it("should return toString with altRSS format") {
                    expect(date.toString(format: .altRSS, in: amsterdam)) == "3 feb. 2001 00:00:00 +0100"
                }

                it("should return toString with extended format") {
                    expect(date.toString(format: .extended, in: amsterdam)) == "za 03-feb.-2001 n.Chr. 00:00:00.000 +0100"
                }

            }

            context("components") {
				
				it("should report proper short month names") {
					expect(date.shortMonthName) == "Feb"
				}

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

                let date = Date(year: 2001, month: 2, day: 3)

                it("should get default region") {

                    expect(date.inDefaultRegion()) == date.inRegion()

                }

            }

        }
    }
}
