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
		let refDate = (2015.years | 4.months | 13.days | 22.hours | 10.seconds).inUTCDate()!
		
		// FORMATS
		let toISO8601DateTime = refDate.toString(DateFormat.ISO8601)
		let toAltRSS = refDate.toString(DateFormat.AltRSS)
		let toRSS = refDate.toString(DateFormat.RSS)
		let toISO8601Date = refDate.toString(DateFormat.ISO8601Date)
		let toCustomFormat_1 = refDate.toString(DateFormat.Custom("d MMM YY 'at' HH:MM"))
		let toCustomFormat_2 = refDate.toString(DateFormat.Custom("eee d MMM YYYY, m 'minutes after' HH '(timezone is' Z')'"))
		
		XCTAssert(toISO8601DateTime == "2015-04-13T22:00:10+0000", "Failed to adding date to an UTC NSDate")
		XCTAssert(toAltRSS == "13 Apr 2015 22:00:10 +0000", "Failed to adding date to an UTC NSDate")
		XCTAssert(toRSS == "Mon, 13 Apr 2015 22:00:10 +0000", "Failed to adding date to an UTC NSDate")
		XCTAssert(toISO8601Date == "2015-04-13", "Failed to adding date to an UTC NSDate")
		XCTAssert(toCustomFormat_1 == "13 Apr 15 at 22:04", "Failed to adding date to an UTC NSDate")
		XCTAssert(toCustomFormat_2 == "Mon 13 Apr 2015, 0 minutes after 22 (timezone is +0000)", "Failed to adding date to an UTC NSDate")
		
		// RELATIVE DATES WITH COCOA
		let en_utc_region = Region(calType: CalendarType.Gregorian, tzType: TimeZoneNames.Other.GMT, loc: NSLocale(localeIdentifier: "EN_US"))
		let it_utc_region = Region(calType: CalendarType.Gregorian, tzType: TimeZoneNames.Other.GMT, loc: NSLocale(localeIdentifier: "IT_IT"))
		
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

		// Our UTC date is 2015-01-01 22:10:00 UTC
		let refDate = (2015.years | 1.months | 1.days | 22.hours | 10.seconds).inUTCDate()!

		if test1 {
			// We will add 1 year, 2 hours, 30 mins and 10 seconds
			// We are expecting 2016-01-02 00:30:20 UTC
			let date = refDate.add(years: 1, hours: 2, minutes: 30, seconds: 10)
			XCTAssert(date.day == 2 && date.month == 1 && date.year == 2016 && date.hour == 0 && date.minute == 30 && date.second == 20, "Failed to adding date to an UTC NSDate")
		}
		
		if test2 {
			// Same as above with NSDateComponents
			let dComps = NSDateComponents()
			dComps.year = 1
			dComps.hour = 2
			dComps.minute = 30
			dComps.second = 10
			let date = refDate.add(dComps)
			XCTAssert(date.day == 2 && date.month == 1 && date.year == 2016 && date.hour == 0 && date.minute == 30 && date.second == 20, "Failed to adding date to an UTC NSDate")
		}
		
		if test3 {
			var dCompDict : [NSCalendarUnit : AnyObject] = [:]
			dCompDict[NSCalendarUnit.Year] = 1
			dCompDict[NSCalendarUnit.Hour] = 2
			dCompDict[NSCalendarUnit.Minute] = 30
			dCompDict[NSCalendarUnit.Second] = 10
			let date = refDate.add(dCompDict)
			XCTAssert(date.day == 2 && date.month == 1 && date.year == 2016 && date.hour == 0 && date.minute == 30 && date.second == 20, "Failed to adding date to an UTC NSDate")
		}
		
		if test4 {
			let newDate = refDate + 2.days + 1.hours + 70.seconds
			XCTAssert(newDate.day == 3 && newDate.hour == 23 && newDate.minute == 1 && newDate.second == 20, "Failed to adding date to an UTC NSDate")
		}
		
		if test5 {
			let today = NSDate()
			
			let date1 = (NSDate() - 1.days)
			XCTAssert(date1.isYesterday(), "Failed to get if date is yesterday")

			let date2 = ((today.year.years | today.month.months | today.day.days | today.hour.hours) + 1.days).inUTCDate()!
			XCTAssert(date2.isTomorrow(), "Failed to get if date is tomorrow")
			
			// Get if date is in weekend (according to default calendar when not specified, Gregorian)
			let date3 = (2015.years | 11.months | 28.days).inUTCDate()!
			XCTAssert(date3.isWeekend()!, "Failed to get if date is weekend in Gregorian calendar")
		}
		
		if test6 {
			let date = (2015.years | 11.months | 26.days).inUTCDate()!
			
			// Last day of week
			let lastDayOfWeekHB = date.lastDayOfWeek(inCalendar : CalendarType.Hebrew)
			XCTAssert(lastDayOfWeekHB == 16, "Failed to get last day of week in Hebrew calendar")
			
			let lastDayOfWeekGREG = date.lastDayOfWeek(inCalendar : CalendarType.Gregorian)
			XCTAssert(lastDayOfWeekGREG == 28, "Failed to get last day of week (Saturday) in Gregorian calendar")
			
			// First day of week
			let firstDayOfWeekHB = date.firstDayOfWeek(inCalendar : CalendarType.Hebrew)
			XCTAssert(firstDayOfWeekHB == 10, "Failed to get first day of week in Hebrew calendar")
			
			let firstDayOfWeekGREG = date.firstDayOfWeek(inCalendar : CalendarType.Gregorian)
			XCTAssert(firstDayOfWeekGREG == 22, "Failed to get first day of week (Sunday) in Gregorian calendar")
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
		// Date is expressed in UTC format
		if test1 {
			let date_str = "2015-01-05T22:10:55.200Z"
			let date = date_str.toDate(DateFormat.ISO8601)
			XCTAssertNotNil(date, "Failed to generate date from '\(date_str)")
			XCTAssert(date!.day == 5 && date!.month == 1 && date!.year == 2015 && date!.hour == 22 && date!.minute == 10 && date!.second == 55, "Failed to get correct components from date '\(date_str)")
		}
		
		// DATE FROM RSS
		// =============
		// Date is expressed in GMT+2 so resulting parsed date (expressed in UTC) will be 2 hours earlier
		if test2 {
			let date_str = "Fri, 09 Sep 2011 15:26:08 +0200"
			let date = date_str.toDate(DateFormat.RSS)
			XCTAssertNotNil(date, "Failed to generate date from '\(date_str)")
			XCTAssert(date!.day == 9 && date!.month == 9 && date!.year == 2011 && date!.hour == 13 && date!.minute == 26 && date!.second == 8, "Failed to get correct components from date '\(date_str)")
		}
		
		// DATE FROM ALT RSS
		// =================
		// Date is expressed in +4hours later so resulting UTC date is at 7pm
		if test3 {
			let date_str = "09 Sep 2011 15:26:08 -0400"
			let date = date_str.toDate(DateFormat.AltRSS)
			XCTAssertNotNil(date, "Failed to generate date from '\(date_str)")
			XCTAssert(date!.day == 9 && date!.month == 9 && date!.year == 2011 && date!.hour == 19 && date!.minute == 26 && date!.second == 8, "Failed to get correct components from date '\(date_str)")
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
			// Date is expressed in a custom format for "2015/11/24 22:10:00 GMT-4"
			// So resulting NSDate (UTC) will be "November 25 at 02:10:00 UTC"
			let date_str = "Thu, November 24 2015 at 22:10 -0400"
			let date = date_str.toDate(DateFormat.Custom("EEE',' MMMM dd yyyy 'at' HH:mm ZZZ"))
			XCTAssertNotNil(date, "Failed to generate date from '\(date_str)")
			XCTAssert(date!.day == 25 && date!.month == 11 && date!.year == 2015 && date!.hour == 2 && date!.minute == 10 && date!.second == 0, "Failed to get correct components from date '\(date_str)")
		}
		
		// DATE FROM COMPONENTS CHAINING
		// =============================
		if test6 {
			// This test create an UTC date by chaining a list of components (all these objects are NSDateComponents)
			// Resulting date must be 2015-04-30 a 15:00:20 UTC
			let components = (2025.years | 4.months | 30.days | 15.hours | 20.seconds)
			let date = components.inUTCDate()
			XCTAssertNotNil(date, "Failed to generate date from components chaining")
			XCTAssert(date!.day == 30 && date!.month == 4 && date!.year == 2025 && date!.hour == 15 && date!.minute == 0 && date!.second == 20, "Failed to get correct components from components chaining")
		}
		if test7 {
			// This test create an UTC date by chaining a list of components for a date expressed in another timezone
			// Resulting NSDate will be, as usual, in UTC.
			// Origin date is 2015-01-31 at 22:00:00 GMT+9 (Asia/Tokyo)
			// We are expecting an NSDate (UTC Date) 2015-02-01 at 13:00:00 UTC
			let components = (2015.years | 1.months | 31.days | 22.hours)
			let date = components.fromTimeZone(tz: TimeZoneNames.Asia.Tokyo)
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
			// Mauritius are 4 hours ahead GMT, so we expect
			// an UTC NSDate: 2034-12-30 at 21:10:00 UTC
			let date = NSDate(components: components)
			XCTAssertNotNil(date, "Failed to generate date from NSDateComponents instance")
			XCTAssert(date!.day == 30 && date!.month == 12 && date!.year == 2034 && date!.hour == 21 && date!.minute == 10 && date!.second == 0, "Failed to get correct components from components chaining")
		}
		if test9 {
			var compDict : [NSCalendarUnit : AnyObject] = [:]
			compDict[NSCalendarUnit.Year] = 2034
			compDict[NSCalendarUnit.Month] = 12
			compDict[NSCalendarUnit.Day] = 31
			compDict[NSCalendarUnit.Hour] = 1
			compDict[NSCalendarUnit.Minute] = 10
			compDict[NSCalendarUnit.Calendar] = CalendarType.Gregorian.toCalendar()
			compDict[NSCalendarUnit.TimeZone] = TimeZoneNames.Indian.Mauritius.toTimeZone()
			// Mauritius are 4 hours ahead GMT, so we expect
			// an UTC NSDate: 2034-12-30 at 21:10:00 UTC
			let date = NSDate(params: compDict)
			XCTAssertNotNil(date, "Failed to generate date from components dictionary")
			XCTAssert(date!.day == 30 && date!.month == 12 && date!.year == 2034 && date!.hour == 21 && date!.minute == 10 && date!.second == 0, "Failed to get correct components from components chaining")
		}
		if test10 {
			// Our ref date is 2015-01-01 at 22:10:00 UTC
			let refDate = (2015.years | 1.months | 1.days | 22.hours | 10.seconds).inUTCDate()!
			// Our region is Rome (GMT+1)
			let regionRome = Region(tzType: TimeZoneNames.Europe.Rome)
			// We want to create a date from refDate where we change the year (2020), month (2), hour (15), minute (30)
			let date = NSDate(refDate: refDate, year: 2020, month: 2, hour: 15, minute: 30, region: regionRome)
			// So we are expecting 2020-02-01 at 15:30:10 GMT+1 (-> in NSDate UTC 2020-02-01 at 14:30:10)
			XCTAssertNotNil(date, "Failed to generate date from init with params")
			XCTAssert(date.day == 1 && date.month == 2 && date.year == 2020 && date.hour == 14 && date.minute == 30 && date.second == 10, "Failed to get correct components from components chaining")
		}
		if test11 {
			// We want to convert UTC date 2015-01-01 22:00:10 UTC to GMT+1
			let refDate = (2015.years | 1.months | 1.days | 22.hours | 10.seconds).inUTCDate()!
			// We are expecting 2015-01-01 23:00:10 GMT+1 (DateInRegion object)
			let inRomeRegion = refDate.inRegion(Region(tzType: TimeZoneNames.Europe.Rome))
			XCTAssert(inRomeRegion.hour == 23, "Failed to get correct components from components chaining")
			let inMauritiusRegion = inRomeRegion.inRegion(anotherRegion: Region(tzType: TimeZoneNames.Indian.Mauritius))
			XCTAssert(inMauritiusRegion.day == 2 && inMauritiusRegion.month == 1 && inMauritiusRegion.year == 2015 && inMauritiusRegion.hour == 2 && inMauritiusRegion.minute == 0 && inMauritiusRegion.second == 10, "Failed to get correct components from components chaining")

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
	}
	
	func test_dateinregion_create() {
		
	}
    
}
