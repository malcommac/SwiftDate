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
            
            context("valueForComponentYMD") {
                
                let region = DateRegion()
                let date = DateInRegion(era: 1, year: 2002, month: 3, day: 4, hour: 5, minute: 6, second: 7, nanosecond: 87654321, region: region)!
                
                it("should report a valid era") {
                    expect(date.valueForComponent(.Era)) == 1
                }
                
                it("should report a valid year") {
                    expect(date.valueForComponent(.Year)) == 2002
                }
                
                it("should report a valid month") {
                    expect(date.valueForComponent(.Month)) == 3
                }
                
                it("should report a valid day") {
                    expect(date.valueForComponent(.Day)) == 4
                }
                
                it("should report a valid hour") {
                    expect(date.valueForComponent(.Hour)) == 5
                }
                
                it("should report a valid minute") {
                    expect(date.valueForComponent(.Minute)) == 6
                }
                
                it("should report a valid second") {
                    expect(date.valueForComponent(.Second)) == 7
                }
                
                it("should report a valid nanosecond") {
                    expect(date.valueForComponent(.Nanosecond)).to(beCloseTo(87654321, within: 10))
                }
                
            }
            
            context("valueForComponentYWD") {
                
                let region = DateRegion()
                let date = DateInRegion(era: 1, yearForWeekOfYear: 2, weekOfYear: 3, weekday: 4, region: region)!
                
                it("should report a valid era") {
                    expect(date.valueForComponent(.Era)) == 1
                }
                
                it("should report a valid yearForWeekOfYear") {
                    expect(date.valueForComponent(.YearForWeekOfYear)) == 2
                }
                
                it("should report a valid weekOfYear") {
                    expect(date.valueForComponent(.WeekOfYear)) == 3
                }
                
                it("should report a valid weekday") {
                    expect(date.valueForComponent(.Weekday)) == 4
                }
                
                it("should report a valid hour") {
                    expect(date.valueForComponent(.Hour)) == 0
                }
                
                it("should report a valid minute") {
                    expect(date.valueForComponent(.Minute)) == 0
                }
                
                it("should report a valid second") {
                    expect(date.valueForComponent(.Second)) == 0
                }
                
                it("should report a valid nanosecond") {
                    expect(date.valueForComponent(.Nanosecond)) == 0
                }
                
            }
            
        }
        
        
        context("component initialisation") {
            
            let newYork = DateRegion(calendarID: NSCalendarIdentifierGregorian, timeZoneID: "EST", localeID: "en_US")
            let netherlands = DateRegion(calendarID: NSCalendarIdentifierGregorian, timeZoneID: "CET", localeID: "nl_NL")
            let utc = DateRegion(calendarID: NSCalendarIdentifierGregorian, timeZoneID: "UTC", localeID: "en_UK")
            
            it("should return a midnight date with nil YMD initialisation in various regions") {
                for region in [newYork, netherlands, utc] {
                    let date = DateInRegion(year: 1912, month: 6, day: 23, region: region)!
                    
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
            
            it("should return a date of 0001-01-01 00:00:00.000 in the default region for component initialisation") {
                let components = NSDateComponents()
                let date = DateInRegion(components)!
                
                expect(date.year) == 1
                expect(date.month) == 1
                expect(date.day) == 1
                expect(date.hour) == 0
                expect(date.minute) == 0
                expect(date.second) == 0
                expect(date.nanosecond) == 0
                expect(date.region) == DateRegion()
            }
            
            it("should return a proper date") {
                let date = DateInRegion(year: 1999, month: 12, day: 31, region: newYork)!
                let components = date.components
                expect(components.year) == 1999
                expect(components.month) == 12
                expect(components.day) == 31
                expect(components.timeZone) == newYork.timeZone
            }
            
        }
        
        context("In Gregorian weekends") {
            
            let netherlands = DateRegion(calendarID: NSCalendarIdentifierGregorian, timeZoneID: "CET", localeID: "nl_NL")
            
            it("should return a proper weekend value for a Saturday") {
                let date = DateInRegion(year: 2015, month: 11, day: 7, region: netherlands)!
                expect(date.isInWeekend()) == true
            }
            
            it("should return a proper weekend value for a Sunday") {
                let date = DateInRegion(year: 2015, month: 11, day: 8, region: netherlands)!
                expect(date.isInWeekend()) == true
            }
            
            it("should return a proper weekend value for a Monday") {
                let date = DateInRegion(year: 2015, month: 11, day: 9, region: netherlands)!
                expect(date.isInWeekend()) == false
            }
            
            it("should return a proper weekend value for a Tuesday") {
                let date = DateInRegion(year: 2015, month: 11, day: 10, region: netherlands)!
                expect(date.isInWeekend()) == false
            }
            
            it("should return a proper weekend value for a Wednesday") {
                let date = DateInRegion(year: 2015, month: 11, day: 11, region: netherlands)!
                expect(date.isInWeekend()) == false
            }
            
            it("should return a proper weekend value for a Thursday") {
                let date = DateInRegion(year: 2015, month: 11, day: 12, region: netherlands)!
                expect(date.isInWeekend()) == false
            }
            
            it("should return a proper weekend value for a Friday") {
                let date = DateInRegion(year: 2015, month: 11, day: 13, region: netherlands)!
                expect(date.isInWeekend()) == false
            }
            
        }
        
        context("Next weekend") {
            
            let netherlands = DateRegion(calendarID: NSCalendarIdentifierGregorian, timeZoneID: "CET", localeID: "nl_NL")
            let expectedStartDate = DateInRegion(year: 2015, month: 11, day: 7, region: netherlands)!
            let expectedEndDate = (expectedStartDate + 1.days).endOf(.Day)
            
            it("should return next weekend on Friday") {
                let date = DateInRegion(year: 2015, month: 11, day: 6, region: netherlands)!
                
                let weekend = date.nextWeekend()!
                
                expect(weekend.startDate) == expectedStartDate
                expect(weekend.endDate) == expectedEndDate
            }
            
            it("should return next weekend on Thursday") {
                let date = DateInRegion(year: 2015, month: 11, day: 5, region: netherlands)!
                
                let weekend = date.nextWeekend()!
                
                expect(weekend.startDate) == expectedStartDate
                expect(weekend.endDate) == expectedEndDate
            }
            
            it("should return next weekend on Wednesday") {
                let date = DateInRegion(year: 2015, month: 11, day: 4, region: netherlands)!
                
                let weekend = date.nextWeekend()!
                
                expect(weekend.startDate) == expectedStartDate
                expect(weekend.endDate) == expectedEndDate
            }
            
            it("should return next weekend on Tuesday") {
                let date = DateInRegion(year: 2015, month: 11, day: 3, region: netherlands)!
                
                let weekend = date.nextWeekend()!
                
                expect(weekend.startDate) == expectedStartDate
                expect(weekend.endDate) == expectedEndDate
            }
            
            it("should return week's weekend on Monday") {
                let date = DateInRegion(year: 2015, month: 11, day: 2, region: netherlands)!
                
                let weekend = date.nextWeekend()!
                
                expect(weekend.startDate) == expectedStartDate
                expect(weekend.endDate) == expectedEndDate
            }
            
            it("should return next week's weekend on Sunday") {
                let date = DateInRegion(year: 2015, month: 11, day: 1, region: netherlands)!
                
                let weekend = date.nextWeekend()!
                
                expect(weekend.startDate) == expectedStartDate
                expect(weekend.endDate) == expectedEndDate
            }
            
            it("should return next week's weekend on Saturday") {
                let date = DateInRegion(year: 2015, month: 10, day: 31, region: netherlands)!
                
                let weekend = date.nextWeekend()!
                
                expect(weekend.startDate) == expectedStartDate
                expect(weekend.endDate) == expectedEndDate
            }
            
        }
        
        context("Previous weekend") {
            
            let netherlands = DateRegion(calendarID: NSCalendarIdentifierGregorian, timeZoneID: "CET", localeID: "nl_NL")
            let expectedStartDate = DateInRegion(year: 2015, month: 10, day: 31, region: netherlands)!
            let expectedEndDate = (expectedStartDate + 1.days).endOf(.Day)
            

            it("should return last week's weekend on Sunday") {
                let date = DateInRegion(year: 2015, month: 11, day: 8, region: netherlands)!
                
                let weekend = date.previousWeekend()!
                
                expect(weekend.startDate) == expectedStartDate
                expect(weekend.endDate) == expectedEndDate
            }
            
            it("should return last week's weekend on Saturday") {
                let date = DateInRegion(year: 2015, month: 11, day: 7, region: netherlands)!
                
                let weekend = date.previousWeekend()!
                
                expect(weekend.startDate) == expectedStartDate
                expect(weekend.endDate) == expectedEndDate
            }
            
            it("should return last weekend on Friday") {
                let date = DateInRegion(year: 2015, month: 11, day: 7, region: netherlands)!
                
                let weekend = date.previousWeekend()!
                
                expect(weekend.startDate) == expectedStartDate
                expect(weekend.endDate) == expectedEndDate
            }
            
            it("should return last weekend on Thursday") {
                let date = DateInRegion(year: 2015, month: 11, day: 5, region: netherlands)!
                
                let weekend = date.previousWeekend()!
                
                expect(weekend.startDate) == expectedStartDate
                expect(weekend.endDate) == expectedEndDate
            }
            
            it("should return last weekend on Wednesday") {
                let date = DateInRegion(year: 2015, month: 11, day: 4, region: netherlands)!
                
                let weekend = date.previousWeekend()!
                
                expect(weekend.startDate) == expectedStartDate
                expect(weekend.endDate) == expectedEndDate
            }
            
            it("should return last weekend on Tuesday") {
                let date = DateInRegion(year: 2015, month: 11, day: 3, region: netherlands)!
                
                let weekend = date.previousWeekend()!
                
                expect(weekend.startDate) == expectedStartDate
                expect(weekend.endDate) == expectedEndDate
            }
            
            it("should return week's weekend on Monday") {
                let date = DateInRegion(year: 2015, month: 11, day: 2, region: netherlands)!
                
                let weekend = date.previousWeekend()!
                
                expect(weekend.startDate) == expectedStartDate
                expect(weekend.endDate) == expectedEndDate
            }
        }
    }
}

