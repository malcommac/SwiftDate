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
            
            context("toString UTC") {
                
                let utcDate = DateInRegion(year: 2015, month: 4, day: 13, hour: 22, minute: 10, timeZoneID: "UTC")!
                
                it("should return proper ISO 8601 string") {
                    expect(utcDate.toString(DateFormat.ISO8601)) == "2015-04-13T22:10:00+0000"
                }
                
                it("should return proper ISO 8601 date string") {
                    expect(utcDate.toString(DateFormat.ISO8601Date)) == "2015-04-13"
                }
                
                it("should return proper Alt RSS date string") {
                    expect(utcDate.toString(DateFormat.AltRSS)) == "13 Apr 2015 22:10:00 +0000"
                }
                
                it("should return proper RSS date string") {
                    expect(utcDate.toString(DateFormat.RSS)) == "Mon, 13 Apr 2015 22:10:00 +0000"
                }
                
                it("should return proper custom date string") {
                    expect(utcDate.toString(DateFormat.Custom("d MMM YY 'at' HH:mm"))) == "13 Apr 15 at 22:10"
                }
                
                it("should return proper custom date string") {
                    expect(utcDate.toString(DateFormat.Custom("eee d MMM YYYY, m 'minutes after' HH '(timezone is' Z')'"))) == "Mon 13 Apr 2015, 10 minutes after 22 (timezone is +0000)"
                }
            }
            
            context("toString local") {
                
                let localDate = DateInRegion(year: 2015, month: 4, day: 13, hour: 22, minute: 10)!
                
                it("should return proper ISO 8601 string") {
                    expect(localDate.toString(DateFormat.ISO8601)?.hasPrefix("2015-04-13T22:10:00"))
                }
                
                it("should return proper ISO 8601 date string") {
                    expect(localDate.toString(DateFormat.ISO8601Date)) == "2015-04-13"
                }
                
                it("should return proper Alt RSS date string") {
                    expect(localDate.toString(DateFormat.AltRSS)!.hasPrefix("13 Apr 2015 22:10:00"))
                }
                
                it("should return proper RSS date string") {
                    expect(localDate.toString(DateFormat.RSS)!.hasPrefix("Mon, 13 Apr 2015 22:10:00"))
                }
                
                it("should return proper custom date string") {
                    expect(localDate.toString(DateFormat.Custom("d MMM YY 'at' HH:mm"))) == "13 Apr 15 at 22:10"
                }
                
                it("should return proper custom date string") {
                    expect(localDate.toString(DateFormat.Custom("eee d MMM YYYY, m 'minutes after' HH '(timezone is' Z')'"))!.hasPrefix("Mon 13 Apr 2015, 10 minutes after 22 (timezone is "))
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

