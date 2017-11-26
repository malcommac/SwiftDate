// SwiftDate
// Manage Date/Time & Timezone in Swift
//
// Created by: Daniele Margutti
// Email: <hello@danielemargutti.com>
// Web: <http://www.danielemargutti.com>
//
// Licensed under MIT License.

import Foundation

// MARK: - DateInRegion Compare Methods

public extension DateInRegion {
	
	/// Returns a ComparisonResult value that indicates the ordering of two given dates based on
	/// their components down to a given unit granularity.
	///
	/// - parameter date:        date to compare.
	/// - parameter granularity: The smallest unit that must, along with all larger units, be equal
	///         for the given dates to be considered the same.
	///         For possible values, see “[Calendar Units](xcdoc://?url=developer.apple.com/library/prerelease/ios/documentation/Cocoa/Reference/Foundation/Classes/NSCalendar_Class/index.html#//apple_ref/c/tdef/NSCalendarUnit)”
	///
	/// - returns: `orderedSame` if the dates are the same down to the given granularity, otherwise
	///     `orderedAscending` or `orderedDescending`.
	public func compare(to date: DateInRegion, granularity: Calendar.Component) -> ComparisonResult {
		switch granularity {
		case .nanosecond:
			// There is a possible rounding error using Calendar to compare two dates below the minute granularity
			// So we've added this trick and use standard Date compare which return correct results in this case
			// https://github.com/malcommac/SwiftDate/issues/346
			return self.absoluteDate.compare(date.absoluteDate)
		default:
			return self.region.calendar.compare(self.absoluteDate, to: date.absoluteDate, toGranularity: granularity)
		}
	}
	
	
	/// Compares equality of two given dates based on their components down to a given unit
	/// granularity.
	///
	/// - parameter date:        date to compare
	/// - parameter granularity: The smallest unit that must, along with all larger units, be equal for the given
	///         dates to be considered the same.
	///
	/// - returns: `true` if the dates are the same down to the given granularity, otherwise `false`
	public func isIn(date: DateInRegion, granularity: Calendar.Component) -> Bool {
		return (self.compare(to: date, granularity: granularity) == .orderedSame)
	}
	
	
	/// Compares whether the receiver is before/before equal `date` based on their components down to a given
	/// unit granularity.
	///
	/// - parameter date:        date to compare
	/// - parameter orEqual:     `true` to also check for equality
	/// - parameter granularity: The smallest unit that must, along with all larger units, be less for the given
	///         dates.
	///
	/// - returns: `true` if the unit of the receiver is less than the unit of `date`, otherwise
	///            `false`
	public func isBefore(date: DateInRegion, orEqual: Bool = false, granularity: Calendar.Component) -> Bool {
		let result = self.compare(to: date, granularity: granularity)
		return (orEqual ? (result == .orderedSame || result == .orderedAscending) : result == .orderedAscending)
	}

	
	/// Compares whether the receiver is after `date` based on their components down to a given unit
	/// granularity.
	///
	/// - parameter date:        date to compare
	/// - parameter orEqual:     `true` to also check for equality
	/// - parameter granularity: The smallest unit that must, along with all larger units, be greater for the given dates.
	///
	/// - returns: `true` if the unit of the receiver is greater than the unit of `date`, otherwise
	///            `false`
	public func isAfter(date: DateInRegion, orEqual: Bool = false, granularity: Calendar.Component) -> Bool {
		let result = self.compare(to: date, granularity: granularity)
		return (orEqual ? (result == .orderedSame || result == .orderedDescending) : result == .orderedDescending)
	}
	
    
	/// Returns whether the given date is equal to the receiver.
	///
	/// - parameter compareDate: a date to compare against
	///
	/// - returns: a boolean indicating whether the receiver is equal to the given date
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
    
    
    /// Compares whether a date is between two dates based on their components down to a given unit
    /// granularity.
    /// Both passed `Date` objects are expressed in passed region before doing the comparison.
    ///
    /// - parameter date:        first date as lower bound
    /// - parameter date2:       second date as upper bound
    /// - parameter orEqual:     `true` to also check for equality on date and date2
    /// - parameter granularity: The smallest unit that must, along with all larger units, be greater
    ///
    /// - returns: `true` if unit is in the middle of two dates, otherwise `false`
    public func isBetween(date: DateInRegion, and date2: DateInRegion, orEqual: Bool = false, granularity: Calendar.Component = .nanosecond) -> Bool{
        return self.isAfter(date: date, orEqual: orEqual, granularity: granularity) && self.isBefore(date: date2, orEqual: orEqual, granularity: granularity)
    }
}


// MARK: - DateInRegion Equatable Support

// This allows us to compare for <,<=,>,>= or == two DateInRegion

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

/// Returns whether the given date is later than the receiver.
/// Just the dates are compared. CalendarName, time zones are irrelevant.
///
/// - Parameters:
///     - date: a date to compare against
///
/// - Returns: a boolean indicating whether the receiver is earlier than the given date
///
public func < (lhs: DateInRegion, rhs: DateInRegion) -> Bool {
	return lhs.absoluteDate.compare(rhs.absoluteDate) == .orderedAscending
}

/// Returns whether the given date is earlier than the receiver.
/// Just the dates are compared. CalendarName, time zones are irrelevant.
///
/// - Parameters:
///     - date: a date to compare against
///
/// - Returns: a boolean indicating whether the receiver is later than the given date
///
public func > (lhs: DateInRegion, rhs: DateInRegion) -> Bool {
	return lhs.absoluteDate.compare(rhs.absoluteDate) == .orderedDescending
}



// MARK: - Support for DateInRegion Hashable Support

extension DateInRegion: Hashable {
	
	/// Allows to generate an unique hash vaalue for an instance of `DateInRegion`
	public var hashValue: Int {
		return self.absoluteDate.hashValue ^ region.hashValue
	}
}
