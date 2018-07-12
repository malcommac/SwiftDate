//
//  TestDateInRegion+Compare.swift
//  SwiftDate
//
//  Created by Daniele Margutti on 18/09/2016.
//  Copyright © 2016 Daniele Margutti. All rights reserved.
//

import Foundation
import XCTest
@testable import SwiftDate


class TestDateInRegion_Compare: XCTestCase {

	let refDate = DateInRegion(components: [.year: 2015, .month: 12, .day: 14, .hour: 13], fromRegion: Region(tz: TimeZoneName.americaParamaribo, cal: CalendarName.gregorian, loc: LocaleName.dutch))!
	
	override func setUp() {
		super.setUp()
	}
	
	override func tearDown() {
		super.tearDown()
	}

	func test_compareGranularity_Year() {
		let date1 = refDate - 1.year
		let date2 = refDate - 1.month
		let date3 = refDate + 1.year
		
		XCTAssertEqual(refDate.compare(to: date1, granularity: .year), .orderedDescending, "Failed get compare year granularity = orderedDescending")
		XCTAssertEqual(refDate.compare(to: date2, granularity: .year), .orderedSame, "Failed get compare year granularity = orderedSame")
		XCTAssertEqual(refDate.compare(to: date3, granularity: .year), .orderedAscending, "Failed get compare year granularity = orderedAscending")
	}
	
	func test_compareGranularity_Month() {
		let date1 = refDate - 1.month
		let date2 = refDate + 1.week
		let date3 = refDate + 1.month
		
		XCTAssertEqual(refDate.compare(to: date1, granularity: .month), .orderedDescending, "Failed get compare month granularity = orderedDescending")
		XCTAssertEqual(refDate.compare(to: date2, granularity: .month), .orderedSame, "Failed get compare month granularity = orderedSame")
		XCTAssertEqual(refDate.compare(to: date3, granularity: .month), .orderedAscending, "Failed get compare month granularity = orderedAscending")
	}
	
	func test_compareGranularity_Week() {
		let date1 = refDate - 1.week
		let date2 = refDate + 1.day
		let date3 = refDate + 1.week
		
		XCTAssertEqual(refDate.compare(to: date1, granularity: .weekOfYear), .orderedDescending, "Failed get compare weekOfYear granularity = orderedDescending")
		XCTAssertEqual(refDate.compare(to: date2, granularity: .weekOfYear), .orderedSame, "Failed get compare weekOfYear granularity = orderedSame")
		XCTAssertEqual(refDate.compare(to: date3, granularity: .weekOfYear), .orderedAscending, "Failed get compare weekOfYear granularity = orderedAscending")
	}
	
	func test_compareGranularity_Days() {
		let date1 = refDate - 1.day
		let date2 = refDate + 1.hour
		let date3 = refDate + 1.day
		
		XCTAssertEqual(refDate.compare(to: date1, granularity: .day), .orderedDescending, "Failed get compare day granularity = orderedDescending")
		XCTAssertEqual(refDate.compare(to: date2, granularity: .day), .orderedSame, "Failed get compare day granularity = orderedSame")
		XCTAssertEqual(refDate.compare(to: date3, granularity: .day), .orderedAscending, "Failed get compare day granularity = orderedAscending")
	}
	
	func test_compareGranularity_Hour() {
		let date1 = refDate - 1.hour
		let date2 = refDate + 1.minute
		let date3 = refDate + 1.hour
		
		XCTAssertEqual(refDate.compare(to: date1, granularity: .hour), .orderedDescending, "Failed get compare hour granularity = orderedDescending")
		XCTAssertEqual(refDate.compare(to: date2, granularity: .hour), .orderedSame, "Failed get compare hour granularity = orderedSame")
		XCTAssertEqual(refDate.compare(to: date3, granularity: .hour), .orderedAscending, "Failed get compare hour granularity = orderedAscending")
	}
	
	func test_compareGranularity_Minute() {
		let date1 = refDate - 1.minute
		let date2 = refDate + 1.second
		let date3 = refDate + 1.minute
		
		XCTAssertEqual(refDate.compare(to: date1, granularity: .minute), .orderedDescending, "Failed get compare minute granularity = orderedDescending")
		XCTAssertEqual(refDate.compare(to: date2, granularity: .minute), .orderedSame, "Failed get compare minute granularity = orderedSame")
		XCTAssertEqual(refDate.compare(to: date3, granularity: .minute), .orderedAscending, "Failed get compare minute granularity = orderedAscending")
	}
	
	func test_compareGranularity_Second() {
		let date1 = refDate - 1.second
		let date2 = refDate + 100000.nanoseconds
		let date3 = refDate + 1.second
		
		XCTAssertEqual(refDate.compare(to: date1, granularity: .second), .orderedDescending, "Failed get compare second granularity = orderedDescending")
		XCTAssertEqual(refDate.compare(to: date2, granularity: .second), .orderedSame, "Failed get compare second granularity = orderedSame")
		XCTAssertEqual(refDate.compare(to: date3, granularity: .second), .orderedAscending, "Failed get compare second granularity = orderedAscending")
	}
	
	func test_isEqualToDate() {
		XCTAssertTrue(refDate.isEqual(to: refDate) == true, "Failed get compare with same date")
		
		let date2 = refDate + 1.second
		XCTAssertTrue(refDate.isEqual(to: date2) == false, "Failed get compare with future date")
		
		let romeRegion = Region(tz: TimeZoneName.europeRome, cal: CalendarName.gregorian, loc: LocaleName.italianItaly)
		let dateInRome = refDate.toRegion(romeRegion)
		XCTAssertTrue(refDate.isEqual(to: dateInRome) == false, "Failed get compare with different region")
	}
	
	func test_isIn_Year() {
		let date1 = refDate - 1.year
		let date2 = refDate - 1.month
		let date3 = refDate + 1.year
		
		XCTAssertTrue(refDate.isIn(date: date1, granularity: .year) == false, "Failed get isIn with year granularity #1")
		XCTAssertTrue(refDate.isIn(date: date2, granularity: .year) == true, "Failed get isIn with year granularity #2")
		XCTAssertTrue(refDate.isIn(date: date3, granularity: .year) == false, "Failed get isIn with year granularity #3")
	}
	
	func test_isIn_Month() {
		let date1 = refDate - 1.month
		let date2 = refDate + 1.week
		let date3 = refDate + 1.month
		
		XCTAssertTrue(refDate.isIn(date: date1, granularity: .month) == false, "Failed get isIn with month granularity #1")
		XCTAssertTrue(refDate.isIn(date: date2, granularity: .month) == true, "Failed get isIn with month granularity #2")
		XCTAssertTrue(refDate.isIn(date: date3, granularity: .month) == false, "Failed get isIn with month granularity #3")
	}
	
	func test_isIn_Week() {
		let date1 = refDate - 1.week
		let date2 = refDate + 1.day
		let date3 = refDate + 1.week
		
		XCTAssertTrue(refDate.isIn(date: date1, granularity: .weekOfYear) == false, "Failed get isIn with weekOfYear granularity #1")
		XCTAssertTrue(refDate.isIn(date: date2, granularity: .weekOfYear) == true, "Failed get isIn with weekOfYear granularity #2")
		XCTAssertTrue(refDate.isIn(date: date3, granularity: .weekOfYear) == false, "Failed get isIn with weekOfYear granularity #3")
	}
	
	func test_isIn_Day() {
		let date1 = refDate - 1.day
		let date2 = refDate + 1.hour
		let date3 = refDate + 1.day
		
		XCTAssertTrue(refDate.isIn(date: date1, granularity: .day) == false, "Failed get isIn with day granularity #1")
		XCTAssertTrue(refDate.isIn(date: date2, granularity: .day) == true, "Failed get isIn with day granularity #2")
		XCTAssertTrue(refDate.isIn(date: date3, granularity: .day) == false, "Failed get isIn with day granularity #3")
	}
	
	func test_isIn_Hour() {
		let date1 = refDate - 1.hour
		let date2 = refDate + 1.minute
		let date3 = refDate + 1.hour
		
		XCTAssertTrue(refDate.isIn(date: date1, granularity: .hour) == false, "Failed get isIn with hour granularity #1")
		XCTAssertTrue(refDate.isIn(date: date2, granularity: .hour) == true, "Failed get isIn with hour granularity #2")
		XCTAssertTrue(refDate.isIn(date: date3, granularity: .hour) == false, "Failed get isIn with hour granularity #3")
	}
	
	func test_isIn_Minutes() {
		let date1 = refDate - 1.minute
		let date2 = refDate + 1.second
		let date3 = refDate + 1.minute
		
		XCTAssertTrue(refDate.isIn(date: date1, granularity: .minute) == false, "Failed get isIn with minute granularity #1")
		XCTAssertTrue(refDate.isIn(date: date2, granularity: .minute) == true, "Failed get isIn with minute granularity #2")
		XCTAssertTrue(refDate.isIn(date: date3, granularity: .minute) == false, "Failed get isIn with minute granularity #3")
	}
	
	func test_isIn_Second() {
		let date1 = refDate - 1.second
		let date2 = refDate + 100000.nanoseconds
		let date3 = refDate + 1.second
		
		XCTAssertTrue(refDate.isIn(date: date1, granularity: .second) == false, "Failed get isIn with second granularity #1")
		XCTAssertTrue(refDate.isIn(date: date2, granularity: .second) == true, "Failed get isIn with second granularity #2")
		XCTAssertTrue(refDate.isIn(date: date3, granularity: .second) == false, "Failed get isIn with second granularity #3")
	}
	
	func test_isBefore_Year() {
		let date1 = refDate - 1.year
		let date2 = refDate - 1.month
		let date3 = refDate + 1.year
		
		XCTAssertTrue(refDate.isBefore(date: date1, granularity: .year) == false, "Failed get isBefore with year granularity #1")
		XCTAssertTrue(refDate.isBefore(date: date2, granularity: .year) == false, "Failed get isBefore with year granularity #2")
		XCTAssertTrue(refDate.isBefore(date: date3, granularity: .year) == true, "Failed get isBefore with year granularity #3")
	}
	
	func test_isBefore_Month() {
		let date1 = refDate - 1.month
		let date2 = refDate + 1.week
		let date3 = refDate + 1.month
		
		XCTAssertTrue(refDate.isBefore(date: date1, granularity: .month) == false, "Failed get isBefore with month granularity #1")
		XCTAssertTrue(refDate.isBefore(date: date2, granularity: .month) == false, "Failed get isBefore with month granularity #2")
		XCTAssertTrue(refDate.isBefore(date: date3, granularity: .month) == true, "Failed get isBefore with month granularity #3")
	}
	
	func test_isBefore_Week() {
		let date1 = refDate - 1.week
		let date2 = refDate + 1.day
		let date3 = refDate + 1.week
		
		XCTAssertTrue(refDate.isBefore(date: date1, granularity: .weekOfYear) == false, "Failed get isBefore with weekOfYear granularity #1")
		XCTAssertTrue(refDate.isBefore(date: date2, granularity: .weekOfYear) == false, "Failed get isBefore with weekOfYear granularity #2")
		XCTAssertTrue(refDate.isBefore(date: date3, granularity: .weekOfYear) == true, "Failed get isBefore with weekOfYear granularity #3")
	}
	
	func test_isBefore_Days() {
		let date1 = refDate - 1.day
		let date2 = refDate + 1.hour
		let date3 = refDate + 1.day
		
		XCTAssertTrue(refDate.isBefore(date: date1, granularity: .day) == false, "Failed get isBefore with day granularity #1")
		XCTAssertTrue(refDate.isBefore(date: date2, granularity: .day) == false, "Failed get isBefore with day granularity #2")
		XCTAssertTrue(refDate.isBefore(date: date3, granularity: .day) == true, "Failed get isBefore with day granularity #3")
	}
	
	func test_isBefore_Hour() {
		let date1 = refDate - 1.hour
		let date2 = refDate + 1.minute
		let date3 = refDate + 1.hour
		
		XCTAssertTrue(refDate.isBefore(date: date1, granularity: .hour) == false, "Failed get isBefore with hour granularity #1")
		XCTAssertTrue(refDate.isBefore(date: date2, granularity: .hour) == false, "Failed get isBefore with hour granularity #2")
		XCTAssertTrue(refDate.isBefore(date: date3, granularity: .hour) == true, "Failed get isBefore with hour granularity #3")
	}
	
	func test_isBefore_Minute() {
		let date1 = refDate - 1.minute
		let date2 = refDate + 1.second
		let date3 = refDate + 1.minute
		
		XCTAssertTrue(refDate.isBefore(date: date1, granularity: .minute) == false, "Failed get isBefore with minute granularity #1")
		XCTAssertTrue(refDate.isBefore(date: date2, granularity: .minute) == false, "Failed get isBefore with minute granularity #2")
		XCTAssertTrue(refDate.isBefore(date: date3, granularity: .minute) == true, "Failed get isBefore with minute granularity #3")
	}
	
	func test_isBefore_Second() {
		let date1 = refDate - 1.second
		let date2 = refDate + 100000.nanoseconds
		let date3 = refDate + 1.second
		
		XCTAssertTrue(refDate.isBefore(date: date1, granularity: .second) == false, "Failed get isBefore with second granularity #1")
		XCTAssertTrue(refDate.isBefore(date: date2, granularity: .second) == false, "Failed get isBefore with second granularity #2")
		XCTAssertTrue(refDate.isBefore(date: date3, granularity: .second) == true, "Failed get isBefore with second granularity #3")
	}
	
	func test_isAfter_Year() {
		let date1 = refDate - 1.year
		let date2 = refDate - 1.month
		let date3 = refDate + 1.year
		
		XCTAssertTrue(refDate.isAfter(date: date1, granularity: .year) == true, "Failed get isAfter with year granularity #1")
		XCTAssertTrue(refDate.isAfter(date: date2, granularity: .year) == false, "Failed get isAfter with year granularity #2")
		XCTAssertTrue(refDate.isAfter(date: date3, granularity: .year) == false, "Failed get isAfter with year granularity #3")
	}
	
	func test_isAfter_Month() {
		let date1 = refDate - 1.month
		let date2 = refDate + 1.week
		let date3 = refDate + 1.month
		
		XCTAssertTrue(refDate.isAfter(date: date1, granularity: .month) == true, "Failed get isAfter with month granularity #1")
		XCTAssertTrue(refDate.isAfter(date: date2, granularity: .month) == false, "Failed get isAfter with month granularity #2")
		XCTAssertTrue(refDate.isAfter(date: date3, granularity: .month) == false, "Failed get isAfter with month granularity #3")
	}
	
	func test_isAfter_Week() {
		let date1 = refDate - 1.week
		let date2 = refDate + 1.day
		let date3 = refDate + 1.week
		
		XCTAssertTrue(refDate.isAfter(date: date1, granularity: .weekOfYear) == true, "Failed get isAfter with weekOfYear granularity #1")
		XCTAssertTrue(refDate.isAfter(date: date2, granularity: .weekOfYear) == false, "Failed get isAfter with weekOfYear granularity #2")
		XCTAssertTrue(refDate.isAfter(date: date3, granularity: .weekOfYear) == false, "Failed get isAfter with weekOfYear granularity #3")
	}
	
	func test_isAfter_Day() {
		let date1 = refDate - 1.day
		let date2 = refDate + 1.hour
		let date3 = refDate + 1.day
		
		XCTAssertTrue(refDate.isAfter(date: date1, granularity: .day) == true, "Failed get isAfter with day granularity #1")
		XCTAssertTrue(refDate.isAfter(date: date2, granularity: .day) == false, "Failed get isAfter with day granularity #2")
		XCTAssertTrue(refDate.isAfter(date: date3, granularity: .day) == false, "Failed get isAfter with day granularity #3")
	}
	
	func test_isAfter_Hour() {
		let date1 = refDate - 1.hour
		let date2 = refDate + 1.minute
		let date3 = refDate + 1.hour
		
		XCTAssertTrue(refDate.isAfter(date: date1, granularity: .hour) == true, "Failed get isAfter with hour granularity #1")
		XCTAssertTrue(refDate.isAfter(date: date2, granularity: .hour) == false, "Failed get isAfter with hour granularity #2")
		XCTAssertTrue(refDate.isAfter(date: date3, granularity: .hour) == false, "Failed get isAfter with hour granularity #3")
	}
	
	func test_isAfter_Minute() {
		let date1 = refDate - 1.minute
		let date2 = refDate + 1.second
		let date3 = refDate + 1.minute
		
		XCTAssertTrue(refDate.isAfter(date: date1, granularity: .minute) == true, "Failed get isAfter with minute granularity #1")
		XCTAssertTrue(refDate.isAfter(date: date2, granularity: .minute) == false, "Failed get isAfter with minute granularity #2")
		XCTAssertTrue(refDate.isAfter(date: date3, granularity: .minute) == false, "Failed get isAfter with minute granularity #3")
	}
	
	func test_isAfter_Second() {
		let date1 = refDate - 1.second
		let date2 = refDate + 100000.nanoseconds
		let date3 = refDate + 1.second
		
		XCTAssertTrue(refDate.isAfter(date: date1, granularity: .second) == true, "Failed get isAfter with second granularity #1")
		XCTAssertTrue(refDate.isAfter(date: date2, granularity: .second) == false, "Failed get isAfter with second granularity #2")
		XCTAssertTrue(refDate.isAfter(date: date3, granularity: .second) == false, "Failed get isAfter with second granularity #3")
	}
	
	func test_isToday() {
		let date1 = DateInRegion()
		XCTAssertTrue(date1.isToday == true, "Failed get correct result from isToday for current date")
		
		let date2 = DateInRegion().startOf(component: .day)
		XCTAssertTrue(date2.isToday == true, "Failed get correct result from isToday for today at midnight")
		
		let date3 = DateInRegion().endOf(component: .day)
		XCTAssertTrue(date3.isToday == true, "Failed get correct result from isToday today just before next midnight")
		
		let date4 = (DateInRegion() + 1.day).startOf(component: .day)
		XCTAssertTrue(date4.isToday == false, "Failed to return false for isToday with a date set to tomorrow at midnight")
		
		let date5 = (DateInRegion() - 1.day).endOf(component: .day)
		XCTAssertTrue(date5.isToday == false, "Failed to return false for isToday with a date set just before last midnight")
		
		let date6 = DateInRegion() - 1.year
		XCTAssertTrue(date6.isToday == false, "Failed to return false for isToday with a date set to last year's date")
	}
	
	func test_isYesterday() {
		let date1 = DateInRegion() - 1.day
		XCTAssertTrue(date1.isYesterday == true, "Failed get correct result from isYesterday for current date")
		
		let date2 = (DateInRegion() - 1.day).startOf(component: .day)
		XCTAssertTrue(date2.isYesterday == true, "Failed get correct result from isYesterday for yesterday at midnight")
		
		let date3 = (DateInRegion() - 1.day).endOf(component: .day)
		XCTAssertTrue(date3.isYesterday == true, "Failed get correct result from isYesterday yesterday just before next midnight")
		
		let date4 = DateInRegion().startOf(component: .day)
		XCTAssertTrue(date4.isYesterday == false, "Failed to return false for isYesterday with a date set to today at midnight")
		
		let date5 = (DateInRegion() - 2.days).endOf(component: .day)
		XCTAssertTrue(date5.isYesterday == false, "Failed to return false for isYesterday with a date set before last midnight")
		
		let date6 = DateInRegion() - 1.year
		XCTAssertTrue(date6.isYesterday == false, "Failed to return false for isYesterday with a date set to last year's date")
	}
	
	func test_isTomorrow() {
		let date1 = DateInRegion() + 1.day
		XCTAssertTrue(date1.isTomorrow == true, "Failed get correct result from isTomorrow for current date")
		
		let date2 = (DateInRegion() + 1.day).startOf(component: .day)
		XCTAssertTrue(date2.isTomorrow == true, "Failed get correct result from isTomorrow for tomorrow at midnight")
		
		let date3 = (DateInRegion() + 1.day).endOf(component: .day)
		XCTAssertTrue(date3.isTomorrow == true, "Failed get correct result from isTomorrow tomorrow just before next midnight")
		
		let date4 = (DateInRegion() + 2.days).startOf(component: .day)
		XCTAssertTrue(date4.isTomorrow == false, "Failed to return false for isTomorrow with a date set the day after tomorrow at midnight")
		
		let date5 = DateInRegion().endOf(component: .day)
		XCTAssertTrue(date5.isTomorrow == false, "Failed to return false for isTomorrow with a date set tomorrow before last midnight")
		
		let date6 = DateInRegion() - 1.year
		XCTAssertTrue(date6.isTomorrow == false, "Failed to return false for isTomorrow with a date set to last year's date")
	}
	
	func test_equationOperators() {
		let d_amsterdam = Region(tz: TimeZoneName.europeAmsterdam, cal: CalendarName.gregorian, loc: LocaleName.dutchNetherlands)
		let d_shanghai = Region(tz: TimeZoneName.asiaShanghai, cal: CalendarName.chinese, loc: LocaleName.chineseChina)
	
		let date1 = DateInRegion(components: [.year: 1999, .month: 12, .day: 31])!
		let date2 = date1
		XCTAssertTrue(date1 == date2, "should return true for equating a different object with the same properties")

		let date3 = DateInRegion(components: [.year: 1999, .month: 12, .day: 31])!
		let date4 = DateInRegion(components: [.year: 1999, .month: 12, .day: 30])!
		XCTAssertTrue(((date3 == date4) == false), "should return false for equating objects with different dates")
		
		let date5 = DateInRegion(components: [.year: 1999, .month: 12, .day: 31], fromRegion: d_amsterdam)!
		let date6 = DateInRegion(components: [.year: 1999, .month: 12, .day: 30], fromRegion: d_shanghai)!
		XCTAssertTrue(((date5 == date6) == false), "should return false for equating objects with different regions")
	}
	
	func test_hashDateInRegion() {
		let date1 = DateInRegion(components: [.year: 1999, .month: 12, .day: 31])!
		XCTAssertTrue(date1.hashValue == date1.hashValue, "should return an equal hash for the same date reference")

		let date2 = DateInRegion(components: [.year: 1999, .month: 12, .day: 31])!
		XCTAssertTrue(date1.hashValue == date2.hashValue, "should return an equal hash for the same date value")

		let date3 = DateInRegion(components: [.year: 1999, .month: 12, .day: 30])!
		XCTAssertTrue(date2.hashValue != date3.hashValue, "hould return an unequal hash for a different date value")

		let netherlands = Region(tz: TimeZoneName.europeAmsterdam, cal: CalendarName.gregorian, loc: LocaleName.dutchNetherlands)
		let utc = Region(tz: TimeZoneName.gmt, cal: CalendarName.gregorian, loc: LocaleName.dutchNetherlands)
		
		let date4 = DateInRegion(components: [.year: 1999, .month: 12, .day: 30], fromRegion: netherlands)!
		let date5 = DateInRegion(components: [.year: 1999, .month: 12, .day: 30], fromRegion: utc)!
		XCTAssertTrue(date4.hashValue != date5.hashValue, "should return an unequal hash for a different time zone value")

	}
	
	func test_dateIntervalOperation() {
		let date_1 = DateInRegion(string: "2012-04-05 12:00:00", format: .custom("yyyy-MM-dd HH:mm:ss"))!
		let date_2 = DateInRegion(string: "2012-04-05 12:05:00", format: .custom("yyyy-MM-dd HH:mm:ss"))!
				
		XCTAssert((date_2 - date_1) == 300, "Failed to compare dates and get correct interval")
		XCTAssert((date_1 - date_2) == -300, "Failed to compare dates and get correct interval")
	}
	
	func test_DateTimeInterval() {
		// #TEST 1:
		// Difference between dates where left operand is older than right operand. Result must be positive.
		let date_a = Date()
		let date_b = date_a + 1.hour
		XCTAssert((date_a - date_b) == -3600, "Failed to make difference between dates")
		XCTAssert((date_b - date_a) == 3600, "Failed to make difference between dates")

		// #TEST 2:
		// Create explicitly a negative interval (where end date occurs earlier in time than the start date)
		// and check the correctness of properties
		let interval = DateTimeInterval(start: date_b, end: date_a)
		XCTAssert(interval.duration == -3600, "Failed to get correct time interval in negative interval")
		XCTAssert(interval.start == date_b, "Failed to get start date")
		// Check end date: this derivate variable (start & duration)
		XCTAssert(interval.end == date_a, "Failed to derivate correct end date from start date and negative duration")

		// #TEST 3:
		// We want to see if a date is inside a given interval
		let gmt = Region.GMTForTests()
		let format: DateFormat = .custom("yyyy-MM-dd HH:mm:ss")
		// Create interval A
		let interval_a_start = DateInRegion(string: "2012-04-05 12:00:00", format: format, fromRegion: gmt)!.absoluteDate
		let interval_a_end = DateInRegion(string: "2012-04-05 18:00:00", format: format, fromRegion: gmt)!.absoluteDate
		let interval_a = DateTimeInterval(start: interval_a_start, end: interval_a_end)
		
		let example_date_1 = DateInRegion(string: "2012-04-05 17:59:00", format: format, fromRegion: gmt)!.absoluteDate
		let example_date_2 = DateInRegion(string: "2012-04-05 11:59:59", format: format, fromRegion: gmt)!.absoluteDate
		XCTAssert(interval_a.contains(example_date_1) == true, "#1 Failed to check if a date is contained in an interval")
		XCTAssert(interval_a.contains(example_date_2) == false, "#2 Failed to check if a date is contained in an interval")

		// #TEST 4:
		// The same test but creating a negative interval
		// It must produce the same results
		let interval_a1 = DateTimeInterval(start: interval_a_end, end: interval_a_start)
		XCTAssert(interval_a1.contains(example_date_1) == true, "#3 Failed to check if a date is contained in an interval")
		XCTAssert(interval_a1.contains(example_date_2) == false, "#4 Failed to check if a date is contained in an interval")

		// #TEST 5:
		// Intersection between two intervals
		let interval_b_start = DateInRegion(string: "2012-04-05 10:00:00", format: format, fromRegion: gmt)!.absoluteDate
		let interval_b_end = DateInRegion(string: "2012-04-05 15:00:00", format: format, fromRegion: gmt)!.absoluteDate
		let interval_b = DateTimeInterval(start: interval_b_start, end: interval_b_end)
		// Does intersects? We expect yes
		let intersect_a_b = interval_a.intersects(interval_b)
		XCTAssert(intersect_a_b == true, "Failed to check if two interval intersects")
		// How?
		let intersection = interval_a.intersection(with: interval_b)
		XCTAssert(intersection!.start == interval_a_start, "Failed to check intersection: start date")
		XCTAssert(intersection!.end == interval_b_end, "Failed to check intersection: end date")

		// #TEST 6:
		// Intersection with two intervals where the second is in reverse order
		let interval_a2 = DateTimeInterval(start: interval_a_start, end: interval_a_end)
		let interval_b2 = DateTimeInterval(start: interval_b_end, end: interval_b_start)
		let intersection_2 = interval_b2.intersection(with: interval_a2)
		XCTAssert(intersection_2!.start == interval_a_start, "Failed to check intersection: start date")
		XCTAssert(intersection_2!.end == interval_b_end, "Failed to check intersection: end date")
		
		// #TEST 7:
		// Compare two intervals
		let compare_1 = interval_a.compare(interval_b)
		XCTAssert(compare_1 == .orderedDescending, "#1 Failed to compare two intervals")
		
		let compare_2 = interval_a2.compare(interval_b2)
		XCTAssert(compare_2 == .orderedDescending, "#2 Failed to compare two intervals")
	}
	
}
