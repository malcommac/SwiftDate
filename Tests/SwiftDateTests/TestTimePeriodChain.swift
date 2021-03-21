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
}
