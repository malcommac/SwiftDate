//
//  SwiftDateTests.swift
//  SwiftDateTests
//
//  Created by Daniele Margutti on 23/11/15.
//  Copyright © 2015 Daniele Margutti. All rights reserved.
//

import XCTest
@testable import SwiftDate

class SwiftDateTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
	func test_operation_toString() {
        let refDate = NSDate(year: 2015, month: 4, day: 13, hour: 22, minute: 10)!
		
		// FORMATS
        // TODO: These tests are incorrect as time zones are reflected in the string. Time zone handling is not an option with NSDate if the time zone is local and can be anything. This should be mocked.
        //XCTAssertEqual(refDate.toString(DateFormat.ISO8601), "2015-04-13T22:00:10+0000")
        //XCTAssertEqual(refDate.toString(DateFormat.AltRSS), "13 Apr 2015 22:00:10 +0000")
        //XCTAssertEqual(refDate.toString(DateFormat.RSS), "Mon, 13 Apr 2015 22:00:10 +0000")
        XCTAssertEqual(refDate.toString(DateFormat.ISO8601Date), "2015-04-13")
        XCTAssertEqual(refDate.toString(DateFormat.Custom("d MMM YY 'at' HH:MM")), "13 Apr 15 at 22:04")
        //XCTAssertEqual(refDate.toString(DateFormat.Custom("eee d MMM YYYY, m 'minutes after' HH '(timezone is' Z')'")), "Mon 13 Apr 2015, 0 minutes after 22 (timezone is +0000)")
		
		// RELATIVE DATES WITH COCOA
		let en_utc_region = DateRegion(calendarType: CalendarType.Gregorian, timeZoneRegion: TimeZoneNames.Other.UTC, locale: NSLocale(localeIdentifier: "EN_US"))
		let it_utc_region = DateRegion(calendarType: CalendarType.Gregorian, timeZoneRegion: TimeZoneNames.Other.UTC, locale: NSLocale(localeIdentifier: "IT_IT"))
		
		let justNowDate = NSDate() + 1.hours + 12.minutes
		let str_justNowDate = justNowDate.toRelativeCocoaString(inRegion: en_utc_region) // should return 'Today' (in english)
		XCTAssert(str_justNowDate?.lowercaseString == "today", "Failed to adding date to an UTC NSDate")

		let str_justNowDateIT = justNowDate.toRelativeCocoaString(inRegion: it_utc_region) // should return 'Oggi' (in italian)
		XCTAssert(str_justNowDateIT?.lowercaseString == "oggi", "Failed to adding date to an UTC NSDate")
		
		// RELATIVE DATES WITH CUSTOM FORMATTER
		let justNowRefDate = NSDate()
		let justNowDate2 = justNowRefDate + 2.seconds + 1.hours
		
		let str_justNowDateInIT = justNowDate2.toRelativeString(fromDate: justNowRefDate, inRegion: en_utc_region, maxUnits: 7)
		XCTAssert(str_justNowDateInIT?.lowercaseString == "1 hour 2 seconds", "Failed to get relative string in en region")
	}

	
	func test_nsdate_operations() {
		let test1 = true
		let test2 = true
		let test3 = true
		let test4 = true
		let test5 = true
		let test6 = true

		// Our absolute time is 2015-01-01 22:10:00
        let refDate = NSDate(year: 2015, month: 1, day: 1, hour: 22, minute: 10)!

		if test1 {
			// We will add 1 year, 2 hours, 30 mins and 10 seconds
			// We are expecting 2016-01-02 00:30:20 UTC
			let date = refDate.add(years: 1, hours: 2, minutes: 30, seconds: 10)
            XCTAssertEqual(date.day, 2)
            XCTAssertEqual(date.month, 1)
            XCTAssertEqual(date.year, 2016)
            XCTAssertEqual(date.hour, 0)
            XCTAssertEqual(date.minute, 40)
            XCTAssertEqual(date.second, 10)
		}
		
		if test2 {
			// Same as above with NSDateComponents
			let dComps = NSDateComponents()
			dComps.year = 1
			dComps.hour = 2
			dComps.minute = 30
			dComps.second = 10
			let date = refDate.add(dComps)
            XCTAssertEqual(date.day, 2)
            XCTAssertEqual(date.month, 1)
            XCTAssertEqual(date.year, 2016)
            XCTAssertEqual(date.hour, 0)
            XCTAssertEqual(date.minute, 40)
            XCTAssertEqual(date.second, 10)
		}
		
		if test3 {
			var dCompDict: [NSCalendarUnit: AnyObject] = [:]
			dCompDict[NSCalendarUnit.Year] = 1
			dCompDict[NSCalendarUnit.Hour] = 2
			dCompDict[NSCalendarUnit.Minute] = 30
			dCompDict[NSCalendarUnit.Second] = 10
			let date = refDate.add(dCompDict)
            XCTAssertEqual(date.day, 2)
            XCTAssertEqual(date.month, 1)
            XCTAssertEqual(date.year, 2016)
            XCTAssertEqual(date.hour, 0)
            XCTAssertEqual(date.minute, 40)
            XCTAssertEqual(date.second, 10)
		}
		
		if test4 {
			let date = refDate + 2.days + 1.hours + 70.seconds
            XCTAssertEqual(date.day, 3)
            XCTAssertEqual(date.month, 1)
            XCTAssertEqual(date.year, 2015)
            XCTAssertEqual(date.hour, 23)
            XCTAssertEqual(date.minute, 11)
            XCTAssertEqual(date.second, 10)
		}
		
		if test5 {
			let date1 = (NSDate() - 1.days)
			XCTAssert(date1.isYesterday(), "Failed to get if date is yesterday")

			let date2 = NSDate() + 1.days
			XCTAssert(date2.isTomorrow(), "Failed to get if date is tomorrow")
			
			// Get if date is in weekend (according to default calendar when not specified, Gregorian)
            let date3 = NSDate(year: 2015, month: 11, day: 28)!
			XCTAssert(date3.isWeekend()!, "Failed to get if date is weekend in Gregorian calendar")
		}
		
		if test6 {
            let date = NSDate(year: 2015, month: 11, day: 26)!
            let locale = NSLocale(localeIdentifier: "it_IT")
            let gregorian = DateRegion(calendarType: .Gregorian, locale: locale)
            let hebrew = DateRegion(calendarType: .Hebrew, locale: locale)

            XCTAssertEqual(date.firstDayOfWeek(inRegion: gregorian), 23)
            XCTAssertEqual(date.firstDayOfWeek(inRegion: hebrew), 11)
            XCTAssertEqual(date.lastDayOfWeek(inRegion: gregorian), 29)
            XCTAssertEqual(date.lastDayOfWeek(inRegion: hebrew), 17)
		}
	}
	
	func test_nsdate_create() {
		let test1 = true
		let test2 = true
		let test3 = true
		let test4 = true
		let test5 = true
		let test6 = true
		let test7 = true
		let test8 = true
		let test9 = true
		let test10 = true
		let test11 = true
		let test12 = true
		let test13 = true

		// DATE FROM ISO8601
		// =================
        
        /* TODO: All these tests are invalid as they are strings converted to absolute time. String representation of NSDate is always local region...
		if test1 {
			let date_str = "2015-01-05T22:10:55.200Z"
            let date = DateInRegion(fromString: date_str, format: DateFormat.ISO8601)?.absoluteTime
			XCTAssertNotNil(date, "Failed to generate date from '\(date_str)")
            XCTAssertEqual(date!.day, 5)
            XCTAssertEqual(date!.month, 1)
            XCTAssertEqual(date!.year, 2015)
            XCTAssertEqual(date!.hour, 22)
            XCTAssertEqual(date!.minute, 10)
            XCTAssertEqual(date!.second, 55)
		}

		// DATE FROM RSS
		// =============
		if test2 {
			let date_str = "Fri, 09 Sep 2011 15:26:08 +0200"
			let date = date_str.toDate(DateFormat.RSS)
			XCTAssertNotNil(date, "Failed to generate date from '\(date_str)")
            XCTAssertEqual(date!.day, 9)
            XCTAssertEqual(date!.month, 9)
            XCTAssertEqual(date!.year, 2011)
            XCTAssertEqual(date!.hour, 15)
            XCTAssertEqual(date!.minute, 26)
            XCTAssertEqual(date!.second, 8)
		}
		
		// DATE FROM ALT RSS
		// =================
		// Date is expressed in +4hours later so resulting absolute time is at 7pm
		if test3 {
			let date_str = "09 Sep 2011 15:26:08 -0400"
			let date = date_str.toDate(DateFormat.AltRSS)
            XCTAssertNotNil(date, "Failed to generate date from '\(date_str)")
            XCTAssertEqual(date!.day, 9)
            XCTAssertEqual(date!.month, 9)
            XCTAssertEqual(date!.year, 2011)
            XCTAssertEqual(date!.hour, 21)
            XCTAssertEqual(date!.minute, 26)
            XCTAssertEqual(date!.second, 8)
		}
		
		// DATE FROM CUSTOM FORMATS
		// ========================
		if test4 {
			// Date is specified only for day/month/year. No timezone mean UTC.
			// No hour/date/seconds/nanoseconds means 0 for all
			// Resulting NSDate must be 22/01/2015 00:00:00 UTC
			let date_str = "22/01/2015"
			let date = date_str.toDate(DateFormat.Custom("dd/MM/yyyy"))
			XCTAssertNotNil(date, "Failed to generate date from '\(date_str)")
			XCTAssert(date!.day == 22 && date!.month == 1 && date!.year == 2015 && date!.hour == 0 && date!.minute == 0 && date!.second == 0, "Failed to get correct components from date '\(date_str)")
		}
		if (test5) {
			// Date is expressed in a custom format for "2015/11/24 22:10:00 UTC-4"
			// So resulting NSDate (UTC) will be "November 25 at 02:10:00 UTC"
			let date_str = "Thu, November 24 2015 at 22:10 -0400"
			let date = date_str.toDate(DateFormat.Custom("EEE',' MMMM dd yyyy 'at' HH:mm ZZZ"))
			XCTAssertNotNil(date, "Failed to generate date from '\(date_str)")
			XCTAssert(date!.day == 25 && date!.month == 11 && date!.year == 2015 && date!.hour == 2 && date!.minute == 10 && date!.second == 0, "Failed to get correct components from date '\(date_str)")
		}
		
		// DATE FROM COMPONENTS CHAINING
		// =============================
		if test6 {
			// This test create an absolute time by chaining a list of components (all these objects are NSDateComponents)
			// Resulting date must be 2015-04-30 a 15:00:20 UTC
            let date = DateInRegion(2025.years | 4.months | 30.days | 15.hours | 20.seconds)
			XCTAssertNotNil(date, "Failed to generate date from components chaining")
			XCTAssert(date!.day == 30 && date!.month == 4 && date!.year == 2025 && date!.hour == 15 && date!.minute == 0 && date!.second == 20, "Failed to get correct components from components chaining")
		}
		if test7 {
			// This test create an absolute time by chaining a list of components for a date expressed in another timezone
			// Resulting NSDate will be, as usual, in UTC.
			// Origin date is 2015-01-31 at 22:00:00 UTC+9 (Asia/Tokyo)
			// We are expecting an NSDate (UTC Date) 2015-02-01 at 13:00:00 UTC
			let components = (2015.years | 1.months | 31.days | 22.hours | (TimeZoneNames.Asia.Tokyo.toTimeZone()?.timeZone)!)
			let date = DateInRegion(components)
			XCTAssertNotNil(date, "Failed to generate date from components chaining")
			XCTAssert(date!.day == 31 && date!.month == 1 && date!.year == 2015 && date!.hour == 13 && date!.minute == 0 && date!.second == 0, "Failed to get correct components from components chaining")
		}
		if test8 {
			let components = NSDateComponents()
			components.year = 2034
			components.month = 12
			components.day = 31
			components.hour = 1
			components.minute = 10
			components.calendar = CalendarType.Gregorian.toCalendar()
			components.timeZone = TimeZoneNames.Indian.Mauritius.toTimeZone()
			// Mauritius are 4 hours ahead UTC, so we expect
			// an UTC NSDate: 2034-12-30 at 21:10:00 UTC
			let date = NSDate(components: components)
			XCTAssertNotNil(date, "Failed to generate date from NSDateComponents instance")
			XCTAssert(date!.day == 30 && date!.month == 12 && date!.year == 2034 && date!.hour == 21 && date!.minute == 10 && date!.second == 0, "Failed to get correct components from components chaining")
		}
		if test9 {
			var compDict: [NSCalendarUnit: AnyObject] = [:]
			compDict[NSCalendarUnit.Year] = 2034
			compDict[NSCalendarUnit.Month] = 12
			compDict[NSCalendarUnit.Day] = 31
			compDict[NSCalendarUnit.Hour] = 1
			compDict[NSCalendarUnit.Minute] = 10
			compDict[NSCalendarUnit.Calendar] = CalendarType.Gregorian.toCalendar()
			compDict[NSCalendarUnit.TimeZone] = TimeZoneNames.Indian.Mauritius.toTimeZone()
			// Mauritius are 4 hours ahead UTC, so we expect
			// an UTC NSDate: 2034-12-30 at 21:10:00 UTC
			let date = NSDate(dateComponentDictionary: compDict)
			XCTAssertNotNil(date, "Failed to generate date from components dictionary")
			XCTAssert(date!.day == 30 && date!.month == 12 && date!.year == 2034 && date!.hour == 21 && date!.minute == 10 && date!.second == 0, "Failed to get correct components from components chaining")
		}
		if test10 {
			// Our ref date is 2015-01-01 at 22:10:00 UTC
            let UTC = DateRegion(timeZoneID: "UTC")
			let refDate = (2015.years | 1.months | 1.days | 22.hours | 10.seconds ).inRegion(UTC)!.absoluteTime
            
			// Our region is Rome (UTC+1)
            let regionRome = DateRegion(timeZoneRegion: TimeZoneNames.Europe.Rome)
			// We want to create a date from refDate where we change the year (2020), month (2), hour (15), minute (30)
			let date = NSDate(refDate: refDate, year: 2020, month: 2, hour: 15, minute: 30, region: regionRome)
			// So we are expecting 2020-02-01 at 15:30:10 UTC+1 (-> in NSDate UTC 2020-02-01 at 14:30:10)
			XCTAssertNotNil(date, "Failed to generate date from init with params")
			XCTAssert(date.day == 1 && date.month == 2 && date.year == 2020 && date.hour == 14 && date.minute == 30 && date.second == 10, "Failed to get correct components from components chaining")
		}
		if test11 {
            let UTC = DateRegion(timeZoneID: "UTC")
            // We want to convert absolute time 2015-01-01 22:00:10 UTC to UTC+1
			let refDate = (2015.years | 1.months | 1.days | 22.hours | 10.seconds).inRegion(UTC)!.absoluteTime
			// We are expecting 2015-01-01 23:00:10 UTC+1 (DateInRegion object)
			let dateInRomeRegion = refDate.inRegion(DateRegion(timeZoneRegion: TimeZoneNames.Europe.Rome))
			XCTAssert(dateInRomeRegion.hour == 23, "Failed to get correct components from components chaining")
			let dateInMauritiusRegion = dateInRomeRegion.inRegion(DateRegion(timeZoneRegion: TimeZoneNames.Indian.Mauritius))
			XCTAssert(dateInMauritiusRegion.day == 2 && dateInMauritiusRegion.month == 1 && dateInMauritiusRegion.year == 2015 && dateInMauritiusRegion.hour == 2 && dateInMauritiusRegion.minute == 0 && dateInMauritiusRegion.second == 10, "Failed to get correct components from components chaining")

		}
		if test12 {
			let now = NSDate()
			let newDate = (10.seconds + 5.hours).fromDate(now)
			let nowVerify = now.dateByAddingTimeInterval((60*60*5)+10)
			XCTAssert(nowVerify == newDate, "Failed to get correct components from components chaining")
		}
		if test13 {
			let now = NSDate()
			let newDate = (20.seconds + 3.hours).agoFromDate(now)
			let nowVerify = now.dateByAddingTimeInterval( (((60*60*3)+20) * -1) )
			XCTAssert(nowVerify == newDate, "Failed to get correct components from components chaining")
		}

*/
	}
	
	func test_dateinregion_create() {
		
	}
    
}
