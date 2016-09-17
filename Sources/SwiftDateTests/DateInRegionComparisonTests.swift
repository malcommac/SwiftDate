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
import SwiftDate

class DateInRegionComparisonSpec: QuickSpec {

    override func spec() {

        describe("DateInRegionComparisons") {

            let region = Region(calendarName: .gregorian, timeZoneName: .americaParamaribo, localeName: .dutch)
            let date = DateInRegion(year: 2015, month: 12, day: 14, hour: 13, region: region)

            context("compareDates") {

                it("should report proper results for year granularity unit") {
                    let date1 = date - 1.years
                    let date2 = date - 1.months
                    let date3 = date + 1.years
                    expect(date.compare(date: date1, toGranularity: .year)) == ComparisonResult.orderedDescending
                    expect(date.compare(date: date2, toGranularity: .year)) == ComparisonResult.orderedSame
                    expect(date.compare(date: date3, toGranularity: .year)) == ComparisonResult.orderedAscending
                }

                it("should report proper results for month granularity unit") {
                    let date1 = date - 1.months
                    let date2 = date + 1.weeks
                    let date3 = date + 1.months
                    expect(date.compare(date: date1, toGranularity: .month)) == ComparisonResult.orderedDescending
                    expect(date.compare(date: date2, toGranularity: .month)) == ComparisonResult.orderedSame
                    expect(date.compare(date: date3, toGranularity: .month)) == ComparisonResult.orderedAscending
                }

                it("should report proper results for week granularity unit") {
                    let date1 = date - 1.weeks
                    let date2 = date + 1.days
                    let date3 = date + 1.weeks
                    expect(date.compare(date: date1, toGranularity: .weekOfYear)) == ComparisonResult.orderedDescending
                    expect(date.compare(date: date2, toGranularity: .weekOfYear)) == ComparisonResult.orderedSame
                    expect(date.compare(date: date3, toGranularity: .weekOfYear)) == ComparisonResult.orderedAscending
                }

                it("should report proper results for day granularity unit") {
                    let date1 = date - 1.days
                    let date2 = date + 1.hours
                    let date3 = date + 1.days
                    expect(date.compare(date: date1, toGranularity: .day)) == ComparisonResult.orderedDescending
                    expect(date.compare(date: date2, toGranularity: .day)) == ComparisonResult.orderedSame
                    expect(date.compare(date: date3, toGranularity: .day)) == ComparisonResult.orderedAscending
                }

                it("should report proper results for hour granularity unit") {
                    let date1 = date - 1.hours
                    let date2 = date + 1.minutes
                    let date3 = date + 1.hours
                    expect(date.compare(date: date1, toGranularity: .hour)) == ComparisonResult.orderedDescending
                    expect(date.compare(date: date2, toGranularity: .hour)) == ComparisonResult.orderedSame
                    expect(date.compare(date: date3, toGranularity: .hour)) == ComparisonResult.orderedAscending
                }

                it("should report proper results for minute granularity unit") {
                    let date1 = date - 1.minutes
                    let date2 = date + 1.seconds
                    let date3 = date + 1.minutes
                    expect(date.compare(date: date1, toGranularity: .minute)) == ComparisonResult.orderedDescending
                    expect(date.compare(date: date2, toGranularity: .minute)) == ComparisonResult.orderedSame
                    expect(date.compare(date: date3, toGranularity: .minute)) == ComparisonResult.orderedAscending
                }

                it("should report proper results for second granularity unit") {
                    let date1 = date - 1.seconds
                    let date2 = date + 100000.nanoseconds
                    let date3 = date + 1.seconds
                    expect(date.compare(date: date1, toGranularity: .second)) == ComparisonResult.orderedDescending
                    expect(date.compare(date: date2, toGranularity: .second)) == ComparisonResult.orderedSame
                    expect(date.compare(date: date3, toGranularity: .second)) == ComparisonResult.orderedAscending
                }
            }

            context("isEqualToDate") {

                it("should report true when comparing to the same date") {
                    expect(date.isEqualToDate(date)) == true
                }

                it("should report false when comparing to a date with different time") {
                    let date2 = date + 1.seconds
                    expect(date.isEqualToDate(date2)) == false
                }

                it("should report false when comparing to a date with different region") {
                    let region = Region(localeName: .italianItaly)
                    let date2 = date.inRegion(region: region)
                    expect(date.isEqualToDate(date2)) == false
                }

            }

            context("isIn") {


                it("should report proper results for year granularity unit") {
                    let date1 = date - 1.years
                    let date2 = date - 1.months
                    let date3 = date + 1.years
                    let unit = Calendar.Component.year
                    expect(date.isIn(component: unit, of: date1)) == false
                    expect(date.isIn(component: unit, of: date2)) == true
                    expect(date.isIn(component: unit, of: date3)) == false
                }

                it("should report proper results for month granularity unit") {
                    let date1 = date - 1.months
                    let date2 = date + 1.weeks
                    let date3 = date + 1.months
                    let unit = Calendar.Component.month
                    expect(date.isIn(component: unit, of: date1)) == false
                    expect(date.isIn(component: unit, of: date2)) == true
                    expect(date.isIn(component: unit, of: date3)) == false
                }

                it("should report proper results for week granularity unit") {
                    let date1 = date - 1.weeks
                    let date2 = date + 1.days
                    let date3 = date + 1.weeks
                    let unit = Calendar.Component.weekOfYear
                    expect(date.isIn(component: unit, of: date1)) == false
                    expect(date.isIn(component: unit, of: date2)) == true
                    expect(date.isIn(component: unit, of: date3)) == false
                }

                it("should report proper results for day granularity unit") {
                    let date1 = date - 1.days
                    let date2 = date + 1.hours
                    let date3 = date + 1.days
                    let unit = Calendar.Component.day
                    expect(date.isIn(component: unit, of: date1)) == false
                    expect(date.isIn(component: unit, of: date2)) == true
                    expect(date.isIn(component: unit, of: date3)) == false
                }

                it("should report proper results for hour granularity unit") {
                    let date1 = date - 1.hours
                    let date2 = date + 1.minutes
                    let date3 = date + 1.hours
                    let unit = Calendar.Component.hour
                    expect(date.isIn(component: unit, of: date1)) == false
                    expect(date.isIn(component: unit, of: date2)) == true
                    expect(date.isIn(component: unit, of: date3)) == false
                }

                it("should report proper results for minute granularity unit") {
                    let date1 = date - 1.minutes
                    let date2 = date + 1.seconds
                    let date3 = date + 1.minutes
                    let unit = Calendar.Component.minute
                    expect(date.isIn(component: unit, of: date1)) == false
                    expect(date.isIn(component: unit, of: date2)) == true
                    expect(date.isIn(component: unit, of: date3)) == false
                }

                it("should report proper results for second granularity unit") {
                    let date1 = date - 1.seconds
                    let date2 = date + 100000.nanoseconds
                    let date3 = date + 1.seconds
                    let unit = Calendar.Component.second
                    expect(date.isIn(component: unit, of: date1)) == false
                    expect(date.isIn(component: unit, of: date2)) == true
                    expect(date.isIn(component: unit, of: date3)) == false
                }
            }

            context("isBefore") {

                it("should report proper results for year granularity unit") {
                    let date1 = date - 1.years
                    let date2 = date - 1.months
                    let date3 = date + 1.years
                    let unit = Calendar.Component.year
                    expect(date.isBefore(component: unit, of: date1)) == false
                    expect(date.isBefore(component: unit, of: date2)) == false
                    expect(date.isBefore(component: unit, of: date3)) == true
                }

                it("should report proper results for month granularity unit") {
                    let date1 = date - 1.months
                    let date2 = date + 1.weeks
                    let date3 = date + 1.months
                    let unit = Calendar.Component.month
                    expect(date.isBefore(component: unit, of: date1)) == false
                    expect(date.isBefore(component: unit, of: date2)) == false
                    expect(date.isBefore(component: unit, of: date3)) == true
                }

                it("should report proper results for week granularity unit") {
                    let date1 = date - 1.weeks
                    let date2 = date + 1.days
                    let date3 = date + 1.weeks
                    let unit = Calendar.Component.weekOfYear
                    expect(date.isBefore(component: unit, of: date1)) == false
                    expect(date.isBefore(component: unit, of: date2)) == false
                    expect(date.isBefore(component: unit, of: date3)) == true
                }

                it("should report proper results for day granularity unit") {
                    let date1 = date - 1.days
                    let date2 = date + 1.hours
                    let date3 = date + 1.days
                    let unit = Calendar.Component.day
                    expect(date.isBefore(component: unit, of: date1)) == false
                    expect(date.isBefore(component: unit, of: date2)) == false
                    expect(date.isBefore(component: unit, of: date3)) == true
                }

                it("should report proper results for hour granularity unit") {
                    let date1 = date - 1.hours
                    let date2 = date + 1.minutes
                    let date3 = date + 1.hours
                    let unit = Calendar.Component.hour
                    expect(date.isBefore(component: unit, of: date1)) == false
                    expect(date.isBefore(component: unit, of: date2)) == false
                    expect(date.isBefore(component: unit, of: date3)) == true
                }

                it("should report proper results for minute granularity unit") {
                    let date1 = date - 1.minutes
                    let date2 = date + 1.seconds
                    let date3 = date + 1.minutes
                    let unit = Calendar.Component.minute
                    expect(date.isBefore(component: unit, of: date1)) == false
                    expect(date.isBefore(component: unit, of: date2)) == false
                    expect(date.isBefore(component: unit, of: date3)) == true
                }

                it("should report proper results for second granularity unit") {
                    let date1 = date - 1.seconds
                    let date2 = date + 100000.nanoseconds
                    let date3 = date + 1.seconds
                    let unit = Calendar.Component.second
                    expect(date.isBefore(component: unit, of: date1)) == false
                    expect(date.isBefore(component: unit, of: date2)) == false
                    expect(date.isBefore(component: unit, of: date3)) == true
                }
            }

            context("isAfter") {

                it("should report proper results for year granularity unit") {
                    let date1 = date - 1.years
                    let date2 = date - 1.months
                    let date3 = date + 1.years
                    let unit = Calendar.Component.year
                    expect(date.isAfter(component: unit, of: date1)) == true
                    expect(date.isAfter(component: unit, of: date2)) == false
                    expect(date.isAfter(component: unit, of: date3)) == false
                }

                it("should report proper results for month granularity unit") {
                    let date1 = date - 1.months
                    let date2 = date + 1.weeks
                    let date3 = date + 1.months
                    let unit = Calendar.Component.month
                    expect(date.isAfter(component: unit, of: date1)) == true
                    expect(date.isAfter(component: unit, of: date2)) == false
                    expect(date.isAfter(component: unit, of: date3)) == false
                }

                it("should report proper results for week granularity unit") {
                    let date1 = date - 1.weeks
                    let date2 = date + 1.days
                    let date3 = date + 1.weeks
                    let unit = Calendar.Component.weekOfYear
                    expect(date.isAfter(component: unit, of: date1)) == true
                    expect(date.isAfter(component: unit, of: date2)) == false
                    expect(date.isAfter(component: unit, of: date3)) == false
                }

                it("should report proper results for day granularity unit") {
                    let date1 = date - 1.days
                    let date2 = date + 1.hours
                    let date3 = date + 1.days
                    let unit = Calendar.Component.day
                    expect(date.isAfter(component: unit, of: date1)) == true
                    expect(date.isAfter(component: unit, of: date2)) == false
                    expect(date.isAfter(component: unit, of: date3)) == false
                }

                it("should report proper results for hour granularity unit") {
                    let date1 = date - 1.hours
                    let date2 = date + 1.minutes
                    let date3 = date + 1.hours
                    let unit = Calendar.Component.hour
                    expect(date.isAfter(component: unit, of: date1)) == true
                    expect(date.isAfter(component: unit, of: date2)) == false
                    expect(date.isAfter(component: unit, of: date3)) == false
                }

                it("should report proper results for minute granularity unit") {
                    let date1 = date - 1.minutes
                    let date2 = date + 1.seconds
                    let date3 = date + 1.minutes
                    let unit = Calendar.Component.minute
                    expect(date.isAfter(component: unit, of: date1)) == true
                    expect(date.isAfter(component: unit, of: date2)) == false
                    expect(date.isAfter(component: unit, of: date3)) == false
                }

                it("should report proper results for second granularity unit") {
                    let date1 = date - 1.seconds
                    let date2 = date + 100000.nanoseconds
                    let date3 = date + 1.seconds
                    let unit = Calendar.Component.second
                    expect(date.isAfter(component: unit, of: date1)) == true
                    expect(date.isAfter(component: unit, of: date2)) == false
                    expect(date.isAfter(component: unit, of: date3)) == false
                }
            }

            context("isInToday") {

                it("should report true for today's date") {
                    let date = DateInRegion()
                    expect(date.isInToday()) == true
                }

                it("should report true for today at midnight") {
                    let date = DateInRegion().startOf(component: .day)
                    expect(date.isInToday()) == true
                }

                it("should report true for today just before next midnight") {
                    let date = DateInRegion().endOf(component: .day)
                    expect(date.isInToday()) == true
                }

                it("should report false for tomorrow at midnight") {
                    let date = (DateInRegion() + 1.days).startOf(component: .day)
                    expect(date.isInToday()) == false
                }

                it("should report false just before last midnight") {
                    let date = (DateInRegion() - 1.days).endOf(component: .day)
                    expect(date.isInToday()) == false
                }

                it("should report false for last year's date") {
                    let date = DateInRegion() - 1.years
                    expect(date.isInToday()) == false
                }

            }

            context("isInYesterday") {

                it("should report true for yesterday's date") {
                    let date = DateInRegion() - 1.days
                    expect(date.isInYesterday()) == true
                }

                it("should report true for yesterday at midnight") {
                    let date = (DateInRegion() - 1.days).startOf(component: .day)
                    expect(date.isInYesterday()) == true
                }

                it("should report true for yesterday just before next midnight") {
                    let date = (DateInRegion() - 1.days).endOf(component: .day)
                    expect(date.isInYesterday()) == true
                }

                it("should report false for today at midnight") {
                    let date = DateInRegion().startOf(component: .day)
                    expect(date.isInYesterday()) == false
                }

                it("should report false just yesterday before last midnight") {
                    let date = (DateInRegion() - 2.days).endOf(component: .day)
                    expect(date.isInYesterday()) == false
                }

                it("should report false for last year's date") {
                    let date = DateInRegion() - 1.years
                    expect(date.isInYesterday()) == false
                }

            }


            context("isInTomorrow") {

                it("should report true for tomorrow's date") {
                    let date = DateInRegion() + 1.days
                    expect(date.isInTomorrow()) == true
                }

                it("should report true for tomorrow at midnight") {
                    let date = (DateInRegion() + 1.days).startOf(component: .day)
                    expect(date.isInTomorrow()) == true
                }

                it("should report true for tomorrow just before next midnight") {
                    let date = (DateInRegion() + 1.days).endOf(component: .day)
                    expect(date.isInTomorrow()) == true
                }

                it("should report false for the day after tomorrow at midnight") {
                    let date = (DateInRegion() + 2.days).startOf(component: .day)
                    expect(date.isInTomorrow()) == false
                }

                it("should report false just tomorrow before last midnight") {
                    let date = DateInRegion().endOf(component: .day)
                    expect(date.isInTomorrow()) == false
                }

                it("should report false for last year's date") {
                    let date = DateInRegion() - 1.years
                    expect(date.isInTomorrow()) == false
                }

            }


        }

    }
}
