//
//  TestDate+Compare.swift
//  SwiftDate
//
//  Created by Daniele Margutti on 29/06/2018.
//  Copyright © 2018 SwiftDate. All rights reserved.
//

import XCTest

class TestDate_Compare: XCTestCase {

	func testCompareCloseTo() {
		let dateA = Date()
		let dateB: Date = (dateA + 4.minutes)
		XCTAssert( dateB.compareCloseTo(dateA), "Failed to compare two close dates (in 5 minutes)")
	}

}
