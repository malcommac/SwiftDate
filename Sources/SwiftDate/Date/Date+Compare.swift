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
        (abs(timeIntervalSince(refDate)) < precision)
	}

	// MARK: - Extendend Compare

	/// Compare the date with the rule specified in the `compareType` parameter.
	///
	/// - Parameter compareType: comparison type.
	/// - Returns: `true` if comparison succeded, `false` otherwise
	func compare(_ compareType: DateComparisonType) -> Bool {
        inDefaultRegion().compare(compareType)
	}

	/// Returns a ComparisonResult value that indicates the ordering of two given dates based on
	/// their components down to a given unit granularity.
	///
	/// - parameter date:        date to compare.
	/// - parameter granularity: The smallest unit that must, along with all larger units be less for the given dates
	/// - returns: `ComparisonResult`
	func compare(toDate refDate: Date, granularity: Calendar.Component) -> ComparisonResult {
        inDefaultRegion().compare(toDate: refDate.inDefaultRegion(), granularity: granularity)
	}

	/// Compares whether the receiver is before/before equal `date` based on their components down to a given unit granularity.
	///
	/// - Parameters:
	///   - refDate: reference date
	///   - orEqual: `true` to also check for equality
	///   - granularity: smallest unit that must, along with all larger units, be less for the given dates
	/// - Returns: Boolean
	func isBeforeDate(_ refDate: Date, orEqual: Bool = false, granularity: Calendar.Component) -> Bool {
        inDefaultRegion().isBeforeDate(refDate.inDefaultRegion(), orEqual: orEqual, granularity: granularity)
	}

	/// Compares whether the receiver is after `date` based on their components down to a given unit granularity.
	///
	/// - Parameters:
	///   - refDate: reference date
	///   - orEqual: `true` to also check for equality
	///   - granularity: Smallest unit that must, along with all larger units, be greater for the given dates.
	/// - Returns: Boolean
	func isAfterDate(_ refDate: Date, orEqual: Bool = false, granularity: Calendar.Component) -> Bool {
        inDefaultRegion().isAfterDate(refDate.inDefaultRegion(), orEqual: orEqual, granularity: granularity)
	}

	/// Returns a value between 0.0 and 1.0 or nil, that is the position of current date between 2 other dates.
	///
	/// - Parameters:
	///   - startDate: range upper bound date
	///   - endDate: range lower bound date
	/// - Returns: `nil` if current date is not between `startDate` and `endDate`. Otherwise returns position between `startDate` and `endDate`.
	func positionInRange(date startDate: Date, and endDate: Date) -> Double? {
        inDefaultRegion().positionInRange(date: startDate.inDefaultRegion(), and: endDate.inDefaultRegion())
	}

	/// Return true if receiver date is contained in the range specified by two dates.
	///
	/// - Parameters:
	///   - startDate: range upper bound date
	///   - endDate: range lower bound date
	///   - orEqual: `true` to also check for equality on date and date2
	///   - granularity: smallest unit that must, along with all larger units, be greater for the given dates.
	/// - Returns: Boolean
	func isInRange(date startDate: Date, and endDate: Date, orEqual: Bool = false, granularity: Calendar.Component = .nanosecond) -> Bool {
        inDefaultRegion().isInRange(date: startDate.inDefaultRegion(), and: endDate.inDefaultRegion(), orEqual: orEqual, granularity: granularity)
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
        (compare(toDate: date, granularity: granularity) == .orderedSame)
	}

	// MARK: - Date Earlier/Later

	/// Return the earlier of two dates, between self and a given date.
	///
	/// - Parameter date: The date to compare to self
	/// - Returns: The date that is earlier
	func earlierDate(_ date: Date) -> Date {
        timeIntervalSince(date) <= 0 ? self : date
	}

	/// Return the later of two dates, between self and a given date.
	///
	/// - Parameter date: The date to compare to self
	/// - Returns: The date that is later
	func laterDate(_ date: Date) -> Date {
        timeIntervalSince(date) >= 0 ? self : date
	}

}

extension Date {

    /// Returns the difference in the calendar component given (like day, month or year)
    /// with respect to the other date as a positive integer
    public func difference(in component: Calendar.Component, from other: Date) -> Int? {
        let (max, min) = orderDate(with: other)
        let result = calendar.dateComponents([component], from: min, to: max)
        return getValue(of: component, from: result)
    }

    /// Returns the differences in the calendar components given (like day, month and year)
    /// with respect to the other date as dictionary with the calendar component as the key
    /// and the diffrence as a positive integer as the value
    public func differences(in components: Set<Calendar.Component>, from other: Date) -> [Calendar.Component: Int] {
        let (max, min) = orderDate(with: other)
        let differenceInDates = calendar.dateComponents(components, from: min, to: max)
        var result = [Calendar.Component: Int]()
        for component in components {
            if let value = getValue(of: component, from: differenceInDates) {
                result[component] = value
            }
        }
        return result
    }

    private func getValue(of component: Calendar.Component, from dateComponents: DateComponents) -> Int? {
        switch component {
        case .era:
            return dateComponents.era
        case .year:
            return dateComponents.year
        case .month:
            return dateComponents.month
        case .day:
            return dateComponents.day
        case .hour:
            return dateComponents.hour
        case .minute:
            return dateComponents.minute
        case .second:
            return dateComponents.second
        case .weekday:
            return dateComponents.weekday
        case .weekdayOrdinal:
            return dateComponents.weekdayOrdinal
        case .quarter:
            return dateComponents.quarter
        case .weekOfMonth:
            return dateComponents.weekOfMonth
        case .weekOfYear:
            return dateComponents.weekOfYear
        case .yearForWeekOfYear:
            return dateComponents.yearForWeekOfYear
        case .nanosecond:
            return dateComponents.nanosecond
        case .calendar, .timeZone:
            return nil
        @unknown default:
            assert(false, "unknown date component")
        }
        return nil
    }

    private func orderDate(with other: Date) -> (Date, Date) {
        let first = self.timeIntervalSince1970
        let second = other.timeIntervalSince1970

        if first >= second {
            return (self, other)
        }

        return (other, self)
    }
}
