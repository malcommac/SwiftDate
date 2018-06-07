//
//  TestInterval.swift
//  SwiftDate
//
//  Created by Daniele Margutti on 06/06/2018.
//  Copyright © 2018 SwiftDate. All rights reserved.
//

import Foundation
import SwiftDate
import XCTest

class TestInterval: XCTestCase {

	func testMathOperations() {
		XCTAssertEqual((1.days + 2.weeks).inDays.value, 15)
		XCTAssertEqual((10.minutes + 30.seconds).timeInterval, 630)
		XCTAssertEqual(Interval<Day>((1.years.inDays + 10.days).value).value, 375.0) // this to avoid round issues
		XCTAssertEqual((5.hours + 3.hours).value, 8.0)
		XCTAssertEqual( Interval<Day>(1.months + 1.weeks).value, 5)
	}

	func testUnitConversions() {
		XCTAssertEqual(10.minutes.inSeconds.value, 600)
		XCTAssertEqual(1.hours.inSeconds.value, 3600)
		XCTAssertEqual(5.minutes.inNanoseconds.value, 3e+11)
		XCTAssertEqual(6.days.inHours.value, 144)
		XCTAssertEqual(10.days.inMinutes.inHours.value, 240)
		XCTAssertEqual(1.seconds.inMilliseconds.value, 1000)
		XCTAssertEqual(1.seconds.inNanoseconds.inDays.value, 1.1574074074074073e-05)
		XCTAssertEqual(1.weeks.inDays.value, 7)
		XCTAssertEqual(1.years.inMonths.value, 12)
		XCTAssertEqual(1.years.inDays.value, 365)
		XCTAssertEqual(1.months.inMinutes.value, 30.416_666_666_666_668)
		XCTAssertEqual(5.hours.converted(as: Minute.self).value, 300.0)
	}

	func testIntervalCompare() {
		XCTAssert(1.minutes == 60.seconds)
		XCTAssert(1.days == 24.hours)
		XCTAssert(24.hours == 86400.seconds)
		XCTAssert(86400.seconds == 1440.minutes)
		XCTAssert(12.days == 1_036_800_000.milliseconds)
		XCTAssertTrue(10.minutes > 100.seconds)
		XCTAssertTrue(1.days > 23.hours)
		XCTAssertTrue(60.minutes < 3601.seconds)
	}

	func testCustomTypes() {
		let fiveSeconds = Interval<Second>(5)
		XCTAssertEqual(fiveSeconds.value, 5)
		let days31 = Interval<Day>(31)
		XCTAssertEqual(days31.inHours.value, 744)
	}

    static var allTests = [
        ("testUnitConversions", testUnitConversions),
		("testIntervalCompare", testIntervalCompare),
		("testMathOperations", testMathOperations)
    ]
}
