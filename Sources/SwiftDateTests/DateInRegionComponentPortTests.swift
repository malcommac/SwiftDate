//
//  DateInRegionComponentPortTests.swift
//  DateInRegion
//
//  Created by Jeroen Houtzager on 07/11/15.
//  Copyright © 2015 CocoaPods. All rights reserved.
//
// https://github.com/Quick/Quick


import Quick
import Nimble
@testable import SwiftDate

class DateInRegionComponentPortSpec: QuickSpec {

    override func spec() {

        describe("DateInRegionComponentPort") {

            let newYork = Region(calendarName: .gregorian, timeZoneName: .americaNewYork, localeName: .englishUnitedStates)
            let amsterdam = Region(calendarName: .gregorian, timeZoneName: .europeAmsterdam, localeName: .dutchNetherlands)
            let utc = Region(calendarName: .gregorian, timeZoneName: .gmt, localeName: .english)

            context("valueForComponentYMD") {

                let region = Region()
                let date = DateInRegion(era: 1, year: 2002, month: 3, day: 4, hour: 5, minute: 6, second: 7, nanosecond: 87654321, region: region)

                it("should report a valid era") {
                    expect(date.value(for: .era)) == 1
                }

                it("should report a valid year") {
                    expect(date.value(for: .year)) == 2002
                }

                it("should report a valid month") {
                    expect(date.value(for: .month)) == 3
                }

                it("should report a valid day") {
                    expect(date.value(for: .day)) == 4
                }

                it("should report a valid hour") {
                    expect(date.value(for: .hour)) == 5
                }

                it("should report a valid minute") {
                    expect(date.value(for: .minute)) == 6
                }

                it("should report a valid second") {
                    expect(date.value(for: .second)) == 7
                }

                it("should report a valid nanosecond") {
                    expect(date.value(for: .nanosecond)).to(beCloseTo(87654321, within: 10))
                }

            }

            context("valueForComponentYWD") {

                let region = Region()
                let date = DateInRegion(era: 1, yearForWeekOfYear: 2, weekOfYear: 3, weekday: 4, region: region)

                it("should report a valid era") {
                    expect(date.value(for: .era)) == 1
                }

                it("should report a valid yearForWeekOfYear") {
                    expect(date.value(for: .yearForWeekOfYear)) == 2
                }

                it("should report a valid weekOfYear") {
                    expect(date.value(for: .weekOfYear)) == 3
                }

                it("should report a valid weekday") {
                    expect(date.value(for: .weekday)) == 4
                }

                it("should report a valid hour") {
                    expect(date.value(for: .hour)) == 0
                }

                it("should report a valid minute") {
                    expect(date.value(for: .minute)) == 0
                }

                it("should report a valid second") {
                    expect(date.value(for: .second)) == 0
                }

                it("should report a valid nanosecond") {
                    expect(date.value(for: .nanosecond)) == 0
                }

            }


            context("component initialisation") {

                it("should return a midnight date with nil YMD initialisation in various regions") {
                    for region in [newYork, amsterdam, utc] {
                        let date = DateInRegion(year: 1912, month: 6, day: 23, region: region)

                        expect(date.year) == 1912
                        expect(date.month) == 6
                        expect(date.day) == 23
                        expect(date.hour) == 0
                        expect(date.minute) == 0
                        expect(date.second) == 0
                        expect(date.nanosecond) == 0
                        expect(date.region) == region
                    }
                }


                it("should return a midnight date with nil YMD initialisation") {
                    let date = DateInRegion(year: 1912, month: 6, day: 23)

                    expect(date.year) == 1912
                    expect(date.month) == 6
                    expect(date.day) == 23
                    expect(date.hour) == 0
                    expect(date.minute) == 0
                    expect(date.second) == 0
                    expect(date.nanosecond) == 0
                    expect(date.region) == Region()
                }


                it("should return a 123 date for YMD initialisation") {
                    let date = DateInRegion(year: 1999, month: 12, day: 31)

                    expect(date.year) == 1999
                    expect(date.month) == 12
                    expect(date.day) == 31
                    expect(date.region) == Region()
                }

                it("should return a 123 date for YWD initialisation") {
                    let date = DateInRegion(yearForWeekOfYear: 2016, weekOfYear: 1, weekday: 1)

                    expect(date.yearForWeekOfYear) == 2016
                    expect(date.weekOfYear) == 1
                    expect(date.weekday) == 1
                }

                it("should return a date of 0001-01-01 00:00:00.000 in the default region for component initialisation") {
                    let components = DateComponents()
                    let date = DateInRegion(components)

                    expect(date.year) == 1
                    expect(date.month) == 1
                    expect(date.day) == 1
                    expect(date.hour) == 0
                    expect(date.minute) == 0
                    expect(date.second) == 0
                    expect(date.nanosecond) == 0
                    expect(date.region) == Region()
                }

                it("should return a proper date") {
                    let date = DateInRegion(year: 1999, month: 12, day: 31, region: newYork)
                    let components = date.components
                    expect(components.year) == 1999
                    expect(components.month) == 12
                    expect(components.day) == 31
                    expect(components.timeZone) == newYork.timeZone
                }

            }

            context("In Gregorian weekends") {

                it("should return a proper weekend value for a Saturday") {
                    let date = DateInRegion(year: 2015, month: 11, day: 7, region: amsterdam)
                    expect(date.isInWeekend()) == true
                }

                it("should return a proper weekend value for a Sunday") {
                    let date = DateInRegion(year: 2015, month: 11, day: 8, region: amsterdam)
                    expect(date.isInWeekend()) == true
                }

                it("should return a proper weekend value for a Monday") {
                    let date = DateInRegion(year: 2015, month: 11, day: 9, region: amsterdam)
                    expect(date.isInWeekend()) == false
                }

                it("should return a proper weekend value for a Tuesday") {
                    let date = DateInRegion(year: 2015, month: 11, day: 10, region: amsterdam)
                    expect(date.isInWeekend()) == false
                }

                it("should return a proper weekend value for a Wednesday") {
                    let date = DateInRegion(year: 2015, month: 11, day: 11, region: amsterdam)
                    expect(date.isInWeekend()) == false
                }

                it("should return a proper weekend value for a Thursday") {
                    let date = DateInRegion(year: 2015, month: 11, day: 12, region: amsterdam)
                    expect(date.isInWeekend()) == false
                }

                it("should return a proper weekend value for a Friday") {
                    let date = DateInRegion(year: 2015, month: 11, day: 13, region: amsterdam)
                    expect(date.isInWeekend()) == false
                }

            }

            context("Next weekend") {

                let expectedStartDate = DateInRegion(year: 2015, month: 11, day: 7, region: amsterdam)
                let expectedEndDate = (expectedStartDate + 1.days).endOf(component: .day)

                it("should return next weekend on Friday") {
                    let date = DateInRegion(year: 2015, month: 11, day: 6, region: amsterdam)

                    let weekend = date.nextWeekend()!

                    expect(weekend.startDate) == expectedStartDate
                    expect(weekend.endDate) == expectedEndDate
                }

                it("should return next weekend on Thursday") {
                    let date = DateInRegion(year: 2015, month: 11, day: 5, region: amsterdam)

                    let weekend = date.nextWeekend()!

                    expect(weekend.startDate) == expectedStartDate
                    expect(weekend.endDate) == expectedEndDate
                }

                it("should return next weekend on Wednesday") {
                    let date = DateInRegion(year: 2015, month: 11, day: 4, region: amsterdam)

                    let weekend = date.nextWeekend()!

                    expect(weekend.startDate) == expectedStartDate
                    expect(weekend.endDate) == expectedEndDate
                }

                it("should return next weekend on Tuesday") {
                    let date = DateInRegion(year: 2015, month: 11, day: 3, region: amsterdam)

                    let weekend = date.nextWeekend()!

                    expect(weekend.startDate) == expectedStartDate
                    expect(weekend.endDate) == expectedEndDate
                }

                it("should return week's weekend on Monday") {
                    let date = DateInRegion(year: 2015, month: 11, day: 2, region: amsterdam)

                    let weekend = date.nextWeekend()!

                    expect(weekend.startDate) == expectedStartDate
                    expect(weekend.endDate) == expectedEndDate
                }

                it("should return next week's weekend on Sunday") {
                    let date = DateInRegion(year: 2015, month: 11, day: 1, region: amsterdam)

                    let weekend = date.nextWeekend()!

                    expect(weekend.startDate) == expectedStartDate
                    expect(weekend.endDate) == expectedEndDate
                }

                it("should return next week's weekend on Saturday") {
                    let date = DateInRegion(year: 2015, month: 10, day: 31, region: amsterdam)

                    let weekend = date.nextWeekend()!

                    expect(weekend.startDate) == expectedStartDate
                    expect(weekend.endDate) == expectedEndDate
                }

            }

            context("Previous weekend") {

                let expectedStartDate = DateInRegion(year: 2015, month: 10, day: 31, region: amsterdam)
                let expectedEndDate = (expectedStartDate + 1.days).endOf(component: .day)


                it("should return last week's weekend on Sunday") {
                    let date = DateInRegion(year: 2015, month: 11, day: 8, region: amsterdam)

                    let weekend = date.previousWeekend()!

                    expect(weekend.startDate) == expectedStartDate
                    expect(weekend.endDate) == expectedEndDate
                }

                it("should return last week's weekend on Saturday") {
                    let date = DateInRegion(year: 2015, month: 11, day: 7, region: amsterdam)

                    let weekend = date.previousWeekend()!

                    expect(weekend.startDate) == expectedStartDate
                    expect(weekend.endDate) == expectedEndDate
                }

                it("should return last weekend on Friday") {
                    let date = DateInRegion(year: 2015, month: 11, day: 7, region: amsterdam)

                    let weekend = date.previousWeekend()!

                    expect(weekend.startDate) == expectedStartDate
                    expect(weekend.endDate) == expectedEndDate
                }

                it("should return last weekend on Thursday") {
                    let date = DateInRegion(year: 2015, month: 11, day: 5, region: amsterdam)

                    let weekend = date.previousWeekend()!

                    expect(weekend.startDate) == expectedStartDate
                    expect(weekend.endDate) == expectedEndDate
                }

                it("should return last weekend on Wednesday") {
                    let date = DateInRegion(year: 2015, month: 11, day: 4, region: amsterdam)

                    let weekend = date.previousWeekend()!

                    expect(weekend.startDate) == expectedStartDate
                    expect(weekend.endDate) == expectedEndDate
                }

                it("should return last weekend on Tuesday") {
                    let date = DateInRegion(year: 2015, month: 11, day: 3, region: amsterdam)

                    let weekend = date.previousWeekend()!

                    expect(weekend.startDate) == expectedStartDate
                    expect(weekend.endDate) == expectedEndDate
                }

                it("should return week's weekend on Monday") {
                    let date = DateInRegion(year: 2015, month: 11, day: 2, region: amsterdam)

                    let weekend = date.previousWeekend()!

                    expect(weekend.startDate) == expectedStartDate
                    expect(weekend.endDate) == expectedEndDate
                }
            }

            context("This weekend") {

                let expectedStartDate = DateInRegion(year: 2016, month: 2, day: 20, region: amsterdam)
                let expectedEndDate = (expectedStartDate + 1.days).endOf(component: .day)


                it("should return this weekend on Sunday") {
                    let date = DateInRegion(year: 2016, month: 2, day: 21, region: amsterdam)

                    let weekend = date.thisWeekend()!

                    expect(weekend.startDate) == expectedStartDate
                    expect(weekend.endDate) == expectedEndDate
                }

                it("should return this weekend on Saturday") {
                    let date = DateInRegion(year: 2016, month: 2, day: 20, region: amsterdam)

                    let weekend = date.thisWeekend()!

                    expect(weekend.startDate) == expectedStartDate
                    expect(weekend.endDate) == expectedEndDate
                }

                it("should return error on Monday") {
                    let date = DateInRegion(year: 2016, month: 2, day: 22, region: amsterdam)

                    let weekend = date.thisWeekend()
                    expect(weekend).to(beNil())
                }

                it("should return error on Friday") {
                    let date = DateInRegion(year: 2016, month: 2, day: 19, region: amsterdam)

                    let weekend = date.thisWeekend()
                    expect(weekend).to(beNil())
                }

                // According to the Apple docs, weekend functions return nil if no weekend exists
                // for the calendar & locale. However, below we test all combinations of calendars
                // and locales; no weekendless combinations exist (yet)
                //
                //                it("should return error if no weekend in calendar") {
                //
                //
                //                    for calendarName in [CalendarIdentifierGregorian,
                //                        CalendarIdentifierBuddhist, CalendarIdentifierChinese,
                //                        CalendarIdentifierCoptic, CalendarIdentifierEthiopicAmeteMihret,
                //                        CalendarIdentifierEthiopicAmeteAlem, CalendarIdentifierHebrew,
                //                        CalendarIdentifierISO8601, CalendarIdentifierIndian,
                //                        CalendarIdentifierIslamic, CalendarIdentifierIslamicCivil,
                //                        CalendarIdentifierJapanese, CalendarIdentifierPersian,
                //                        CalendarIdentifierRepublicOfChina, CalendarIdentifierIslamicTabular,
                //                        CalendarIdentifierIslamicUmmAlQura] {
                //                        print(calendarName)
                //                        let calendar = Calendar(identifier: calendarName)!
                //                        for localeName in Locale.availableLocaleIdentifiers() {
                //                            let locale = Locale(localeIdentifier: localeName)
                //                            let region = Region(calendar: calendar, locale: locale)
                //                            let date = DateInRegion(region: region)
                //                            let weekend = date.nextWeekend()
                //                            expect(weekend).toNot(beNil())
                //                        }
                //                    }
                //
                //                }

            }

            context("nearest hour") {

                let date = DateInRegion(year: 2002, month: 3, day: 4, hour: 5, minute: 30, region: newYork)

                it("should report the next hour on 30 minutes") {
                    expect(date.nearestHour) == 6
                }

                it("should report the previous hour on 30 minutes minus a little") {
                    let date2 = date - 1000.nanoseconds
                    expect(date2.nearestHour) == 5
                }

            }

            context("weekdayName") {

                let date = DateInRegion(year: 2002, month: 3, day: 4, hour: 5, minute: 30, region: newYork)

                it("should report the weekday name") {
                    expect(date.weekdayName) == "Monday"
                }

            }

        }
    }
}
