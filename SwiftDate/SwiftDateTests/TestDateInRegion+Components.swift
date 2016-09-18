//
//  TestDateInRegion+Components.swift
//  SwiftDate
//
//  Created by Daniele Margutti on 16/09/16.
//  Copyright © 2016 Daniele Margutti. All rights reserved.
//

import Foundation

import XCTest
@testable import SwiftDate


class TestDateInRegion_Components: XCTestCase {
	
	let newYork = Region(tz: TimeZones.americaNewYork, cal: Calendars.gregorian, loc: Locales.englishUnitedStates)
	let rome = Region(tz: TimeZones.europeRome, cal: Calendars.gregorian, loc: Locales.italianItaly)
	let amsterdam = Region(tz: TimeZones.europeAmsterdam, cal: Calendars.gregorian, loc: Locales.dutchNetherlands)
	let utc = Region(tz: TimeZones.gmt, cal: Calendars.gregorian, loc: Locales.english)
	
	override func setUp() {
		super.setUp()

	}
	
	override func tearDown() {
		// Put teardown code here. This method is called after the invocation of each test method in the class.
		super.tearDown()
	}

	func testDifferentRegionComponents_YMD() {
		let c: [Calendar.Component : Int] = [.year: 2002, .month: 3, .hour: 5, .day: 4, .minute: 6, .second: 7, .nanosecond: 87654321]
		
		let date = try! DateInRegion(components: c, fromRegion: nil)
		
		XCTAssertEqual(date.era, 1, "Failed get correct era")
		XCTAssertEqual(date.year, 2002, "Failed get correct year")
		XCTAssertEqual(date.month, 3, "Failed get correct month")
		XCTAssertEqual(date.day, 4, "Failed get correct day")
		XCTAssertEqual(date.hour, 5, "Failed get correct hour")
		XCTAssertEqual(date.minute, 6, "Failed get correct minute")
		XCTAssertEqual(date.second, 7, "Failed get correct second")
		if date.nanosecond < 87654321-10 || date.nanosecond > 87654321+10 {
			XCTAssert(false, "Failed to get correct nanosecond")
		}
	}
	
	func testDifferentRegionComponents_YWD() {
		let c: [Calendar.Component : Int] = [.era: 1, .yearForWeekOfYear: 2, .weekOfYear: 3, .weekday: 4]
		let date = try! DateInRegion(components: c, fromRegion: nil)

		XCTAssertEqual(date.era, 1, "Failed get correct era")
		XCTAssertEqual(date.yearForWeekOfYear, 2, "Failed get correct yearForWeekOfYear")
		XCTAssertEqual(date.weekOfYear, 3, "Failed get correct weekOfYear")
		XCTAssertEqual(date.weekday, 4, "Failed get correctweekday")
		XCTAssertEqual(date.hour, 0, "Failed get correct hour")
		XCTAssertEqual(date.minute, 0, "Failed get correct minute")
		XCTAssertEqual(date.second, 0, "Failed get correct second")
		XCTAssertEqual(date.nanosecond, 0, "Failed get correct nanosecond")
	}
	
	func testDifferentRegionComponents_Midnight() {
		// should return a midnight date with nil YMD initialisation in various regions
		[rome,newYork,amsterdam,utc].forEach { region in
			let date = try! DateInRegion(components: [.year: 1912, .month: 6, .day: 23, .hour: 0, .minute: 0, .second: 0], fromRegion: region)
			XCTAssertEqual(date.year, 1912, "Failed get correct year")
			XCTAssertEqual(date.month, 6, "Failed get correct month")
			XCTAssertEqual(date.day, 23, "Failed get correct day")
			XCTAssertEqual(date.hour, 0, "Failed get correct hour")
			XCTAssertEqual(date.minute, 0, "Failed get correct minute")
			XCTAssertEqual(date.region, region, "Failed get correct second")
		}
	}
	
	func test_MidnightWithNilYMDInit() {
		// should return a midnight date with nil YMD initialisation
		let localDate = try! DateInRegion(components: [.year: 1912, .month: 6, .day: 23], fromRegion: nil)
		XCTAssertEqual(localDate.year, 1912, "Failed get correct year")
		XCTAssertEqual(localDate.month, 6, "Failed get correct month")
		XCTAssertEqual(localDate.day, 23, "Failed get correct day")
		XCTAssertEqual(localDate.hour, 0, "Failed get correct hour")
		XCTAssertEqual(localDate.minute, 0, "Failed get correct minute")
	}
	
	func test_123DateForYMDInit() {
		// should return a 123 date for YMD initialisation
		let localDate = try! DateInRegion(components: [.year: 1999, .month: 12, .day: 31], fromRegion: nil)
		XCTAssertEqual(localDate.year, 1999, "Failed get correct year")
		XCTAssertEqual(localDate.month, 12, "Failed get correct month")
		XCTAssertEqual(localDate.day, 31, "Failed get correct day")
	}
	
	func test_yearShiftBetweenRegions() {
		let romeRegion = Region(tz: TimeZones.europeRome, cal: Calendars.gregorian, loc: Locales.current)
		let romeDate = try! DateInRegion(components: [.year: 2000, .month: 1, .day: 1, .hour: 0, .minute: 0, .second: 0], fromRegion: romeRegion)
		
		let gmtRegion = Region.GMT()
		let gmtDate = romeDate.toRegion(gmtRegion)
		
		XCTAssertEqual(gmtDate.year, 1999, "Failed get correct year")
		XCTAssertEqual(gmtDate.month, 12, "Failed get correct month")
		XCTAssertEqual(gmtDate.day, 31, "Failed get correct day")
		XCTAssertEqual(gmtDate.hour, 23, "Failed get correct day")
	}
	
	func test_123DateForYWDInit() {
		let localDate = try! DateInRegion(components: [.year: 1999, .month: 12, .day: 31])
		XCTAssertEqual(localDate.year, 1999, "Failed get correct year")
		XCTAssertEqual(localDate.month, 12, "Failed get correct month")
		XCTAssertEqual(localDate.day, 31, "Failed get correct day")
	}
	
	func test_123DateForYWDInit_2() {
		let localDate = try! DateInRegion(components: [.year: 2016, .weekOfYear: 1, .weekday: 1])
		XCTAssertEqual(localDate.yearForWeekOfYear, 2016, "Failed get correct yearForWeekOfYear")
		XCTAssertEqual(localDate.weekOfYear, 1, "Failed get correct weekOfYear")
		XCTAssertEqual(localDate.weekday, 1, "Failed get correct weekday")
	}
	
	func test_zeroInitIndefaultRegion() {
		let components = DateComponents()
		let zeroDate = try! DateInRegion(components: components)
		
		XCTAssertEqual(zeroDate.year, 1, "Failed get correct year")
		XCTAssertEqual(zeroDate.month, 1, "Failed get correct month")
		XCTAssertEqual(zeroDate.day, 1, "Failed get correct day")
		XCTAssertEqual(zeroDate.hour, 1, "Failed get correct hour")
		XCTAssertEqual(zeroDate.minute, 1, "Failed get correct minute")
		XCTAssertEqual(zeroDate.second, 1, "Failed get correct second")
		XCTAssertEqual(zeroDate.nanosecond, 1, "Failed get correct nanosecond")
	}
}
