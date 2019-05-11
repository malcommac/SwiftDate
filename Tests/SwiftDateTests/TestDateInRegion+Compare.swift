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

class TestDateInRegion_Compare: XCTestCase {

	func testDateInRegion_compareCloseTo() {
		let regionRome = Region(calendar: Calendars.gregorian, zone: Zones.europeRome, locale: Locales.italian)
		let dateFormat = "yyyy-MM-dd HH:mm:ss"

		let refDate = DateInRegion("2015-01-01 00:00:00", format: dateFormat, region: regionRome)!
		let dateA = DateInRegion("2015-01-01 01:00:00", format: dateFormat, region: regionRome)!
		let dateB = DateInRegion("2014-12-31 22:30:00", format: dateFormat, region: regionRome)!
		let dateC = DateInRegion("2015-01-01 04:00:00", format: dateFormat, region: regionRome)!

		let failMsg = "Failed to evaluate if date is close to another with given interval"
		XCTAssert( (dateA.compareCloseTo(refDate, precision: 1.hours.timeInterval) == true), failMsg)
		XCTAssert( (dateB.compareCloseTo(refDate, precision: 1.hours.timeInterval) == false), failMsg)
		XCTAssert( (dateC.compareCloseTo(refDate, precision: 3.hours.timeInterval) == false), failMsg)
		XCTAssert( (dateC.compareCloseTo(refDate, precision: 5.hours.timeInterval) == true), failMsg)
	}

	func testDateInRegion_compare() {

		// isToday
		XCTAssert( DateInRegion().compare(.isToday), "Failed to evaluate isToday")
		XCTAssert( ((DateInRegion() - 2.days).compare(.isToday) == false), "Failed to evaluate isToday == false")

		// isTomorrow
		XCTAssert( (DateInRegion() + 1.days + 5.minutes).compare(.isTomorrow), "Failed to evaluate isTomorrow")
		XCTAssert( (DateInRegion().dateAt(.endOfDay).compare(.isTomorrow) == false), "Failed to evaluate isTomorrow")

		// isYesterday
		XCTAssert( (DateInRegion().dateAt(.startOfDay) - 1.days).compare(.isYesterday), "Failed to evaluate isYesterday")
		XCTAssert( ((DateInRegion().dateAt(.startOfDay)).compare(.isYesterday) == false), "Failed to evaluate isYesterday == false")

		// isThisWeek
		XCTAssert( DateInRegion().compare(.isThisWeek), "Failed to evaluate isThisWeek")
		XCTAssert( DateInRegion().dateAt(.startOfWeek).compare(.isThisWeek), "Failed to evaluate isThisWeek")

		// isNextWeek
		XCTAssert( (DateInRegion() + 7.days).compare(.isNextWeek), "Failed to evaluate isNextWeek")
		XCTAssert( (DateInRegion().dateAt(.endOfWeek) + 1.days).compare(.isNextWeek), "Failed to evaluate isNextWeek")

		// isLastWeek
		XCTAssert( (DateInRegion() - 7.days).compare(.isLastWeek), "Failed to evaluate isLastWeek")
		XCTAssert( (DateInRegion().dateAt(.startOfWeek) - 1.days).compare(.isLastWeek), "Failed to evaluate isLastWeek")

		// isSameWeek
		let regionRome = Region(calendar: Calendars.gregorian, zone: Zones.europeRome, locale: Locales.italian)
		let dateFormat = "yyyy-MM-dd HH:mm:ss"
		let dateA = DateInRegion("2018-06-19 01:00:00", format: dateFormat, region: regionRome)!
		let dateB = DateInRegion("2018-06-23 22:30:00", format: dateFormat, region: regionRome)!
		let dateC = DateInRegion("2018-06-17 23:59:00", format: dateFormat, region: regionRome)!

		XCTAssert( dateA.compare(.isSameWeek(dateB)), "Failed to evaluate isSameWeek")
		XCTAssert( dateA.compare(.isSameWeek(dateC)) == false, "Failed to evaluate isSameWeek == false")

		// isThisMonth
		XCTAssert( (DateInRegion().dateAt(.startOfMonth) + 6.days).compare(.isThisMonth), "Failed to evaluate isThisMonth")
		XCTAssert( DateInRegion().compare(.isThisMonth), "Failed to evaluate isThisMonth")
		XCTAssert( (DateInRegion().dateAt(.startOfMonth) - 1.days).compare(.isThisMonth) == false, "Failed to evaluate isThisMonth == false")

		// isNextMonth
		XCTAssert( (DateInRegion().dateAt(.startOfMonth) - 1.days).compare(.isNextMonth) == false, "Failed to evaluate isNextMonth == false")
		XCTAssert( (DateInRegion().dateAt(.endOfMonth) + 5.days).compare(.isNextMonth), "Failed to evaluate isNextMonth")
		XCTAssert( DateInRegion().compare(.isNextMonth) == false, "Failed to evaluate isNextMonth == false")

		// isLastMonth
		XCTAssert( (DateInRegion().dateAt(.startOfMonth) - 1.days).compare(.isLastMonth), "Failed to evaluate isLastMonth")
		XCTAssert( (DateInRegion().dateAt(.endOfMonth) + 5.days).compare(.isLastMonth) == false, "Failed to evaluate isLastMonth == false")
		XCTAssert( DateInRegion().compare(.isLastMonth) == false, "Failed to evaluate isLastMonth == false")

		// isSameMonth
		let dateA1 = DateInRegion("2018-06-19 01:00:00", format: dateFormat, region: regionRome)!
		let dateB1 = DateInRegion("2018-06-23 22:30:00", format: dateFormat, region: regionRome)!
		let dateC1 = DateInRegion("2018-07-01 00:00:00", format: dateFormat, region: regionRome)!
		XCTAssert( dateA1.compare(.isSameMonth(dateB1)), "Failed to evaluate isSameMonth")
		XCTAssert( dateB1.compare(.isSameMonth(dateC1)) == false, "Failed to evaluate isSameMonth == false")

		// prevWeek/nextWeek
		XCTAssert( dateA1.dateAt(.prevWeek).toISO() == "2018-06-11T00:00:00+02:00", "Failed to evaluate prevWeek")
		XCTAssert( dateA1.dateAt(.nextWeek).toISO() == "2018-06-25T00:00:00+02:00", "Failed to evaluate prevWeek")

		// isThisYear
		XCTAssert( DateInRegion().compare(.isThisYear), "Failed to evaluate isThisYear")
		XCTAssert( (DateInRegion() + 1.years).compare(.isThisYear) == false, "Failed to evaluate isThisYear == false")
		XCTAssert( (DateInRegion() - 1.years).compare(.isThisYear) == false, "Failed to evaluate isThisYear == false")

		// isSameYear
		let dateA2 = DateInRegion("2018-01-01 00:00:00", format: dateFormat, region: regionRome)!
		let dateB2 = DateInRegion("2017-12-31 23:59:59", format: dateFormat, region: regionRome)!
		let dateC2 = DateInRegion("2018-12-31 23:59:59", format: dateFormat, region: regionRome)!
		XCTAssert( dateA2.compare(.isSameYear(dateB2)) == false, "Failed to evaluate isSameYear == false")
		XCTAssert( dateA2.compare(.isSameYear(dateC2)), "Failed to evaluate isSameYear")
		XCTAssert( dateB2.compare(.isSameYear(dateC2)) == false, "Failed to evaluate isSameYear == false")

		// isInTheFuture
		XCTAssert( (DateInRegion() + 1.seconds).compare(.isInTheFuture), "Failed to evaluate isInTheFuture")
		XCTAssert( (DateInRegion() - 1.seconds).compare(.isInTheFuture) == false, "Failed to evaluate isInTheFuture == false")
		XCTAssert( (DateInRegion() + 1.years).compare(.isInTheFuture), "Failed to evaluate isInTheFuture")

		// isInThePast
		XCTAssert( (DateInRegion() - 1.seconds).compare(.isInThePast), "Failed to evaluate isInThePast")
		XCTAssert( (DateInRegion() + 1.seconds).compare(.isInThePast) == false, "Failed to evaluate isInThePast == false")
		XCTAssert( (DateInRegion() - 1.years).compare(.isInThePast), "Failed to evaluate isInThePast")

		// isEarlier
		let dateA3 = DateInRegion("2018-01-01 00:00:00", format: dateFormat, region: regionRome)!
		let dateB3 = DateInRegion("2017-12-31 23:59:59", format: dateFormat, region: regionRome)!
		XCTAssert( dateA3.compare(.isEarlier(than: dateB3)) == false, "Failed to evaluate isEarlier == false")
		XCTAssert( dateB3.compare(.isEarlier(than: dateA3)), "Failed to evaluate isEarlier")

		// isLater
		XCTAssert( dateA3.compare(.isLater(than: dateB3)), "Failed to evaluate isLater")
		XCTAssert( dateB3.compare(.isLater(than: dateA3)) == false, "Failed to evaluate isLater == false")

		// isWeekday
		XCTAssert( DateInRegion().dateAt(.endOfWeek).compare(.isWeekday) == false, "Failed to evaluate isWeekday == false")
		XCTAssert( (DateInRegion().dateAt(.startOfWeek) + 1.days).compare(.isWeekday), "Failed to evaluate isWeekday")

		// isWeekend
		XCTAssert( DateInRegion().dateAt(.endOfWeek).compare(.isWeekend), "Failed to evaluate isWeekend")
		XCTAssert( (DateInRegion().dateAt(.startOfWeek) + 1.days).compare(.isWeekend) == false, "Failed to evaluate isWeekend == false")

		// isInDST
		// Region rome:
		// 	25 Mar 2018 - Daylight Saving Time Started
		// 	28 Oct 2018 - Daylight Saving Time Ends
		XCTAssert( DateInRegion().dateAt(.endOfWeek).compare(.isWeekend), "Failed to evaluate isWeekend")
		let dateA4 = DateInRegion("2018-03-26 00:00:00", format: dateFormat, region: regionRome)!
		let dateB4 = DateInRegion("2018-06-01 00:00:00", format: dateFormat, region: regionRome)!

		let dateC4 = DateInRegion("2018-10-29 00:00:00", format: dateFormat, region: regionRome)!
		let dateD4 = DateInRegion("2018-12-01 00:00:00", format: dateFormat, region: regionRome)!

		XCTAssert( dateA4.compare(.isInDST), "Failed to evaluate isInDST")
		XCTAssert( dateB4.compare(.isInDST), "Failed to evaluate isInDST")

		XCTAssert( dateC4.compare(.isInDST) == false, "Failed to evaluate isInDST == false")
		XCTAssert( dateD4.compare(.isInDST) == false, "Failed to evaluate isInDST == false")

		// isMorning
		let dateA5 = DateInRegion("2018-03-26 05:00:00", format: dateFormat, region: regionRome)!
		let dateA6 = DateInRegion("2018-03-26 10:00:00", format: dateFormat, region: regionRome)!
		let dateA7 = DateInRegion("2018-03-26 11:59:00", format: dateFormat, region: regionRome)!
		let dateA8 = DateInRegion("2018-03-26 13:59:00", format: dateFormat, region: regionRome)!
		let dateA9 = DateInRegion("2018-03-26 17:59:00", format: dateFormat, region: regionRome)!
		let dateA10 = DateInRegion("2018-03-26 23:00:00", format: dateFormat, region: regionRome)!
		let dateA11 = DateInRegion("2018-03-26 04:00:00", format: dateFormat, region: regionRome)!
		XCTAssert( dateA5.compare(.isMorning), "Failed to evaluate isMorning")
		XCTAssert( dateA6.compare(.isMorning), "Failed to evaluate isMorning")
		XCTAssert( dateA7.compare(.isMorning), "Failed to evaluate isMorning")
		XCTAssert( dateA8.compare(.isMorning) == false, "Failed to evaluate isMorning == false")

		// isAfternoon
		XCTAssert( dateA5.compare(.isAfternoon) == false, "Failed to evaluate isAfternoon == false")
		XCTAssert( dateA8.compare(.isAfternoon), "Failed to evaluate isAfternoon")
		XCTAssert( dateA9.compare(.isAfternoon) == false, "Failed to evaluate isAfternoon == false")

		// isEvening
		XCTAssert( dateA9.compare(.isEvening), "Failed to evaluate isEvening")
		XCTAssert( dateA10.compare(.isEvening) == false, "Failed to evaluate isEvening == false")

		// isNight
		XCTAssert( dateA5.compare(.isNight) == false, "Failed to evaluate isNight == false")
		XCTAssert( dateA11.compare(.isNight), "Failed to evaluate isNight")
		XCTAssert( dateA10.compare(.isNight), "Failed to evaluate isNight")

	}

	func testDateInRegion_compareGranularity() {
		let regionRome = Region(calendar: Calendars.gregorian, zone: Zones.europeRome, locale: Locales.italian)
		let dateFormat = "yyyy-MM-dd HH:mm:ss"

		let date1 = DateInRegion("2018-06-19 01:00:00", format: dateFormat, region: regionRome)!
		let date2 = DateInRegion("2018-06-19 20:00:00", format: dateFormat, region: regionRome)!
		let date3 = DateInRegion("2018-06-21 20:00:00", format: dateFormat, region: regionRome)!

		// Same day/month/year granularity
		XCTAssert( date1.compare(toDate: date2, granularity: .day) == .orderedSame, "Failed to compare with .day granularity")
		XCTAssert( date1.compare(toDate: date2, granularity: .month) == .orderedSame, "Failed to compare with .month granularity")
		XCTAssert( date1.compare(toDate: date2, granularity: .year) == .orderedSame, "Failed to compare with .year granularity")

		// Different day
		XCTAssert( date2.compare(toDate: date3, granularity: .day) == .orderedAscending, "Failed to compare with .day granularity")
		XCTAssert( date2.compare(toDate: date3, granularity: .month) == .orderedSame, "Failed to compare with .month granularity")
		XCTAssert( date2.compare(toDate: date3, granularity: .hour) == .orderedAscending, "Failed to compare with .hour granularity")
	}

	func testDateInRegion_isBeforeDate() {
		let regionRome = Region(calendar: Calendars.gregorian, zone: Zones.europeRome, locale: Locales.italian)
		let regionLondon = Region(calendar: Calendars.gregorian, zone: Zones.europeLondon, locale: Locales.english)
		let dateFormat = "yyyy-MM-dd HH:mm:ss"

		let date1 = DateInRegion("2018-06-19 01:00:00", format: dateFormat, region: regionRome)!
		let date2 = DateInRegion("2018-06-19 01:00:00", format: dateFormat, region: regionLondon)!
		let date3 = DateInRegion("2018-06-21 01:10:00", format: dateFormat, region: regionRome)!

		XCTAssert( date1.isBeforeDate(date2, granularity: .hour), "Failed to isBeforeDate() - .hour")
		XCTAssert( date1.isBeforeDate(date3, granularity: .hour), "Failed to isBeforeDate() - .hour")
		XCTAssert( date1.isBeforeDate(date2, granularity: .day) == false, "Failed to isBeforeDate() - .day == false")
	}

	func testDateInRegion_isAfterDate() {
		let regionRome = Region(calendar: Calendars.gregorian, zone: Zones.europeRome, locale: Locales.italian)
		let regionLondon = Region(calendar: Calendars.gregorian, zone: Zones.europeLondon, locale: Locales.english)
		let dateFormat = "yyyy-MM-dd HH:mm:ss"

		let date1 = DateInRegion("2018-06-19 01:00:00", format: dateFormat, region: regionRome)!
		let date2 = DateInRegion("2018-06-19 01:00:00", format: dateFormat, region: regionLondon)!
		let date3 = DateInRegion("2018-06-21 01:10:00", format: dateFormat, region: regionRome)!
		let date4 = DateInRegion("2018-06-30 00:00:00", format: dateFormat, region: regionRome)!
		let date5 = DateInRegion("2018-06-30 00:00:00", format: dateFormat, region: regionLondon)!

		XCTAssert( date3.isAfterDate(date1, granularity: .day), "Failed to isAfterDate() - .day")
		XCTAssert( date1.isAfterDate(date3, granularity: .month) == false, "Failed to isAfterDate() - .month == false")
		XCTAssert( date4.isAfterDate(date5, granularity: .month) == false, "Failed to isAfterDate() - .day == false")
		XCTAssert( date2.isAfterDate(date1, granularity: .year) == false, "Failed to isAfterDate() - .year == false")
	}

	func testDateInRegion_isInRange() {
		let regionRome = Region(calendar: Calendars.gregorian, zone: Zones.europeRome, locale: Locales.italian)
		let regionLondon = Region(calendar: Calendars.gregorian, zone: Zones.europeLondon, locale: Locales.english)
		let dateFormat = "yyyy-MM-dd HH:mm:ss"

		let lowerBound = DateInRegion("2018-05-31 23:00:00", format: dateFormat, region: regionRome)!
		let upperBound = DateInRegion("2018-06-01 01:00:00", format: dateFormat, region: regionRome)!

		let testDate1 = DateInRegion("2018-06-01 00:02:00", format: dateFormat, region: regionRome)!
		XCTAssert( testDate1.isInRange(date: lowerBound, and: upperBound, orEqual: true, granularity: .hour), "Failed to isInRange .hour")

		let testDate2 = DateInRegion("2018-06-01 00:02:00", format: dateFormat, region: regionLondon)!
		XCTAssert( testDate2.isInRange(date: lowerBound, and: upperBound, orEqual: true, granularity: .hour), "Failed to isInRange .hour")

		let testDate3 = DateInRegion("2018-06-01 01:00:01", format: dateFormat, region: regionLondon)!
		XCTAssert( testDate3.isInRange(date: lowerBound, and: upperBound, orEqual: true, granularity: .hour) == false, "Failed to isInRange .hour == false")
	}

	func testDateInRegion_earlierAndLaterDate() {
		let regionRome = Region(calendar: Calendars.gregorian, zone: Zones.europeRome, locale: Locales.italian)
		let regionLondon = Region(calendar: Calendars.gregorian, zone: Zones.europeLondon, locale: Locales.english)
		let dateFormat = "yyyy-MM-dd HH:mm:ss"

		let date1 = DateInRegion("2018-05-31 23:00:00", format: dateFormat, region: regionRome)!
		let date2 = DateInRegion("2018-06-01 00:00:00", format: dateFormat, region: regionRome)!
		let date3 = DateInRegion("2018-06-01 01:00:00", format: dateFormat, region: regionLondon)!

		// earlierDate()
		XCTAssert( (date1.earlierDate(date2) == date1), "Failed to get .earlierDate()")
		XCTAssert( (date1.earlierDate(date3) == date1), "Failed to get .earlierDate()")

		// laterDate()
		XCTAssert( (date1.laterDate(date2) == date2), "Failed to get .laterDate()")
		XCTAssert( (date1.laterDate(date3) == date3), "Failed to get .laterDate()")
	}

	func testDateInRegion_compareMath() {
		let regionRome = Region(calendar: Calendars.gregorian, zone: Zones.europeRome, locale: Locales.italian)
		let regionNY = Region(calendar: Calendars.gregorian, zone: Zones.americaNewYork, locale: Locales.english)
		let dateFormat = "yyyy-MM-dd HH:mm:ss"

		let date1 = DateInRegion("2018-01-01 00:10:00", format: dateFormat, region: regionRome)!
		let date2 = DateInRegion("2017-12-31 23:00:00", format: dateFormat, region: regionRome)!
		let date3 = DateInRegion("2018-01-01 00:20:00", format: dateFormat, region: regionNY)!

		XCTAssert( (date1 >= date2), "Failed to math compare two dates")
		XCTAssert( (date1 > date2), "Failed to math compare two dates")
		XCTAssert( (date3 > date1), "Failed to math compare two dates")
		XCTAssert( (date3 == date3), "Failed to math compare two dates")
		XCTAssert( (date3 >= date3), "Failed to math compare two dates")
		XCTAssert( (date3 <= date3), "Failed to math compare two dates")
		XCTAssert( (date1 <= date3), "Failed to math compare two dates")
	}

	func testDateInRange_GranuralityTest() {
		let startTime = Date(timeIntervalSince1970: 1_538_344_800.0) // 2018-09-30 22:00:00 +0000
		let endTime = Date(timeIntervalSince1970: 1_540_940_400.0 + (60 * 60 * 3)) // 2018-10-31 02:00:00 +0000
		let checkStart = Date(timeIntervalSince1970: 1_540_976_400.0) // 2018-10-31 09:00:00 +0000

		let isInside = checkStart.isInRange(date: startTime, and: endTime, orEqual: true, granularity: .day) // should return false even if its true
		XCTAssert( (isInside == true), "Failed to compare date with granularity")
	}

}
