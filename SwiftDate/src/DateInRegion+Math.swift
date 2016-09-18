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

public func + (lhs: DateInRegion, rhs: DateComponents) -> DateInRegion {
	let nextDate = lhs.region.calendar.date(byAdding: rhs, to: lhs.absoluteDate)
	return DateInRegion(absoluteDate: nextDate!, in: lhs.region.copy())
}

public func - (lhs: DateInRegion, rhs: DateComponents) -> DateInRegion {
	return lhs + (-rhs)
}

public func + (lhs: DateInRegion, rhs: [Calendar.Component : Int]) -> DateInRegion {
	let cmps = DateInRegion.componentsFrom(values: rhs)
	return lhs + cmps
}

public func - (lhs: DateInRegion, rhs: [Calendar.Component : Int]) -> DateInRegion {
	var invertedCmps: [Calendar.Component : Int] = [:]
	rhs.forEach { invertedCmps[$0] = -$1 }
	return lhs + invertedCmps
}

public func - (lhs: DateInRegion, rhs: DateInRegion) -> TimeInterval {
	var interval: TimeInterval = 0
	if lhs.absoluteDate < rhs.absoluteDate {
		interval = -(DateInterval(start: lhs.absoluteDate, end: rhs.absoluteDate)).duration
	} else {
		interval = (DateInterval(start: rhs.absoluteDate, end: lhs.absoluteDate)).duration
	}
	return interval
}
