//
//  Date+Compare.swift
//  SwiftDate
//
//  Created by Daniele Margutti on 15/09/16.
//  Copyright © 2016 Daniele Margutti. All rights reserved.
//

import Foundation

public extension Date {
	
	public func compare(to date: Date, in region: Region? = nil, granularity: Calendar.Component) -> ComparisonResult {
		let srcRegion = region ?? DateDefaultRegion
		return srcRegion.calendar.compare(self, to: date, toGranularity: granularity)
	}
	
	public func isIn(date: Date, in region: Region? = nil, granularity: Calendar.Component) -> Bool {
		return (self.compare(to: date, granularity: granularity) == .orderedSame)
	}
	
	public func isBefore(date: Date, orEqual: Bool = false, in region: Region? = nil, granularity: Calendar.Component) -> Bool {
		let result = self.compare(to: date, granularity: granularity)
		return (orEqual ? (result == .orderedSame || result == .orderedAscending) : result == .orderedAscending)
	}
	
	public func isAfter(date: Date, orEqual: Bool = false, in region: Region? = nil, granularity: Calendar.Component) -> Bool {
		let result = self.compare(to: date, granularity: granularity)
		return (orEqual ? (result == .orderedSame || result == .orderedDescending) : result == .orderedDescending)
	}
	
}
