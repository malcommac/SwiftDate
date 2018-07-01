//
//  TestDateInRegion+Math.swift
//  SwiftDate
//
//  Created by Daniele Margutti on 19/06/2018.
//  Copyright © 2018 SwiftDate. All rights reserved.
//

import SwiftDate
import XCTest

class TestDateInRegion_Math: XCTestCase {

	func testDateInRegion_DateTruncated() {
		let format = "yyyy-MM-dd HH:mm:ss"
		let rome = Region(calendar: Calendars.gregorian, zone: Zones.europeRome, locale: Locales.italian)

		let d1 = DateInRegion("2017-07-22 15:03:50", format: format, region: rome)!
		let d1_truncatedAt = d1.dateTruncated(at: [.month, .day, .minute])
		let d1_truncatedFrom = d1.dateTruncated(from: .hour)

		XCTAssert( d1_truncatedAt?.description == "{abs_date=\'2017-01-01T14:00:50Z\', rep_date=\'2017-01-01T15:00:50+01:00\', region={calendar=\'gregorian\', timezone=\'Europe/Rome\', locale=\'it\'}", "Failed to truncate date at components")

		XCTAssert( d1_truncatedFrom?.description == "{abs_date=\'2017-07-21T22:00:00Z\', rep_date=\'2017-07-22T00:00:00+02:00\', region={calendar=\'gregorian\', timezone=\'Europe/Rome\', locale=\'it\'}", "Failed to truncate date from hour component")

	}

	func testDateInRegion_Rounding() {
		let format = "yyyy-MM-dd HH:mm:ss"
		let rome = Region(calendar: Calendars.gregorian, zone: Zones.europeRome, locale: Locales.italian)

		// Round down 10m
		let d1 = DateInRegion("2017-07-22 00:03:50", format: format, region: rome)
		let d1_rounded = d1?.dateRoundedAt(.to10Mins)
		XCTAssert( d1_rounded?.description == "{abs_date=\'2017-07-21T22:00:00Z\', rep_date=\'2017-07-22T00:00:00+02:00\', region={calendar=\'gregorian\', timezone=\'Europe/Rome\', locale=\'it\'}", "Failed to round a date down 10mins")

		// Round up 10min
		let d2 = DateInRegion("2015-01-24 15:07:20", format: format, region: rome)
		let d2_roundedup10 = d2?.dateRoundedAt(.to10Mins)
		XCTAssert( d2_roundedup10?.description == "{abs_date=\'2015-01-24T14:10:00Z\', rep_date=\'2015-01-24T15:10:00+01:00\', region={calendar=\'gregorian\', timezone=\'Europe/Rome\', locale=\'it\'}", "Failed to round a date up 10mins")

		// Round up 30min
		let d2_roundedc30 = d2?.dateRoundedAt(.toCeil30Mins)
		XCTAssert( d2_roundedc30?.description == "{abs_date=\'2015-01-24T14:30:00Z\', rep_date=\'2015-01-24T15:30:00+01:00\', region={calendar=\'gregorian\', timezone=\'Europe/Rome\', locale=\'it\'}", "Failed to round a date ceil 30mins")

	}

	func testDateInRegion_MathOperations() {
		let regionRome = Region(calendar: Calendars.gregorian, zone: Zones.europeRome, locale: Locales.italian)
		let dateFormat = "yyyy-MM-dd HH:mm:ss"

		let date1 = DateInRegion("2017-07-22 00:00:00", format: dateFormat, region: regionRome)!
		let date2 = DateInRegion("2017-07-22 00:00:00", format: dateFormat, region: regionRome)!
		let date3 = DateInRegion("2018-08-23 10:50:20", format: dateFormat, region: regionRome)!

		// TEST #1
		// (DateInRegion - DateInRegion) -> DateComponents
		XCTAssert( ((date2 - date1) as DateComponents).isZero, "Failed to extract components from math operation between dates")
		XCTAssert( ((date3 - date2) as DateComponents).hour == 10, "Failed to extract components from math operation between dates")
		XCTAssert( ((date3 - date2) as DateComponents).day == 1, "Failed to extract components from math operation between dates")
		XCTAssert( ((date3 - date2) as DateComponents).year == 1, "Failed to extract components from math operation between dates")

		// TEST #2
		// (DateInRegion + DateComponents) -> DateInRegion
		let components1 = DateComponents.create {
			$0.day = 1
			$0.hour = 2
			$0.minute = 30
		}
		let finalDate1 = (date1 + components1).toFormat(dateFormat)
		XCTAssert( (finalDate1 == "2017-07-23 02:30:00"), "Failed to sum date to components and get the exact final date")

		// TEST #3
		let components2 = DateComponents.create {
			$0.year = 1
			$0.weekOfYear = 2
		}
		let finalDate2 = (date1 + components2).toFormat(dateFormat)
		XCTAssert( (finalDate2 == "2018-08-05 00:00:00"), "Failed to sum date to components and get the exact final date")

		// TEST #4
		// (DateInRegion - DateComponents) -> DateInRegion
		let finalDate3 = (date1 - DateComponents.create({
			$0.day = 30
			$0.hour = 27
		})).toFormat(dateFormat)
		XCTAssert( (finalDate3 == "2017-06-20 21:00:00"), "Failed to minus date to components and get the exact final date")

		// TEST #5
		let finalDate4 = (date1 + [Calendar.Component.year: 1]).toFormat(dateFormat)
		XCTAssert( (finalDate4 == "2018-07-22 00:00:00"), "Failed to add components dict and get the exact final date")

		// TEST #6
		let finalDate5 = (date1 + [Calendar.Component.day: 20, Calendar.Component.hour: 10]).toFormat(dateFormat)
		XCTAssert( (finalDate5 == "2017-08-11 10:00:00"), "Failed to add components dict and get the exact final date")

	}

}
