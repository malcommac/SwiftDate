//
//  DateInRegion.swift
//  SwiftDate
//
//  Created by Daniele Margutti on 13/09/16.
//  Copyright © 2016 Daniele Margutti. All rights reserved.
//

import XCTest
@testable import SwiftDate


class DateInRegionTest: XCTestCase {
        
	override func setUp() {
		super.setUp()
		// Put setup code here. This method is called before the invocation of each test method in the class.
	}
	
	override func tearDown() {
		// Put teardown code here. This method is called after the invocation of each test method in the class.
		super.tearDown()
	}
	
	
	/// Generate a new DateInRegion object from an absolute date and express it in another region
	func testDateInRegionInit_AbsoluteDate() {
		// Create a new date for 2005-06-01 10:00:00 UTC
		let absDate = Date(timeIntervalSince1970: 1117620000)
		let regionRome = Region(tz: TimeZoneName.europeRome, cal: CalendarName.gregorian, loc: LocaleName.current)
		let dateInRome = DateInRegion(absoluteDate: absDate, in: regionRome)
		let dateInRomeAsString = dateInRome.string(format: .iso8601(options: .withInternetDateTime))
		XCTAssertEqual("2005-06-01T12:00:00+02:00", dateInRomeAsString, "Failed to generate a valid date in a region")
	}
	
	func testDateInRegionInit_Components() {
		// Create a new DateComponents and set the 10:00 AM of Feb 4,2016 GMT+2
		var components = DateComponents()
		components.year = 2016
		components.month = 2
		components.day = 4
		components.hour = 10
		components.timeZone = TimeZoneName.europeRome.timeZone
		components.calendar = CalendarName.current.calendar
		do {
			// Created DateInRegion instance should report +1 date due to light saving time in Feb
			let regionInRome = try DateInRegion(components: components)
			let dateInRomeAsString = regionInRome.string(format: .iso8601(options: .withInternetDateTime))
			XCTAssertEqual("2016-02-04T10:00:00+01:00", dateInRomeAsString, "Failed to generate a valid date in a region from a component dictionary")
		} catch let err {
			XCTAssert(false, "Failed to create a region from components dictionary: \(err)")
		}
	}
	
	func testDateInRegionInit_ComponentsDict() {
		do {
			let regionRome = Region(tz: TimeZoneName.europeRome, cal: CalendarName.gregorian, loc: LocaleName.current)
			let cmpDict: [Calendar.Component : Int] = [.year: 2016, .month: 9, .day: 14, .hour: 7]
			let regionInRome = try DateInRegion(components: cmpDict, fromRegion: regionRome)
			let dateInRomeAsString = regionInRome.string(format: .iso8601(options: .withInternetDateTime))
			XCTAssertEqual("2016-09-14T07:00:00+02:00", dateInRomeAsString, "Failed to generate a valid date in a region")
		} catch let err {
			XCTAssert(false, "Failed to create a region from components: \(err)")
		}
	}
	
	func testDateInRegionInit_StringCustom() {
		let customString = "090911"
		do {
			let dateInUTC = try DateInRegion(string: customString, format: .custom("ddMMyy"), fromRegion: Region.GMT())
			let dateUTCAsString = dateInUTC.string(format: .iso8601(options: .withInternetDateTime))
			XCTAssertEqual("2011-09-09T00:00:00Z", dateUTCAsString, "Failed to generate a valid date from custom string format")
		} catch let err {
			XCTAssert(false, "Failed to create a region from custom string format: \(err)")
		}
	}
	
	func testDateInRegionInit_AltRSSWithZ() {
		let customString = "09 Sep 2011 15:26:08 Z"
		do {
			let dateInUTC = try DateInRegion(string: customString, format: .rss(alt: true), fromRegion: Region.GMT())
			let dateUTCAsString = dateInUTC.string(format: .iso8601(options: .withInternetDateTime))
			XCTAssertEqual("2011-09-09T15:26:08Z", dateUTCAsString, "Failed to generate a valid date from Alt RSS format")
		} catch let err {
			XCTAssert(false, "Failed to create a region from Alt RSS format: \(err)")
		}
	}
	
	func testDateInRegionInit_AltRSSWithTimezone() {
		let customString = "09 Sep 2011 15:26:08 -0400"
		do {
			let dateInUTC = try DateInRegion(string: customString, format: .rss(alt: true), fromRegion: Region.GMT())
			let dateUTCAsString = dateInUTC.string(format: .iso8601(options: .withInternetDateTime))
			XCTAssertEqual("2011-09-09T19:26:08Z", dateUTCAsString, "Failed to generate a valid date from Alt RSS format")
		} catch let err {
			XCTAssert(false, "Failed to create a region from Alt RSS format: \(err)")
		}
	}

	
	func testDateInRegionInit_FromRSSWithZ() {
		let customString = "Fri, 09 Sep 2011 15:26:08 Z"
		do {
			let dateInUTC = try DateInRegion(string: customString, format: .rss(alt: false), fromRegion: Region.GMT())
			let dateUTCAsString = dateInUTC.string(format: .iso8601(options: .withInternetDateTime))
			XCTAssertEqual("2011-09-09T15:26:08Z", dateUTCAsString, "Failed to generate a valid date from Alt RSS format")
		} catch let err {
			XCTAssert(false, "Failed to create a region from RSS format: \(err)")
		}
	}
	
	func testDateInRegionInit_FromRSSWithTimezone() {
		let customString = "Fri, 09 Sep 2011 15:26:08 +0200"
		do {
			let dateInUTC = try DateInRegion(string: customString, format: .rss(alt: false), fromRegion: Region.GMT())
			let dateUTCAsString = dateInUTC.string(format: .iso8601(options: .withInternetDateTime))
			XCTAssertEqual("2011-09-09T13:26:08Z", dateUTCAsString, "Failed to generate a valid date from Alt RSS format")
		} catch let err {
			XCTAssert(false, "Failed to create a region from RSS format: \(err)")
		}
	}
	
	func testDateInRegionInit_FromExtended() {
		let customString = "Fri 09-Sep-2011 AD 15:26:08.123 +0100"
		do {
			let dateInUTC = try DateInRegion(string: customString, format: .extended, fromRegion: Region.GMT())
			let dateUTCAsString = dateInUTC.string(format: .iso8601(options: .withInternetDateTime))
			XCTAssertEqual("2011-09-09T14:26:08Z", dateUTCAsString, "Failed to generate a valid date from Alt RSS format")
		} catch let err {
			XCTAssert(false, "Failed to create a region from extended format: \(err)")
		}
	}
	
	func testDateInRegionInit_ISO8601Fail() {
		let customString = "2015-01-05T22:10:abc"
		do {
			let dateInUTC = try DateInRegion(string: customString, format: .iso8601(options: .withFullTime), fromRegion: Region.GMT())
			XCTAssertNil(dateInUTC, "Parser should fail here")
		} catch {
		}
	}
	
	func testDateInRegion_ISO8601_NoZ() {
		let customString = "2015-01-05T22:10:55+0200"
		do {
			let dateInUTC = try DateInRegion(string: customString, format: .iso8601(options: .withInternetDateTime), fromRegion: Region.GMT())
			let dateUTCAsString = dateInUTC.string(format: .iso8601(options: .withInternetDateTime))
			XCTAssertEqual("2015-01-05T20:10:55Z", dateUTCAsString, "Failed to generate a valid date from Alt RSS format")
		} catch let err {
			XCTAssert(false, "Failed to create a region from ISO8601 format: \(err)")
		}
    }
    
    func testDateInRegion_ISO8601InternetDateTimesExtendedWithZ() {
        let customString = "2016-09-05T04:38:04.746Z"
        do {
            let dateInUTC = try DateInRegion(string: customString, format: .iso8601(options: .withInternetDateTimeExtended), fromRegion: Region.GMT())
            let dateUTCAsString = dateInUTC.string(format: .iso8601(options: .withInternetDateTimeExtended))
            XCTAssertEqual("2016-09-05T04:38:04.746Z", dateUTCAsString, "Failed to generate a valid date from ISO8601 internet date times extended format")
        } catch let err {
            XCTAssert(false, "Failed to create a region from ISO8601 internet date times extended format: \(err)")
        }
    }
    
    func testDateInRegion_ISO8601InternetDateTimesExtendedWithTimezone() {
        let customString = "2016-09-05T04:38:04.746+0200"
        do {
            let dateInUTC = try DateInRegion(string: customString, format: .iso8601(options: .withInternetDateTimeExtended), fromRegion: Region.GMT())
            let dateUTCAsString = dateInUTC.string(format: .iso8601(options: .withInternetDateTimeExtended))
            XCTAssertEqual("2016-09-05T02:38:04.746Z", dateUTCAsString, "Failed to generate a valid date from ISO8601 internet date times extended format")
        } catch let err {
            XCTAssert(false, "Failed to create a region from ISO8601 internet date times extended format: \(err)")
        }
    }
    
    func testDateInRegion_ConversionToRegion() {
        do {
			let sourceRegion_Rome = Region(tz: TimeZoneName.europeRome, cal: CalendarName.gregorian, loc: LocaleName.current)
			let destRegion_NY = Region(tz: TimeZoneName.americaNewYork, cal: CalendarName.gregorian, loc: LocaleName.current)
			
			let cmpDict: [Calendar.Component : Int] = [.year: 2016, .month: 9, .day: 14, .hour: 7]
			
			let srcDateInRegion = try DateInRegion(components: cmpDict, fromRegion: sourceRegion_Rome)
			let dstDateInRegion = srcDateInRegion.toRegion(destRegion_NY)
		
			let dstDateString = dstDateInRegion.string(format: .iso8601(options: .withInternetDateTime))
			print(dstDateString)
			XCTAssertEqual("2016-09-14T01:00:00-04:00", dstDateString, "Failed to convert a date from a region to another")
		} catch let err {
			XCTAssert(false, "Failed to convert a date from a region to another: \(err)")
		}

	}
}
