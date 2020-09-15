//
//  TestDate.swift
//  SwiftDate-macOS Tests
//
//  Created by Imthath M on 30/05/19.
//  Copyright © 2019 SwiftDate. All rights reserved.
//

import SwiftDate
import XCTest

class TestDate: XCTestCase {

	override func setUp() {
		// Put setup code here. This method is called before the invocation of each test method in the class.
	}

	override func tearDown() {
		// Put teardown code here. This method is called after the invocation of each test method in the class.
	}

	func testDifferencesBetweenDates() {
		let date = Date()
		let date2 = "2019-01-05".toDate()!.date
		let result = date.differences(in: [.hour, .day, .month], from: date2)
		print(result)
	}

  func testDifferenceBetweenDates() {
    let date = Date()
    let date2 = "2019-01-05".toDate()!.date
    let result = date.difference(in: .day, from: date2)
    print(result!)
  }

	func testPositionInRange() {
		let regionRome = Region(calendar: Calendars.gregorian, zone: Zones.europeRome, locale: Locales.italian)
		let regionLondon = Region(calendar: Calendars.gregorian, zone: Zones.europeLondon, locale: Locales.english)
		let dateFormat = "yyyy-MM-dd HH:mm:ss"

		let lowerBound = "2018-05-31 23:00:00".toDate(dateFormat, region: regionRome)!.date
		let upperBound = "2018-06-01 01:00:00".toDate(dateFormat, region: regionRome)!.date

		let testDate1 = "2018-06-01 00:30:00".toDate(dateFormat, region: regionRome)!.date
		XCTAssertEqual( testDate1.positionInRange(date: lowerBound, and: upperBound), 0.75)

		let testDate2 = "2018-05-31 22:30:00".toDate(dateFormat, region: regionLondon)!.date
		XCTAssertEqual( testDate2.positionInRange(date: lowerBound, and: upperBound), 0.25)

		let testDate3 = "2018-05-31 21:00:00".toDate(dateFormat, region: regionLondon)!.date
		XCTAssertNil( testDate3.positionInRange(date: lowerBound, and: upperBound))

		let testDate4 = "2018-06-01 03:00:00".toDate(dateFormat, region: regionLondon)!.date
		XCTAssertNil( testDate4.positionInRange(date: lowerBound, and: upperBound))
	}

}
