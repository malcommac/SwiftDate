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

class TestRegion: XCTestCase {
    
    func test() {
        let ago5Mins = DateInRegion() - 5.minutes
        let x = ago5Mins.toRelative(since: nil, dateTimeStyle: .named, unitsStyle: .short)
        print(x)
    }

	func testRegionInit() {

		SwiftDate.defaultRegion = Region(calendar: Calendars.gregorian, zone: Zones.gmt, locale: Locales.english)

		// UTC Region
		XCTAssert( (Region.UTC.timeZone.identifier == Zones.gmt.toTimezone().identifier), "Failed to create UTC region")
		XCTAssert( (Region.UTC.calendar.identifier == Calendar.autoupdatingCurrent.identifier), "Failed to inherith the appropriate calendar fromd default region")
		XCTAssert( (Region.UTC.locale.identifier == Locale.autoupdatingCurrent.identifier), "Failed to inherith the appropriate locale fromd default region")

		// New Region
		let region1 = Region(calendar: Calendars.gregorian, zone: Zones.europeRome, locale: Locales.italian)
		XCTAssert( (region1.timeZone.identifier == "Europe/Rome"), "Failed to set region's zone")
		XCTAssert( (region1.calendar.identifier == Calendar.Identifier.gregorian), "Failed to set region's calendar")
		XCTAssert( (region1.locale.identifier == "it"), "Failed to set region's locale")

		// Current Region
		let currentRegion = Region.current
		XCTAssert( (currentRegion.calendar.identifier == Calendar.current.identifier), "Failed to set current's region calendar")
		XCTAssert( (currentRegion.timeZone.identifier == TimeZone.current.identifier), "Failed to set current's region timezone")
		XCTAssert( (currentRegion.locale.identifier == Locale.current.identifier), "Failed to set current's region locale")

		// Default region in another locale and calendar
		let modifiedDefaultRegion = Region.currentIn(locale: Locales.japanese, calendar: Calendars.japanese)
		XCTAssert( (modifiedDefaultRegion.locale.identifier == Locale(identifier: "ja").identifier), "Failed to create new region from default with modified locale")
		XCTAssert( (modifiedDefaultRegion.calendar.identifier == Calendar(identifier: Calendar.Identifier.japanese).identifier), "Failed to create new region from default with modified calendar")

		// Default region in another locale and calendar, no action
		let unmodifiedDefaultRegion = Region.currentIn()
		XCTAssert( (unmodifiedDefaultRegion == SwiftDate.defaultRegion), "currentIn() with no parameters should return unmodified default region")

		// Default region in another locale and calendar, only calendar
		let modifiedCalendarDefaultRegion = Region.currentIn(calendar: Calendars.buddhist)
		XCTAssert( (modifiedCalendarDefaultRegion.calendar.identifier == Calendar.Identifier.buddhist), "currentIn() with modified calendar only does not work")
		XCTAssert( (modifiedCalendarDefaultRegion.locale == SwiftDate.defaultRegion.locale), "currentIn() with modified calendar also modify the locale")

		// Default region in another locale and calendar, only locale
		let modifiedLocaleDefaultRegion = Region.currentIn(locale: Locales.italian)
		XCTAssert( (modifiedLocaleDefaultRegion.locale.identifier == Locale(identifier: "it").identifier), "currentIn() with modified locale only does not work")
		XCTAssert( (modifiedLocaleDefaultRegion.calendar.identifier == SwiftDate.defaultRegion.calendar.identifier), "currentIn() with modified locale also modify the calendar")

		// Init from DateComponents
		var dComps = DateComponents()
		dComps.calendar = Calendar(identifier: Calendar.Identifier.coptic)
		dComps.timeZone = TimeZone(identifier: "Pacific/Truk")
		let regionFromComponents = Region(fromDateComponents: dComps)
		XCTAssert( (regionFromComponents.calendar == dComps.calendar!), "Failed to create new region from date components / calendar")
		XCTAssert( (regionFromComponents.timeZone == dComps.timeZone!), "Failed to create new region from date components / timezone")

		// Compare two regions
		let regionA = Region(calendar: Calendars.gregorian, zone: Zones.europeOslo, locale: Locales.english)
		let regionB = Region(calendar: Calendars.gregorian, zone: Zones.europeOslo, locale: Locales.english)
		let regionC = Region(calendar: Calendars.buddhist, zone: Zones.europeOslo, locale: Locales.english)
		let regionD = Region(calendar: Calendars.gregorian, zone: Zones.europeRome, locale: Locales.english)
		let regionE = Region(calendar: Calendars.buddhist, zone: Zones.europeOslo, locale: Locales.italian)
		XCTAssert( (regionA == regionB), "Failed to compare two regions")
		XCTAssert( (regionC != regionD && regionD != regionE), "Failed to compare two regions")

		// Codable/Decodable for Region
		do {
			let encodedJSON_A = try JSONEncoder().encode(regionA)
			let encodedJSON_B = try JSONEncoder().encode(regionB)
			XCTAssert( (encodedJSON_A == encodedJSON_B), "Same data regions does not encode the same")

			let decodedJSON_RegionA = try JSONDecoder().decode(Region.self, from: encodedJSON_A)
			let decodedJSON_RegionB = try JSONDecoder().decode(Region.self, from: encodedJSON_B)
			XCTAssert( (decodedJSON_RegionA == decodedJSON_RegionB), "Same data decoded region are not the same")

			let stringJSON_A = String(data: encodedJSON_A, encoding: .utf8)
			let compareStringJSON_A = "{\"timezone\":\"Europe\\/Oslo\",\"locale\":\"en\",\"calendar\":\"gregorian\"}"
			XCTAssert( (stringJSON_A! == compareStringJSON_A), "JSON differ in encodable")

		} catch let err {
			XCTFail("Failed to test encodable/decodable on Region: \(err)")
		}

		// Description
		let descriptionRegion_A = regionA.description
		let expectedDescRegion_A = "{calendar='gregorian', timezone='Europe/Oslo', locale='en'}"
		XCTAssert( (descriptionRegion_A == expectedDescRegion_A), "Region description differ from expected")

		// Hash value
		let hash_regionA = regionA.hashValue
		let hash_regionB = regionB.hashValue
		XCTAssert( (hash_regionA == hash_regionB), "Hash value fails")

		// Current date in this region
		let regionIT = Region(calendar: Calendars.gregorian, zone: Zones.europeRome, locale: Locales.italian)
		let nowInIT = regionIT.nowInThisRegion()
		XCTAssert( (nowInIT.region == regionIT), "Produced date in Region.nowInThisRegion does not have the same origin Region")
		XCTAssertInTimeIntervalRange(value: nowInIT.date.timeIntervalSinceNow, range: 2, "Produced date in Region.nowInThisRegion does not have the current date")

		// Init with default region data
		let regionWithDefault = Region()
		XCTAssert( (regionWithDefault == SwiftDate.defaultRegion), "Failed to create new Region from default region")

		// Init with only fixed calendar
		let defaultRegion_fixedCal = Region(calendar: Calendars.buddhist)
		XCTAssert( (defaultRegion_fixedCal.calendar.identifier == Calendar.Identifier.buddhist), "Failed to new region from default with fixed only calendar / different calendar")
		XCTAssert( (defaultRegion_fixedCal.locale.identifier == SwiftDate.defaultRegion.locale.identifier), "Failed to new region from default with fixed only calendar / different locale")
		XCTAssert( (defaultRegion_fixedCal.timeZone.identifier == SwiftDate.defaultRegion.timeZone.identifier), "Failed to new region from default with fixed only calendar / different timezone")

	}

}

func XCTAssertInTimeIntervalRange(value: Double, range: TimeInterval, _ error: String) {
	guard value >= (value - range) && value <= (value + range) else {
		XCTFail(error)
		return
	}
}
