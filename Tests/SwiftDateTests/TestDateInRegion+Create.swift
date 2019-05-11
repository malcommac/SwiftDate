//
//  SwiftDate
//  Parse, validate, manipulate, and display dates, time and timezones in Swift
//
//  Created by Daniele Margutti
//   - Web: https://www.danielemargutti.com
//   - Twitter: https://twitter.com/danielemargutti
//   - Mail: hello@danielemargutti.com
//
//  Copyright © 2019 Daniele Margutti. Licensed under MIT License.
//

import SwiftDate
import XCTest

public func randomNumber<T: SignedInteger>(inRange range: ClosedRange<T> = 1...6) -> T {
	let length = Int64(range.upperBound - range.lowerBound + 1)
	let value = Int64.random(in: 0..<Int64.max) % length + Int64(range.lowerBound)
	return T(value)
}

class TestDateInRegion_Create: XCTestCase {

	func testDateInRegion_DateBySetTime() {
		let regionRome = Region(calendar: Calendars.gregorian, zone: Zones.europeRome, locale: Locales.italian)
		let date1 = DateInRegion("2010-01-01 00:00:00", format: "yyyy-MM-dd HH:mm:ss", region: regionRome)!
		guard let date1a = date1.dateBySet(hour: 20, min: 13, secs: 15) else {
			XCTFail("Failed to alter date's time")
			return
		}
		XCTAssert( (date1a.hour == 20 && date1a.minute == 13 && date1a.second == 15 ), "Failed to alter date's time")

		// altering only one component
		guard let date2a = date1.dateBySet(hour: 20, min: nil, secs: nil) else {
			XCTFail("Failed to alter date's time")
			return
		}
		XCTAssert( (date2a.hour == 20 && date2a.minute == 00 && date2a.second == 00 ), "Failed to alter date's time")

	}

	func testDateInRegion_DateBySet() {
		// swiftlint:disable nesting
		struct ExpectDateBySet {
			var components: [Calendar.Component: Int?] = [:]

			init() {
				let allCmps: [Calendar.Component] = [.second, .minute, .hour, .day, .month, .year]
				for i in 0..<allCmps.count {
					let componentToAlter = allCmps[i]
					let range: ClosedRange<Int>?
					switch componentToAlter {
					case .second, .minute:	range = 0...50
					case .hour:				range = 0...20
					case .day:				range = 1...28
					case .month:			range = 1...12
					case .year:				range = 2000...2050
					default:				range = nil
					}
					if let range = range {
						let value = randomNumber(inRange: range)
						components[componentToAlter] = value
					}
				}
			}

			func verify(date: DateInRegion) {
				components.keys.forEach {
					if let value = date.dateComponents.value(for: $0), let expected = components[$0] as? Int {
						if value != expected {
							XCTFail("Failed to set value of component \($0). Got \(value), expected \(expected)")
							return
						}
					}
				}

			}
		}

		for _ in 0..<50 {
			let randomDate = "2041-05-18T18:00:25Z".toISODate()! //DateInRegion.randomDate(region: regionRome)
			let alterComponents = ExpectDateBySet()
			if let alteredDate = randomDate.dateBySet(alterComponents.components) {
				alterComponents.verify(date: alteredDate)
			}
		}
	}

	func testDateInRegion_RandomDatesInRange() {
		// Random dates
		let regionNorw = Region(calendar: Calendars.gregorian, zone: Zones.europeOslo, locale: Locales.norwegianBokmlSvalbardJanMayen)
		let randomDateAny = DateInRegion.randomDate(region: regionNorw)
		guard randomDateAny.region == regionNorw else {
			XCTFail("Failed to generate a random date in region")
			return
		}

		// Random dates in range
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

	func testDateInRegion_RandomDatesBackToDays() {
		for _ in 0..<50 {
			let daysBack = (Int.random(in: 0..<365) + 1)
			let randomDate = DateInRegion.randomDate(withinDaysBeforeToday: daysBack)
			guard randomDate.getInterval(toDate: DateInRegion(), component: .day) <= daysBack else {
				XCTFail("Failed to generate a random back date back to max \(daysBack) days")
				return
			}
		}
	}

	func testDateInRegion_EnumerateDates() {
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

	func testDateInRegion_DateForWeekdays() {
		func validateArrayOfISODates(_ found: [String], _ expected: [String]) {
			guard found.count == expected.count else {
				XCTFail("Failed to validate array of dates. Different in number.")
				return
			}
			for i in 0..<expected.count {
				guard found[i] == expected[i] else {
					XCTFail("Failed to validate item '\(i)'. Found '\(found[i])', expecting '\(expected[i])'")
					return
				}
			}
		}

		let mondaysInJan2019 = DateInRegion.datesForWeekday(.monday, inMonth: 1, ofYear: 2019, region: Region.UTC).map { $0.toISO() }
		validateArrayOfISODates(mondaysInJan2019, [
			"2019-01-07T00:00:00Z",
			"2019-01-14T00:00:00Z",
			"2019-01-21T00:00:00Z",
			"2019-01-28T00:00:00Z"
		])

		let fromDate = DateInRegion(year: 2019, month: 5, day: 27, hour: 0, minute: 0)
		let toDate = DateInRegion(year: 2019, month: 6, day: 8, hour: 0, minute: 0)

		let fridaysInJunePartial = DateInRegion.datesForWeekday(.friday, from: fromDate, to: toDate, region: Region.UTC).map {
			$0.toISO()
		}
		validateArrayOfISODates(fridaysInJunePartial, [
			"2019-05-31T00:00:00Z",
			"2019-06-07T00:00:00Z"
		])
	}
}
