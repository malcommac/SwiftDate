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

class TestSwiftDate: XCTestCase {

	func testAutoFormats() {
		let builtInAutoFormats = SwiftDate.autoFormats
		XCTAssert((SwiftDate.autoFormats.isEmpty == false), "No auto formats available")
		let newFormats = [DateFormats.altRSS, DateFormats.extended, DateFormats.httpHeader]
		SwiftDate.autoFormats = newFormats
		XCTAssert( (SwiftDate.autoFormats == newFormats), "Failed to set new auto formats")
		SwiftDate.resetAutoFormats()
		XCTAssert( (SwiftDate.autoFormats == builtInAutoFormats), "Failed to reset auto formats")
	}

}
