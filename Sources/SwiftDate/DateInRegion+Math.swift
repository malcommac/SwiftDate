//
//	SwiftDate, Full featured Swift date library for parsing, validating, manipulating, and formatting dates and timezones.
//	Created by:				Daniele Margutti
//	Main contributors:		Jeroen Houtzager
//
//
//	Permission is hereby granted, free of charge, to any person obtaining a copy
//	of this software and associated documentation files (the "Software"), to deal
//	in the Software without restriction, including without limitation the rights
//	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//	copies of the Software, and to permit persons to whom the Software is
//	furnished to do so, subject to the following conditions:
//
//	The above copyright notice and this permission notice shall be included in
//	all copies or substantial portions of the Software.
//
//	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//	THE SOFTWARE.

import Foundation

// MARK: - DateInRegion Private Extension

extension DateInRegion {

	
	/// Return a `DateComponent` object from a given set of `Calendar.Component` object with associated values and a specific region
	///
	/// - parameter values:    calendar components to set (with their values)
	/// - parameter multipler: optional multipler (by default is nil; to make an inverse component value it should be multipled by -1)
	/// - parameter region:    optional region to set
	///
	/// - returns: a `DateComponents` object
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

// MARK: - DateInRegion Support for math operation

// These functions allows us to make something like
//		`let newDate = (date - 3.days + 3.months)`
// We can sum algebrically a `DateInRegion` object with a calendar component.

public func + (lhs: DateInRegion, rhs: DateComponents) -> DateInRegion {
	let nextDate = lhs.region.calendar.date(byAdding: rhs, to: lhs.absoluteDate)
	return DateInRegion(absoluteDate: nextDate!, in: lhs.region)
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
	if #available(iOS 10.0, *) {
		if lhs.absoluteDate < rhs.absoluteDate {
			interval = -(DateTimeInterval(start: lhs.absoluteDate, end: rhs.absoluteDate)).duration
		} else {
			interval = (DateTimeInterval(start: rhs.absoluteDate, end: lhs.absoluteDate)).duration
		}
	} else {
		interval = rhs.absoluteDate.timeIntervalSince(lhs.absoluteDate)
	}
	return interval
}
