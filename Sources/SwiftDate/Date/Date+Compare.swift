//
//  SwiftDate
//  Parse, validate, manipulate, and display dates, time and timezones in Swift
//
//  Created by Daniele Margutti
//   - Web: https://www.danielemargutti.com
//   - Twitter: https://twitter.com/danielemargutti
//   - Mail: hello@danielemargutti.com
//
//  Copyright © 2019 Daniele Margutti. Licensed under MIT License.
//

import Foundation

public extension Date {

	// MARK: - Comparing Close

	/// Decides whether a Date is "close by" another one passed in parameter,
	/// where "Being close" is measured using a precision argument
	/// which is initialized a 300 seconds, or 5 minutes.
	///
	/// - Parameters:
	///   - refDate: reference date compare against to.
	///   - precision: The precision of the comparison (default is 5 minutes, or 300 seconds).
	/// - Returns: A boolean; true if close by, false otherwise.
	func compareCloseTo(_ refDate: Date, precision: TimeInterval = 300) -> Bool {
		return (abs(timeIntervalSince(refDate)) < precision)
	}

	// MARK: - Extendend Compare

	/// Compare the date with the rule specified in the `compareType` parameter.
	///
	/// - Parameter compareType: comparison type.
	/// - Returns: `true` if comparison succeded, `false` otherwise
	func compare(_ compareType: DateComparisonType) -> Bool {
		return inDefaultRegion().compare(compareType)
	}

	/// Returns a ComparisonResult value that indicates the ordering of two given dates based on
	/// their components down to a given unit granularity.
	///
	/// - parameter date:        date to compare.
	/// - parameter granularity: The smallest unit that must, along with all larger units be less for the given dates
	/// - returns: `ComparisonResult`
	func compare(toDate refDate: Date, granularity: Calendar.Component) -> ComparisonResult {
		return inDefaultRegion().compare(toDate: refDate.inDefaultRegion(), granularity: granularity)
	}

	/// Compares whether the receiver is before/before equal `date` based on their components down to a given unit granularity.
	///
	/// - Parameters:
	///   - refDate: reference date
	///   - orEqual: `true` to also check for equality
	///   - granularity: smallest unit that must, along with all larger units, be less for the given dates
	/// - Returns: Boolean
	func isBeforeDate(_ refDate: Date, orEqual: Bool = false, granularity: Calendar.Component) -> Bool {
		return inDefaultRegion().isBeforeDate(refDate.inDefaultRegion(), orEqual: orEqual, granularity: granularity)
	}

	/// Compares whether the receiver is after `date` based on their components down to a given unit granularity.
	///
	/// - Parameters:
	///   - refDate: reference date
	///   - orEqual: `true` to also check for equality
	///   - granularity: Smallest unit that must, along with all larger units, be greater for the given dates.
	/// - Returns: Boolean
	func isAfterDate(_ refDate: Date, orEqual: Bool = false, granularity: Calendar.Component) -> Bool {
		return inDefaultRegion().isAfterDate(refDate.inDefaultRegion(), orEqual: orEqual, granularity: granularity)
	}

	/// Return true if receiver data is contained in the range specified by two dates.
	///
	/// - Parameters:
	///   - startDate: range upper bound date
	///   - endDate: range lower bound date
	///   - orEqual: `true` to also check for equality on date and date2
	///   - granularity: smallest unit that must, along with all larger units, be greater for the given dates.
	/// - Returns: Boolean
	func isInRange(date startDate: Date, and endDate: Date, orEqual: Bool = false, granularity: Calendar.Component = .nanosecond) -> Bool {
        return self.inDefaultRegion().isInRange(date: startDate.inDefaultRegion(), and: endDate.inDefaultRegion(), orEqual: orEqual, granularity: granularity)
	}

	/// Compares equality of two given dates based on their components down to a given unit
	/// granularity.
	///
	/// - parameter date:        date to compare
	/// - parameter granularity: The smallest unit that must, along with all larger units, be equal for the given
	///         dates to be considered the same.
	///
	/// - returns: `true` if the dates are the same down to the given granularity, otherwise `false`
	func isInside(date: Date, granularity: Calendar.Component) -> Bool {
		return (compare(toDate: date, granularity: granularity) == .orderedSame)
	}

	// MARK: - Date Earlier/Later

	/// Return the earlier of two dates, between self and a given date.
	///
	/// - Parameter date: The date to compare to self
	/// - Returns: The date that is earlier
	func earlierDate(_ date: Date) -> Date {
		return (timeIntervalSince1970 <= date.timeIntervalSince1970) ? self : date
	}

	/// Return the later of two dates, between self and a given date.
	///
	/// - Parameter date: The date to compare to self
	/// - Returns: The date that is later
	func laterDate(_ date: Date) -> Date {
		return (timeIntervalSince1970 >= date.timeIntervalSince1970) ? self : date
	}

}
