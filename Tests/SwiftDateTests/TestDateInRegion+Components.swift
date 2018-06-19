//
//  TestDateInRegion+Components.swift
//  SwiftDate
//
//  Created by Daniele Margutti on 19/06/2018.
//  Copyright © 2018 SwiftDate. All rights reserved.
//

import SwiftDate
import XCTest

class TestDateInRegion_Components: XCTestCase {

	func testDateInRegion_Components() {
		let regionLondon = Region(calendar: Calendars.gregorian, zone: Zones.europeLondon, locale: Locales.italian)
		let dateFormat = "yyyy-MM-dd HH:mm:ss"

		// TEST #1: Date In Italian
		let dateA = DateInRegion("2018-02-05 23:14:45", format: dateFormat, region: regionLondon)!
		XCTValidateDateComponents(date: dateA, expec: ExpectedDateComponents {
			$0.year = 2018
			$0.month = 2
			$0.day = 5
			$0.hour = 23
			$0.minute = 14
			$0.second = 45
			$0.monthNameDefault = "febbraio"
			$0.monthNameDefaultStd = "febbraio"
			$0.monthNameShort = "feb"
			$0.monthNameStandaloneShort = "feb"
			$0.msInDay = 83_686_000
			$0.weekday = 2
			$0.weekdayNameShort = "lun"
			$0.weekdayNameVeryShort = "L"
			$0.weekOfMonth = 2
			$0.eraNameShort = "a.C."
			$0.weekdayOrdinal = 1
			$0.nearestHour = 23
			$0.firstDayOfWeek = 4
			$0.lastDayOfWeek = 10
			$0.yearForWeekOfYear = 2018
			$0.quarter = 0
		})

		// TEST #1: Date In French
		let regionParis = Region(calendar: Calendars.gregorian, zone: Zones.europeParis, locale: Locales.french)
		let dateB = DateInRegion("2018-02-05 23:14:45", format: dateFormat, region: regionParis)!
		XCTValidateDateComponents(date: dateB, expec: ExpectedDateComponents {
			$0.monthNameDefault = "février"
			$0.monthNameShort = "févr."
			$0.eraNameShort = "av. J.-C."
			$0.weekdayNameDefault = "lundi"
		})

		// TEST #3: Other components
		XCTAssert( (dateB.region == regionParis), "Failed to assign correct region to date")
		XCTAssert( (dateB.calendar.identifier == regionParis.calendar.identifier), "Failed to assign correct region's calendar to date")
		XCTAssert( (dateB.quarterName(.default) == "1er trimestre"), "Failed to get quarterName in default")
		XCTAssert( (dateB.quarterName(.short) == "T1"), "Failed to get quarterName in short")
	}

	func testDateInRegion_isLeapMonth() {
		let regionRome = Region(calendar: Calendars.gregorian, zone: Zones.europeRome, locale: Locales.italian)
		let dateFormat = "yyyy-MM-dd HH:mm:ss"

		let dateA = DateInRegion("2018-02-05 00:00:00", format: dateFormat, region: regionRome)!
		let dateB = DateInRegion("2016-02-22 00:00:00", format: dateFormat, region: regionRome)!
		let dateC = DateInRegion("2017-12-10 00:00:00", format: dateFormat, region: regionRome)!
		XCTAssert( dateA.isLeapMonth == false, "Failed to evaluate is date isLeapMonth == false")
		XCTAssert( dateC.isLeapMonth == false, "Failed to evaluate is date isLeapMonth == false")
		XCTAssert( dateB.isLeapMonth, "Failed to evaluate is date isLeapMonth")
	}

	func testDateInRegion_isLeapYear() {
		let regionRome = Region(calendar: Calendars.gregorian, zone: Zones.europeRome, locale: Locales.italian)
		let dateFormat = "yyyy-MM-dd HH:mm:ss"

		let dateA = DateInRegion("2018-04-05 00:00:00", format: dateFormat, region: regionRome)!
		let dateB = DateInRegion("2016-07-22 00:00:00", format: dateFormat, region: regionRome)!
		let dateC = DateInRegion("2017-12-10 00:00:00", format: dateFormat, region: regionRome)!
		XCTAssert( dateA.isLeapYear == false, "Failed to evaluate is date isLeapYear == false")
		XCTAssert( dateC.isLeapYear == false, "Failed to evaluate is date isLeapYear == false")
		XCTAssert( dateB.isLeapYear, "Failed to evaluate is date isLeapYear")
	}

	func testDateInRegion_julianDayAndModifiedJulianDay() {

	}

	func testDateInRegion_getIntervalForComponentBetweenDates() {
		let regionRome = Region(calendar: Calendars.gregorian, zone: Zones.europeRome, locale: Locales.italian)
		let dateFormat = "yyyy-MM-dd HH:mm:ss"

		let dateA = DateInRegion("2017-07-22 00:00:00", format: dateFormat, region: regionRome)!
		let dateB = DateInRegion("2017-07-23 12:00:00", format: dateFormat, region: regionRome)!
		let dateC = DateInRegion("2017-09-23 12:00:00", format: dateFormat, region: regionRome)!
		let dateD = DateInRegion("2017-09-23 12:54:00", format: dateFormat, region: regionRome)!

		XCTAssert( (dateA.getInterval(toDate: dateB, component: .hour) == 36), "Failed to evaluate is hours interval")
		XCTAssert( (dateA.getInterval(toDate: dateB, component: .day) == 2), "Failed to evaluate is days interval") // 1 days, 12 hours
		XCTAssert( (dateB.getInterval(toDate: dateC, component: .month) == 2), "Failed to evaluate is months interval")
		XCTAssert( (dateB.getInterval(toDate: dateC, component: .day) == 62), "Failed to evaluate is days interval")
		XCTAssert( (dateB.getInterval(toDate: dateC, component: .year) == 0), "Failed to evaluate is years interval")
		XCTAssert( (dateB.getInterval(toDate: dateC, component: .weekOfYear) == 9), "Failed to evaluate is weeksOfYear interval")
		XCTAssert( (dateC.getInterval(toDate: dateD, component: .minute) == 54), "Failed to evaluate is minutes interval")
		XCTAssert( (dateC.getInterval(toDate: dateD, component: .hour) == 0), "Failed to evaluate is hours interval")
		XCTAssert( (dateA.getInterval(toDate: dateD, component: .minute) == 91494), "Failed to evaluate is minutes interval")
	}

	func testDateInRegion_timeIntervalSince() {
		let regionRome = Region(calendar: Calendars.gregorian, zone: Zones.europeRome, locale: Locales.italian)
		let regionLondon = Region(calendar: Calendars.gregorian, zone: Zones.europeLondon, locale: Locales.english)
		let dateFormat = "yyyy-MM-dd HH:mm:ss"

		let dateA = DateInRegion("2017-07-22 00:00:00", format: dateFormat, region: regionRome)!
		let dateB = DateInRegion("2017-07-22 00:00:00", format: dateFormat, region: regionRome)!
		let dateC = DateInRegion("2017-07-23 13:20:15", format: dateFormat, region: regionLondon)!
		let dateD = DateInRegion("2017-07-23 13:20:20", format: dateFormat, region: regionLondon)!

		XCTAssert( dateA.timeIntervalSince(dateC) == -138015.0, "Failed to evaluate is minutes interval")
		XCTAssert( dateA.timeIntervalSince(dateB) == 0, "Failed to evaluate is minutes interval")
		XCTAssert( dateC.timeIntervalSince(dateD) == -5, "Failed to evaluate is minutes interval")
	}

}
