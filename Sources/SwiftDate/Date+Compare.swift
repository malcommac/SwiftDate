// SwiftDate
// Manage Date/Time & Timezone in Swift
//
// Created by: Daniele Margutti
// Email: <hello@danielemargutti.com>
// Web: <http://www.danielemargutti.com>
//
// Licensed under MIT License.

import Foundation

public extension Date {
	
	/// Returns a ComparisonResult value that indicates the ordering of two given dates based on
	/// their components down to a given unit granularity. Both passed `Date` objects are expressed in
	/// passed region before doing the comparison.
	///
	/// - parameter date:        date to compare
	/// - parameter region:      region in which both dates will be expressed (if nil, defaultRegion will be used instead)
	/// - parameter granularity: The smallest unit that must, along with all larger units, be equal
	///         for the given dates to be considered the same.
	///         For possible values, see “[Calendar Units](xcdoc://?url=developer.apple.com/library/prerelease/ios/documentation/Cocoa/Reference/Foundation/Classes/NSCalendar_Class/index.html#//apple_ref/c/tdef/NSCalendarUnit)”
	///
	/// - returns: `orderedSame` if the dates are the same down to the given granularity, otherwise
	///     `orderedAscending` or `orderedDescending`.
	public func compare(to date: Date, in region: Region? = nil, granularity: Calendar.Component) -> ComparisonResult {
		let srcRegion = region ?? DateDefaultRegion
		return srcRegion.calendar.compare(self, to: date, toGranularity: granularity)
	}
	
	
	/// Compares equality of two given dates based on their components down to a given unit
	/// granularity.
	/// Both passed `Date` objects are expressed in passed region before doing the comparison.
	///
	/// - parameter date:        date to compare
	/// - parameter region:      region in which both dates will be expressed (if nil, defaultRegion will be used instead)
	/// - parameter granularity: The smallest unit that must, along with all larger units, be equal for the given
	///         dates to be considered the same.
	///
	/// - returns: `true` if the dates are the same down to the given granularity, otherwise `false`
	public func isIn(date: Date, in region: Region? = nil, granularity: Calendar.Component) -> Bool {
		return (self.compare(to: date, granularity: granularity) == .orderedSame)
	}
	
	
	/// Compares whether the receiver is before/before equal `date` based on their components down to a given
	/// unit granularity.
	///
	/// - parameter date:        date to compare
	/// - parameter orEqual:     `true` to also check for equality
	/// - parameter region:      region in which both dates will be expressed (if nil, defaultRegion will be used instead)
	/// - parameter granularity: The smallest unit that must, along with all larger units, be less for the given
	///         dates.
	///
	/// - returns: `true` if the unit of the receiver is less than the unit of `date`, otherwise
	///            `false`
	public func isBefore(date: Date, orEqual: Bool = false, in region: Region? = nil, granularity: Calendar.Component) -> Bool {
		let result = self.compare(to: date, granularity: granularity)
		return (orEqual ? (result == .orderedSame || result == .orderedAscending) : result == .orderedAscending)
	}
	
	/// Compares whether the receiver is after `date` based on their components down to a given unit
	/// granularity.
	/// Both passed `Date` objects are expressed in passed region before doing the comparison.
	///
	/// - parameter date:        date to compare
	/// - parameter orEqual:     `true` to also check for equality
	/// - parameter region:      region in which both dates will be expressed (if nil, defaultRegion will be used instead)
	/// - parameter granularity: The smallest unit that must, along with all larger units, be greater
	///
	/// - returns: `true` if the unit of the receiver is greater than the unit of `date`, otherwise
	///            `false`
	public func isAfter(date: Date, orEqual: Bool = false, in region: Region? = nil, granularity: Calendar.Component) -> Bool {
		let result = self.compare(to: date, granularity: granularity)
		return (orEqual ? (result == .orderedSame || result == .orderedDescending) : result == .orderedDescending)
	}
    
    
    /// Compares whether a date is between two dates based on their components down to a given unit
    /// granularity.
    /// Both passed `Date` objects are expressed in passed region before doing the comparison.
    ///
    /// - parameter date:        first date as lower bound
    /// - parameter date2:       second date as upper bound
    /// - parameter orEqual:     `true` to also check for equality on date and date2
    /// - parameter region:      region in which both dates will be expressed (if nil, defaultRegion will be used instead)
    /// - parameter granularity: The smallest unit that must, along with all larger units, be greater
    ///
    /// - returns: `true` if the unit is in the middle of two dates, otherwise `false`
    public func isBetween(date: Date, and date2: Date, orEqual: Bool = false, in region: Region? = nil, granularity: Calendar.Component = .nanosecond) -> Bool{
        return self.isAfter(date: date, orEqual: orEqual, in: region, granularity: granularity) && self.isBefore(date: date2, orEqual: orEqual, in: region, granularity: granularity)
    }
	
}
