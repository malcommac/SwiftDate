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
	
	let refDate = try! DateInRegion(components: [.year: 2015, .month: 12, .day: 14, .hour: 13], fromRegion: Region(tz: TimeZones.americaParamaribo, cal: Calendars.gregorian, loc: Locales.dutch))
	
	override func setUp() {
		super.setUp()
	}
	
	override func tearDown() {
		super.tearDown()
	}
	
	public func test_toString() {
		let rome = Region(tz: TimeZones.europeRome, cal: Calendars.gregorian, loc: Locales.italian)
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
		let rome = Region(tz: TimeZones.europeRome, cal: Calendars.gregorian, loc: Locales.italian)
		let testDate = try! DateInRegion(components: [.year: 2001, .month: 2, .day: 3, .hour: 15, .minute: 30], fromRegion: rome)

		let custom_1 = testDate.string(dateStyle: .full, timeStyle: .full)
		XCTAssertEqual(custom_1, "sabato 3 febbraio 2001 15:30:00 Ora standard dell’Europa centrale", "Failed get string representation as custom #1")

		let inLondon = testDate.toRegion(Region(tz: TimeZones.europeLondon, cal: Calendars.gregorian, loc: Locales.englishUnitedKingdom))
		let custom_2 = inLondon.string(dateStyle: .short, timeStyle: .short)
		XCTAssertEqual(custom_2, "03/02/2001, 14:30", "Failed get string representation as custom #2")
	}
	
	public func test_toColloquialString() {
		let rome = Region(tz: TimeZones.europeRome, cal: Calendars.gregorian, loc: Locales.italian)
	
		let testDate = try! DateInRegion(components: [.year: 2001, .month: 2, .day: 3, .hour: 15, .minute: 30], fromRegion: rome)
		let custom_1 = try! testDate.colloquialSinceNow().date
		XCTAssertEqual(custom_1, "2001", "Failed get colloquial representation of an old date")
		
		let oneHourAgo = DateInRegion() - 1.hours
		let custom_3 = try! oneHourAgo.colloquialSinceNow(unitStyle: .positional).date
		XCTAssertEqual(custom_3, "one hour ago", "Failed get colloquial representation of an old date")
		
		let oneHourAgo_IT = DateInRegion(absoluteDate: Date(), in: rome) - 1.hours
		let custom_4 = try! oneHourAgo_IT.colloquialSinceNow(unitStyle: .positional).date
		XCTAssertEqual(custom_4, "un'ora fa", "Failed get colloquial representation of an old date")
		
		let another_Date = DateInRegion(absoluteDate: Date(), in: rome) - 2.hours - 5.minutes - 3.seconds
		let custom_5 = try! another_Date.timeComponentsSinceNow()
		XCTAssertEqual(custom_5, "2 hr,5 min,3 sec", "Failed get colloquial representation of an old date")
	}
	
}
