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
			$0.yearForWeekOfYear = 2018
			$0.quarter = 1
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
		XCTAssert( (dateB.quarterName(.default, locale: Locales.italian) == "1º trimestre"), "Failed to get quarterName with overwrite of locale")
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

	func testDateInRegion_dateBySet() {
		let originalDate = "2018-10-10T12:02:16.024".toISODate()
		let newDate = originalDate?.dateBySet(hour: nil, min: nil, secs: nil, ms: 7)
		XCTAssert( newDate?.toISO([.withInternetDateTimeExtended]) == "2018-10-10T12:02:16.007Z", "Failed to set milliseconds")
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

		// swiftlint:disable nesting
		struct ExpectedJulian {
			var dateISO: String
			var julianDay: Double
			var modifiedJulianDay: Double
		}

		let dates = [
			ExpectedJulian(dateISO: "2017-12-22T00:06:18+01:00", julianDay: 2_458_109.462_708_333_5, modifiedJulianDay: 58108.962_708_333_51),
			ExpectedJulian(dateISO: "2018-06-02T02:14:45+02:00", julianDay: 2_458_271.510_243_055_4, modifiedJulianDay: 58271.010_243_055_41),
			ExpectedJulian(dateISO: "2018-04-04T13:31:12+02:00", julianDay: 2_458_212.98, modifiedJulianDay: 58212.479_999_999_98),
			ExpectedJulian(dateISO: "2018-03-18T10:11:10+01:00", julianDay: 2_458_195.882_754_629_5, modifiedJulianDay: 58195.382_754_629_48),
			ExpectedJulian(dateISO: "2018-03-10T18:03:22+01:00", julianDay: 2_458_188.210_671_296_3, modifiedJulianDay: 58187.710_671_296_34),
			ExpectedJulian(dateISO: "2017-07-14T06:33:47+02:00", julianDay: 2_457_948.690_127_315, modifiedJulianDay: 57948.190_127_315),
			ExpectedJulian(dateISO: "2018-02-14T16:51:14+01:00", julianDay: 2_458_164.160_578_703_5, modifiedJulianDay: 58163.660_578_703_51),
			ExpectedJulian(dateISO: "2017-08-15T17:41:44+02:00", julianDay: 2_457_981.153_981_481_7, modifiedJulianDay: 57980.653_981_481_68),
			ExpectedJulian(dateISO: "2018-03-04T09:54:54+01:00", julianDay: 2_458_181.871_458_333, modifiedJulianDay: 58181.371_458_332_986),
			ExpectedJulian(dateISO: "2017-09-23T08:18:15+02:00", julianDay: 2_458_019.762_673_611, modifiedJulianDay: 58019.262_673_610_82),
			ExpectedJulian(dateISO: "2017-12-10T10:29:42+01:00", julianDay: 2_458_097.895625, modifiedJulianDay: 58097.395_624_999_89),
			ExpectedJulian(dateISO: "2017-11-11T02:49:41+01:00", julianDay: 2_458_068.576_168_981_4, modifiedJulianDay: 58068.076_168_981_38),
			ExpectedJulian(dateISO: "2017-07-06T04:05:39+02:00", julianDay: 2_457_940.587_256_944_7, modifiedJulianDay: 57940.087_256_944_74),
			ExpectedJulian(dateISO: "2017-12-02T00:23:52+01:00", julianDay: 2_458_089.474_907_407_5, modifiedJulianDay: 58088.974_907_407_54),
			ExpectedJulian(dateISO: "2017-11-14T17:59:46+01:00", julianDay: 2_458_072.208_171_296_4, modifiedJulianDay: 58071.708_171_296_4),
			ExpectedJulian(dateISO: "2018-03-02T10:53:52+01:00", julianDay: 2_458_179.912_407_407_5, modifiedJulianDay: 58179.412_407_407_54),
			ExpectedJulian(dateISO: "2018-04-14T23:46:35+02:00", julianDay: 2_458_223.407_349_537, modifiedJulianDay: 58222.907_349_537_13),
			ExpectedJulian(dateISO: "2018-04-28T07:25:22+02:00", julianDay: 2_458_236.725_949_074, modifiedJulianDay: 58236.225_949_074_14),
			ExpectedJulian(dateISO: "2018-01-06T14:36:53+01:00", julianDay: 2_458_125.067_280_092_3, modifiedJulianDay: 58124.567_280_092_28),
			ExpectedJulian(dateISO: "2017-09-24T19:58:19+02:00", julianDay: 2_458_021.248_831_019, modifiedJulianDay: 58020.748_831_018_806),
			ExpectedJulian(dateISO: "2017-12-17T21:12:31+01:00", julianDay: 2_458_105.342_025_463, modifiedJulianDay: 58104.842_025_463_004),
			ExpectedJulian(dateISO: "2018-05-04T02:28:42+02:00", julianDay: 2_458_242.519_930_555_5, modifiedJulianDay: 58242.019_930_555_485),
			ExpectedJulian(dateISO: "2018-01-21T18:41:34+01:00", julianDay: 2_458_140.237_199_074, modifiedJulianDay: 58139.737_199_074_12),
			ExpectedJulian(dateISO: "2018-04-05T02:36:54+02:00", julianDay: 2_458_213.525625, modifiedJulianDay: 58213.025_624_999_78),
			ExpectedJulian(dateISO: "2018-02-07T13:35:16+01:00", julianDay: 2_458_157.024_490_741, modifiedJulianDay: 58156.524_490_741_08),
			ExpectedJulian(dateISO: "2017-11-30T00:58:20+01:00", julianDay: 2_458_087.498_842_592_4, modifiedJulianDay: 58086.998_842_592_35),
			ExpectedJulian(dateISO: "2018-04-10T07:10:34+02:00", julianDay: 2_458_218.715_671_296, modifiedJulianDay: 58218.215_671_296_23),
			ExpectedJulian(dateISO: "2017-08-11T09:36:56+02:00", julianDay: 2_457_976.817_314_815, modifiedJulianDay: 57976.317_314_814_776),
			ExpectedJulian(dateISO: "2018-04-28T12:30:18+02:00", julianDay: 2_458_236.937_708_333, modifiedJulianDay: 58236.437_708_333_135),
			ExpectedJulian(dateISO: "2017-09-17T11:59:29+02:00", julianDay: 2_458_013.916_307_870_3, modifiedJulianDay: 58013.416_307_870_3)
		]

		dates.forEach {
			let date = $0.dateISO.toISODate()!
			guard date.julianDay == $0.julianDay else {
				XCTFail("Failed to evaluate julianDay of '\($0.dateISO)'. Got '\(date.julianDay)', expected '\($0.julianDay)'")
				return
			}
			guard date.modifiedJulianDay == $0.modifiedJulianDay else {
				XCTFail("Failed to evaluate modifiedJulianDay of '\($0.dateISO)'. Got '\(date.modifiedJulianDay)', expected '\($0.modifiedJulianDay)'")
				return
			}
		}

	}

	@available(iOS 9.0, macOS 10.11, *)
	func test_ordinalDay() {
		let newYork = Region(calendar: Calendars.gregorian, zone: Zones.americaNewYork, locale: Locales.englishUnitedStates)

		let localDate = DateInRegion(components: {
			$0.year = 2002
			$0.month = 3
			$0.day = 1
			$0.hour = 5
			$0.minute = 30
		}, region: newYork)!
		XCTAssert(localDate.ordinalDay == "1st", "Failed to get the correct value of the ordinalDay for a date")

		let localDate2 = DateInRegion(components: {
			$0.year = 2002
			$0.month = 3
			$0.day = 2
			$0.hour = 5
			$0.minute = 30
		}, region: newYork)!
		XCTAssert(localDate2.ordinalDay == "2nd", "Failed to get the correct value of the ordinalDay for a date")

		let localDate3 = DateInRegion(components: {
			$0.year = 2002
			$0.month = 3
			$0.day = 3
			$0.hour = 5
			$0.minute = 30
		}, region: newYork)!
		XCTAssert(localDate3.ordinalDay == "3rd", "Failed to get the correct value of the ordinalDay for a date")

		let localDate4 = DateInRegion(components: {
			$0.year = 2002
			$0.month = 3
			$0.day = 4
			$0.hour = 5
			$0.minute = 30
		}, region: newYork)!
		XCTAssert(localDate4.ordinalDay == "4th", "Failed to get the correct value of the ordinalDay for a date")

		let regionRome = Region(calendar: Calendars.gregorian, zone: Zones.europeRome, locale: Locales.italian)
		let localDate5 = DateInRegion(components: {
			$0.year = 2002
			$0.month = 3
			$0.day = 2
			$0.hour = 5
			$0.minute = 30
		}, region: regionRome)!
		XCTAssert(localDate5.ordinalDay == "2º", "Failed to get the correct value of the ordinalDay for a date")
	}

	func testDateInRegion_ISOFormatterAlt() {
		let regionRome = Region(calendar: Calendars.gregorian, zone: Zones.europeRome, locale: Locales.italian)
		let dateFormat = "yyyy-MM-dd HH:mm:ss"
		let date = DateInRegion("2017-07-22 00:00:00", format: dateFormat, region: regionRome)!

		XCTAssert( date.toISO() == "2017-07-22T00:00:00+02:00", "Failed to format ISO")
		XCTAssert( date.toISO([.withFullDate]) == "2017-07-22", "Failed to format ISO")
		XCTAssert( date.toISO([.withFullDate, .withFullTime, .withDashSeparatorInDate, .withSpaceBetweenDateAndTime]) == "2017-07-22 00:00:00+02:00", "Failed to format ISO")
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

	func testQuarter() {
		let regionLondon = Region(calendar: Calendars.gregorian, zone: Zones.europeLondon, locale: Locales.english)
		let dateFormat = "yyyy-MM-dd HH:mm:ss"

		let dateA = DateInRegion("2018-02-05 23:14:45", format: dateFormat, region: regionLondon)!
		let dateB = DateInRegion("2018-09-05 23:14:45", format: dateFormat, region: regionLondon)!
		let dateC = DateInRegion("2018-12-05 23:14:45", format: dateFormat, region: regionLondon)!

		XCTAssert( dateA.quarter == 1, "Failed to evaluate quarter property")
		XCTAssert( dateB.quarter == 3, "Failed to evaluate quarter property")
		XCTAssert( dateC.quarter == 4, "Failed to evaluate quarter property")
	}

	func testAbsoluteDateISOFormatting() {
		let now = DateInRegion()
		let iso8601_string = now.toISO([.withInternetDateTime])
		let absoluteDate = now.date
		let absoluteDate_iso8601_string = absoluteDate.toISO([.withInternetDateTime])
		XCTAssert( absoluteDate_iso8601_string == iso8601_string, "Failed respect the absolute ISO date")
	}
    
    func testComparingTimeUnitsWithDateComponents() {
        SwiftDate.defaultRegion = .local

        let now = Date()
        XCTAssert((now.addingTimeInterval(3600) - now).in(.hour) == 1, "Failed to compare date")
        XCTAssert((now.addingTimeInterval(3600) - now) == 1.hours, "Failed to compare date")
    }
    
}
