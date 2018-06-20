//
//  TestDateInRegion+Create.swift
//  SwiftDate
//
//  Created by Daniele Margutti on 17/06/2018.
//  Copyright © 2018 SwiftDate. All rights reserved.
//

import SwiftDate
import XCTest

class TestDateInRegion_Create: XCTestCase {

	func testDateInRegion_RandomDates() {
		let regionRome = Region(calendar: Calendars.gregorian, zone: Zones.europeRome, locale: Locales.italian)
		let upperLimit = DateInRegion("2015-01-01 00:00:00", format: "yyyy-MM-dd HH:mm:ss", region: regionRome)!
		let lowerLimit = DateInRegion("2010-01-01 00:00:00", format: "yyyy-MM-dd HH:mm:ss", region: regionRome)!

		let randomDates = DateInRegion.randomDates(count: 50, between: lowerLimit, and: upperLimit, region: regionRome)
		randomDates.forEach {
			guard $0.isInRange(date: lowerLimit, and: upperLimit) else {
				XCTFail("Random date '\($0.description)' is not in given range")
				return
			}
		}
	}

	func testDateInRegion_EnumareDates() {
		let regionRome = Region(calendar: Calendars.gregorian, zone: Zones.europeRome, locale: Locales.italian)

		// TEST DATE #1
		// +1 days
		let fromDate1 = DateInRegion("2015-01-01 00:00:00", format: "yyyy-MM-dd HH:mm:ss", region: regionRome)!
		let toDate1 = DateInRegion("2015-01-02 03:00:00", format: "yyyy-MM-dd HH:mm:ss", region: regionRome)!

		let increment1 = DateComponents.create {
			$0.hour = 1
		}
		let enumeratedDates1 = DateInRegion.enumerateDates(from: fromDate1, to: toDate1, increment: increment1)
		let expectedDates1 = [
			"2015-01-01 00:00:00",
			"2015-01-01 01:00:00",
			"2015-01-01 02:00:00",
			"2015-01-01 03:00:00",
			"2015-01-01 04:00:00",
			"2015-01-01 05:00:00",
			"2015-01-01 06:00:00",
			"2015-01-01 07:00:00",
			"2015-01-01 08:00:00",
			"2015-01-01 09:00:00",
			"2015-01-01 10:00:00",
			"2015-01-01 11:00:00",
			"2015-01-01 12:00:00",
			"2015-01-01 13:00:00",
			"2015-01-01 14:00:00",
			"2015-01-01 15:00:00",
			"2015-01-01 16:00:00",
			"2015-01-01 17:00:00",
			"2015-01-01 18:00:00",
			"2015-01-01 19:00:00",
			"2015-01-01 20:00:00",
			"2015-01-01 21:00:00",
			"2015-01-01 22:00:00",
			"2015-01-01 23:00:00",
			"2015-01-02 00:00:00",
			"2015-01-02 01:00:00",
			"2015-01-02 02:00:00",
			"2015-01-02 03:00:00"]
		XCTExpectedFormattedDates(enumeratedDates1, expected: expectedDates1)

		// TEST DATE #2
		// +1 hour, +30 minutes, +10 seconds
		let increment2 = DateComponents.create {
			$0.hour = 1
			$0.minute = 30
			$0.second = 10
		}
		let fromDate2 = DateInRegion("2015-01-01 10:00:00", format: "yyyy-MM-dd HH:mm:ss", region: regionRome)!
		let toDate2 = DateInRegion("2015-01-02 03:00:00", format: "yyyy-MM-dd HH:mm:ss", region: regionRome)!
		let enumeratedDates2 = DateInRegion.enumerateDates(from: fromDate2, to: toDate2, increment: increment2)
		let expectedDates2 = [
			"2015-01-01 10:00:00",
			"2015-01-01 11:30:10",
			"2015-01-01 13:00:20",
			"2015-01-01 14:30:30",
			"2015-01-01 16:00:40",
			"2015-01-01 17:30:50",
			"2015-01-01 19:01:00",
			"2015-01-01 20:31:10",
			"2015-01-01 22:01:20",
			"2015-01-01 23:31:30",
			"2015-01-02 01:01:40",
			"2015-01-02 02:31:50"
		]
		XCTExpectedFormattedDates(enumeratedDates2, expected: expectedDates2)

		// TEST DATE #3
		// +1 month
		let increment3 = DateComponents.create {
			$0.month = 1
		}
		let fromDate3 = DateInRegion("2015-01-01 01:00:00", format: "yyyy-MM-dd HH:mm:ss", region: regionRome)!
		let toDate3 = DateInRegion("2016-02-05 02:00:00", format: "yyyy-MM-dd HH:mm:ss", region: regionRome)!
		let enumeratedDates3 = DateInRegion.enumerateDates(from: fromDate3, to: toDate3, increment: increment3)
		let expectedDates3 = [
			"2015-01-01 01:00:00",
			"2015-02-01 01:00:00",
			"2015-03-01 01:00:00",
			"2015-04-01 01:00:00",
			"2015-05-01 01:00:00",
			"2015-06-01 01:00:00",
			"2015-07-01 01:00:00",
			"2015-08-01 01:00:00",
			"2015-09-01 01:00:00",
			"2015-10-01 01:00:00",
			"2015-11-01 01:00:00",
			"2015-12-01 01:00:00",
			"2016-01-01 01:00:00",
			"2016-02-01 01:00:00"
		]
		XCTExpectedFormattedDates(enumeratedDates3, expected: expectedDates3)
	}

	func XCTExpectedFormattedDates(_ list: [DateInRegion], expected expectedDates: [String]) {
		list.enumerated().forEach {
			let formatted = $0.element.toFormat("yyyy-MM-dd HH:mm:ss")
			let expected = expectedDates[$0.offset]
			guard expected == formatted else {
				XCTFail("Failed to enumerate dates. Got '\(formatted)' expected '\(expected)")
				return
			}
		}
	}

	func testDateInRegion_oldestAndNewestAndSortsIn() {
		let regionRome = Region(calendar: Calendars.gregorian, zone: Zones.europeRome, locale: Locales.italian)
		let regionLondon = Region(calendar: Calendars.gregorian, zone: Zones.europeLondon, locale: Locales.english)
		let regionNY = Region(calendar: Calendars.gregorian, zone: Zones.americaNewYork, locale: Locales.english)

		let datesArrayFormat = "yyyy-MM-dd HH:mm:ss"

		let date1 = DateInRegion("2015-09-24 13:20:55", format: datesArrayFormat, region: regionRome)!
		let date2 = DateInRegion("2015-11-14 14:44:00", format: datesArrayFormat, region: regionRome)!
		let date3 = DateInRegion("2017-01-01 00:00:00", format: datesArrayFormat, region: regionRome)!
		let date4 = DateInRegion("2015-09-24 13:00:55", format: datesArrayFormat, region: regionNY)!
		let date5 = DateInRegion("2017-11-30 20:00:40", format: datesArrayFormat, region: regionNY)!
		let date6 = DateInRegion("2017-11-29 23:59:59", format: datesArrayFormat, region: regionLondon)!
		let datesArray = [date1, date2, date3, date4, date5, date6]

		// Oldest and Newest
		XCTAssert( (DateInRegion.oldestIn(list: datesArray) == date1), "Failed to get the oldest date in list")
		XCTAssert( (DateInRegion.newestIn(list: datesArray) == date5), "Failed to get the newest date in list")

		// Order by newest
		let orderedByNewest = DateInRegion.sortedByNewest(list: datesArray)
		XCTSameDateArray([date5, date6, date3, date2, date4, date1], orderedByNewest)

		// Order by oldest
		let orderedByOldest = DateInRegion.sortedByOldest(list: datesArray)
		XCTSameDateArray([date1, date4, date2, date3, date6, date5], orderedByOldest)
	}

	@discardableResult
	func XCTSameDateArray(_ left: [DateInRegion], _ right: [DateInRegion]) -> Bool {
		guard left.count == right.count else { return false }
		// swiftlint:disable for_where
		for idx in 0..<left.count {
			if left[idx] != right[idx] {
				XCTFail("At index \(idx). Expected date = {\(left[idx].date)}, got = {\(right[idx].date)}")
				return false
			}
		}
		return true
	}
}
