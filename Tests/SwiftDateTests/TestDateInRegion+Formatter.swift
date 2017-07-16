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
	
	public func test_toColloquialString() {
		let rome = Region(tz: TimeZoneName.europeRome, cal: CalendarName.gregorian, loc: LocaleName.italian)
        let id = Region(tz: TimeZoneName.asiaBangkok,
                        cal: CalendarName.gregorian, loc: LocaleName.indonesian)
	
		guard let testDate = DateInRegion(components: [.year: 2001, .month: 2, .day: 3, .hour: 15, .minute: 30], fromRegion: rome) else {
			XCTFail("Failed to create date from components")
			return
		}
		let (custom_1,_) = try! testDate.colloquialSinceNow()
		XCTAssertEqual(custom_1, "2001", "Failed get colloquial representation of an old date")
		
		let mins12Ago = DateInRegion() - 12.minutes
		let (custom_2,_) = try! mins12Ago.colloquialSinceNow()
		XCTAssertEqual(custom_2, "12 minutes ago", "Failed get colloquial representation of an old date")
		
		let oneHourAgo = DateInRegion() - 1.hour
		let (custom_3,_) = try! oneHourAgo.colloquialSinceNow()
		XCTAssertEqual(custom_3, "one hour ago", "Failed get colloquial representation of an old date")
		
		let oneHourAgo_IT = DateInRegion(absoluteDate: Date(), in: rome) - 1.hour
		let (custom_4,_) = try! oneHourAgo_IT.colloquialSinceNow()
		XCTAssertEqual(custom_4, "un'ora fa", "Failed get colloquial representation of an old date")
        
        let oneHourAgo_ID = DateInRegion(absoluteDate: Date(), in: id) - 1.hour
        let (custom_6,_) = try! oneHourAgo_ID.colloquialSinceNow()
        XCTAssertEqual(custom_6, "1 jam yang lalu", "Failed get colloquial representation of an old date")
		
        let another_Date = DateInRegion(absoluteDate: Date()) - 2.hours - 5.minutes - 3.seconds
        var componentFormatterOptions = ComponentsFormatterOptions()
        componentFormatterOptions.style = .short
        componentFormatterOptions.zeroBehavior = .dropAll
        let custom_5 = try! another_Date.timeComponentsSinceNow(options: componentFormatterOptions)
		XCTAssertEqual(custom_5, "2 hr, 5 min, 3 sec", "Failed get colloquial representation of an old date")
		
		let (custom_7,_) = try! (DateInRegion() - 1.year).colloquialSinceNow()
		XCTAssertEqual(custom_7, "last year", "Failed get colloquial representation of an old date")
		
		// 3 Days Ago difference
		let days_3ago = DateInRegion() - 3.day
		let days_3ago_colloquial = (try! days_3ago.colloquialSinceNow().colloquial)
		XCTAssertEqual(days_3ago_colloquial, "3 days ago")
		
		// Less than 48 days difference => yesterday

		let ref_date = DateInRegion(string: "2000-01-02 18:00:00", format: .custom("yyyy-MM-dd HH:mm:SS"))!
		
		let hours_27ago = ref_date - 27.hours
		let hours_27ago_colloquial = (try! hours_27ago.colloquial(toDate: ref_date).colloquial)
		XCTAssertEqual(hours_27ago_colloquial, "yesterday")
	
		
		let hours_49 = ref_date - 49.hours
		let hours_49ago_colloquial = (try! hours_49.colloquial(toDate: ref_date).colloquial)
		XCTAssertEqual(hours_49ago_colloquial, "2 days ago")
		
		// Few hours between two days
		let few_d1 = DateInRegion(string: "2000-01-02 23:00:00", format: .custom("yyyy-MM-dd HH:mm:SS"))!
		let few_d2 = DateInRegion(string: "2000-01-03 01:00:00", format: .custom("yyyy-MM-dd HH:mm:SS"))!
		let few_colloquial = try! few_d1.colloquial(toDate: few_d2)
		XCTAssertEqual(few_colloquial.colloquial, "2 hours ago")
		
		let to = Date()
		let from = Date(timeIntervalSince1970: to.timeIntervalSince1970 - 47 * 60 * 60)
		
		// 47 hours ago
		let fromDate = DateInRegion(absoluteDate: from, in: nil)
		let toDate = DateInRegion(absoluteDate: to, in: fromDate.region)
		let formatter = DateInRegionFormatter()
		formatter.localization = Localization(locale: fromDate.region.locale)
		formatter.imminentInterval = 1
		let result = try! formatter.colloquial(from: fromDate, to: toDate).colloquial
		XCTAssertEqual(result, "yesterday")

		// 4 Days Ago
		let days_4ago_d1 = DateInRegion(string: "2000-04-20 00:00:00", format: .custom("yyyy-MM-dd HH:mm:SS"))!
		let days_4ago_d2 = DateInRegion(string: "2000-04-24 00:00:00", format: .custom("yyyy-MM-dd HH:mm:SS"))!
		let days_4ago_d1_colloquial = try! days_4ago_d1.colloquial(toDate: days_4ago_d2).colloquial
		XCTAssertEqual(days_4ago_d1_colloquial, "4 days ago")
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
	
}
