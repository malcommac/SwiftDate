//
//  SwiftDate
//  Parse, validate, manipulate, and display dates, time and timezones in Swift
//
//  Created by AsioOtus
//   - Mail: asio.otus.verus@icloud.com
//
//  Copyright © 2019 Daniele Margutti. Licensed under MIT License.
//

@testable import SwiftDate
import XCTest

class TestTimePeriodChain: XCTestCase {
	let periods = [
		TimePeriod(start: .init(year: 2020, month: 2, day: 1), end: .init(year: 2020, month: 2, day: 28)),
		TimePeriod(start: .init(year: 2020, month: 3, day: 1), end: .init(year: 2020, month: 3, day: 31)),
		TimePeriod(start: .init(year: 2020, month: 4, day: 1), end: .init(year: 2020, month: 4, day: 30)),
		TimePeriod(start: .init(year: 2020, month: 5, day: 1), end: .init(year: 2020, month: 5, day: 31))
	]
	
	func testInitialExtremes () {
		let chain = TimePeriodChain(periods)
		
		XCTAssert(chain.start == periods.first!.start, "TimePeriodChain initial start not equals to source period start")
		XCTAssert(chain.end == periods.last!.end, "TimePeriodChain initial end not equals to source period end")
	}
		
	func testInsert () {
		let chain = TimePeriodChain(periods)
		let period = TimePeriod(start: .init(year: 2020, month: 1, day: 1), end: .init(year: 2020, month: 1, day: 20))
		
		let originalDuration_0 = chain.periods[0].duration
		let originalDuration_1 = chain.periods[1].duration
		let originalDuration_2 = chain.periods[2].duration
		let originalDuration_3 = chain.periods[3].duration
		
		chain.insert(period, at: 2)
		
		XCTAssert(chain.periods[0].duration == originalDuration_0, "Unexpected duration of 0 period– Actual: \(chain.periods[0].duration) – Expected: \(originalDuration_0)")
		XCTAssert(chain.periods[1].duration == originalDuration_1, "Unexpected duration of 1 period – Actual: \(chain.periods[1].duration) – Expected: \(originalDuration_1)")
		XCTAssert(chain.periods[2].duration == period.duration, "Unexpected duration of 2 period – Actual: \(chain.periods[2].duration) – Expected: \(period.duration)")
		XCTAssert(chain.periods[3].duration == originalDuration_2, "Unexpected duration of 3 period – Actual: \(chain.periods[3].duration) – Expected: \(originalDuration_2)")
		XCTAssert(chain.periods[4].duration == originalDuration_3, "Unexpected duration of 4 period – Actual: \(chain.periods[4].duration) – Expected: \(originalDuration_3)")
	}
	
	func testPrependPeriod () {
		let period = TimePeriod(start: .init(year: 2020, month: 1, day: 1), end: .init(year: 2020, month: 1, day: 20))
		let chain = TimePeriodChain(periods)
		
		chain.prepend(period)
		
		XCTAssert(
			chain[0].start == DateInRegion(year: 2020, month: 1, day: 13),
			"Prepended TimePeriodChain contains unexpected period start date – Actual: \(chain[0].start!) – Expected: \(DateInRegion(year: 2020, month: 1, day: 13))"
		)
		
		XCTAssert(
			chain[1].start == DateInRegion(year: 2020, month: 2, day: 1),
			"Prepended TimePeriodChain contains unexpected period start date – Actual: \(chain[1].start!) – Expected: \(DateInRegion(year: 2020, month: 2, day: 1))"
		)
		
		XCTAssert(
			chain[2].start == DateInRegion(year: 2020, month: 3, day: 1),
			"Prepended TimePeriodChain contains unexpected period start date – Actual: \(chain[2].start!) – Expected: \(DateInRegion(year: 2020, month: 3, day: 1))"
		)
		
		XCTAssert(
			chain[3].start == DateInRegion(year: 2020, month: 4, day: 1),
			"Prepended TimePeriodChain contains unexpected period start date – Actual: \(chain[3].start!) – Expected: \(DateInRegion(year: 2020, month: 4, day: 1))"
		)
		
		XCTAssert(
			chain[4].start == DateInRegion(year: 2020, month: 5, day: 1),
			"Prepended TimePeriodChain contains unexpected period start date – Actual: \(chain[4].start!) – Expected: \(DateInRegion(year: 2020, month: 5, day: 1))"
		)
	}
	
	func testPrependGroup () {
		let testPeriods = [
			TimePeriod(start: .init(year: 2019, month: 10, day: 1), end: .init(year: 2019, month: 10, day: 31)),
			TimePeriod(start: .init(year: 2019, month: 11, day: 1), end: .init(year: 2019, month: 11, day: 30)),
			TimePeriod(start: .init(year: 2019, month: 12, day: 1), end: .init(year: 2019, month: 12, day: 31)),
		]
		let group = TimePeriodGroup(testPeriods)
		let chain = TimePeriodChain(periods)
		
		chain.prepend(contentsOf: group)
		
		XCTAssert(
			chain[0].start == DateInRegion(year: 2019, month: 11, day: 4),
			"Prepended TimePeriodChain contains unexpected period start date – Actual: \(chain[0].start!) – Expected: \(DateInRegion(year: 2019, month: 11, day: 1))"
		)
		
		XCTAssert(
			chain[1].start == DateInRegion(year: 2019, month: 12, day: 4),
			"Prepended TimePeriodChain contains unexpected period start date – Actual: \(chain[1].start!) – Expected: \(DateInRegion(year: 2019, month: 12, day: 4))"
		)
		
		XCTAssert(
			chain[2].start == DateInRegion(year: 2020, month: 1, day: 2),
			"Prepended TimePeriodChain contains unexpected period start date – Actual: \(chain[2].start!) – Expected: \(DateInRegion(year: 2020, month: 1, day: 2))"
		)
		
		XCTAssert(
			chain[3].start == DateInRegion(year: 2020, month: 2, day: 1),
			"Prepended TimePeriodChain contains unexpected period start date – Actual: \(chain[3].start!) – Expected: \(DateInRegion(year: 2020, month: 2, day: 1))"
		)
		
		XCTAssert(
			chain[4].start == DateInRegion(year: 2020, month: 3, day: 1),
			"Prepended TimePeriodChain contains unexpected period start date – Actual: \(chain[4].start!) – Expected: \(DateInRegion(year: 2020, month: 3, day: 1))"
		)
		
		XCTAssert(
			chain[5].start == DateInRegion(year: 2020, month: 4, day: 1),
			"Prepended TimePeriodChain contains unexpected period start date – Actual: \(chain[5].start!) – Expected: \(DateInRegion(year: 2020, month: 4, day: 1))"
		)
		
		XCTAssert(
			chain[6].start == DateInRegion(year: 2020, month: 5, day: 1),
			"Prepended TimePeriodChain contains unexpected period start date – Actual: \(chain[6].start!) – Expected: \(DateInRegion(year: 2020, month: 5, day: 1))"
		)
	}
	
	func testAppendPeriod () {
		let period = TimePeriod(start: .init(year: 2020, month: 1, day: 1), end: .init(year: 2020, month: 1, day: 20))
		let chain = TimePeriodChain(periods)
		
		chain.append(period)
		
		XCTAssert(
			chain[0].end == DateInRegion(year: 2020, month: 2, day: 28),
			"Appended TimePeriodChain contains unexpected period end date – Actual: \(chain[0].end!) – Expected: \(DateInRegion(year: 2020, month: 2, day: 28))"
		)
		
		XCTAssert(
			chain[1].end == DateInRegion(year: 2020, month: 3, day: 31),
			"Appended TimePeriodChain contains unexpected period end date – Actual: \(chain[1].end!) – Expected: \(DateInRegion(year: 2020, month: 3, day: 31))"
		)
		
		XCTAssert(
			chain[2].end == DateInRegion(year: 2020, month: 4, day: 30),
			"Appended TimePeriodChain contains unexpected period end date – Actual: \(chain[2].end!) – Expected: \(DateInRegion(year: 2020, month: 4, day: 30))"
		)
		
		XCTAssert(
			chain[3].end == DateInRegion(year: 2020, month: 5, day: 31),
			"Appended TimePeriodChain contains unexpected period end date – Actual: \(chain[3].end!) – Expected: \(DateInRegion(year: 2020, month: 5, day: 31))"
		)
		
		XCTAssert(
			chain[4].end == DateInRegion(year: 2020, month: 6, day: 19),
			"Appended TimePeriodChain contains unexpected period end date – Actual: \(chain[4].end!) – Expected: \(DateInRegion(year: 2020, month: 6, day: 19))"
		)
	}
	
	func testAppendGroup () {
		let testPeriods = [
			TimePeriod(start: .init(year: 2019, month: 10, day: 1), end: .init(year: 2019, month: 10, day: 31)),
			TimePeriod(start: .init(year: 2019, month: 11, day: 1), end: .init(year: 2019, month: 11, day: 30)),
			TimePeriod(start: .init(year: 2019, month: 12, day: 1), end: .init(year: 2019, month: 12, day: 31)),
		]
		let group = TimePeriodGroup(testPeriods)
		let chain = TimePeriodChain(periods)
		
		chain.append(contentsOf: group)
		
		XCTAssert(
			chain[0].end == DateInRegion(year: 2020, month: 2, day: 28),
			"Prepended TimePeriodChain contains unexpected period end date – Actual: \(chain[0].end!) – Expected: \(DateInRegion(year: 2020, month: 2, day: 28))"
		)
		
		XCTAssert(
			chain[1].end == DateInRegion(year: 2020, month: 3, day: 31),
			"Prepended TimePeriodChain contains unexpected period end date – Actual: \(chain[1].end!) – Expected: \(DateInRegion(year: 2020, month: 3, day: 31))"
		)
		
		XCTAssert(
			chain[2].end == DateInRegion(year: 2020, month: 4, day: 30),
			"Prepended TimePeriodChain contains unexpected period end date – Actual: \(chain[2].end!) – Expected: \(DateInRegion(year: 2020, month: 4, day: 30))"
		)
		
		XCTAssert(
			chain[3].end == DateInRegion(year: 2020, month: 5, day: 31),
			"Prepended TimePeriodChain contains unexpected period end date – Actual: \(chain[3].end!) – Expected: \(DateInRegion(year: 2020, month: 5, day: 31))"
		)
		
		XCTAssert(
			chain[4].end == DateInRegion(year: 2020, month: 6, day: 30),
			"Prepended TimePeriodChain contains unexpected period end date – Actual: \(chain[4].end!) – Expected: \(DateInRegion(year: 2020, month: 6, day: 30))"
		)
		
		XCTAssert(
			chain[5].end == DateInRegion(year: 2020, month: 7, day: 29),
			"Prepended TimePeriodChain contains unexpected period end date – Actual: \(chain[5].end!) – Expected: \(DateInRegion(year: 2020, month: 7, day: 29))"
		)
		
		XCTAssert(
			chain[6].end == DateInRegion(year: 2020, month: 8, day: 28),
			"Prepended TimePeriodChain contains unexpected period end date – Actual: \(chain[6].end!) – Expected: \(DateInRegion(year: 2020, month: 8, day: 28))"
		)
	}
	
	func testShiftStartToDate () {
		let date = DateInRegion(year: 2020, month: 1, day: 1)
		let chain = TimePeriodChain(periods)
		
		chain.shiftStart(to: date)
		
		XCTAssert(
			chain.start == DateInRegion(year: 2020, month: 1, day: 1),
			"Shifted TimePeriodChain has unexpected start date – Actual: \(chain.start!) – Expected: \(DateInRegion(year: 2020, month: 1, day: 1))"
		)
		
		XCTAssert(
			chain.end == DateInRegion(year: 2020, month: 4, day: 30),
			"Shifted TimePeriodChain has unexpected end date – Actual: \(chain.end!) – Expected: \(DateInRegion(year: 2020, month: 4, day: 30))"
		)
	}
	
	func testShiftEndToDate () {
		let date = DateInRegion(year: 2020, month: 1, day: 1)
		let chain = TimePeriodChain(periods)
		
		chain.shiftEnd(to: date)
		
		XCTAssert(
			chain.start == DateInRegion(year: 2019, month: 9, day: 3),
			"Shifted TimePeriodChain has unexpected start date – Actual: \(chain.start!) – Expected: \(DateInRegion(year: 2019, month: 9, day: 3))"
		)
		
		XCTAssert(
			chain.end == DateInRegion(year: 2020, month: 1, day: 1),
			"Shifted TimePeriodChain has unexpected end date – Actual: \(chain.end!) – Expected: \(DateInRegion(year: 2020, month: 1, day: 1))"
		)
	}

}
