//
//  TestSwiftDate.swift
//  SwiftDate
//
//  Created by Daniele Margutti on 29/06/2018.
//  Copyright © 2018 SwiftDate. All rights reserved.
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
