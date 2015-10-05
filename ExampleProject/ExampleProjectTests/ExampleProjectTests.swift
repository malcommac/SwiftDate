//
//  ExampleProjectTests.swift
//  ExampleProjectTests
//
//  Created by Mark Norgren on 5/21/15.
//
//

import UIKit
import XCTest

class ExampleProjectTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
	
	func testDateDifferences_DaysMonthsYears() {
		let date1 = "1983-03-10".toDate(format: DateFormat.ISO8601)
		let date2 = "1984-05-15".toDate(format: DateFormat.ISO8601)
		let diff = date1?.difference(date2!, unitFlags: [NSCalendarUnit.Day,NSCalendarUnit.Month,NSCalendarUnit.Year])
		let diffDays = diff!.day
		let diffMonths = diff!.month
		let diffYears = diff!.year
		XCTAssertTrue(diffDays == 5, "SwiftDate failed to testing differences between two dates in terms of days")
		XCTAssertTrue(diffMonths == 2, "SwiftDate failed to testing differences between two dates in terms of months")
		XCTAssertTrue(diffYears == 1, "SwiftDate failed to testing differences between two dates in terms of years")
	}
	
	func testDateDifferences_HoursMinutes() {
		let date1 = "1997-07-16T19:20+01:00".toDate(format: DateFormat.ISO8601)
		let date2 = "1997-07-17T02:25+01:00".toDate(format: DateFormat.ISO8601)
		let diff = date1?.difference(date2!, unitFlags: [NSCalendarUnit.Hour,NSCalendarUnit.Minute])
		XCTAssertTrue(diff!.hour == 7, "SwiftDate failed to testing differences between two dates in terms of hours")
		XCTAssertTrue(diff!.minute == 5, "SwiftDate failed to testing differences between two dates in terms of minutes")
	}
	
    func testISO8601_Year() {
        let dateString = "1983"
        let date = dateString.toDate(format: DateFormat.ISO8601)
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy"
        let controlDate = dateFormatter.dateFromString(dateString)
        XCTAssertEqual(date!, controlDate!, "SwiftDate should equal controlDate")
    }
    
    // dateFormatter = "yyyy-MM"
    func testISO8601_YearMonth() {
        let dateString = "1983-03"
        let date = dateString.toDate(format: DateFormat.ISO8601)
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM"
        let controlDate = dateFormatter.dateFromString(dateString)
        XCTAssertEqual(date!, controlDate!, "SwiftDate should equal controlDate")
    }
    //  dateFormatter = "yyyy-MM-DD"
    func testISO8601_YearMonthDay() {
        let dateString = "1983-03-10"
        let date = dateString.toDate(format: DateFormat.ISO8601)
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let controlDate = dateFormatter.dateFromString(dateString)
        XCTAssertEqual(date!, controlDate!, "SwiftDate should equal controlDate")
    }
    // dateFormatter = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    func testISO8601_YearMonthDayHoursMinutes() {
        let dateString = "1997-07-16T19:20+01:00"
        let date = dateString.toDate(format: DateFormat.ISO8601)
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mmZ"
        let controlDate = dateFormatter.dateFromString(dateString)
        XCTAssertEqual(date!, controlDate!, "SwiftDate should equal controlDate")
    }
    // "yyyy-MM-dd'T'HH:mm:ssZ"
    func testISO8601_YearMonthDayHoursMinutesSeconds() {
        let dateString = "1997-07-16T19:20:30+01:00"
        let date = dateString.toDate(format: DateFormat.ISO8601)
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let controlDate = dateFormatter.dateFromString(dateString)
        XCTAssertEqual(date!, controlDate!, "SwiftDate should equal controlDate")
    }
    // "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    func testISO8601_YearMonthDayHoursMinutesSecondsFractionOfSecondTwoPlaces() {
        let dateString = "1997-07-16T19:20:30.45+01:00"
        let date = dateString.toDate(format: DateFormat.ISO8601)
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let controlDate = dateFormatter.dateFromString(dateString)
        XCTAssertEqual(date!, controlDate!, "SwiftDate should equal controlDate")
    }
    // "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    func testISO8601_YearMonthDayHoursMinutesSecondsFractionOfSecondThreePlaces() {
        let dateString = "1997-07-16T19:20:30.456+01:00"
        let date = dateString.toDate(format: DateFormat.ISO8601)
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let controlDate = dateFormatter.dateFromString(dateString)
        XCTAssertEqual(date!, controlDate!, "SwiftDate should equal controlDate")
    }
}
