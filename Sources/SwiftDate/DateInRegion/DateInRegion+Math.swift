//
//  DateInRegion+Math.swift
//  SwiftDate
//
//  Created by Daniele Margutti on 07/06/2018.
//  Copyright © 2018 SwiftDate. All rights reserved.
//

import Foundation

// MARK: - Math Operation DateInRegion - DateInRegion

public func - (lhs: DateInRegion, rhs: DateInRegion) -> TimeInterval {
	return rhs.timeIntervalSince(lhs)
}

// MARK: - Math Operation DateInRegion - Date Components

public func + (lhs: DateInRegion, rhs: DateComponents) -> DateInRegion {
	let nextDate = lhs.calendar.date(byAdding: rhs, to: lhs.date)
	return DateInRegion(nextDate!, region: lhs.region)
}

public func - (lhs: DateInRegion, rhs: DateComponents) -> DateInRegion {
	return lhs + (-rhs)
}

// MARK: - Math Operation DateInRegion - Calendar.Component

public func + (lhs: DateInRegion, rhs: [Calendar.Component: Int]) -> DateInRegion {
	let cmps = DateInRegion.componentsFrom(values: rhs)
	return lhs + cmps
}

public func - (lhs: DateInRegion, rhs: [Calendar.Component: Int]) -> DateInRegion {
	var invertedCmps: [Calendar.Component: Int] = [:]
	rhs.forEach { invertedCmps[$0.key] = -$0.value }
	return lhs + invertedCmps
}

// MARK: - Internal DateInRegion Extension

extension DateInRegion {

	/// Return a `DateComponent` object from a given set of `Calendar.Component` object with associated values and a specific region
	///
	/// - parameter values:    calendar components to set (with their values)
	/// - parameter multipler: optional multipler (by default is nil; to make an inverse component value it should be multipled by -1)
	/// - parameter region:    optional region to set
	///
	/// - returns: a `DateComponents` object
	internal static func componentsFrom(values: [Calendar.Component: Int], multipler: Int? = nil, setRegion region: Region? = nil) -> DateComponents {
		var cmps = DateComponents()
		if region != nil {
			cmps.calendar = region!.calendar
			cmps.calendar!.locale = region!.locale
			cmps.timeZone = region!.timeZone
		}
		values.forEach { pair in
			if pair.key != .timeZone && pair.key != .calendar {
				cmps.setValue( (multipler == nil ? pair.value : pair.value * multipler!), for: pair.key)
			}
		}
		return cmps
	}

	/// Adds a time interval to this date.
	/// WARNING:
	/// This only adjusts an absolute value. If you wish to add calendrical concepts like hours,
	/// days, months then you must use a Calendar.
	/// That will take into account complexities like daylight saving time,
	/// months with different numbers of days, and more.
	///
	/// - Parameter timeInterval: The value to add, in seconds.
	public mutating func addTimeInterval(_ timeInterval: TimeInterval) {
		date.addTimeInterval(timeInterval)
	}
}
