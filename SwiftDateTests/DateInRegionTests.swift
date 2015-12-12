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

@testable import SwiftDate

class DateInRegionSpec: QuickSpec {

    override func spec() {

        let newYork = DateRegion(calendarID: NSCalendarIdentifierGregorian, timeZoneID: "America/New York", localeID: "en_US")
        let netherlands = DateRegion(calendarID: NSCalendarIdentifierGregorian, timeZoneID: "Europe/Amsterdam", localeID: "nl_NL")
        let italy = DateRegion(calendarID: NSCalendarIdentifierGregorian, timeZoneID: "Europe/Rome", localeID: "it_IT")
        let utc = DateRegion(calendarID: NSCalendarIdentifierGregorian, timeZoneID: "UTC", localeID: "en_UK")

        describe("DateInRegion") {

            context("DateInRegion, region initialisation") {

                it("should have the default time zone in the current calendar") {
                    let expectedTimeZone = NSTimeZone.defaultTimeZone()
                    expect(NSCalendar.currentCalendar().timeZone) == expectedTimeZone
                }

                it("should have the default region as default") {
                    let date = DateInRegion()
                    let expectedRegion = DateRegion()

                    expect(date).toNot(beNil())
                    expect(date.region) == expectedRegion
                }

                it("should have the specified region") {
                    let date = DateInRegion(region: newYork)
                    expect(date.region) == newYork
                }

                it("should return the current date") {
                    let jhDate = DateInRegion(region: netherlands)
                    let nsDate = NSDate()

                    let expectedInterval = NSTimeInterval(Double(nsDate.timeIntervalSinceReferenceDate))
                    expect(jhDate.timeIntervalSinceReferenceDate) ≈ (expectedInterval, 1)
                }

                it("should return the specified date") {
                    let calendar = NSCalendar(identifier: NSCalendarIdentifierJapanese)!
                    let components = NSDateComponents()
                    components.year = 2345
                    components.month = 12
                    components.day = 5
                    let nsDate = calendar.dateFromComponents(components)!

                    let jhDate = DateInRegion(absoluteTime: nsDate, region: netherlands)

                    let expectedInterval = NSTimeInterval(Double(nsDate.timeIntervalSinceReferenceDate))
                    expect(jhDate.timeIntervalSinceReferenceDate) == expectedInterval
                }
                
            }
/*
            context("DefaultComponents") {

                it("should return 1-Jan-2001 00:00:00.000 in the local time zone") {
                    let components = DateInRegion.defaultComponents()

                    expect(components.year) == 2001
                    expect(components.month) == 1
                    expect(components.day) == 1
                    expect(components.hour) == 0
                    expect(components.minute) == 0
                    expect(components.second) == 0
                    expect(components.nanosecond) == 0
                    expect(components.calendar) == NSCalendar.currentCalendar()
                    expect(components.timeZone) == NSTimeZone.localTimeZone()
                }

            }
*/
            context("NSDate ports") {

                it("should return a zero time interval for 1-Jan-2001 00:00:00.000 UTC") {
                    let refDate = NSDate(timeIntervalSinceReferenceDate: 0)
                    let date = DateInRegion(absoluteTime: refDate, region: utc)

                    expect(date.timeIntervalSinceReferenceDate) == 0
                }
                
                it("should report the maximum date") {
                    let testDate = DateInRegion(year: 5, month: 2, day: 3, region: netherlands)!
                    let maxDate = DateInRegion.latestDate(
                        DateInRegion(year: 1, month: 2, day: 3, region: netherlands)!,
                        DateInRegion(year: 2, month: 2, day: 3, region: netherlands)!,
                        DateInRegion(year: 3, month: 2, day: 3, region: netherlands)!,
                        testDate,
                        DateInRegion(year: 4, month: 2, day: 3, region: netherlands)!)
                    expect(maxDate) == testDate
                }

                it("should report the minimum date") {
                    let testDate = DateInRegion(year: 100, month: 2, day: 3)!
                    let minDate = DateInRegion.earliestDate(
                        DateInRegion(year: 101, month: 2, day: 3)!,
                        DateInRegion(year: 102, month: 2, day: 3)!,
                        DateInRegion(year: 103, month: 2, day: 3)!,
                        testDate,
                        DateInRegion(year: 104, month: 2, day: 3)!)
                    expect(minDate) == testDate
                }

            }

            context("component initialisation") {

                it("should return a midnight date with nil YMD initialisation with UTC time zone") {
                    let date = DateInRegion(year: 1912, month: 6, day: 23, region: utc)!
                    let calendar = date.calendar
                    calendar.timeZone = utc.timeZone

                    expect(date.year) == 1912
                    expect(date.month) == 6
                    expect(date.day) == 23
                    expect(date.hour) == 0
                    expect(date.minute) == 0
                    expect(date.second) == 0
                    expect(date.nanosecond) == 0
                    expect(date.calendar) == calendar
                    expect(date.timeZone) == utc.timeZone
                }


                it("should return a midnight date with nil YMD initialisation") {
                    let date = DateInRegion(year: 1912, month: 6, day: 23)!

                    expect(date.year) == 1912
                    expect(date.month) == 6
                    expect(date.day) == 23
                    expect(date.hour) == 0
                    expect(date.minute) == 0
                    expect(date.second) == 0
                    expect(date.nanosecond) == 0
                    expect(date.region) == DateRegion()
                }


                it("should return a midnight date with nil YWD initialisation") {
                    let date = DateInRegion(yearForWeekOfYear: 1492, weekOfYear: 15, weekday: 4, region: netherlands)!

                    expect(date.year) == 1492
                    expect(date.month) == 4
                    expect(date.day) == 13
                    expect(date.hour) == 0
                    expect(date.minute) == 0
                    expect(date.second) == 0
                    expect(date.nanosecond) == 0
                    expect(date.region) == netherlands
                }


                it("should return a 123 date for YMD initialisation") {
                    let date = DateInRegion(year: 1999, month: 12, day: 31)!

                    expect(date.year) == 1999
                    expect(date.month) == 12
                    expect(date.day) == 31
                    expect(date.region) == DateRegion()
                }

                it("should return a 123 date for YWD initialisation") {
                    let date = DateInRegion(yearForWeekOfYear: 2016, weekOfYear: 1, weekday: 1)!

                    expect(date.yearForWeekOfYear) == 2016
                    expect(date.weekOfYear) == 1
                    expect(date.weekday) == 1
                }

                it("should return a date of 0001-01-01 00:00:00.000 UTC for component initialisation") {
                    let components = NSDateComponents()
                    let nsDate = NSCalendar.currentCalendar().dateFromComponents(components)!
                    let date = DateInRegion(components)!
                    let expectedDate = DateInRegion(absoluteTime: nsDate)

                    expect(date) == expectedDate
                }

                it("should return a proper date") {
                    let date = DateInRegion(year: 1999, month: 12, day: 31, region: newYork)!
                    let components = date.components
                    expect(components.year) == 1999
                    expect(components.month) == 12
                    expect(components.day) == 31
                    expect(components.timeZone) == newYork.timeZone
                }
                
                it("should return a proper date from components chaining") {
                    let date = DateInRegion(1999.years | 12.months | 31.days)!
                    let components = date.components
                    expect(components.year) == 1999
                    expect(components.month) == 12
                    expect(components.day) == 31
                    expect(components.calendar) == DateRegion().calendar
                    expect(components.timeZone) == DateRegion().timeZone
                    expect(components.calendar!.locale) == DateRegion().locale
                }
                
            }

            context("properties") {
                
                it("should return proper normal YMD properties") {
                    let date = DateInRegion(year: 1999, month: 12, day: 31)!
                    expect(date.year) == 1999
                    expect(date.month) == 12
                    expect(date.day) == 31
                }

                it("should return proper normal HMSN properties") {
                    let date = DateInRegion(year: 1999, month: 12, day: 31, hour: 23, minute: 59, second: 59, nanosecond: 500000000)!
                    expect(date.year) == 1999
                    expect(date.month) == 12
                    expect(date.day) == 31
                    expect(date.hour) == 23
                    expect(date.minute) == 59
                    expect(date.second) == 59
                    expect(date.nanosecond) > 400000000
                    expect(date.nanosecond) < 600000000
                }

                it("should return proper leap month for Gregorian calendars") {
                    for year in 1500...2500 {
                        let date = DateInRegion(year: year, month: 2, day: 1, region: netherlands)!

                        if year < 1582 {
                            expect(date.leapMonth).to(beFalse(), description: "years < 1582 have no leap year")
                        } else if year % 400 == 0 {
                            expect(date.leapMonth).to(beTrue(), description: "year \(year) is divisable by 400 and is leap")
                        } else if year % 100 == 0 {
                            expect(date.leapMonth).to(beFalse(), description: "year \(year) is divisable by 100 and is NOT leap")
                        } else if year % 4 == 0 {
                            expect(date.leapMonth).to(beTrue(), description: "year \(year) is divisable by 4 and is leap")
                        } else {
                            expect(date.leapMonth).to(beFalse(), description: "year \(year) is NOT divisable by 4 and is NOT leap")
                        }
                    }
                }
                
                it("should not return leap month for non-February months in Gregorian calendars") {
                    for month in 1...12 {
                        // Skip February
                        if month == 2 { continue }

                        let date = DateInRegion(year: 2000, month: month, day: 1, region: netherlands)!

                        expect(date.leapMonth).to(beFalse(), description: "months other than February can never be leap months")
                    }
                }
                
                it("should return proper leap year for Gregorian calendars") {
                    for year in 1500...2500 {
                        let date = DateInRegion(year: year, month: 8, day: 1, region: netherlands)!

                        if year < 1582 {
                            expect(date.leapYear).to(beFalse(), description: "years < 1582 have no leap year")
                        } else if year % 400 == 0 {
                            expect(date.leapYear).to(beTrue(), description: "year \(year) is divisable by 400 and is leap")
                        } else if year % 100 == 0 {
                            expect(date.leapYear).to(beFalse(), description: "year \(year) is divisable by 100 and is NOT leap")
                        } else if year % 4 == 0 {
                            expect(date.leapYear).to(beTrue(), description: "year \(year) is divisable by 4 and is leap")
                        } else {
                            expect(date.leapYear).to(beFalse(), description: "year \(year) is NOT divisable by 4 and is NOT leap")
                        }
                    }
                }
                
                // TODO: Leap tests for non-gregorian calendars

                it("should synchronise all locale assignments") {
                    let date = DateInRegion(year: 1999, month: 12, day: 31)!
                    expect(date.calendar.locale) == date.locale
                }

                it("should synchronise all time zone assignments") {
                    let date = DateInRegion(year: 1999, month: 12, day: 31)!
                    expect(date.calendar.timeZone) == date.timeZone
                }
            }

            context("conversions") {

                it("should convert to another calendar") {
                    let region1 = DateRegion(calendarID: NSCalendarIdentifierGregorian, timeZoneID: "CET", localeID: "nl_NL")
                    let region2 = DateRegion(calendarID: NSCalendarIdentifierHebrew, timeZoneID: "CET", localeID: "nl_NL")
                    let date1 = DateInRegion(year: 1999, month: 12, day: 31, region: region1)!
                    let date2 = DateInRegion(fromDate: date1, region: region2)

                    expect(date2.day) == 22
                    expect(date2.month) == 4
                    expect(date2.year) == 5760
                }
                
                it("should convert to another time zone") {
                    let region1 = DateRegion(calendarID: NSCalendarIdentifierGregorian, timeZoneID: "UTC", localeID: "nl_NL")
                    let region2 = DateRegion(calendarID: NSCalendarIdentifierGregorian, timeZoneID: "IST", localeID: "nl_NL")
                    let date1 = DateInRegion(year: 1999, month: 12, day: 31, region: region1)!
                    let date2 = DateInRegion(fromDate: date1, region: region2)

                    expect(date2.minute) == 30
                    expect(date2.hour) == 5
                    expect(date2.day) == 31
                    expect(date2.month) == 12
                    expect(date2.year) == 1999
                }
                
                it("should convert to another locale") {
                    let region1 = DateRegion(calendarID: NSCalendarIdentifierGregorian, timeZoneID: "CET", localeID: "nl_NL")
                    let region2 = DateRegion(calendarID: NSCalendarIdentifierGregorian, timeZoneID: "CET", localeID: "jp_JP")
                    let date1 = DateInRegion(year: 1999, month: 12, day: 31, region: region1)!
                    let date2 = DateInRegion(fromDate: date1, region: region2)

                    expect(date2.toString(dateStyle: .MediumStyle)) == "Dec 31, 1999"
                }
                
                it("should convert to another region") {
                    let region1 = DateRegion(calendarID: NSCalendarIdentifierGregorian, timeZoneID: "CET", localeID: "nl_NL")
                    let region2 = DateRegion(calendarID: NSCalendarIdentifierBuddhist, timeZoneID: "Asia/Tokyo", localeID: "ja_JP")
                    let date1 = DateInRegion(year: 1999, month: 12, day: 31, hour: 12, region: region1)!
                    let date2 = date1.inRegion(region2)

                    expect(date2.region) == region2
                    expect(date2.hour) == 20
                    expect(date2.day) == 31
                    expect(date2.month) == 12
                    expect(date2.year) == 2542
                }
                
            }

            context("descriptions") {

                let date = DateInRegion(year: 1999, month: 12, day: 31, hour: 23, minute: 59, second: 59, nanosecond: 500000000, region: netherlands)!
                
                it("Should output a proper description") {
                    expect(date.description) == "31 dec. 1999 23:59:59; region: gregorian; Europe/Amsterdam:GMT+1; nl_NL"
                }
                
                it("Should output a proper debug description") {
                    expect(date.debugDescription) == "31 december 1999 23:59:59 CET\nUTC\t31 december 1999 22:59:59 GMT\nCalendar: gregorian\nTime zone: Europe/Amsterdam\nLocale: nl_NL"
                }
            }
            
            context("init from string") {
                
                it("should init from a ISO 8601 string") {
                    let string = "2015-01-05T22:10:55.200Z"
                    let date = DateInRegion(fromString: string, format: DateFormat.ISO8601, region: utc)
                    expect(date).toNot(beNil())
                    expect(date!.year) == 2015
                    expect(date!.month) == 1
                    expect(date!.day) == 5
                    expect(date!.hour) == 22
                    expect(date!.minute) == 10
                    expect(date!.second) == 55
                    expect(date!.timeZone.secondsFromGMT) == 0
                }
                
                it("should init from ISO 8601 date string") {
                    let string = "2015-01-05"
                    let date = DateInRegion(fromString: string, format: DateFormat.ISO8601Date, region: utc)
                    expect(date).toNot(beNil())
                    expect(date!.year) == 2015
                    expect(date!.month) == 1
                    expect(date!.day) == 5
                    expect(date!.hour) == 0
                    expect(date!.minute) == 0
                    expect(date!.second) == 0
                    expect(date!.timeZone.secondsFromGMT) == 0
                }
                
                it("should init from Alt RSS date string") {
                    let string = "09 Sep 2011 15:26:08 -0400"
                    let date = DateInRegion(fromString: string, format: DateFormat.AltRSS, region: utc)
                    expect(date).toNot(beNil())
                    expect(date!.year) == 2011
                    expect(date!.month) == 9
                    expect(date!.day) == 9
                    expect(date!.hour) == 19
                    expect(date!.minute) == 26
                    expect(date!.second) == 08
                    expect(date!.timeZone.secondsFromGMT) == 0
                }
                
                it("should init from RSS date string") {
                    let string = "Fri, 09 Sep 2011 15:26:08 +0200"
                    let date = DateInRegion(fromString: string, format: DateFormat.RSS, region: utc)
                    expect(date).toNot(beNil())
                    expect(date!.year) == 2011
                    expect(date!.month) == 9
                    expect(date!.day) == 9
                    expect(date!.hour) == 13
                    expect(date!.minute) == 26
                    expect(date!.second) == 08
                    expect(date!.timeZone.secondsFromGMT) == 0
                }
                
                it("should init from custom format date string") {
                    let string = "090911"
                    let date = DateInRegion(fromString: string, format: DateFormat.Custom("ddMMyy"))
                    expect(date).toNot(beNil())
                    expect(date!.year) == 2011
                    expect(date!.month) == 9
                    expect(date!.day) == 9
                }
            }
            
            context("date formatter") {

                let china = DateRegion(calendarID: NSCalendarIdentifierBuddhist, timeZoneID: "Asia/Shanghai", localeID: "zh_CN")
                let netherlands = DateRegion(calendarID: NSCalendarIdentifierGregorian, timeZoneID: "CET", localeID: "nl_NL")
                let date = DateInRegion(year: 1999, month: 12, day: 31, hour: 23, minute: 59, second: 59, nanosecond: 500000000, region: netherlands)!

                it("should initiate default date formatter") {
                    expect(date.toString()) == "31 dec. 1999 23:59:59"
                }

                it("should assign calendar, time zone and locale properly") {
                    let testDate = DateInRegion(fromDate: date, region: china)
                    expect(testDate.toString()) == "佛历2543年1月1日 上午6:59:59"
                }

                it("should return a proper string by default") {
                    let date = DateInRegion(year: 1999, month: 12, day: 31)!

                    let formatter = NSDateFormatter()
                    formatter.dateStyle = .MediumStyle
                    formatter.timeStyle = .MediumStyle
                    formatter.calendar = date.calendar
                    formatter.locale = date.locale
                    formatter.timeZone = date.timeZone

                    expect(date.toString(.MediumStyle)) == formatter.stringFromDate(date.absoluteTime)
                }
                
                // TODO: new relative string conversion test
                /*
                it("should return a proper date string with relative conversion") {
                    let date = DateInRegion(region: italy)
                    let date2 = (date + 2.days)!
                    expect(date2.toRelativeString()) == "dopodomani"
                }
                
                it("should return a proper date string with relative conversion") {
                    let date = DateInRegion(region: netherlands)
                    let date2 = (date - 2.seconds)!
                    expect(date2.toRelativeString(date)) == "vandaag"
                }
*/
                
            }
        }

        context("comparisons") {

            it("should return true for greater than comparing") {
                let date1 = DateInRegion(year: 1999, month: 12, day: 31)!
                let date2 = DateInRegion(year: 1999, month: 12, day: 30)!

                expect(date1 > date2) == true
            }
            
            it("should return false for greater than comparing") {
                let date2 = DateInRegion(year: 1999, month: 12, day: 30)

                expect(date2 > date2) == false
            }

            it("should return false for greater than comparing") {
                let date1 = DateInRegion(year: 1999, month: 12, day: 31)
                let date2 = DateInRegion(year: 1999, month: 12, day: 30)

                expect(date2 > date1) == false
            }

            it("should return true for less than comparing") {
                let date1 = DateInRegion(year: 1999, month: 12, day: 29)!
                let date2 = DateInRegion(year: 1999, month: 12, day: 30)!

                expect(date1 < date2) == true
            }

            it("should return false for less than comparing") {
                let date2 = DateInRegion(year: 1999, month: 12, day: 30)!

                expect(date2 < date2) == false
            }

            it("should return false for less than comparing") {
                let date1 = DateInRegion(year: 1999, month: 12, day: 29)!
                let date2 = DateInRegion(year: 1999, month: 12, day: 30)!

                expect(date2 < date1) == false
            }

            it("should return true for greater-equal than comparing") {
                let date1 = DateInRegion(year: 1999, month: 12, day: 31)!
                let date2 = DateInRegion(year: 1999, month: 12, day: 30)!

                expect(date1 >= date2) == true
            }

            it("should return false for greater-equal than comparing") {
                let date2 = DateInRegion(year: 1999, month: 12, day: 30)!

                expect(date2 >= date2) == true
            }

            it("should return false for greater-equal than comparing") {
                let date1 = DateInRegion(year: 1999, month: 12, day: 31)!
                let date2 = DateInRegion(year: 1999, month: 12, day: 30)!

                expect(date2 >= date1) == false
            }

            it("should return true for less-equal than comparing") {
                let date1 = DateInRegion(year: 1999, month: 12, day: 29)!
                let date2 = DateInRegion(year: 1999, month: 12, day: 30)!

                expect(date1 <= date2) == true
            }

            it("should return false for less-equal than comparing") {
                let date2 = DateInRegion(year: 1999, month: 12, day: 30)!

                expect(date2) <= date2
            }

            it("should return false for less-equal than comparing") {
                let date1 = DateInRegion(year: 1999, month: 12, day: 29)
                let date2 = DateInRegion(year: 1999, month: 12, day: 30)

                expect(date2 <= date1) == false
            }
        }

        context("Int extensions") {

            it("should return proper integer extension values") {
                let expectedComponents = NSDateComponents()
                expectedComponents.day = 1
                expect(1.days) == expectedComponents
            }

        }

        context("operations") {

            it("should add properly") {
                let date = DateInRegion(year: 1999, month: 12, day: 31)!
                let testDate = date + 1.days
                let expectedDate = DateInRegion(year: 2000, month: 1, day: 1)

                expect(testDate) == expectedDate
            }

            it("should add properly") {
                let date = DateInRegion(year: 1999, month: 12, day: 31)!
                let testDate = (date + 1.weeks)!

                expect(testDate.year) == 2000
                expect(testDate.month) == 1
                expect(testDate.day) == 7
            }

            it("should subtract properly") {
                let date = DateInRegion(year: 2000, month: 1, day: 1)!
                let testDate = date - 1.days
                let expectedDate = DateInRegion(year: 1999, month: 12, day: 31)

                expect(testDate) == expectedDate
            }

            it("should differ properly") {
                let date1 = DateInRegion(year: 2001, month: 2, day: 1)!
                let date2 = DateInRegion(year: 2003, month: 1, day: 10)!
                let components = date1.difference(date2, unitFlags: [.Month, .Year])

                let expectedComponents = NSDateComponents()
                expectedComponents.month = 11
                expectedComponents.year = 1

                expect(components) == expectedComponents
            }

        }

        context("start of unit") {

            var date: DateInRegion!
            beforeEach {
                date = DateInRegion(year: 1999, month: 12, day: 31, hour: 14, minute: 15, second: 16, nanosecond: 17, region: netherlands)!
            }

            it("should return start of second") {
                let testDate = date.startOf(.Second)!

                expect(testDate.year) == 1999
                expect(testDate.month) == 12
                expect(testDate.day) == 31
                expect(testDate.hour) == 14
                expect(testDate.minute) == 15
                expect(testDate.second) == 16
                expect(testDate.nanosecond) == 0
            }
            
            it("should return start of minute") {
                let testDate = date.startOf(.Minute)!

                expect(testDate.year) == 1999
                expect(testDate.month) == 12
                expect(testDate.day) == 31
                expect(testDate.hour) == 14
                expect(testDate.minute) == 15
                expect(testDate.second) == 0
                expect(testDate.nanosecond) == 0
            }
            
            it("should return start of hour") {
                let testDate = date.startOf(.Hour)!

                expect(testDate.year) == 1999
                expect(testDate.month) == 12
                expect(testDate.day) == 31
                expect(testDate.hour) == 14
                expect(testDate.minute) == 0
                expect(testDate.second) == 0
                expect(testDate.nanosecond) == 0
            }
            
            it("should return start of day") {
                let testDate = date.startOf(.Day)!

                expect(testDate.year) == 1999
                expect(testDate.month) == 12
                expect(testDate.day) == 31
                expect(testDate.hour) == 0
                expect(testDate.minute) == 0
                expect(testDate.second) == 0
                expect(testDate.nanosecond) == 0
            }
            
            it("should return start of day for midnight") {
                date = date.startOf(.Day)
                let testDate = date.startOf(.Day)!

                expect(testDate.year) == 1999
                expect(testDate.month) == 12
                expect(testDate.day) == 31
                expect(testDate.hour) == 0
                expect(testDate.minute) == 0
                expect(testDate.second) == 0
                expect(testDate.nanosecond) == 0
            }

            it("should return start of week in Europe") {
                let testDate = date.startOf(.WeekOfYear)!

                expect(testDate.year) == 1999
                expect(testDate.month) == 12
                expect(testDate.day) == 27
                expect(testDate.hour) == 0
                expect(testDate.minute) == 0
                expect(testDate.second) == 0
                expect(testDate.nanosecond) == 0
            }
            
            it("should return start of year for week in Europe") {
                let testDate = date.startOf(.YearForWeekOfYear)!

                expect(testDate.year) == 1999
                expect(testDate.month) == 1
                expect(testDate.day) == 4
                expect(testDate.hour) == 0
                expect(testDate.minute) == 0
                expect(testDate.second) == 0
                expect(testDate.nanosecond) == 0
            }
            
            it("should return start of weekday") {
                let testDate = date.startOf(.Weekday)!

                expect(testDate.year) == 1999
                expect(testDate.month) == 12
                expect(testDate.day) == 31
                expect(testDate.hour) == 0
                expect(testDate.minute) == 0
                expect(testDate.second) == 0
                expect(testDate.nanosecond) == 0
            }
            
            it("should return start of week in USA") {
                let usaDate = DateInRegion(fromDate: date, region: newYork)
                let testDate = usaDate.startOf(.WeekOfYear)!

                expect(testDate.year) == 1999
                expect(testDate.month) == 12
                expect(testDate.day) == 26
                expect(testDate.hour) == 0
                expect(testDate.minute) == 0
                expect(testDate.second) == 0
                expect(testDate.nanosecond) == 0
            }
            
            it("should return start of month") {
                let testDate = date.startOf(.Month)!

                expect(testDate.year) == 1999
                expect(testDate.month) == 12
                expect(testDate.day) == 1
                expect(testDate.hour) == 0
                expect(testDate.minute) == 0
                expect(testDate.second) == 0
                expect(testDate.nanosecond) == 0
            }
            
            it("should return start of year") {
                let testDate = date.startOf(.Year)!

                expect(testDate.year) == 1999
                expect(testDate.month) == 1
                expect(testDate.day) == 1
                expect(testDate.hour) == 0
                expect(testDate.minute) == 0
                expect(testDate.second) == 0
                expect(testDate.nanosecond) == 0
            }
            
            it("should return start of era") {
                let testDate = date.startOf(.Era)!

                expect(testDate.year) == 1
                expect(testDate.month) == 1
                expect(testDate.day) == 1
                expect(testDate.hour) == 0
                expect(testDate.minute) == 19
                expect(testDate.second) == 32
                expect(testDate.nanosecond) == 0
            }
            
        }

        context("end of unit") {

            it("should return end of day") {
                let date = DateInRegion(year: 1999, month: 1, day: 1, hour: 14, minute: 15, second: 16, nanosecond: 17)!
                let testDate = date.endOf(.Day)!

                expect(testDate.year) == 1999
                expect(testDate.month) == 1
                expect(testDate.day) == 1
                expect(testDate.hour) == 23
                expect(testDate.minute) == 59
                expect(testDate.second) == 59
                expect(Double(testDate.nanosecond!)/1000000000) ≈ 0.999
            }

            it("should return end of month") {
                let date = DateInRegion(year: 1999, month: 1, day: 1, hour: 14, minute: 15, second: 16, nanosecond: 17)!
                let testDate = date.endOf(.Month)!

                expect(testDate.year) == 1999
                expect(testDate.month) == 1
                expect(testDate.day) == 31
                expect(testDate.hour) == 23
                expect(testDate.minute) == 59
                expect(testDate.second) == 59
            }
            
            it("should return end of year") {
                let date = DateInRegion(year: 1999, month: 1, day: 1, hour: 14, minute: 15, second: 16, nanosecond: 17)!
                let testDate = date.endOf(.Year)!

                expect(testDate.year) == 1999
                expect(testDate.month) == 12
                expect(testDate.day) == 31
                expect(testDate.hour) == 23
                expect(testDate.minute) == 59
                expect(testDate.second) == 59
            }
            
        }

        context("Copying") {
            it("should create a copy and not a reference") {
                let a = DateInRegion()
                let b = DateInRegion(fromDate: a)

                expect(a) == b
            }
        }

    }
    
}

