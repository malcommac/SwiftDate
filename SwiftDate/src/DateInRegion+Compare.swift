//
//  DateInRegion+Equatable.swift
//  SwiftDate
//
//  Created by Daniele Margutti on 11/09/16.
//  Copyright © 2016 Daniele Margutti. All rights reserved.
//

import Foundation

public extension DateInRegion {
	
	public func compare(to date: DateInRegion, granularity: Calendar.Component) -> ComparisonResult {
		return self.region.calendar.compare(self.absoluteDate, to: date.absoluteDate, toGranularity: granularity)
	}
	
	public func isIn(date: DateInRegion, granularity: Calendar.Component) -> Bool {
		return (self.compare(to: date, granularity: granularity) == .orderedSame)
	}
	
	public func isBefore(date: DateInRegion, orEqual: Bool = false, granularity: Calendar.Component) -> Bool {
		let result = self.compare(to: date, granularity: granularity)
		return (orEqual ? (result == .orderedSame || result == .orderedAscending) : result == .orderedAscending)
	}

	public func isAfter(date: DateInRegion, orEqual: Bool = false, granularity: Calendar.Component) -> Bool {
		let result = self.compare(to: date, granularity: granularity)
		return (orEqual ? (result == .orderedSame || result == .orderedDescending) : result == .orderedDescending)
	}
	
	public func isEqual(to compareDate: DateInRegion) -> Bool {
		// Compare the content, first the date
		if self.absoluteDate != compareDate.absoluteDate {
			return false
		}
		
		// Then the region
		if region != compareDate.region {
			return false
		}
		
		// We have made it! They are equal!
		return true
	}
}

extension DateInRegion: Equatable {}

public func == (left: DateInRegion, right: DateInRegion) -> Bool {
	return left.isEqual(to: right)
}

public func <= (lhs: DateInRegion, rhs: DateInRegion) -> Bool {
	let result = lhs.absoluteDate.compare(rhs.absoluteDate)
	return (result == .orderedAscending || result == .orderedSame)
}

public func >= (lhs: DateInRegion, rhs: DateInRegion) -> Bool {
	let result = lhs.absoluteDate.compare(rhs.absoluteDate)
	return (result == .orderedDescending || result == .orderedSame)
}

extension DateInRegion: Comparable {}

public func < (lhs: DateInRegion, rhs: DateInRegion) -> Bool {
	return lhs.absoluteDate.compare(rhs.absoluteDate) == .orderedAscending
}

public func > (lhs: DateInRegion, rhs: DateInRegion) -> Bool {
	return lhs.absoluteDate.compare(rhs.absoluteDate) == .orderedDescending
}


extension DateInRegion: Hashable {
	
	/// Allows to generate an unique hash vaalue for an instance of `DateInRegion`
	public var hashValue: Int {
		return self.absoluteDate.hashValue ^ region.hashValue
	}
}
