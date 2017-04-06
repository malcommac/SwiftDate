//
//  TestDateInRegion+Components.swift
//  SwiftDate
//
//  Created by Daniele Margutti on 16/09/16.
//  Copyright © 2016 Daniele Margutti. All rights reserved.
//

import Foundation

import XCTest
@testable import SwiftDate


class TestDateInRegion_Components: XCTestCase {
	
	let newYork = Region(tz: TimeZoneName.americaNewYork, cal: CalendarName.gregorian, loc: LocaleName.englishUnitedStates)
	let rome = Region(tz: TimeZoneName.europeRome, cal: CalendarName.gregorian, loc: LocaleName.italianItaly)
	let amsterdam = Region(tz: TimeZoneName.europeAmsterdam, cal: CalendarName.gregorian, loc: LocaleName.dutchNetherlands)
	let utc = Region(tz: TimeZoneName.gmt, cal: CalendarName.gregorian, loc: LocaleName.english)
	
	
	override func setUp() {
		super.setUp()
	}
	
	override func tearDown() {
		super.tearDown()
	}

	func testDifferentRegionComponents_YMD() {
		let c: [Calendar.Component : Int] = [.year: 2002, .month: 3, .hour: 5, .day: 4, .minute: 6, .second: 7, .nanosecond: 87654321]
		
		let date = DateInRegion(components: c, fromRegion: nil)!
		
		XCTAssertEqual(date.era, 1, "Failed get correct era")
		XCTAssertEqual(date.year, 2002, "Failed get correct year")
		XCTAssertEqual(date.month, 3, "Failed get correct month")
		XCTAssertEqual(date.day, 4, "Failed get correct day")
		XCTAssertEqual(date.hour, 5, "Failed get correct hour")
		XCTAssertEqual(date.minute, 6, "Failed get correct minute")
		XCTAssertEqual(date.second, 7, "Failed get correct second")
		if date.nanosecond < 87654321-10 || date.nanosecond > 87654321+10 {
			XCTAssert(false, "Failed to get correct nanosecond")
		}
	}
	
	func testDifferentRegionComponents_YWD() {
		let c: [Calendar.Component : Int] = [.era: 1, .yearForWeekOfYear: 2, .weekOfYear: 3, .weekday: 4]
		let date = DateInRegion(components: c, fromRegion: nil)!

		XCTAssertEqual(date.era, 1, "Failed get correct era")
		XCTAssertEqual(date.yearForWeekOfYear, 2, "Failed get correct yearForWeekOfYear")
		XCTAssertEqual(date.weekOfYear, 3, "Failed get correct weekOfYear")
		XCTAssertEqual(date.weekday, 4, "Failed get correctweekday")
		XCTAssertEqual(date.hour, 0, "Failed get correct hour")
		XCTAssertEqual(date.minute, 0, "Failed get correct minute")
		XCTAssertEqual(date.second, 0, "Failed get correct second")
		XCTAssertEqual(date.nanosecond, 0, "Failed get correct nanosecond")
	}
	
	func testDifferentRegionComponents_Midnight() {
		// should return a midnight date with nil YMD initialisation in various regions
		[rome,newYork,amsterdam,utc].forEach { region in
			let date = DateInRegion(components: [.year: 1912, .month: 6, .day: 23, .hour: 0, .minute: 0, .second: 0], fromRegion: region)!
			XCTAssertEqual(date.year, 1912, "Failed get correct year")
			XCTAssertEqual(date.month, 6, "Failed get correct month")
			XCTAssertEqual(date.day, 23, "Failed get correct day")
			XCTAssertEqual(date.hour, 0, "Failed get correct hour")
			XCTAssertEqual(date.minute, 0, "Failed get correct minute")
			XCTAssertEqual(date.region, region, "Failed get correct second")
		}
	}
	
	func test_MidnightWithNilYMDInit() {
		// should return a midnight date with nil YMD initialisation
		let localDate = DateInRegion(components: [.year: 1912, .month: 6, .day: 23], fromRegion: nil)!
		XCTAssertEqual(localDate.year, 1912, "Failed get correct year")
		XCTAssertEqual(localDate.month, 6, "Failed get correct month")
		XCTAssertEqual(localDate.day, 23, "Failed get correct day")
		XCTAssertEqual(localDate.hour, 0, "Failed get correct hour")
		XCTAssertEqual(localDate.minute, 0, "Failed get correct minute")
	}
	
	func test_123DateForYMDInit() {
		// should return a 123 date for YMD initialisation
		let localDate = DateInRegion(components: [.year: 1999, .month: 12, .day: 31], fromRegion: nil)!
		XCTAssertEqual(localDate.year, 1999, "Failed get correct year")
		XCTAssertEqual(localDate.month, 12, "Failed get correct month")
		XCTAssertEqual(localDate.day, 31, "Failed get correct day")
	}
	
	func test_yearShiftBetweenRegions() {
		let romeRegion = Region(tz: TimeZoneName.europeRome, cal: CalendarName.gregorian, loc: LocaleName.current)
		let romeDate = DateInRegion(components: [.year: 2000, .month: 1, .day: 1, .hour: 0, .minute: 0, .second: 0], fromRegion: romeRegion)!
		
		let gmtRegion = Region.GMT()
		let gmtDate = romeDate.toRegion(gmtRegion)
		
		XCTAssertEqual(gmtDate.year, 1999, "Failed get correct year")
		XCTAssertEqual(gmtDate.month, 12, "Failed get correct month")
		XCTAssertEqual(gmtDate.day, 31, "Failed get correct day")
		XCTAssertEqual(gmtDate.hour, 23, "Failed get correct day")
	}
	
	func test_123DateForYWDInit() {
		let localDate = DateInRegion(components: [.year: 1999, .month: 12, .day: 31])!
		XCTAssertEqual(localDate.year, 1999, "Failed get correct year")
		XCTAssertEqual(localDate.month, 12, "Failed get correct month")
		XCTAssertEqual(localDate.day, 31, "Failed get correct day")
	}
	
	func test_123DateForYWDInit_2() {
		let localDate = DateInRegion(components: [.year: 2016, .weekOfYear: 1, .weekday: 1])!
		XCTAssertEqual(localDate.yearForWeekOfYear, 2016, "Failed get correct yearForWeekOfYear")
		XCTAssertEqual(localDate.weekOfYear, 1, "Failed get correct weekOfYear")
		XCTAssertEqual(localDate.weekday, 1, "Failed get correct weekday")
	}
	
	func test_zeroInitIndefaultRegion() {
		let components = DateComponents()
		let zeroDate = DateInRegion(components: components)!
		
		XCTAssertEqual(zeroDate.year, 1, "Failed get correct year")
		XCTAssertEqual(zeroDate.month, 1, "Failed get correct month")
		XCTAssertEqual(zeroDate.day, 1, "Failed get correct day")
		XCTAssertEqual(zeroDate.hour, 0, "Failed get correct hour")
		XCTAssertEqual(zeroDate.minute, 0, "Failed get correct minute")
		XCTAssertEqual(zeroDate.second, 0, "Failed get correct second")
		XCTAssertEqual(zeroDate.nanosecond, 0, "Failed get correct nanosecond")
	}
	
	func test_returnProperDate() {
		let localDate = DateInRegion(components: [.year: 1999, .month: 12, .day: 31], fromRegion: newYork)!
		XCTAssertEqual(localDate.year, 1999, "Failed get correct year")
		XCTAssertEqual(localDate.month, 12, "Failed get correct month")
		XCTAssertEqual(localDate.day, 31, "Failed get correct day")
		XCTAssertEqual(localDate.region.timeZone, newYork.timeZone, "Failed get correct timeZone")
	}
	
	func test_gregorianWk_saturday() {
		let localDate = DateInRegion(components: [.year: 2015, .month: 11, .day: 7], fromRegion: amsterdam)!
		XCTAssert(localDate.isInWeekend,"Failed to get the correct value for isInWeekend=true on Saturday")
	}
	
	func test_gregorianWk_sunday() {
		let localDate = DateInRegion(components: [.year: 2015, .month: 11, .day: 8], fromRegion: amsterdam)!
		XCTAssert(localDate.isInWeekend,"Failed to get the correct value for isInWeekend=true on Sunday")
	}
	
	func test_gregorianWk_monday() {
		let localDate = DateInRegion(components: [.year: 2015, .month: 11, .day: 9], fromRegion: amsterdam)!
		XCTAssert(localDate.isInWeekend == false,"Failed to get the correct value for isInWeekend=false on Monday")
	}
	
	func test_gregorianWk_Thursday() {
		let localDate = DateInRegion(components: [.year: 2015, .month: 11, .day: 12], fromRegion: amsterdam)!
		XCTAssert(localDate.isInWeekend == false,"Failed to get the correct value for isInWeekend=false on Thursday")
	}
	
	func test_monthNameLocalized() {
		let localDate = DateInRegion(components: [.year: 2015, .month: 11, .day: 12], fromRegion: rome)!
		XCTAssert(localDate.monthName.lowercased() == "novembre","Failed to get the correct value of the month in given locale")
	}
	
	func test_monthDaysInLeapYear() {
		let localDate = DateInRegion(components: [.year: 2020, .month: 02], fromRegion: rome)!
		XCTAssert(localDate.monthDays == 29,"Failed to get the correct value of the monthDays for a leap year")
	}
	
	func test_nearestHour() {
		let localDate = DateInRegion(components: [.year: 2020, .month: 02, .day: 14, .hour: 13, .minute: 15], fromRegion: rome)!
		XCTAssert(localDate.nearestHour == 13,"Failed to get the correct value of the nearestHour +0")
		
		let localDate2 = DateInRegion(components: [.year: 2020, .month: 02, .day: 14, .hour: 13, .minute: 30, .second: 10], fromRegion: rome)!
		XCTAssert(localDate2.nearestHour == 14,"Failed to get the correct value of the nearestHour +1")
	}
	
	func test_leapMonthAndYear() {
		let localDate1 = DateInRegion(components: [.year: 2016, .month: 9, .day: 18], fromRegion: rome)!
		XCTAssert(localDate1.leapMonth == false,"Failed to get the correct value of the leapMonth for a non leapMonth month")

		let localDate2 = DateInRegion(components: [.year: 2020, .month: 2, .day: 1], fromRegion: rome)!
		XCTAssert(localDate2.leapMonth == true,"Failed to get the correct value of the leapMonth for a non leapMonth month")

		let localDate3 = DateInRegion(components: [.year: 2015, .month: 9, .day: 18], fromRegion: rome)!
		XCTAssert(localDate3.leapYear == false,"Failed to get the correct value of the leapYear for a non leapYear year")
		
		let localDate4 = DateInRegion(components: [.year: 2020, .month: 2, .day: 1], fromRegion: rome)!
		XCTAssert(localDate4.leapYear == true,"Failed to get the correct value of the leapYear for a non leapYear year")
	}
	
	func test_julianDay() {
		let localDate1 = DateInRegion(components: [.year: 2016, .month: 9, .day: 18], fromRegion: rome)!
		XCTAssert(localDate1.julianDay == 2457649.416666667,"Failed to get the correct value of the julianDay for a date")
	}
	
	
	func test_nextWeekend() {
		let expectedWeekendStartDate = DateInRegion(components: [.year: 2015, .month: 11, .day: 7], fromRegion: amsterdam)!
		let expectedWeekendEndDate = (expectedWeekendStartDate + 1.day).endOf(component: .day)
		
		var daysToTest: [DateInRegion] = []
		daysToTest.append(DateInRegion(components: [.year: 2015, .month: 11, .day: 6], fromRegion: amsterdam)!)
		daysToTest.append(DateInRegion(components: [.year: 2015, .month: 11, .day: 5], fromRegion: amsterdam)!)
		daysToTest.append(DateInRegion(components: [.year: 2015, .month: 11, .day: 4], fromRegion: amsterdam)!)
		daysToTest.append(DateInRegion(components: [.year: 2015, .month: 11, .day: 3], fromRegion: amsterdam)!)
		daysToTest.append(DateInRegion(components: [.year: 2015, .month: 11, .day: 2], fromRegion: amsterdam)!)
		daysToTest.append(DateInRegion(components: [.year: 2015, .month: 11, .day: 1], fromRegion: amsterdam)!)
		daysToTest.append(DateInRegion(components: [.year: 2015, .month: 10, .day: 31], fromRegion: amsterdam)!)

		
		for dateToTest in daysToTest {
			let foundWeekend = dateToTest.nextWeekend
			XCTAssert(foundWeekend!.startDate == expectedWeekendStartDate,"Failed to get the correct value of weekend.startDate")
			XCTAssert(foundWeekend!.endDate == expectedWeekendEndDate,"Failed to get the correct value of weekend.endDate")
		}
	}
	
	func test_previousWeekend() {
		let expectedWeekendStartDate = DateInRegion(components: [.year: 2015, .month: 10, .day: 31], fromRegion: amsterdam)!
		let expectedWeekendEndDate = (expectedWeekendStartDate + 1.day).endOf(component: .day)
		
		var daysToTest: [DateInRegion] = []
		daysToTest.append(DateInRegion(components: [.year: 2015, .month: 11, .day: 8], fromRegion: amsterdam)!)
		daysToTest.append(DateInRegion(components: [.year: 2015, .month: 11, .day: 7], fromRegion: amsterdam)!)
		daysToTest.append(DateInRegion(components: [.year: 2015, .month: 11, .day: 6], fromRegion: amsterdam)!)
		daysToTest.append(DateInRegion(components: [.year: 2015, .month: 11, .day: 5], fromRegion: amsterdam)!)
		daysToTest.append(DateInRegion(components: [.year: 2015, .month: 11, .day: 4], fromRegion: amsterdam)!)
		daysToTest.append(DateInRegion(components: [.year: 2015, .month: 11, .day: 3], fromRegion: amsterdam)!)
		daysToTest.append(DateInRegion(components: [.year: 2015, .month: 11, .day: 2], fromRegion: amsterdam)!)
		
		
		for dateToTest in daysToTest {
			let foundWeekend = dateToTest.previousWeekend
			XCTAssert(foundWeekend!.startDate == expectedWeekendStartDate,"Failed to get the correct value of weekend.startDate")
			XCTAssert(foundWeekend!.endDate == expectedWeekendEndDate,"Failed to get the correct value of weekend.endDate")
		}
	}
	
	func test_weekendName() {
		let date = DateInRegion(components: [.year: 2002, .month: 3, .day: 4, .hour: 5, .minute: 30], fromRegion: newYork)!
		XCTAssert(date.weekdayName.lowercased() == "monday", "Failed to get the correct value of weekdayName")
	}
	
	func test_isTodayYesterdayTomorrow() {
		let date = DateInRegion(absoluteDate: Date(), in: newYork)
		
		XCTAssert(date.isToday, "Failed to get the correct value of isToday")
		XCTAssert(date.isTomorrow == false, "Failed to get the correct value of isTomorrow when it's not tomorrow")
		XCTAssert(date.isYesterday == false, "Failed to get the correct value of isYesterday when it's not yesterday")

		let yesterday = (date - 1.day)
		XCTAssert(yesterday.isYesterday, "Failed to get the correct value of isYesterday when it's yesterday")
		
		let tomorrow = (date + 1.day)
		XCTAssert(tomorrow.isTomorrow, "Failed to get the correct value of isTomorrow when it's tomorrow")
	}
	
	func test_inPastAndInFuture() {
		let pastDate = (DateInRegion(absoluteDate: Date(), in: newYork) - 2.days)
		let futureDate = (DateInRegion(absoluteDate: Date(), in: newYork) + 2.days)
	
		XCTAssert(pastDate.isInPast, "Failed to get the correct value of isInPast")
		XCTAssert(futureDate.isInFuture, "Failed to get the correct value of isInFuture when it's tomorrow")
	}
	
	func test_isSameDayOf() {
		let date1 = DateInRegion(components: [.year: 2012, .month: 4, .day: 5])!
		let sameDayDate = DateInRegion(string: "2012-04-05 23:59:00", format: .custom("yyyy-MM-dd HH:mm:ss"))!
		let differentDayDate = DateInRegion(string: "2012-04-06 00:00:01", format: .custom("yyyy-MM-dd HH:mm:ss"))!
		
		XCTAssert(sameDayDate.isInSameDayOf(date: date1), "Failed to get the correct value of isInSameDayOf")
		XCTAssert(differentDayDate.isInSameDayOf(date: date1) == false, "Failed to get the correct value of isInSameDayOf")
	}
	
	func test_startEndOfDay() {
		let date = DateInRegion(string: "2012-04-05 15:30:00", format: .custom("yyyy-MM-dd HH:mm:ss"), fromRegion: rome)!

		let startOfDay = date.startOfDay
		let endOfDay = date.endOfDay
		
		XCTAssertEqual("2012-04-05T00:00:00+02:00", startOfDay.iso8601(), "Failed to generate a valid date from Alt RSS format")
		XCTAssertEqual("2012-04-05T23:59:59+02:00", endOfDay.iso8601(), "Failed to generate a valid date from Alt RSS format")
	}
	
	func test_nextPrevMonth() {
		let date = DateInRegion(string: "2012-04-05 15:30:00", format: .custom("yyyy-MM-dd HH:mm:ss"), fromRegion: rome)!
		
		let nextMonth = date.nextMonth
		let prevMonth = date.prevMonth
		
		XCTAssertEqual("2012-05-05T00:00:00+02:00", nextMonth.iso8601(), "Failed to generate a valid date from Alt RSS format")
		XCTAssertEqual("2012-03-05T00:00:00+01:00", prevMonth.iso8601(), "Failed to generate a valid date from Alt RSS format")
	}
	
	func test_atTime() {
		let date_rome = DateInRegion(components: [.year: 2002, .month: 3, .day: 4, .hour: 5, .minute: 30, .second: 10], fromRegion: rome)!
		guard let dateWithTimeSet = date_rome.atTime(hour: 20, minute: 22, second: 56) else {
			XCTFail("Failed to set hour/minute/seconds")
			return
		}
		XCTAssertEqual(dateWithTimeSet.hour, 20, "Failed to set a valid hour")
		XCTAssertEqual(dateWithTimeSet.minute, 22, "Failed to set a valid hour")
		XCTAssertEqual(dateWithTimeSet.second, 56, "Failed to set a valid hour")
		XCTAssertEqual("2002-03-04T20:22:56+01:00", dateWithTimeSet.iso8601(), "Failed to set atTime")
	}
	
	func test_mathOperations() {
		let date = DateInRegion(string: "1999-12-31 23:30:00", format: .custom("yyyy-MM-dd HH:mm:ss"), fromRegion: rome)!
		let nextYearDate = (date + 31.minutes)
		XCTAssertEqual("2000-01-01T00:01:00+01:00", nextYearDate.iso8601(), "Failed to switch to another year with math operaiton")
		
		let date2 = (date - 1.week)
		XCTAssertEqual("1999-12-24T23:30:00+01:00", date2.iso8601(), "Failed to execute math operation")
		
		
		let date3 = (date - 10.minutes - 1.hour + 61.seconds)
		XCTAssertEqual("1999-12-31T22:21:01+01:00", date3.iso8601(), "Failed to execute math operation")
	
		let date4 = (date - 1.year + 2.months)
		XCTAssertEqual("1999-02-28T23:30:00+01:00", date4.iso8601(), "Failed to execute math operation")

		
		let date5 = (date + [.year: 1, .month: 2])
		XCTAssertEqual("2001-02-28T23:30:00+01:00", date5.iso8601(), "Failed to execute math operation")
	}
	
	func test_timeIntervals() {
		let date1 = DateInRegion(string: "1999-12-31 23:30:00", format: .custom("yyyy-MM-dd HH:mm:ss"), fromRegion: rome)!
		let date2 = DateInRegion(string: "1999-12-31 23:40:05", format: .custom("yyyy-MM-dd HH:mm:ss"), fromRegion: rome)!

		let diffInSeconds = abs((date2 - date1).in(.second)!)
		XCTAssertEqual(diffInSeconds, 605, "Failed to get diff in seconds between two dates")

		let diffInMinutes = abs((date2 - date1).in(.minute)!)
		XCTAssertEqual(diffInMinutes, 10, "Failed to get diff in minutes between two dates")

		let diffInBoth = (date1 - date2).in([.second, .minute])
		XCTAssertTrue(diffInBoth[.minute] == 10 && diffInBoth[.second] == 5, "Failed to get diff in several components between two dates")
		
		let diffInSecondsRev = abs((date1 - date2).in(.second)!)
		XCTAssertEqual(diffInSecondsRev, 605, "Failed to get diff in seconds between two dates (reversed)")
	}
	
	func test_fromNow() {
		var components = DateComponents()
		components.second = 3600
		
		let now = Date()
		let newDateFrom = components.from(date: now)
		XCTAssertTrue(newDateFrom!.timeIntervalSince(now) == 3600,"Failed to get a new date from now plus 3600 seconds")
		
		let newDateAgo = components.ago(from: now)
		XCTAssertTrue(newDateAgo!.timeIntervalSince(now) == -3600,"Failed to get a new date from now minus 3600 seconds")
	}
    
    func test_isMorningAfternoonEveningNight() {
        
        let ninePM = DateInRegion(string: "1989-06-06 21:00:00", format: .custom("yyyy-MM-dd HH:mm:ss"), fromRegion: rome)!
        
        XCTAssert(ninePM.isNight, "Failed to get the 33333333333333333333333333333333correct value of isNight")
        XCTAssert(ninePM.isMorning == false, "Failed to get the correct value of isMorning when it's not morning")
        XCTAssert(ninePM.isAfternoon == false, "Failed to get the correct value of isAfternoon when it's not afternoon")
        XCTAssert(ninePM.isEvening == false, "Failed to get the correct value of isEvening when it's not evening")
        
        let fiveAM = (ninePM + 8.hours)
        XCTAssert(fiveAM.isMorning, "Failed to get the correct value of isMorning")
        XCTAssert(fiveAM.isNight == false, "Failed to get the correct value of isNight when it's not night")
        XCTAssert(fiveAM.isAfternoon == false, "Failed to get the correct value of isAfternoon when it's not afternoon")
        XCTAssert(fiveAM.isEvening == false, "Failed to get the correct value of isEvening when it's not evening")
        
        let twelvePM = (ninePM + 15.hours)
        XCTAssert(twelvePM.isAfternoon, "Failed to get the correct value of isAfternoon")
        XCTAssert(twelvePM.isNight == false, "Failed to get the correct value of isNight when it's not night")
        XCTAssert(twelvePM.isMorning == false, "Failed to get the correct value of isMorning when it's not morning")
        XCTAssert(twelvePM.isEvening == false, "Failed to get the correct value of isEvening when it's not evening")
        
        let fivePM = (ninePM + 20.hours)
        XCTAssert(fivePM.isEvening, "Failed to get the correct value of isEvening")
        XCTAssert(fivePM.isNight == false, "Failed to get the correct value of isNight when it's not night")
        XCTAssert(fivePM.isMorning == false, "Failed to get the correct value of isMorning when it's not morning")
        XCTAssert(fivePM.isAfternoon == false, "Failed to get the correct value of isAfternoon when it's not afternoon")

    }
}
