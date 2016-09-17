//
//  Date+Components.swift
//  SwiftDate
//
//  Created by Daniele Margutti on 15/09/16.
//  Copyright © 2016 Daniele Margutti. All rights reserved.
//

import Foundation

internal var DateDefaultRegion: Region = Region.Local()

public extension Date {
	
	public func setDateDefaultRegion(_ region: Region) {
		DateDefaultRegion = region
	}
	
	public func dateDefaultRegion() -> Region {
		return DateDefaultRegion
	}
	
	internal func inDateDefaultRegion() -> DateInRegion {
		return self.inRegion(region: DateDefaultRegion)
	}
	
	public var era: Int {
		return self.inDateDefaultRegion().era
	}
	
	public var year: Int {
		return self.inDateDefaultRegion().year
	}
	
	public var month: Int {
		return self.inDateDefaultRegion().month
	}
	
	public var day: Int {
		return self.inDateDefaultRegion().day
	}
	
	public var hour: Int {
		return self.inDateDefaultRegion().hour
	}
	
	public var nearestHour: Int {
		return self.inDateDefaultRegion().nearestHour
	}
	
	public var minute: Int {
		return self.inDateDefaultRegion().minute
	}
	
	public var second: Int {
		return self.inDateDefaultRegion().second
	}
	
	public var nanosecond: Int {
		return self.inDateDefaultRegion().nanosecond
	}
	
	public var yearForWeekOfYear: Int {
		return self.inDateDefaultRegion().yearForWeekOfYear
	}
	
	public var weekOfYear: Int {
		return self.inDateDefaultRegion().weekOfYear
	}
	
	public var weekday: Int {
		return self.inDateDefaultRegion().weekday
	}
	
	public var weekdayOrdinal: Int {
		return self.inDateDefaultRegion().weekdayOrdinal
	}
	
	public var weekdayName: String {
		return self.inDateDefaultRegion().weekdayName
	}
	
	public var monthDays: Int {
		return self.inDateDefaultRegion().monthDays
	}
	
	public var weekOfMonth: Int {
		return self.inDateDefaultRegion().weekOfMonth
	}
	
	public var monthName: String {
		return self.inDateDefaultRegion().monthName
	}
	
	public var shortMonthName: String {
		return self.inDateDefaultRegion().shortMonthName
	}
	
	public var leapMonth: Bool {
		return self.inDateDefaultRegion().leapMonth
	}
	
	public var leapYear: Bool {
		return self.inDateDefaultRegion().leapYear
	}
	
	public var julianDay: Double {
		return self.inDateDefaultRegion().julianDay
	}
	
	public var modifiedJulianDay: Double {
		return self.inDateDefaultRegion().modifiedJulianDay()
	}
	
	public var thisWeekend: (startDate: DateInRegion, endDate: DateInRegion)? {
		return self.inDateDefaultRegion().thisWeekend
	}
	
	public var nextWeekend: (startDate: DateInRegion, endDate: DateInRegion)? {
		return self.inDateDefaultRegion().nextWeekend
	}
	
	public var previousWeekend: (startDate: DateInRegion, endDate: DateInRegion)? {
		return self.inDateDefaultRegion().previousWeekend
	}
	
	public var isToday: Bool {
		return self.inDateDefaultRegion().isToday
	}
	
	public var isYesterday: Bool {
		return self.inDateDefaultRegion().isYesterday
	}
	
	public var isTomorrow: Bool {
		return self.inDateDefaultRegion().isTomorrow
	}
	
	public var isInWeekend: Bool {
		return self.inDateDefaultRegion().isInWeekend
	}
	
	public var isInPast: Bool {
		return self.inDateDefaultRegion().isInPast
	}
	
	public var isInFuture: Bool {
		return self.inDateDefaultRegion().isInFuture
	}
	
	public func isInSameDayOf(date: Date) -> Bool {
		return self.inDateDefaultRegion().isInSameDayOf(date: date.inDateDefaultRegion())
	}
	
	public var startOfDay: Date {
		return self.inDateDefaultRegion().startOfDay.absoluteDate
	}
	
	public var endOfDay: Date {
		return self.inDateDefaultRegion().endOfDay.absoluteDate
	}
	
	public var nextMonth: Date {
		return self.inDateDefaultRegion().nextMonth.absoluteDate
	}
	
	public var prevMonth: Date {
		return self.inDateDefaultRegion().prevMonth.absoluteDate
	}
	
	public func startOf(component: Calendar.Component) -> Date {
		return self.inDateDefaultRegion().startOf(component: component).absoluteDate
	}
	
	public func endOf(component: Calendar.Component) -> Date {
		return self.inDateDefaultRegion().endOf(component: component).absoluteDate
	}
	
	public var timeIntervalSinceReferenceDate: TimeInterval {
		return self.inDateDefaultRegion().timeIntervalSinceReferenceDate
	}
	
	public func atTime(hour: Int, minute: Int, second: Int) throws -> Date {
		return try self.inDateDefaultRegion().atTime(hour: hour, minute: minute, second: second).absoluteDate
	}
	
	public func at(unit: Calendar.Component, value: Int) throws -> Date {
		return try self.inDateDefaultRegion().at(unit: unit, value: value).absoluteDate
	}
	
	public func at(unitsWithValues dict: [Calendar.Component : Int]) throws -> Date {
		return try self.inDateDefaultRegion().at(unitsWithValues: dict).absoluteDate
	}
}
