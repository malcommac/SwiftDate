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

            let region = Region(calendarName: .Gregorian, timeZoneName: .AmericaParamaribo, localeName: .Dutch)
            let date = DateInRegion(year: 2015, month: 12, day: 14, hour: 13, region: region)

            context("compareDates") {

                it("should report proper results for year granularity unit") {
                    let date1 = date - 1.years
                    let date2 = date - 1.months
                    let date3 = date + 1.years
                    expect(date.compareDate(date1, toUnitGranularity: .Year)) == NSComparisonResult.OrderedDescending
                    expect(date.compareDate(date2, toUnitGranularity: .Year)) == NSComparisonResult.OrderedSame
                    expect(date.compareDate(date3, toUnitGranularity: .Year)) == NSComparisonResult.OrderedAscending
                }

                it("should report proper results for month granularity unit") {
                    let date1 = date - 1.months
                    let date2 = date + 1.weeks
                    let date3 = date + 1.months
                    expect(date.compareDate(date1, toUnitGranularity: .Month)) == NSComparisonResult.OrderedDescending
                    expect(date.compareDate(date2, toUnitGranularity: .Month)) == NSComparisonResult.OrderedSame
                    expect(date.compareDate(date3, toUnitGranularity: .Month)) == NSComparisonResult.OrderedAscending
                }

                it("should report proper results for week granularity unit") {
                    let date1 = date - 1.weeks
                    let date2 = date + 1.days
                    let date3 = date + 1.weeks
                    expect(date.compareDate(date1, toUnitGranularity: .WeekOfYear)) == NSComparisonResult.OrderedDescending
                    expect(date.compareDate(date2, toUnitGranularity: .WeekOfYear)) == NSComparisonResult.OrderedSame
                    expect(date.compareDate(date3, toUnitGranularity: .WeekOfYear)) == NSComparisonResult.OrderedAscending
                }

                it("should report proper results for day granularity unit") {
                    let date1 = date - 1.days
                    let date2 = date + 1.hours
                    let date3 = date + 1.days
                    expect(date.compareDate(date1, toUnitGranularity: .Day)) == NSComparisonResult.OrderedDescending
                    expect(date.compareDate(date2, toUnitGranularity: .Day)) == NSComparisonResult.OrderedSame
                    expect(date.compareDate(date3, toUnitGranularity: .Day)) == NSComparisonResult.OrderedAscending
                }

                it("should report proper results for hour granularity unit") {
                    let date1 = date - 1.hours
                    let date2 = date + 1.minutes
                    let date3 = date + 1.hours
                    expect(date.compareDate(date1, toUnitGranularity: .Hour)) == NSComparisonResult.OrderedDescending
                    expect(date.compareDate(date2, toUnitGranularity: .Hour)) == NSComparisonResult.OrderedSame
                    expect(date.compareDate(date3, toUnitGranularity: .Hour)) == NSComparisonResult.OrderedAscending
                }

                it("should report proper results for minute granularity unit") {
                    let date1 = date - 1.minutes
                    let date2 = date + 1.seconds
                    let date3 = date + 1.minutes
                    expect(date.compareDate(date1, toUnitGranularity: .Minute)) == NSComparisonResult.OrderedDescending
                    expect(date.compareDate(date2, toUnitGranularity: .Minute)) == NSComparisonResult.OrderedSame
                    expect(date.compareDate(date3, toUnitGranularity: .Minute)) == NSComparisonResult.OrderedAscending
                }

                it("should report proper results for second granularity unit") {
                    let date1 = date - 1.seconds
                    let date2 = date + 100000.nanoseconds
                    let date3 = date + 1.seconds
                    expect(date.compareDate(date1, toUnitGranularity: .Second)) == NSComparisonResult.OrderedDescending
                    expect(date.compareDate(date2, toUnitGranularity: .Second)) == NSComparisonResult.OrderedSame
                    expect(date.compareDate(date3, toUnitGranularity: .Second)) == NSComparisonResult.OrderedAscending
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
                    let region = Region(localeName: .ItalianItaly)
                    let date2 = date.inRegion(region)
                    expect(date.isEqualToDate(date2)) == false
                }

            }

            context("isIn") {


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

                it("should report proper results for week granularity unit") {
                    let date1 = date - 1.weeks
                    let date2 = date + 1.days
                    let date3 = date + 1.weeks
                    let unit = NSCalendarUnit.WeekOfYear
                    expect(date.isIn(unit, ofDate: date1)) == false
                    expect(date.isIn(unit, ofDate: date2)) == true
                    expect(date.isIn(unit, ofDate: date3)) == false
                }

                it("should report proper results for day granularity unit") {
                    let date1 = date - 1.days
                    let date2 = date + 1.hours
                    let date3 = date + 1.days
                    let unit = NSCalendarUnit.Day
                    expect(date.isIn(unit, ofDate: date1)) == false
                    expect(date.isIn(unit, ofDate: date2)) == true
                    expect(date.isIn(unit, ofDate: date3)) == false
                }

                it("should report proper results for hour granularity unit") {
                    let date1 = date - 1.hours
                    let date2 = date + 1.minutes
                    let date3 = date + 1.hours
                    let unit = NSCalendarUnit.Hour
                    expect(date.isIn(unit, ofDate: date1)) == false
                    expect(date.isIn(unit, ofDate: date2)) == true
                    expect(date.isIn(unit, ofDate: date3)) == false
                }

                it("should report proper results for minute granularity unit") {
                    let date1 = date - 1.minutes
                    let date2 = date + 1.seconds
                    let date3 = date + 1.minutes
                    let unit = NSCalendarUnit.Minute
                    expect(date.isIn(unit, ofDate: date1)) == false
                    expect(date.isIn(unit, ofDate: date2)) == true
                    expect(date.isIn(unit, ofDate: date3)) == false
                }

                it("should report proper results for second granularity unit") {
                    let date1 = date - 1.seconds
                    let date2 = date + 100000.nanoseconds
                    let date3 = date + 1.seconds
                    let unit = NSCalendarUnit.Second
                    expect(date.isIn(unit, ofDate: date1)) == false
                    expect(date.isIn(unit, ofDate: date2)) == true
                    expect(date.isIn(unit, ofDate: date3)) == false
                }
            }

            context("isBefore") {

                it("should report proper results for year granularity unit") {
                    let date1 = date - 1.years
                    let date2 = date - 1.months
                    let date3 = date + 1.years
                    let unit = NSCalendarUnit.Year
                    expect(date.isBefore(unit, ofDate: date1)) == false
                    expect(date.isBefore(unit, ofDate: date2)) == false
                    expect(date.isBefore(unit, ofDate: date3)) == true
                }

                it("should report proper results for month granularity unit") {
                    let date1 = date - 1.months
                    let date2 = date + 1.weeks
                    let date3 = date + 1.months
                    let unit = NSCalendarUnit.Month
                    expect(date.isBefore(unit, ofDate: date1)) == false
                    expect(date.isBefore(unit, ofDate: date2)) == false
                    expect(date.isBefore(unit, ofDate: date3)) == true
                }

                it("should report proper results for week granularity unit") {
                    let date1 = date - 1.weeks
                    let date2 = date + 1.days
                    let date3 = date + 1.weeks
                    let unit = NSCalendarUnit.WeekOfYear
                    expect(date.isBefore(unit, ofDate: date1)) == false
                    expect(date.isBefore(unit, ofDate: date2)) == false
                    expect(date.isBefore(unit, ofDate: date3)) == true
                }

                it("should report proper results for day granularity unit") {
                    let date1 = date - 1.days
                    let date2 = date + 1.hours
                    let date3 = date + 1.days
                    let unit = NSCalendarUnit.Day
                    expect(date.isBefore(unit, ofDate: date1)) == false
                    expect(date.isBefore(unit, ofDate: date2)) == false
                    expect(date.isBefore(unit, ofDate: date3)) == true
                }

                it("should report proper results for hour granularity unit") {
                    let date1 = date - 1.hours
                    let date2 = date + 1.minutes
                    let date3 = date + 1.hours
                    let unit = NSCalendarUnit.Hour
                    expect(date.isBefore(unit, ofDate: date1)) == false
                    expect(date.isBefore(unit, ofDate: date2)) == false
                    expect(date.isBefore(unit, ofDate: date3)) == true
                }

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

                it("should report proper results for year granularity unit") {
                    let date1 = date - 1.years
                    let date2 = date - 1.months
                    let date3 = date + 1.years
                    let unit = NSCalendarUnit.Year
                    expect(date.isAfter(unit, ofDate: date1)) == true
                    expect(date.isAfter(unit, ofDate: date2)) == false
                    expect(date.isAfter(unit, ofDate: date3)) == false
                }

                it("should report proper results for month granularity unit") {
                    let date1 = date - 1.months
                    let date2 = date + 1.weeks
                    let date3 = date + 1.months
                    let unit = NSCalendarUnit.Month
                    expect(date.isAfter(unit, ofDate: date1)) == true
                    expect(date.isAfter(unit, ofDate: date2)) == false
                    expect(date.isAfter(unit, ofDate: date3)) == false
                }

                it("should report proper results for week granularity unit") {
                    let date1 = date - 1.weeks
                    let date2 = date + 1.days
                    let date3 = date + 1.weeks
                    let unit = NSCalendarUnit.WeekOfYear
                    expect(date.isAfter(unit, ofDate: date1)) == true
                    expect(date.isAfter(unit, ofDate: date2)) == false
                    expect(date.isAfter(unit, ofDate: date3)) == false
                }

                it("should report proper results for day granularity unit") {
                    let date1 = date - 1.days
                    let date2 = date + 1.hours
                    let date3 = date + 1.days
                    let unit = NSCalendarUnit.Day
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

                it("should report proper results for minute granularity unit") {
                    let date1 = date - 1.minutes
                    let date2 = date + 1.seconds
                    let date3 = date + 1.minutes
                    let unit = NSCalendarUnit.Minute
                    expect(date.isAfter(unit, ofDate: date1)) == true
                    expect(date.isAfter(unit, ofDate: date2)) == false
                    expect(date.isAfter(unit, ofDate: date3)) == false
                }

                it("should report proper results for second granularity unit") {
                    let date1 = date - 1.seconds
                    let date2 = date + 100000.nanoseconds
                    let date3 = date + 1.seconds
                    let unit = NSCalendarUnit.Second
                    expect(date.isAfter(unit, ofDate: date1)) == true
                    expect(date.isAfter(unit, ofDate: date2)) == false
                    expect(date.isAfter(unit, ofDate: date3)) == false
                }
            }

            context("isInToday") {

                it("should report true for today's date") {
                    let date = DateInRegion()
                    expect(date.isInToday()) == true
                }

                it("should report true for today at midnight") {
                    let date = DateInRegion().startOf(.Day)
                    expect(date.isInToday()) == true
                }

                it("should report true for today just before next midnight") {
                    let date = DateInRegion().endOf(.Day)
                    expect(date.isInToday()) == true
                }

                it("should report false for tomorrow at midnight") {
                    let date = (DateInRegion() + 1.days).startOf(.Day)
                    expect(date.isInToday()) == false
                }

                it("should report false just before last midnight") {
                    let date = (DateInRegion() - 1.days).endOf(.Day)
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
                    let date = (DateInRegion() - 1.days).startOf(.Day)
                    expect(date.isInYesterday()) == true
                }

                it("should report true for yesterday just before next midnight") {
                    let date = (DateInRegion() - 1.days).endOf(.Day)
                    expect(date.isInYesterday()) == true
                }

                it("should report false for today at midnight") {
                    let date = DateInRegion().startOf(.Day)
                    expect(date.isInYesterday()) == false
                }

                it("should report false just yesterday before last midnight") {
                    let date = (DateInRegion() - 2.days).endOf(.Day)
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
                    let date = (DateInRegion() + 1.days).startOf(.Day)
                    expect(date.isInTomorrow()) == true
                }

                it("should report true for tomorrow just before next midnight") {
                    let date = (DateInRegion() + 1.days).endOf(.Day)
                    expect(date.isInTomorrow()) == true
                }

                it("should report false for the day after tomorrow at midnight") {
                    let date = (DateInRegion() + 2.days).startOf(.Day)
                    expect(date.isInTomorrow()) == false
                }

                it("should report false just tomorrow before last midnight") {
                    let date = DateInRegion().endOf(.Day)
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
