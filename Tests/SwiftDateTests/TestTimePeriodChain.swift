//
//  SwiftDate
//  Parse, validate, manipulate, and display dates, time and timezones in Swift
//
//  Created by AsioOtus
//   - Mail: asio.otus.verus@icloud.com
//
//  Copyright © 2019 Daniele Margutti. Licensed under MIT License.
//

import SwiftDate
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
	
}
