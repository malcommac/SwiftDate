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
	
	let refDate = try! DateInRegion(components: [.year: 2015, .month: 12, .day: 14, .hour: 13], fromRegion: Region(tz: TimeZoneName.americaParamaribo, cal: CalendarName.gregorian, loc: LocaleName.dutch))
	
	override func setUp() {
		super.setUp()
	}
	
	override func tearDown() {
		super.tearDown()
	}
	
	public func test_toString() {
		let rome = Region(tz: TimeZoneName.europeRome, cal: CalendarName.gregorian, loc: LocaleName.italian)
		let testDate = try! DateInRegion(components: [.year: 2001, .month: 2, .day: 3, .hour: 15, .minute: 30], fromRegion: rome)

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
		let testDate = try! DateInRegion(components: [.year: 2001, .month: 2, .day: 3, .hour: 15, .minute: 30], fromRegion: rome)

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
	
		let testDate = try! DateInRegion(components: [.year: 2001, .month: 2, .day: 3, .hour: 15, .minute: 30], fromRegion: rome)
		let (custom_1,_) = try! testDate.colloquialSinceNow()
		XCTAssertEqual(custom_1, "2001", "Failed get colloquial representation of an old date")
		
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
		XCTAssertEqual(custom_5, "2 hr,5 min,3 sec", "Failed get colloquial representation of an old date")
	}

	public func test_iso8601_formatter() {
		let rome = Region(tz: TimeZoneName.europeRome, cal: CalendarName.gregorian, loc: LocaleName.italian)
		let testDate = try! DateInRegion(components: [.year: 2001, .month: 2, .day: 3, .hour: 15, .minute: 30], fromRegion: rome)

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
}
