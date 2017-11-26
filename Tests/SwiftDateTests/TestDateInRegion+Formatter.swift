//
//  TestDateInRegion+Formatter.swift
//  SwiftDate
//
//  Created by Daniele Margutti on 18/09/2016.
//  Copyright © 2016 Daniele Margutti. All rights reserved.
//

import Foundation
import XCTest
@testable import SwiftDate


class TestDateInRegion_Formatter: XCTestCase {
	
	let refDate = DateInRegion(components: [.year: 2015, .month: 12, .day: 14, .hour: 13], fromRegion: Region(tz: TimeZoneName.americaParamaribo, cal: CalendarName.gregorian, loc: LocaleName.dutch))
	
	override func setUp() {
		super.setUp()
	}
	
	override func tearDown() {
		super.tearDown()
	}
	
	public func test_iso8601_milliseconds() {
		// Test milliseconds support of the ISO8601 parser
		let string = "2017-07-16T03:54:37.800Z"
		let date = DateInRegion(
			string: string,
			format: .iso8601(options: .withInternetDateTimeExtended),
			fromRegion: Region.GMT()
		)
		let str = date!.string(format: .iso8601(options: .withInternetDateTimeExtended))
		XCTAssertEqual(str, "2017-07-16T03:54:37.800Z", "Failed to keep correct milliseconds information from ISO8601 datetime")
	}
	
	public func test_toString() {
		let rome = Region(tz: TimeZoneName.europeRome, cal: CalendarName.gregorian, loc: LocaleName.italian)
		guard let testDate = DateInRegion(components: [.year: 2001, .month: 2, .day: 3, .hour: 15, .minute: 30], fromRegion: rome) else {
			XCTFail("Failed to create date from components")
			return
		}

		let iso8601_internetTime = testDate.string(format: .iso8601(options: .withInternetDateTime))
		XCTAssertEqual(iso8601_internetTime, "2001-02-03T15:30:00+01:00", "Failed get string representation as ISO8601 Internet DateTime")

		let iso8601_fullDate = testDate.string(format: .iso8601(options: .withFullDate))
		XCTAssertEqual(iso8601_fullDate, "2001-02-03", "Failed get string representation as ISO8601 Full Date")
		
		let altss = testDate.string(format: .rss(alt: true))
		XCTAssertEqual(altss, "3 feb 2001 15:30:00 +0100", "Failed get string representation as Alt RSS")

		let rss = testDate.string(format: .rss(alt: false))
		XCTAssertEqual(rss, "sab, 3 feb 2001 15:30:00 +0100", "Failed get string representation as RSS")
		
		let custom = testDate.string(custom: "d MMM YY 'at' HH:mm")
		XCTAssertEqual(custom, "3 feb 01 at 15:30", "Failed get string representation as custom #1")

		let custom_2 = testDate.string(custom: "eee d MMM YYYY, m 'minutes after' HH '(timezone is' Z')'")
		XCTAssertEqual(custom_2, "sab 3 feb 2001, 30 minutes after 15 (timezone is +0100)", "Failed get string representation as custom #2")
	}
	
	public func test_toStringWithStyle() {
		let rome = Region(tz: TimeZoneName.europeRome, cal: CalendarName.gregorian, loc: LocaleName.italian)
		guard let testDate = DateInRegion(components: [.year: 2001, .month: 2, .day: 3, .hour: 15, .minute: 30], fromRegion: rome) else {
			XCTFail("Failed to create date from components")
			return
		}

		let custom_1 = testDate.string(dateStyle: .full, timeStyle: .full)
		XCTAssertEqual(custom_1, "sabato 3 febbraio 2001 15:30:00 Ora standard dell’Europa centrale", "Failed get string representation as custom #1")

		let inLondon = testDate.toRegion(Region(tz: TimeZoneName.europeLondon, cal: CalendarName.gregorian, loc: LocaleName.englishUnitedKingdom))
		let custom_2 = inLondon.string(dateStyle: .short, timeStyle: .short)
		XCTAssertEqual(custom_2, "03/02/2001, 14:30", "Failed get string representation as custom #2")
	}
	
	
	public func test_dotNet() {
		let dotnet_dates = ["/Date(641858400000+0200)/","/Date(-31536000000+0200)/","/Date(-1330563600000+0100)/"]

		dotnet_dates.forEach { dotnet_date in
			guard let parsed_date = dotnet_date.date(format: .dotNET) else {
				XCTFail("Cannot parse dotnet string: \(dotnet_date)")
				return
			}
			let output_str = DOTNETDateTimeFormatter.string(parsed_date)
			XCTAssertEqual(dotnet_date, output_str)
		}
	}

	public func test_iso8601_formatter() {
		let rome = Region(tz: TimeZoneName.europeRome, cal: CalendarName.gregorian, loc: LocaleName.italian)
		guard let testDate = DateInRegion(components: [.year: 2001, .month: 2, .day: 3, .hour: 15, .minute: 30], fromRegion: rome) else {
			XCTFail("Failed to create date from components")
			return
		}

		var options: ISO8601DateTimeFormatter.Options = [.withWeekOfYear,.withMonth,.withDashSeparatorInDate]
		let string_1 = testDate.string(format: .iso8601(options: options))
		XCTAssertEqual(string_1, "02-W05", "Failed get ISO8601 #1 representation of the string")
		
		options = [.withInternetDateTime]
		let string_2 = testDate.string(format: .iso8601(options: options))
		XCTAssertEqual(string_2, "2001-02-03T15:30:00+01:00", "Failed get ISO8601 #2 representation of the string")
		
		options = [.withInternetDateTimeExtended]
		let string_3 = testDate.string(format: .iso8601(options: options))
		XCTAssertEqual(string_3, "2001-02-03T15:30:00.000+01:00", "Failed get ISO8601 extended #3 representation of the string")
		
		options = [.withFullDate]
		let string_4 = testDate.string(format: .iso8601(options: options))
		XCTAssertEqual(string_4, "2001-02-03", "Failed get ISO8601 #4 representation of the string")
		
		options = [.withFullDate,.withFullTime]
		let string_5 = testDate.string(format: .iso8601(options: options))
		XCTAssertEqual(string_5, "2001-02-03T15:30:00+01:00", "Failed get ISO8601 #5 representation of the string")
		
		options = [.withDay,.withMonth]
		let string_6 = testDate.string(format: .iso8601(options: options))
		XCTAssertEqual(string_6, "0203", "Failed get ISO8601 #6 representation of the string")
		
		options = [.withWeekOfYear,.withMonth]
		let string_7 = testDate.string(format: .iso8601(options: options))
		XCTAssertEqual(string_7, "02W05", "Failed get ISO8601 #7 representation of the string")
		
		options = [.withYear,.withMonth,.withWeekOfYear]
		let string_8 = testDate.string(format: .iso8601(options: options))
		XCTAssertEqual(string_8, "200102W05", "Failed get ISO8601 #8 representation of the string")
		
		options = [.withYear,.withMonth,.withDay]
		let string_9 = testDate.string(format: .iso8601(options: options))
		XCTAssertEqual(string_9, "20010203", "Failed get ISO8601 #9 representation of the string")
		
		options = [.withYear,.withMonth,.withDay,.withFullTime]
		let string_10 = testDate.string(format: .iso8601(options: options))
		XCTAssertEqual(string_10, "20010203T15:30:00+01:00", "Failed get ISO8601 #10 representation of the string")
		
		options = [.withFullDate,.withTimeZone]
		let string_11 = testDate.string(format: .iso8601(options: options))
		XCTAssertEqual(string_11, "2001-02-03T+01:00", "Failed get ISO8601 #11 representation of the string")
	}
	
	public func test_ISO8601Formatter() {
		
		func validate(_ isoString: String, expected: String) {
			let res = isoString.date(format: .iso8601Auto)?.string(format: .iso8601Auto)
			XCTAssert(res == expected, "Failed ISO8601 parsing: '\(isoString)' should be '\(expected)', not '\(res!)'")
		}
		
		let now = Date()
		let now_cmp = Region.GMT().calendar.dateComponents([.year,.month,.day], from: now)
		validate("060224", expected: "2006-02-24T00:00:00Z")
		validate("06-W22", expected: "2006-05-28T00:00:00Z")
		validate("06-W2", expected: "2006-01-08T00:00:00Z")
		validate("06-W2-1", expected: "2006-01-09T00:00:00Z")
		validate("-6-02-24", expected: "2016-02-24T00:00:00Z")
		validate("-6-12", expected: "2016-12-01T00:00:00Z")
		validate("-6", expected: "2016-01-01T00:00:00Z")
		validate("-6-", expected: "2016-01-01T00:00:00Z")
		validate("-6-02-", expected: "2016-02-01T00:00:00Z")
		validate("-6-W22", expected: "2016-05-30T00:00:00Z")
		validate("-6-W2", expected: "2016-01-11T00:00:00Z")
		validate("-6-W2-1", expected: "2016-01-11T00:00:00Z")
		validate("-6-W2-2", expected: "2016-01-12T00:00:00Z")
		validate("--0224", expected: "\(now_cmp.year!)-02-24T00:00:00Z")
		validate("--2-24", expected: "\(now_cmp.year!)-02-24T00:00:00Z")
		validate("--02-2", expected: "\(now_cmp.year!)-02-02T00:00:00Z")
		validate("--02", expected: "\(now_cmp.year!)-02-01T00:00:00Z")
		validate("---24", expected: now.string(format: .custom("yyyy-MM")) + "-24T00:00:00Z")
		validate("-W2", expected: now.string(format: .custom("yyyy")) + "-01-08T00:00:00Z")
		validate("-W2-2", expected: now.string(format: .custom("yyyy")) + "-01-10T00:00:00Z")
		validate("-W-3", expected: now.string(format: .custom("yyyy")) + "-01-04T00:00:00Z")
		validate("--W-3", expected: now.string(format: .custom("yyyy")) + "-01-04T00:00:00Z")
		validate("2006-001", expected: "2006-01-01T00:00:00Z")
		validate("2006-002", expected: "2006-01-02T00:00:00Z")
		validate("2006-032", expected: "2006-02-01T00:00:00Z")
		validate("2006-055", expected: "2006-02-24T00:00:00Z")
		validate("2006-365", expected: "2006-12-31T00:00:00Z")
		validate("2004-001", expected: "2004-01-01T00:00:00Z")
		validate("2004-366", expected: "2004-12-31T00:00:00Z")
		validate("-055", expected: now.string(format: .custom("yyyy"))+"-02-24T00:00:00Z")
		validate("--055", expected: now.string(format: .custom("yyyy"))+"-02-24T00:00:00Z")
		validate("2006T", expected: "2006-01-01T00:00:00Z")
		validate("T22:63:24+50:70", expected: now.string(format: .custom("yyyy-MM-dd")) + "T23:03:24Z")
		validate("T22:1:2", expected: now.string(format: .custom("yyyy-MM-dd")) + "T22:01:02Z")
		validate("T22:1Z", expected: now.string(format: .custom("yyyy-MM-dd")) + "T22:01:00Z")
		validate("T22", expected: now.string(format: .custom("yyyy-MM-dd")) + "T22:00:00Z")
		validate("T2", expected: now.string(format: .custom("yyyy-MM-dd")) + "T02:00:00Z")
		validate("T2:2:2", expected: now.string(format: .custom("yyyy-MM-dd")) + "T02:02:02Z")
		validate("2006-02-24T02:43:24", expected: "2006-02-24T02:43:24Z")
		validate("2006-02-24T22:63:24", expected: "2006-02-24T23:03:24Z")
		validate("2006-12T12:34", expected: "2006-12-01T12:34:00Z")
		validate("2006T22", expected: "2006-01-01T22:00:00Z")
		validate("2006-02-24T22:63:24Z", expected: "2006-02-24T23:03:24Z")
		validate("2006-02-24T22:63:24-1", expected: "2006-02-24T23:03:24-01:00")
		validate("2006-02-24T22:63:24-01", expected: "2006-02-24T23:03:24-01:00")
		validate("2006-02-24T22:63:24-01:32", expected: "2006-02-24T23:03:24-01:32")
		validate("2006-02-24T22:63:24-01:0", expected: "2006-02-24T23:03:24-01:00")
		validate("2006-02-24T22:63:24-01:00", expected: "2006-02-24T23:03:24-01:00")
		validate("2009-12T12:34", expected: "2009-12-01T12:34:00Z")
		validate("2009", expected: "2009-01-01T00:00:00Z")
		validate("2009-05-19", expected: "2009-05-19T00:00:00Z")
		validate("20090519", expected: "2009-05-19T00:00:00Z")
		validate("2009123", expected: "2009-05-03T00:00:00Z")
		validate("2009-05", expected: "2009-05-01T00:00:00Z")
		validate("2009-123", expected: "2009-05-03T00:00:00Z")
		validate("2009-222", expected: "2009-08-10T00:00:00Z")
		validate("2009-001", expected: "2009-01-01T00:00:00Z")
		validate("2009-W01-1", expected: "2008-12-29T00:00:00Z")
		validate("2009-W511", expected: "2009-12-14T00:00:00Z")
		validate("2009-W33", expected: "2009-08-09T00:00:00Z")
		validate("2009W511", expected: "2009-12-14T00:00:00Z")
		validate("2009-05-19 00:00", expected: "2009-05-19T00:00:00Z")
		validate("2009-05-19 14", expected: "2009-05-19T14:00:00Z")
		validate("2009-05-19 14:31", expected: "2009-05-19T14:31:00Z")
		validate("2009-05-19 14:39:22", expected: "2009-05-19T14:39:22Z")
		validate("2009-W21-2", expected: "2009-05-19T00:00:00Z")
		validate("2009-W21-2T01:22", expected: "2009-05-19T01:22:00Z")
		validate("2009-139", expected: "2009-05-19T00:00:00Z")
		validate("2009-05-19 14:39:22-06:00", expected: "2009-05-19T14:39:22-06:00")
		validate("2009-05-19 14:39:22+0600", expected: "2009-05-19T14:39:22+06:00")
		validate("2009-05-19 14:39:22-01", expected: "2009-05-19T14:39:22-01:00")
		validate("20090621T0545Z", expected: "2009-06-21T05:45:00Z")
		validate("2007-04-06T00:00", expected: "2007-04-06T00:00:00Z")
		validate("2007-04-05T24:00", expected: "2007-04-06T00:00:00Z")
		validate("2010-02-18T16:23:48.5", expected: "2010-02-18T16:23:48Z")
		validate("2010-02-18T16:23:48,444", expected: "2010-02-18T16:23:48Z")
		validate("2010-02-18T16:23:48,3-06:00", expected: "2010-02-18T16:23:48-06:00")
		validate("2010-02-18T16:23.4", expected: "2010-02-18T16:23:23Z")
		validate("2010-02-18T16.23334444", expected: "2010-02-18T16:00:00Z")
		validate("2009-05-19 1439,55", expected: "2009-05-19T14:39:00Z")
		validate("09:00:00", expected: now.string(format: .custom("yyyy-MM-dd")) + "T09:00:00Z")
	}
	
	func test_fallbackFromColloquialToTimeComponents() {
		let date = DateInRegion() - 1.hour
		let abbreviated_string = try! date.colloquialSinceNow(style: .abbreviated)
		XCTAssertEqual(abbreviated_string.colloquial, "1h", "Failed get colloquial string in abbreviated form")
	}
	
	func _executeDateTest(dateA: String, dateB: String, options: ColloquialDateFormatter.Options, expected: String) {
		let dFormat = DateFormat.custom("dd-MM-yyyy HH:mm:ss")
		let date_a = DateInRegion(string: dateA, format: dFormat, fromRegion: Region.GMT())!
		let date_b = DateInRegion(string: dateB, format: dFormat, fromRegion: Region.GMT())!
		let colloquial = date_a.colloquial(toDate: date_b, options: options)
		print("colloquial= '\(colloquial!)', expected= '\(expected)'")
		XCTAssert(colloquial == expected, "Failed to get colloquial for dates: \(dateA) - \(dateB). Got '\(colloquial ?? "<nil>")', expected '\(expected)'")
	}
	
    func test_colloquial() {
		var options = ColloquialDateFormatter.Options()
		options.locale = Localization(locale: LocaleName.english)
		options.imminentRange = 7.minutes // < 7 minutes is imminent
        
        func testDates(dateA: DateInRegion, dateB: DateInRegion, expected: String) {
			let colloquial = dateA.colloquial(toDate: dateB, options: options)
            XCTAssert(colloquial == expected, "Failed to get colloquial for dates: \(dateA) - \(dateB). Got '\(colloquial ?? "<nil>")', expected '\(expected)'")
        }
		
        _executeDateTest(dateA: "02-02-2017 22:00:00", dateB: "02-02-2017 22:54:00", options: options, expected: "54 minutes ago")
        _executeDateTest(dateA: "02-02-2017 22:00:00", dateB: "02-03-2017 01:00:00", options: options, expected: "3 weeks ago")
		
		options.imminentRange = nil
		_executeDateTest(dateA: "02-02-2017 22:00:05", dateB: "02-02-2017 22:04:45", options: options, expected: "4 minutes ago")
		
		options.imminentRange = 7.minutes
      	_executeDateTest(dateA: "02-02-2017 22:00:00", dateB: "02-02-2017 22:00:15", options: options, expected: "just now")
       	_executeDateTest(dateA: "02-02-2017 22:00:00", dateB: "02-02-2017 22:06:59", options: options, expected: "just now")
      	_executeDateTest(dateA: "02-02-2017 22:00:00", dateB: "02-02-2017 22:07:02", options: options, expected: "7 minutes ago")
       	_executeDateTest(dateA: "01-11-2017 00:00:00", dateB: "26-11-2017 00:00:00", options: options, expected: "3 weeks ago")
       	_executeDateTest(dateA: "01-11-2017 00:00:00", dateB: "26-11-2019 00:00:00", options: options, expected: "2017")
       	_executeDateTest(dateA: "01-11-2017 00:00:00", dateB: "01-11-2017 00:00:00", options: options, expected: "just now")
		_executeDateTest(dateA: "01-11-2017 00:00:00", dateB: "01-11-2017 00:00:00", options: options, expected: "just now")
		_executeDateTest(dateA: "01-01-2017 23:00:00", dateB: "02-01-2017 01:00:00", options: options, expected: "yesterday")
		_executeDateTest(dateA: "02-01-2017 02:00:00", dateB: "01-01-2017 23:59:00", options: options, expected: "tomorrow")
		_executeDateTest(dateA: "02-01-2017 20:00:00", dateB: "02-01-2017 23:59:00", options: options, expected: "3 hours ago")
		
		let now_date = DateInRegion()
		testDates(dateA: (now_date - 47.hours), dateB: now_date, expected: "yesterday")
		
        // Disable weeks components and get the days instead of weeks
        options.allowedComponents = [.day]
		_executeDateTest(dateA: "01-11-2017 00:00:00", dateB: "26-11-2017 00:00:00", options: options, expected: "25 days ago")
		
		// Disable hour components and get the minutes instead of hours
		options.allowedComponents = [.minute]
        _executeDateTest(dateA: "01-11-2017 00:20:00", dateB: "01-11-2017 01:20:00", options: options, expected: "60 minutes ago")

	}
	
	func test_colloquial_2() {
		var opts = ColloquialDateFormatter.Options()
		opts.distantRange = 2.hour
		
		_executeDateTest(dateA: "01-01-2017 20:00:00", dateB: "01-01-2017 21:00:00", options: opts, expected: "one hour ago")
		_executeDateTest(dateA: "01-01-2017 20:00:00", dateB: "01-01-2017 22:05:00", options: opts, expected: "22:05")

		opts.distantRange = 2.days
		_executeDateTest(dateA: "02-01-2017 20:00:00", dateB: "01-01-2017 22:05:00", options: opts, expected: "tomorrow")
		_executeDateTest(dateA: "03-01-2017 00:00:00", dateB: "01-01-2017 00:00:00", options: opts, expected: "01/01")

		opts.distantRange = 20.days
		_executeDateTest(dateA: "01-01-2017 00:00:00", dateB: "19-01-2017 00:00:00", options: opts, expected: "2 weeks ago")
		_executeDateTest(dateA: "01-01-2017 00:00:00", dateB: "22-01-2017 00:00:00", options: opts, expected: "01/22")
	}
	
}
