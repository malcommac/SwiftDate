//
//  Date+Math.swift
//  SwiftDate
//
//  Created by Daniele Margutti on 11/09/16.
//  Copyright © 2016 Daniele Margutti. All rights reserved.
//

import Foundation


// MARK: - Shortcuts to convert Date to DateInRegion

public extension Date {
	
	/// Return the current absolute datetime in local's device region (timezone+calendar+locale)
	///
	/// - returns: a new `DateInRegion` instance object which express passed absolute date in the context of the local device's region
	public func inLocalRegion() -> DateInRegion {
		return DateInRegion(absoluteDate: self)
	}
	
	/// Return the current absolute datetime in UTC/GMT timezone. `Calendar` and `Locale` are set automatically to the device's current settings.
	///
	/// - returns: a new `DateInRegion` instance object which express passed absolute date in UTC timezone
	public func inGMTRegion() -> DateInRegion {
		return DateInRegion(absoluteDate: self, in: Region.GMT())
	}
	
	/// Return the current absolute datetime in the context of passed `Region`.
	///
	/// - parameter region: region you want to use to express `self` date.
	///
	/// - returns: a new `DateInRegion` which represent `self` in the context of passed `Region`
	public func inRegion(region: Region? = nil) -> DateInRegion {
		return DateInRegion(absoluteDate: self, in: region)
	}
	
	/// Create a new Date object which is the sum of passed calendar components in `DateComponents` to `self`
	///
	/// - parameter components: components to set
	///
	/// - throws: throw an exception if new date cannot be evaluated
	///
	/// - returns: a new `Date`
	public func add(components: DateComponents) throws -> Date {
		let date: DateInRegion = self.inGMTRegion() + components
		return date.absoluteDate
	}
	
	/// Create a new Date object which is the sum of passed calendar components in dictionary of `Calendar.Component` values to `self`
	///
	/// - parameter components: components to set
	///
	/// - throws: throw an exception if new date cannot be evaluated
	///
	/// - returns: a new `Date`
	public func add(components: [Calendar.Component: Int]) throws -> Date {
		let date: DateInRegion = self.inGMTRegion() + components
		return date.absoluteDate
	}
	
}

// MARK: - Sum of Dates and Date & Components

public func - (lhs: Date, rhs: DateComponents) -> Date {
	return lhs + (-rhs)
}

public func + (lhs: Date, rhs: DateComponents) -> Date {
	return try! lhs.add(components: rhs)
}

public func + (lhs: Date, rhs: TimeInterval) -> Date {
	return lhs.addingTimeInterval(rhs)
}

public func - (lhs: Date, rhs: TimeInterval) -> Date {
	return lhs.addingTimeInterval(-rhs)
}

public func + (lhs: Date, rhs: [Calendar.Component : Int]) -> Date {
	return try! lhs.add(components: DateInRegion.componentsFrom(values: rhs))
}

public func - (lhs: Date, rhs: [Calendar.Component : Int]) -> Date {
	return try! lhs.add(components: DateInRegion.componentsFrom(values: rhs, multipler: -1))
}

public func - (lhs: Date, rhs: Date) -> TimeInterval {
	return DateInterval(start: lhs, end: rhs).duration
}
