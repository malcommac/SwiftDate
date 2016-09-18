//
//  DateInRegion+Math.swift
//  SwiftDate
//
//  Created by Daniele Margutti on 09/09/16.
//  Copyright © 2016 Daniele Margutti. All rights reserved.
//

import Foundation

extension DateComponents {
	
	internal static let allComponentsSet: Set<Calendar.Component> = [.nanosecond, .second, .minute, .hour,
	                                                                 .day, .month, .year, .yearForWeekOfYear, .weekOfYear, .weekday, .quarter, .weekdayOrdinal,
	                                                                 .weekOfMonth]
	
	internal static let allComponents: [Calendar.Component] =  [.nanosecond, .second, .minute, .hour,
	                                                           .day, .month, .year, .yearForWeekOfYear, .weekOfYear, .weekday, .quarter, .weekdayOrdinal,
	                                                           .weekOfMonth]
}

extension DateInRegion {
	
	internal static func componentsFrom(values: [Calendar.Component : Int], multipler: Int? = nil, setRegion region: Region? = nil) -> DateComponents {
		var cmps = DateComponents()
		if region != nil {
			cmps.calendar = region!.calendar
			cmps.calendar!.locale = region!.locale
			cmps.timeZone = region!.timeZone
		}
		values.forEach { key,value in
			if key != .timeZone && key != .calendar {
				cmps.setValue( (multipler == nil ? value : value * multipler!), for: key)
			}
		}
		return cmps
	}
	
}

public func + (lhs: DateInRegion, rhs: DateComponents) throws -> DateInRegion {
	guard let nextDate = lhs.region.calendar.date(byAdding: rhs, to: lhs.absoluteDate) else {
		throw DateError.FailedToCalculate
	}
	return DateInRegion(absoluteDate: nextDate, in: lhs.region.copy())
}

public func - (lhs: DateInRegion, rhs: DateComponents) throws -> DateInRegion {
	return try lhs + (-rhs)
}

public func + (lhs: DateInRegion, rhs: DateComponents) throws -> Date {
	guard let nextDate = lhs.region.calendar.date(byAdding: rhs, to: lhs.absoluteDate) else {
		throw DateError.FailedToCalculate
	}
	return nextDate
}

public func - (lhs: DateInRegion, rhs: DateComponents) throws -> Date {
	return try lhs + (-rhs)
}

public func + (lhs: DateInRegion, rhs: [Calendar.Component : Int]) throws -> Date {
	let cmps = DateInRegion.componentsFrom(values: rhs)
	return try lhs + cmps
}

public func - (lhs: DateInRegion, rhs: [Calendar.Component : Int]) throws -> Date {
	var invertedCmps: [Calendar.Component : Int] = [:]
	rhs.forEach { invertedCmps[$0] = -$1 }
	return try lhs + invertedCmps
}

public func + (lhs: DateInRegion, rhs: [Calendar.Component : Int]) throws -> DateInRegion {
	let cmps = DateInRegion.componentsFrom(values: rhs)
	return try lhs + cmps
}

public func - (lhs: DateInRegion, rhs: [Calendar.Component : Int]) throws -> DateInRegion {
	var invertedCmps: [Calendar.Component : Int] = [:]
	rhs.forEach { invertedCmps[$0] = -$1 }
	return try lhs + invertedCmps
}

public func - (lhs: DateInRegion, rhs: DateInRegion) -> TimeInterval {
	return DateInterval(start: lhs.absoluteDate, end: rhs.absoluteDate).duration
}
