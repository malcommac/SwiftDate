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

class TestDateInRegion: XCTestCase {

	let testDate = Date()
	let testRegion = Region(calendar: Calendars.gregorian, zone: Zones.europeRome, locale: Locales.italian)

	func testDateInRegion_ParseWithLocale() {
		let itRegion = Region(calendar: Calendars.gregorian, zone: Zones.europeRome, locale: Locales.italian)
		let dateIt = "15 Settembre 2001".toDate("dd MMM yyyy", region: itRegion)
		XCTAssertNotNil(dateIt, "Failed to parse with forced locale it")

		let dateEnStr = "10 July 2005"
		let dateEnFail = dateEnStr.toDate("dd MMM yyyy", region: itRegion)
		XCTAssertNil(dateEnFail, "This date should be not represented")

		let enRegion = Region(calendar: Calendars.gregorian, zone: Zones.europeRome, locale: Locales.english)
		let dateEnSuccess = dateEnStr.toDate("dd MMM yyyy", region: enRegion)
		XCTAssertNotNil(dateEnSuccess, "Failed to parse with forced locale en")
	}

	func testDateInRegion_InitWithDateAndRegion() {
		SwiftDate.defaultRegion = testRegion

		// test with given date in test region
		let dateInTestRegion = DateInRegion(testDate, region: testRegion)
		XCTAssert( (dateInTestRegion.date == testDate), "Failed to create DateInRegion with given date and test region / different date")
		XCTAssert( (dateInTestRegion.region == testRegion), "Failed to create DateInRegion with given date and test region / different region")

		// test with current date in test region
		let nowInTestRegion = DateInRegion(region: testRegion)
		XCTAssertInTimeIntervalRange(value: (Date().timeIntervalSince1970 - nowInTestRegion.date.timeIntervalSince1970), range: 5, "Failed to create DateInRegion with now date and test region / date is not now")
		XCTAssert( (nowInTestRegion.region == testRegion), "Failed to create DateInRegion with now date and test region / different region")

		// test with current date in default region
		let nowInDefRegion = DateInRegion()
		XCTAssertInTimeIntervalRange(value: (Date().timeIntervalSince1970 - nowInDefRegion.date.timeIntervalSince1970), range: 5, "Failed to create DateInRegion with now date and default region / date is not now")
		XCTAssert( (nowInDefRegion.region == SwiftDate.defaultRegion), "Failed to create DateInRegion with now date and default region / different region")

	}

	func testDateInRegion_InitFromTimeInterval() {
		SwiftDate.defaultRegion = Region(calendar: Calendars.buddhist, zone: Zones.indianCocos, locale: Locales.nepaliIndia)

		// Init with seconds and default region at UTC timezone
		let secsFromEpoch = DateInRegion(seconds: 10)
		XCTAssert( (secsFromEpoch.date.timeIntervalSince1970 == 10), "Failed to create DateInRegion from epoch time and UTC region / different date")
		XCTAssert( (secsFromEpoch.region.timeZone == Region.UTC.timeZone), "Failed to create DateInRegion from epoch time and UTC region / different region than UTC")
		XCTAssert( (secsFromEpoch.region.locale == Region.UTC.locale), "Failed to create DateInRegion from epoch time and UTC region / no default's region locale")
		XCTAssert( (secsFromEpoch.region.calendar.identifier == Region.UTC.calendar.identifier), "Failed to create DateInRegion from epoch time and UTC region / no default's region calendar")

		// Init with milliseconds and default region at UTC timezone
		let msecsFromEpoch = DateInRegion(milliseconds: 5000)
		XCTAssert( (msecsFromEpoch.date.timeIntervalSince1970 == 5), "Failed to create DateInRegion from epoch time and UTC region / different date")

		// Init with second and given region
		let regionBerlin = Region(calendar: Calendars.gregorian, zone: Zones.europeBerlin, locale: Locales.dutch)
		let secsFromEpochInBerlin = DateInRegion(seconds: 56673, region: regionBerlin)
		XCTAssert( (secsFromEpochInBerlin.region == regionBerlin), "Failed to create DateInRegion from epoch time and fixed region / different region")
		XCTAssert( (secsFromEpochInBerlin.date.timeIntervalSince1970 == 56673), "Failed to create DateInRegion from epoch time and fixed region / different date")

		// Init with milliseconds and given region
		let msecsFromEpochInRegion = DateInRegion(milliseconds: 5000, region: regionBerlin)
		XCTAssert( (msecsFromEpochInRegion.date.timeIntervalSince1970 == 5), "Failed to create DateInRegion from epoch time and fixed region / different date")
		XCTAssert( (msecsFromEpochInRegion.region == regionBerlin), "Failed to create DateInRegion from epoch time and fixed region / different date")

		// Init with fraction of seconds
		let msecsLessThanSeconds = DateInRegion(milliseconds: 10)
		XCTAssertEqual(round(msecsLessThanSeconds.date.timeIntervalSince1970 * 1000), 10)

	}

	func testDateInRegion_InitFromComponents() {

		let regionRome = Region(calendar: Calendars.gregorian, zone: Zones.europeRome, locale: Locales.italian)
		let regionUTC = Region.UTC

		var dComponents = DateComponents()
		dComponents.year = 1995
		dComponents.month = 6
		dComponents.day = 15
		dComponents.hour = 16
		dComponents.minute = 30
		dComponents.second = 55

		guard let dateInRome = DateInRegion(components: dComponents, region: regionRome) else {
			XCTFail("Failed to create DateInRegion from valid components")
			return
		}

		// Date must be expressed in Rome Time Zone which is UTC+1 for given date (1995/06/15)
		// So we expect the same components of the date components and given hour -1 in absolute date (UTC)
		let validDateTime = ((dateInRome.year == dComponents.year!) &&
			(dateInRome.month == dComponents.month!) &&
			(dateInRome.day == dComponents.day!) &&
			(dateInRome.hour == dComponents.hour!) &&
			(dateInRome.minute == dComponents.minute!) &&
			(dateInRome.second == dComponents.second!))
		XCTAssert(validDateTime, "Failed to create a valid DateInRegion in given region from components. One or more date components differs from original DateComponents")
		XCTAssert( (dateInRome.date.in(region: regionUTC).hour == 14), "DateInRegion absolute date different from expected UTC value (14:30 UTC for given date)")
	}

	func testDateInRegion_InitFromParams() {

		// Init with fixed parameters in a given region
		let regionLondon = Region(calendar: Calendars.gregorian, zone: Zones.europeLondon, locale: Locales.englishUnitedKingdom)
		let aDayInLondon = DateInRegion(year: 2001, month: 1, day: 5, hour: 23, minute: 30, second: 0, region: regionLondon)
		let validDateLondon = (aDayInLondon.year == 2001 && aDayInLondon.month == 1 && aDayInLondon.day == 5 && aDayInLondon.hour == 23 && aDayInLondon.minute == 30 && aDayInLondon.second == 0)
		XCTAssert(validDateLondon, "Failed to create a valid DateInRegion from paramters. One or more date components differs from original params")

		// Init with fixed parameters (and some other missings) in default region
		SwiftDate.defaultRegion = Region(calendar: Calendars.gregorian, zone: Zones.americaNewYork, locale: Locales.englishUnitedStates)
		let aDayInNY = DateInRegion(year: 1995, month: 1, day: 5)
		let validDateNY = (aDayInNY.year == 1995 && aDayInNY.month == 1 && aDayInNY.day == 5 && aDayInNY.hour == 0 && aDayInNY.minute == 0 && aDayInNY.second == 0)
		XCTAssert(validDateNY, "Failed to create a valid DateInRegion from paramters and default region. One or more date components differs from original params")
		XCTAssert( (aDayInNY.region == SwiftDate.defaultRegion), "Failed to create a valid DateInRegion from paramters and default region.")

	}

	func testDateInRegion_PastAndFuture() {
		XCTAssert( (DateInRegion.past().date == Date.distantPast), "Failed to create DateInRegion with distant past date")
		XCTAssert( (DateInRegion.future().date == Date.distantFuture), "Failed to create DateInRegion with distant future date")
	}

	func testDateInRegion_Description() {
		let regionParis = Region(calendar: Calendars.gregorian, zone: Zones.europeParis, locale: Locales.frenchFrance)
		let aDayInParis = DateInRegion(year: 2018, month: 5, day: 1, region: regionParis)

		let descriptionDayInParis = aDayInParis.description
		let expectedDescription = "{abs_date='2018-04-30T22:00:00Z', rep_date='2018-05-01T00:00:00+02:00', region={calendar='gregorian', timezone='Europe/Paris', locale='fr_FR'}"
		XCTAssert( (descriptionDayInParis == expectedDescription), "Failed to create valid description from DateInRegion")
	}

	func testDateInRegion_DateComponents() {
		let regionParis = Region(calendar: Calendars.gregorian, zone: Zones.europeParis, locale: Locales.frenchFrance)
		let aDayInParis = DateInRegion(year: 2018, month: 5, day: 1, region: regionParis)

		// Components of the date are expressed into the context of the region in which the date is created
		let comps = aDayInParis.dateComponents
		let areValidComponents = (comps.day! == 1 && comps.month! == 5 && comps.year! == 2018 && comps.hour! == 0 && comps.minute! == 0 && comps.second! == 0)
		XCTAssert(areValidComponents, "Failed to extract valid components in the context of the region of the DateInRegion instance")
	}

	func testDateInRegion_Hash() {
		//		let regionParis = Region(calendar: Calendars.gregorian, zone: Zones.europeParis, locale: Locales.frenchFrance)
		//		let aDayInParis = DateInRegion(year: 2018, month: 5, day: 1, region: regionParis)
		//		let sameDayInParis = DateInRegion(year: aDayInParis.year, month: aDayInParis.month, day: aDayInParis.day, region: regionParis)
		//
		//		XCTAssert( (aDayInParis.hashValue != sameDayInParis.hashValue), "Failed to extract hash value from different date with same values")
	}

	func testDateInRegion_InitComponentsCallback() {
		// From components in fixed region
		let regionRome = Region(calendar: Calendars.gregorian, zone: Zones.europeRome, locale: Locales.italian)
		guard let dateInRome = DateInRegion(components: {
			$0.year = 2001
			$0.month = 9
			$0.day = 11
			$0.hour = 12
			$0.minute = 0
			$0.second = 5
		}, region: regionRome) else {
			XCTFail("Failed to create valid date from components callback init")
			return
		}
		XCTValidateDateComponents(date: dateInRome, expec: ExpectedDateComponents {
			$0.year = 2001
			$0.month = 9
			$0.day = 11
			$0.hour = 12
			$0.minute = 0
			$0.second = 5
		})

		// From components in default region
		let regionNY = Region(calendar: Calendars.gregorian, zone: Zones.americaNewYork, locale: Locales.english)
		SwiftDate.defaultRegion = regionNY

		guard let dateInNY = DateInRegion(components: {
			$0.year = 2001
			$0.month = 9
			$0.day = 11
			$0.hour = 12
			$0.minute = 0
			$0.second = 5
		}) else {
			XCTFail("Failed to create valid date from components callback init")
			return
		}

		let inUTC = dateInNY.convertTo(region: Region.UTC)
		XCTValidateDateComponents(date: inUTC, expec: ExpectedDateComponents {
			$0.year = 2001
			$0.month = 9
			$0.day = 11
			$0.hour = 16
			$0.minute = 0
			$0.second = 5
		})
	}

	func testDateInRegion_ExtractComponents() {
		let regionParis = Region(calendar: Calendars.gregorian, zone: Zones.europeParis, locale: Locales.frenchFrance)
		let dateInParis = DateInRegion(year: 2006, month: 1, day: 1, hour: 0, minute: 45, second: 30, region: regionParis)

		// Validate in local region
		let componentsOfDate = dateInParis.dateComponents
		XCTAssert((componentsOfDate.year! == 2006), "Failed to extract local timezone date components from date / invalid year")
		XCTAssert((componentsOfDate.month! == 1), "Failed to extract local timezone date components from date / invalid month")
		XCTAssert((componentsOfDate.day! == 1), "Failed to extract local timezone date components from date / invalid day")
		XCTAssert((componentsOfDate.hour! == 0), "Failed to extract local timezone date components from date / invalid hour")
		XCTAssert((componentsOfDate.minute! == 45), "Failed to extract local timezone date components from date / invalid minute")
		XCTAssert((componentsOfDate.second! == 30), "Failed to extract local timezone date components from date / invalid second")

		// Validate in UTC
		SwiftDate.defaultRegion = Region.UTC
		let componentsInUTC = dateInParis.date.dateComponents // components are expressed in default zone! UTC
		XCTAssert((componentsInUTC.year! == 2005), "Failed to extract local timezone date components from date / invalid year")
		XCTAssert((componentsInUTC.month! == 12), "Failed to extract local timezone date components from date / invalid month")
		XCTAssert((componentsInUTC.day! == 31), "Failed to extract local timezone date components from date / invalid day")
		XCTAssert((componentsInUTC.hour! == 23), "Failed to extract local timezone date components from date / invalid hour")
		XCTAssert((componentsInUTC.minute! == 45), "Failed to extract local timezone date components from date / invalid minute")
		XCTAssert((componentsInUTC.second! == 30), "Failed to extract local timezone date components from date / invalid second")
	}

	func testDateInRegion_InitStringAutoFormat() {
		let regionParis = Region(calendar: Calendars.gregorian, zone: Zones.europeParis, locale: Locales.frenchFrance)

		// Init with no format (yyyy-MM-dd'T'HH:mm:ssZZZZZ)
		let expectedResult = ExpectedDateComponents {
			$0.year = 2015
			$0.month = 9
			$0.day = 24
			$0.hour = 13
			$0.minute = 20
			$0.second = 55
		}

		XCTValidateParse(string: "1:20 48055000", format: nil, region: regionParis, expec: ExpectedDateComponents {
			$0.hour = 13
			$0.minute = 20
			$0.msInDay = 48_056_000
		}) // h:mm A
		XCTValidateParse(string: "après Jésus-Christ-[4]04-jeu.", format: nil, region: regionParis, expec: ExpectedDateComponents {
			$0.day = 27
			$0.era = 1
		}) // GGGG-[W]WW-E
		XCTValidateParse(string: "après Jésus-Christ-[4]04", format: nil, region: regionParis, expec: ExpectedDateComponents {
			$0.era = 1
		}) // GGGG-[W]WW
		XCTValidateParse(string: "2015-09-24T13:20:55+02:00", format: nil, region: regionParis, expec: expectedResult) // yyyy-MM-dd'T'HH:mm:ssZZZZZ
		XCTValidateParse(string: "2015-09-24T13:20:55Z", format: nil, region: regionParis, expec: expectedResult) // yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'
		XCTValidateParse(string: "2015-09-24T13:20:55.000Z", format: nil, region: regionParis, expec: expectedResult) // yyyy'-'MM'-'dd'T'HH':'mm':'ss'.'SSS'Z'
		XCTValidateParse(string: "2015-09-24T13:20:55.000+0200", format: nil, region: regionParis, expec: expectedResult) // yyyy-MM-dd'T'HH:mm:ss.SSSZ
		XCTValidateParse(string: "2015-09-24", format: nil, region: regionParis, expec: ExpectedDateComponents {
			$0.year = 2015
			$0.month = 9
			$0.day = 24
		}) // yyyy-MM-dd
		XCTValidateParse(string: "2015-09-24 13:20:55", format: nil, region: regionParis, expec: expectedResult) // yyyy-MM-dd HH:mm:ss
		XCTValidateParse(string: "1:20:55 48055000", format: nil, region: regionParis, expec: ExpectedDateComponents {
			$0.hour = 13
			$0.minute = 20
			$0.second = 55
			$0.msInDay = 48_056_000
		}) // h:mm:ss A
		XCTValidateParse(string: "09/24/2015", format: nil, region: regionParis, expec: ExpectedDateComponents {
			$0.month = 9
			$0.day = 24
			$0.year = 2015
			$0.hour = 0
			$0.minute = 0
			$0.second = 0
		}) // MM/dd/yyyy
		XCTValidateParse(string: "septembre 24, 2015", format: nil, region: regionParis, expec: ExpectedDateComponents {
			$0.month = 9
			$0.day = 24
			$0.year = 2015
			$0.hour = 0
			$0.minute = 0
			$0.second = 0
		}) // MMMM d, yyyy
		XCTValidateParse(string: "002015-09-24", format: nil, region: regionParis, expec: ExpectedDateComponents {
			$0.month = 9
			$0.day = 24
			$0.year = 2015
			$0.hour = 0
			$0.minute = 0
			$0.second = 0
		}) // yyyyyy-MM-dd
		XCTValidateParse(string: "2015-09-24", format: nil, region: regionParis, expec: ExpectedDateComponents {
			$0.month = 9
			$0.day = 24
			$0.year = 2015
			$0.hour = 0
			$0.minute = 0
			$0.second = 0
		}) // yyyy-MM-dd
		XCTValidateParse(string: "2015-024", format: nil, region: regionParis, expec: ExpectedDateComponents {
			$0.dayOfYear = 24
			$0.year = 2015
			$0.hour = 0
			$0.minute = 0
			$0.second = 0
		}) // yyyy-ddd
		XCTValidateParse(string: "13:20:55.0000", format: nil, region: regionParis, expec: ExpectedDateComponents {
			$0.hour = 13
			$0.minute = 20
			$0.second = 55
		}) // HH:mm:ss.SSSS
		XCTValidateParse(string: "13:20:55", format: nil, region: regionParis, expec: ExpectedDateComponents {
			$0.hour = 13
			$0.minute = 20
			$0.second = 55
		}) // HH:mm:ss
		XCTValidateParse(string: "13:20", format: nil, region: regionParis, expec: ExpectedDateComponents {
			$0.hour = 13
			$0.minute = 20
		}) // HH:mm
		XCTValidateParse(string: "13", format: nil, region: regionParis, expec: ExpectedDateComponents {
			$0.hour = 13
		}) // HH

	}
}

public struct ExpectedDateComponents {
	var year: Int?
	var day: Int?
	var dayOfYear: Int?
	var month: Int?
	var hour: Int?
	var minute: Int?
	var second: Int?
	var weekOfMonth: Int?
	var msInDay: Int?
	var era: Int?
	var monthDays: Int?
	var weekOfYear: Int?
	var weekdayOrdinal: Int?
	var firstDayOfWeek: Int?
	var lastDayOfWeek: Int?
	var yearForWeekOfYear: Int?
	var quarter: Int?
	var DSTOffset: TimeInterval?
	var nearestHour: Int?

	var monthNameDefault: String?
	var monthNameDefaultStd: String?
	var monthNameShort: String?
	var monthNameStandaloneShort: String?
	var monthNameVeryShort: String?
	var monthNameStandaloneVeryShort: String?

	var weekday: Int?
	var weekdayNameDefault: String?
	var weekdayNameDefaultStd: String?
	var weekdayNameShort: String?
	var weekdayNameShortStd: String?
	var weekdayNameVeryShort: String?
	var weekdayNameVeryShortStd: String?

	var eraNameDefault: String?
	var eraNameDefaultStd: String?
	var eraNameShort: String?
	var eraNameShortStd: String?
	var eraNameVeryShort: String?
	var eraNameVeryShortStd: String?

	public init(_ configure: ((inout ExpectedDateComponents) -> Void)? = nil) {
		configure?(&self)
	}

	func validate(_ date: DateInRegion, _ origin: String) -> String? {
		if let year = self.year, year != date.year { return "year" }
		if let day = self.day, day != date.day { return "day" }
		if let month = self.month, month != date.month { return "month" }
		if let minute = self.minute, minute != date.minute {
			return "minute exp='\(self.minute!)' val='\(date.minute)' date='\(date)' origin='\(origin)'"
		}
		if let second = self.second, second != date.second { return "second" }
		if let weekOfMonth = self.weekOfMonth, weekOfMonth != date.weekOfMonth { return "weekOfMonth" }
		if let dayOfYear = self.dayOfYear, dayOfYear != date.dayOfYear { return "dayOfYear" }
		if let era = self.era, era != date.era { return "era" }
		if let msInDay = self.msInDay, msInDay != date.msInDay { return "msInDay" }
		if let monthNameDefault = self.monthNameDefault, monthNameDefault != date.monthName(.`default`) { return "monthName(.`default`)" }
		if let monthNameDefaultStd = self.monthNameDefaultStd, monthNameDefaultStd != date.monthName(.defaultStandalone) { return "monthName(.defaultStandalone)" }
		if let monthNameShort = self.monthNameShort, monthNameShort != date.monthName(.short) { return "monthName(.short)" }
		if let monthNameVeryShort = self.monthNameVeryShort, monthNameVeryShort != date.monthName(.veryShort) { return "monthName(.veryShort)" }
		if let monthNameStandaloneShort = self.monthNameStandaloneShort, monthNameStandaloneShort != date.monthName(.standaloneShort) { return "monthName(.standaloneShort)" }
		if let monthNameStandaloneVeryShort = self.monthNameStandaloneVeryShort, monthNameStandaloneVeryShort != date.weekdayName(.standaloneVeryShort) { return "weekdayName(.veryShortStandalone)" }

		if let monthDays = self.monthDays, monthDays != date.monthDays { return "monthDays" }

		if let weekday = self.weekday, weekday != date.weekday { return "weekday" }
		if let weekdayNameDefault = self.weekdayNameDefault, weekdayNameDefault != date.weekdayName(.`default`) { return "weekdayName(.`default`)" }
		if let weekdayNameDefaultStd = self.weekdayNameDefaultStd, weekdayNameDefaultStd != date.weekdayName(.defaultStandalone) { return "weekdayName(.defaultStandalone)" }
		if let weekdayNameShort = self.weekdayNameShort, weekdayNameShort != date.weekdayName(.short) { return "weekdayName(.short)" }
		if let weekdayNameShortStd = self.weekdayNameShortStd, weekdayNameShortStd != date.weekdayName(.standaloneShort) { return "weekdayName(.shortStandalone)" }
		if let weekdayNameVeryShort = self.weekdayNameVeryShort, weekdayNameVeryShort != date.weekdayName(.veryShort) { return "weekdayName(.veryShort)" }
		if let weekdayNameVeryShortStd = self.weekdayNameVeryShortStd, weekdayNameVeryShortStd != date.weekdayName(.standaloneVeryShort) { return "weekdayName(.veryShortStandalone)" }

		if let weekOfYear = self.weekOfYear, weekOfYear != date.weekOfYear { return "weekOfYear" }
		if let weekdayOrdinal = self.weekdayOrdinal, weekdayOrdinal != date.weekdayOrdinal { return "weekdayOrdinal" }
		if let firstDayOfWeek = self.firstDayOfWeek, firstDayOfWeek != date.firstDayOfWeek { return "firstDayOfWeek" }
		if let lastDayOfWeek = self.lastDayOfWeek, lastDayOfWeek != date.lastDayOfWeek { return "lastDayOfWeek" }
		if let yearForWeekOfYear = self.yearForWeekOfYear, yearForWeekOfYear != date.yearForWeekOfYear { return "yearForWeekOfYear" }
		if let quarter = self.quarter, quarter != date.quarter { return "quarter" }

		if let eraNameDefault = self.eraNameDefault, eraNameDefault != date.eraName(.`default`) { return "eraName(.`default`)" }
		if let eraNameDefaultStd = self.eraNameDefaultStd, eraNameDefaultStd != date.eraName(.defaultStandalone) { return "eraName(.defaultStandalone)" }
		if let eraNameShort = self.eraNameShort, eraNameShort != date.eraName(.short) { return "eraName(.short)" }
		if let eraNameShortStd = self.eraNameShortStd, eraNameShortStd != date.eraName(.standaloneShort) { return "eraName(.shortStandalone)" }
		if let eraNameVeryShort = self.eraNameVeryShort, eraNameVeryShort != date.eraName(.veryShort) { return "eraName(.veryShort)" }
		if let eraNameVeryShortStd = self.eraNameVeryShortStd, eraNameVeryShortStd != date.eraName(.standaloneVeryShort) { return "eraName(.veryShortStandalone)" }

		if let DSTOffset = self.DSTOffset, DSTOffset != date.DSTOffset { return "DSTOffset" }
		if let nearestHour = self.nearestHour, nearestHour != date.nearestHour { return "nearestHour" }

		return nil
	}
}

func XCTValidateParse(string: String, format: String?, region: Region, expec: ExpectedDateComponents) {
	guard let date = DateInRegion(string, format: format, region: region) else {
		XCTFail("Failed to parse date '\(string)' with format: '\(format ?? "<AUTO>")'")
		return
	}
	if let errors = expec.validate(date, string) {
		XCTFail("Failed to validate components of parsed date string '\(string)' with format: '\(format ?? "<AUTO>")'. One or more components differ from expected: \(errors)")
		return
	}
}

func XCTValidateDateComponents(date: DateInRegion, expec: ExpectedDateComponents) {
	if let errors = expec.validate(date, "") {
		XCTFail("Failed to validate components of date '\(date.description)'. One or more components differ from expected: \(errors)")
		return
	}
}
