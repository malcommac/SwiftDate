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

class TestDataStructures: XCTestCase {

	func test_Weekday() {
		// Circular operations
		XCTAssert(WeekDay.monday.subtract(days: 2) == .saturday, "Failed to use circular operation for weekday")
		XCTAssert(WeekDay.friday.add(days: 4) == .tuesday, "Failed to use circular operation for weekday")
		XCTAssert(WeekDay.monday.add(days: 0) == .monday, "Failed to use circular operation for weekday")
		XCTAssert(WeekDay.friday.subtract(days: 0) == .friday, "Failed to use circular operation for weekday")
		XCTAssert(WeekDay.friday.add(days: -1) == .thursday, "Failed to use circular operation for weekday")
		XCTAssert(WeekDay.friday.subtract(days: -1) == .saturday, "Failed to use circular operation for weekday")

		// Locale display name
		XCTAssert(WeekDay.monday.name(locale: Locales.italian).lowercased() == "lunedì", "Failed to get the weekday display name in locale")
		XCTAssert(WeekDay.sunday.name(locale: Locales.english).lowercased() == "sunday", "Failed to get the weekday display name in locale")
		XCTAssert(WeekDay.monday.name(locale: Locales.ukrainian).lowercased() == "понеділок", "Failed to get the month display name in locale")
	}

	func test_Month() {
		// Circular operations
		XCTAssert(Month.january.subtract(months: 2) == .november, "Failed to use circular operation for month")
		XCTAssert(Month.september.add(months: 5) == .february, "Failed to use circular operation for month")
		XCTAssert(Month.september.add(months: 0) == .september, "Failed to use circular operation for month")
		XCTAssert(Month.december.subtract(months: 0) == .december, "Failed to use circular operation for month")
		XCTAssert(Month.december.add(months: -1) == .november, "Failed to use circular operation for month")
		XCTAssert(Month.may.subtract(months: -1) == .june, "Failed to use circular operation for month")

		// Locale display name
		XCTAssert(Month.january.name(locale: Locales.italian).lowercased() == "gennaio", "Failed to get the month display name in locale")
		XCTAssert(Month.may.name(locale: Locales.english).lowercased() == "may", "Failed to get the month display name in locale")
		XCTAssert(Month.may.name(locale: Locales.french).lowercased() == "mai", "Failed to get the month display name in locale")

		// Number of days in month
		XCTAssert(Month.february.numberOfDays(year: 2016) == 29, "Failed to get a leap year")
		XCTAssert(Month.january.numberOfDays(year: 2017) == 31, "Failed to get a leap year")
		XCTAssert(Month.february.numberOfDays(year: 1924) == 29, "Failed to get a leap year")
	}

	func test_Year() {
		XCTAssert(Year(2016).isLeap() == true, "Failed to get a leap year")
		XCTAssert(Year(2020).isLeap() == true, "Failed to get a leap year")
		XCTAssert(Year(2024).isLeap() == true, "Failed to get a leap year")
		XCTAssert(Year(2028).isLeap() == true, "Failed to get a leap year")
		XCTAssert(Year(2096).isLeap() == true, "Failed to get a leap year")
		XCTAssert(Year(1924).isLeap() == true, "Failed to get a leap year")
		XCTAssert(Year(2067).isLeap() == false, "Failed to get a non leap year")

		XCTAssert(Year(1924).numberOfDays() == 366, "Failed to get the correct number of day in a year")
		XCTAssert(Year(1944).numberOfDays() == 366, "Failed to get the correct number of day in a year")
		XCTAssert(Year(2067).numberOfDays() == 365, "Failed to get the correct number of day in a year")
	}

}
