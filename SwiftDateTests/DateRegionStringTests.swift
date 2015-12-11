//
//  SwiftDateTests.swift
//  SwiftDateTests
//
//  Created by Daniele Margutti on 23/11/15.
//  Copyright © 2015 Daniele Margutti. All rights reserved.
//

import Quick
import Nimble
@testable import SwiftDate

class DateRegionStringSpec: QuickSpec {
    
    override func spec() {
        
        describe("NSDate extension") {
            
            context("toString") {
                
                let date = DateInRegion(year: 2015, month: 4, day: 13, hour: 22, minute: 10, timeZoneID: "UTC")!
                
                it("should return proper ISO 8601 string") {
                    expect(date.toString(DateFormat.ISO8601)) == "2015-04-13T22:00:10+0000"
                }
                
                it("should return proper ISO 8601 date string") {
                    expect(date.toString(DateFormat.ISO8601Date)) == "2015-04-13"
                }
                
                it("should return proper Alt RSS date string") {
                    expect(date.toString(DateFormat.AltRSS)) == "2015-04-13"
                }
                
                it("should return proper ISO 8601 date string") {
                    expect(date.toString(DateFormat.ISO8601Date)) == "2015-04-13"
                }
                
                it("should return proper RSS date string") {
                    expect(date.toString(DateFormat.RSS)) == "2015-04-13"
                }
                
                it("should return proper custom date string") {
                    expect(date.toString(DateFormat.Custom("d MMM YY 'at' HH:MM"))) == "2015-04-13"
                }
                
                it("should return proper custom date string") {
                    expect(date.toString(DateFormat.Custom("eee d MMM YYYY, m 'minutes after' HH '(timezone is' Z')'"))) == "2015-04-13"
                }
            }
            
            context("relative strings EN") {
                let en_utc_region = DateRegion(calendarType: CalendarType.Gregorian, timeZoneRegion: TimeZoneNames.Other.UTC, localeID: "en_US")
                let justNowDate = NSDate() + 1.hours + 12.minutes
                let str_justNowDate = justNowDate.toRelativeCocoaString(inRegion: en_utc_region) // should return 'Today' (in English)
                
                expect(str_justNowDate).toNot(beNil())
                expect(str_justNowDate!.lowercaseString) == "today"
            }
            
            context("relative strings IT") {
                let it_utc_region = DateRegion(calendarType: CalendarType.Gregorian, timeZoneRegion: TimeZoneNames.Other.UTC, locale: NSLocale(localeIdentifier: "it_IT"))
                let justNowDate = NSDate() + 1.hours + 12.minutes
                let str_justNowDate = justNowDate.toRelativeCocoaString(inRegion: it_utc_region) // should return 'Oggi' (in Italian)
                
                expect(str_justNowDate).toNot(beNil())
                expect(str_justNowDate!.lowercaseString) == "oggi"
            }
            
        }
    }
}

