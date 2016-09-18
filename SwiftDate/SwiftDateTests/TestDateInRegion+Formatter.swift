//
//  TestDateInRegion+Formatter.swift
//  SwiftDate
//
//  Created by Daniele Margutti on 18/09/2016.
//  Copyright © 2016 Daniele Margutti. All rights reserved.
//

import Foundation
import XCTest
@testable import SwiftDate


class TestDateInRegion_Formatter: XCTestCase {
	
	let refDate = try! DateInRegion(components: [.year: 2015, .month: 12, .day: 14, .hour: 13], fromRegion: Region(tz: TimeZones.americaParamaribo, cal: Calendars.gregorian, loc: Locales.dutch))
	
	override func setUp() {
		super.setUp()
	}
	
	override func tearDown() {
		super.tearDown()
	}
	
	public func test_toString() {
		let rome = Region(tz: TimeZones.europeRome, cal: Calendars.gregorian, loc: Locales.italian)
		let date = try! DateInRegion(components: [.year: 2001, .month: 2, .day: 3, .hour: 15, .minute: 30], fromRegion: rome)

		let iso8601_internetTime = date.string(format: .iso8601(options: .withInternetDateTime))
		XCTAssertEqual(iso8601_internetTime, "2001-02-03T15:30:00+01:00", "Failed get string representation as ISO8601 Internet DateTime")

		let iso8601_fullDate = date.string(format: .iso8601(options: .withFullDate))
		XCTAssertEqual(iso8601_fullDate, "2001-02-03", "Failed get string representation as ISO8601 Full Date")
	}
}
