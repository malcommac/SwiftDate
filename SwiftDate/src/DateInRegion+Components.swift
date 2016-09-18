//
//  DateInRegion+Components.swift
//  SwiftDate
//
//  Created by Daniele Margutti on 09/09/16.
//  Copyright © 2016 Daniele Margutti. All rights reserved.
//

import Foundation

extension DateInRegion {
	
	internal func value(forComponent cmp: Calendar.Component) -> Int {
		if cmp == .calendar || cmp == .timeZone {
			assertionFailure("You can't get the value of the calendar/timezone component")
		}
		let components = self.region.calendar.dateComponents([cmp], from: self.absoluteDate)
		let value = components.value(for: cmp)
		return value!
	}
	
	public var components: DateComponents {
		return self.region.calendar.dateComponents(DateComponents.allComponentsSet, from: self.absoluteDate)
	}
	
	public var era: Int {
		return self.value(forComponent: .era)
	}
	
	public var year: Int {
		return self.value(forComponent: .year)
	}
	
	public var month: Int {
		return self.value(forComponent: .month)
	}
	
	public var day: Int {
		return self.value(forComponent: .day)
	}
	
	public var hour: Int {
		return self.value(forComponent: .hour)
	}
	
	public var nearestHour: Int {
		let date: DateInRegion = (self + 30.minutes)
		return Int(date.hour)
	}
	
	public var minute: Int {
		return self.value(forComponent: .minute)
	}
	
	public var second: Int {
		return self.value(forComponent: .second)
	}
	
	public var nanosecond: Int {
		return self.value(forComponent: .nanosecond)
	}
	
	public var yearForWeekOfYear: Int {
		return self.value(forComponent: .yearForWeekOfYear)
	}
	
	public var weekOfYear: Int {
		return self.value(forComponent: .weekOfYear)
	}
	
	public var weekday: Int {
		return self.value(forComponent: .weekday)
	}
	
	public var weekdayOrdinal: Int {
		return self.value(forComponent: .weekdayOrdinal)
	}
	
	public var weekdayName: String {
		return self.region.formatter(format: "EEEE").string(from: self.absoluteDate)
	}
	
	public var monthDays: Int {
		let range: Range<Int> = self.region.calendar.range(of: .day, in: .month, for: self.absoluteDate)!
		return (range.upperBound - range.lowerBound)
	}
	
	public var weekOfMonth: Int {
		return self.value(forComponent: .weekOfMonth)
	}
	
	public var monthName: String {
		return self.region.formatter().monthSymbols[self.month-1]
	}
	
	public var shortMonthName: String {
		return self.region.formatter().shortMonthSymbols[self.month-1]
	}
	
	public var leapMonth: Bool {
		let calendar = self.region.calendar
		if calendar.identifier == Calendar.Identifier.gregorian && self.year > 1582 {
			guard let range: Range<Int> = calendar.range(of: .day, in: .month, for: self.absoluteDate) else {
				return false
			}
			return ((range.upperBound - range.lowerBound) == 29)
		}
		
		return calendar.dateComponents([.day,.month,.year], from: self.absoluteDate).isLeapMonth!
	}
	
	public var leapYear: Bool {
		let calendar = self.region.calendar
		if calendar.identifier == Calendar.Identifier.gregorian {
			var newComponents = self.components
			newComponents.month = 2
			newComponents.day = 10
			let testDate = newComponents.dateInRegion!
			return testDate.leapMonth
		}
		return calendar.dateComponents([.day,.month,.year], from: self.absoluteDate).isLeapMonth!
	}
	
	public var julianDay: Double {
		let destRegion = Region(tz: TimeZones.gmt, cal: Calendars.gregorian, loc: Locales.english)
		let utc = self.toRegion(destRegion)
		
		let year = Double(utc.year)
		let month = Double(utc.month)
		let day = Double(utc.day)
		let hour = Double(utc.hour) + Double(utc.minute)/60.0 + (Double(utc.second)+Double(utc.nanosecond)/1e9)/3600.0
		
		var jd = 367.0*year - floor( 7.0*( year+floor((month+9.0)/12.0))/4.0 )
		jd -= floor( 3.0*(floor( (year+(month-9.0)/7.0)/100.0 ) + 1.0)/4.0 )
		jd += floor(275.0*month/9.0) + day + 1721028.5 + hour/24.0
		
		return jd
	}
	
	public func modifiedJulianDay() -> Double {
		return self.julianDay - 2400000.5
	}
	
	public var thisWeekend: (startDate: DateInRegion, endDate: DateInRegion)? {
		guard self.region.calendar.isDateInWeekend(self.absoluteDate) else {
			return nil
		}
		let date: DateInRegion = (self - 2.days)
		return date.nextWeekend
	}
	
	public var nextWeekend: (startDate: DateInRegion, endDate: DateInRegion)? {
		var wkStart: Date = self.absoluteDate
		var tInt: TimeInterval = 0
		let d = self.absoluteDate
		
		let calendar = self.region.calendar
		if calendar.nextWeekend(startingAfter: d, start: &wkStart, interval: &tInt) == false {
			return nil
		}
		
		// Subtract one thousandth of a second to distinguish from Midnigth
		// on the next Monday for the isEqualDate function of NSDate
		let wkEnd = wkStart.addingTimeInterval(tInt - 0.001)
		
		let startDate = DateInRegion(absoluteDate: wkStart, in: region)
		let endDate = DateInRegion(absoluteDate: wkEnd, in: region)
		return (startDate, endDate)
	}
	
	public var previousWeekend: (startDate: DateInRegion, endDate: DateInRegion)? {
		let date: DateInRegion = (self - 9.days)
		return date.nextWeekend
	}
	
	public var isToday: Bool {
		return self.region.calendar.isDateInToday(self.absoluteDate)
	}
	
	public var isYesterday: Bool {
		return self.region.calendar.isDateInYesterday(self.absoluteDate)
	}
	
	public var isTomorrow: Bool {
		return self.region.calendar.isDateInTomorrow(self.absoluteDate)
	}
	
	public var isInWeekend: Bool {
		return self.region.calendar.isDateInWeekend(self.absoluteDate)
	}
	
	public var isInPast: Bool {
		return self.absoluteDate < Date()
	}
	
	public var isInFuture: Bool {
		return self.absoluteDate > Date()
	}
	
	public func isInSameDayOf(date: DateInRegion) -> Bool {
		return self.region.calendar.isDate(self.absoluteDate, inSameDayAs: date.absoluteDate)
	}
	
	public var startOfDay: DateInRegion {
		let absoluteDate = self.region.calendar.startOfDay(for: self.absoluteDate)
		return DateInRegion(absoluteDate: absoluteDate, in: self.region.copy())
	}
	
	public var endOfDay: DateInRegion {
		let cal = self.region.calendar
		var dCmps = DateComponents()
		dCmps.day = 1
		let nextDay = cal.startOfDay(for: cal.date(byAdding: dCmps, to: self.absoluteDate)!)
		return DateInRegion(absoluteDate: nextDay.addingTimeInterval(-0.001), in: self.region.copy())
	}

	public var nextMonth: DateInRegion {
		let refDate = self.startOfDay.absoluteDate
		let nextMonth = self.region.calendar.date(byAdding: .month, value: 1, to: refDate)
		return DateInRegion(absoluteDate: nextMonth!, in: self.region.copy())
	}
	
	public var prevMonth: DateInRegion {
		let refDate = self.startOfDay.absoluteDate
		let prevMonth = self.region.calendar.date(byAdding: .month, value: -1, to: refDate)
		return DateInRegion(absoluteDate: prevMonth!, in: self.region.copy())
	}
	
	public func startOf(component: Calendar.Component) -> DateInRegion {
		let absoluteTime = self.region.calendar.range(of: component, for: self.absoluteDate)!.start
		return DateInRegion(absoluteDate: absoluteTime, in: self.region.copy())
	}
	
	public func endOf(component: Calendar.Component) -> DateInRegion {
		// RangeOfUnit returns the start of the next unit; we will subtract one thousandth of a
		// second
		let startOfNextUnit = self.region.calendar.range(of: component, for: self.absoluteDate)!.end
		let endOfThisUnit = Date(timeInterval: -0.001, since: startOfNextUnit)
		return DateInRegion(absoluteDate: endOfThisUnit, in: self.region.copy())
	}
	
	public var timeIntervalSinceReferenceDate: TimeInterval {
		return self.absoluteDate.timeIntervalSinceReferenceDate
	}
	
	public static var distantFuture: DateInRegion {
		return DateInRegion(absoluteDate: Date.distantFuture)
	}
	
	public static var distantPast: DateInRegion {
		return DateInRegion(absoluteDate: Date.distantPast)
	}
	
	public func atTime(hour: Int, minute: Int, second: Int) throws -> DateInRegion {
		guard let newDate = self.region.calendar.date(bySettingHour: hour, minute: minute, second: second, of: self.absoluteDate) else {
			throw DateError.FailedToCalculate
		}
		return DateInRegion(absoluteDate: newDate, in: self.region.copy())
	}

	public func at(unit: Calendar.Component, value: Int) throws -> DateInRegion {
		guard let newDate = self.region.calendar.date(bySetting: unit, value: value, of: self.absoluteDate) else {
			throw DateError.FailedToCalculate
		}
		return DateInRegion(absoluteDate: newDate, in: self.region.copy())
	}
	
	public func at(unitsWithValues dict: [Calendar.Component : Int]) throws -> DateInRegion {
		var calculatedDate = self.absoluteDate
		try DateComponents.allComponents.forEach { component in
			let value = dict[component]
			if value != nil {
				guard let newDate = self.region.calendar.date(bySetting: component, value: value!, of: calculatedDate) else {
					throw DateError.FailedToSetComponent(component)
				}
				calculatedDate = newDate
			}
		}
		return DateInRegion(absoluteDate: calculatedDate, in: self.region.copy())
	}
}

public extension Array where Element: DateInRegion {
	
	public var latestDate: DateInRegion {
		var currentMaximum = DateInRegion.distantPast
		self.forEach { cDate in
			if currentMaximum < cDate {
				currentMaximum = cDate
			}
		}
		return currentMaximum
	}
	
	public var earliestDate: DateInRegion {
		var currentMinimum = DateInRegion.distantFuture
		self.forEach { cDate in
			if currentMinimum > cDate {
				currentMinimum = cDate
			}
		}
		return currentMinimum
	}
	
}
