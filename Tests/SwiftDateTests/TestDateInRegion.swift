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

class TestDateInRegion: XCTestCase {

	func testInitialize() {
		let x = DateInRegion()
		print(x)
	}

	func testSerializationWithCodable() {
		let newDate = DateInRegion()
		do {
			let encoder = JSONEncoder()
			let encoded = try encoder.encode(newDate)
			// let encodedJSON = String(data: encoded, encoding: .utf8)!
			let decoder = JSONDecoder()
			let decodedDate = try decoder.decode(DateInRegion.self, from: encoded)
			XCTAssert( (decodedDate == newDate) )
		} catch let err {
			XCTFail("Failed encoding/decoding using Codable: \(err)")
		}
	}

	static var allTests = [
		("testSerializationWithCodable", testSerializationWithCodable)
	]
}
