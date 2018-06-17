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

	func testDateInRegion_EnumareDates() {
		let regionRome = Region(calendar: Calendars.gregorian, zone: Zones.europeRome, locale: Locales.italian)

		let fromDate = DateInRegion("2015-01-01 00:00:00", format: "yyyy-MM-dd HH:mm:ss", region: regionRome)!
		let toDate = DateInRegion("2015-01-02 03:00:00", format: "yyyy-MM-dd HH:mm:ss", region: regionRome)!

		var incrementByHour = DateComponents()
		incrementByHour.hour = 1
		let enumeratedDates = DateInRegion.enumerateDates(from: fromDate, to: toDate, increment: incrementByHour)
		print("")
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
