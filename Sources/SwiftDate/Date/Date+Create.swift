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

	/// Return the oldest date in given list.
	///
	/// - Parameter list: list of dates
	/// - Returns: a tuple with the index of the oldest date and its instance.
	static func oldestIn(list: [Date]) -> Date? {
		guard list.count > 0 else { return nil }
		guard list.count > 1 else { return list.first! }
		return list.min(by: {
			return $0 < $1
		})
	}

	/// Return the newest date in given list.
	///
	/// - Parameter list: list of dates
	/// - Returns: a tuple with the index of the oldest date and its instance.
	static func newestIn(list: [Date]) -> Date? {
		guard list.count > 0 else { return nil }
		guard list.count > 1 else { return list.first! }
		return list.max(by: {
			return $0 < $1
		})
	}

	/// Enumerate dates between two intervals by adding specified time components defined by a function and return an array of dates.
	/// `startDate` interval will be the first item of the resulting array.
	/// The last item of the array is evaluated automatically and maybe not equal to `endDate`.
	///
	/// - Parameters:
	///   - start: starting date
	///   - endDate: ending date
	///   - increment: increment function. It get the last generated date and require a valida `DateComponents` instance which define the increment
	/// - Returns: array of dates
	static func enumerateDates(from startDate: Date, to endDate: Date, increment: ((Date) -> (DateComponents))) -> [Date] {
		var dates: [Date] = []
		var currentDate = startDate

		while currentDate <= endDate {
			dates.append(currentDate)
			currentDate = (currentDate + increment(currentDate))
		}
		return dates
	}

	/// Enumerate dates between two intervals by adding specified time components and return an array of dates.
	/// `startDate` interval will be the first item of the resulting array.
	/// The last item of the array is evaluated automatically and maybe not equal to `endDate`.
	///
	/// - Parameters:
	///   - start: starting date
	///   - endDate: ending date
	///   - increment: components to add
	/// - Returns: array of dates
	static func enumerateDates(from startDate: Date, to endDate: Date, increment: DateComponents) -> [Date] {
		return Date.enumerateDates(from: startDate, to: endDate, increment: { _ in
			return increment
		})
	}

	/// Round a given date time to the passed style (off|up|down).
	///
	/// - Parameter style: rounding mode.
	/// - Returns: rounded date
	func dateRoundedAt(at style: RoundDateMode) -> Date {
		return inDefaultRegion().dateRoundedAt(style).date
	}

	/// Returns a new DateInRegion that is initialized at the start of a specified unit of time.
	///
	/// - Parameter unit: time unit value.
	/// - Returns: instance at the beginning of the time unit; `self` if fails.
	func dateAtStartOf(_ unit: Calendar.Component) -> Date {
		return inDefaultRegion().dateAtStartOf(unit).date
	}

	/// Return a new DateInRegion that is initialized at the start of the specified components
	/// executed in order.
	///
	/// - Parameter units: sequence of transformations as time unit components
	/// - Returns: new date at the beginning of the passed components, intermediate results if fails.
	func dateAtStartOf(_ units: [Calendar.Component]) -> Date {
		return units.reduce(self) { (currentDate, currentUnit) -> Date in
			return currentDate.dateAtStartOf(currentUnit)
		}
	}

	/// Returns a new Moment that is initialized at the end of a specified unit of time.
	///
	/// - parameter unit: A TimeUnit value.
	///
	/// - returns: A new Moment instance.
	func dateAtEndOf(_ unit: Calendar.Component) -> Date {
		return inDefaultRegion().dateAtEndOf(unit).date
	}

	/// Return a new DateInRegion that is initialized at the end of the specified components
	/// executed in order.
	///
	/// - Parameter units: sequence of transformations as time unit components
	/// - Returns: new date at the end of the passed components, intermediate results if fails.
	func dateAtEndOf(_ units: [Calendar.Component]) -> Date {
		return units.reduce(self) { (currentDate, currentUnit) -> Date in
			return currentDate.dateAtEndOf(currentUnit)
		}
	}

	/// Create a new date by altering specified components of the receiver.
	///
	/// - Parameter components: components to alter with their new values.
	/// - Returns: new altered `DateInRegion` instance
	func dateBySet(_ components: [Calendar.Component: Int]) -> Date? {
		return DateInRegion(self, region: SwiftDate.defaultRegion).dateBySet(components)?.date
	}

	/// Create a new date by altering specified time components.
	///
	/// - Parameters:
	///   - hour: hour to set (`nil` to leave it unaltered)
	///   - min: min to set (`nil` to leave it unaltered)
	///   - secs: sec to set (`nil` to leave it unaltered)
	///   - ms: milliseconds to set (`nil` to leave it unaltered)
	///   - options: options for calculation
	/// - Returns: new altered `DateInRegion` instance
	func dateBySet(hour: Int?, min: Int?, secs: Int?, ms: Int? = nil, options: TimeCalculationOptions = TimeCalculationOptions()) -> Date? {
		let srcDate = DateInRegion(self, region: SwiftDate.defaultRegion)
		return srcDate.dateBySet(hour: hour, min: min, secs: secs, ms: ms, options: options)?.date
	}

	/// Creates a new instance by truncating the components
	///
	/// - Parameter components: components to truncate.
	/// - Returns: new date with truncated components.
	func dateTruncated(_ components: [Calendar.Component]) -> Date? {
		return DateInRegion(self, region: SwiftDate.defaultRegion).dateTruncated(at: components)?.date
	}

	/// Creates a new instance by truncating the components starting from given components down the granurality.
	///
	/// - Parameter component: The component to be truncated from.
	/// - Returns: new date with truncated components.
	func dateTruncated(from component: Calendar.Component) -> Date? {
		return DateInRegion(self, region: SwiftDate.defaultRegion).dateTruncated(from: component)?.date
	}

	/// Offset a date by n calendar components.
	/// Note: This operation can be functionally chained.
	///
	/// - Parameters:
	///   - count: value of the offset.
	///   - component: component to offset.
	/// - Returns: new altered date.
	func dateByAdding(_ count: Int, _ component: Calendar.Component) -> DateInRegion {
		return DateInRegion(self, region: SwiftDate.defaultRegion).dateByAdding(count, component)
	}

	/// Return related date starting from the receiver attributes.
	///
	/// - Parameter type: related date to obtain.
	/// - Returns: instance of the related date.
	func dateAt(_ type: DateRelatedType) -> Date {
		return inDefaultRegion().dateAt(type).date
	}

	/// Create a new date at now and extract the related date using passed rule type.
	///
	/// - Parameter type: related date to obtain.
	/// - Returns: instance of the related date.
	static func nowAt(_ type: DateRelatedType) -> Date {
		return Date().dateAt(type)
	}

	/// Return the dates for a specific weekday inside given month of specified year.
	/// Ie. get me all the saturdays of Feb 2018.
	/// NOTE: Values are returned in order.
	///
	/// - Parameters:
	///   - weekday: weekday target.
	///   - month: month target.
	///   - year: year target.
	///   - region: region target, omit to use `SwiftDate.defaultRegion`
	/// - Returns: Ordered list of the dates for given weekday into given month.
	static func datesForWeekday(_ weekday: WeekDay, inMonth month: Int, ofYear year: Int,
									   region: Region = SwiftDate.defaultRegion) -> [Date] {
		let fromDate = DateInRegion(Date(year: year, month: month, day: 1, hour: 0, minute: 0), region: region)
		let toDate = fromDate.dateAt(.endOfMonth)
		return DateInRegion.datesForWeekday(weekday, from: fromDate, to: toDate, region: region).map { $0.date }
	}

	/// Return the dates for a specific weekday inside a specified date range.
	/// NOTE: Values are returned in order.
	///
	/// - Parameters:
	///   - weekday: weekday target.
	///   - startDate: from date of the range.
	///   - endDate: to date of the range.
	///   - region: region target, omit to use `SwiftDate.defaultRegion`
	/// - Returns: Ordered list of the dates for given weekday in passed range.
	static func datesForWeekday(_ weekday: WeekDay, from startDate: Date, to endDate: Date,
									   region: Region = SwiftDate.defaultRegion) -> [Date] {
		let fromDate = DateInRegion(startDate, region: region)
		let toDate = DateInRegion(endDate, region: region)
		return DateInRegion.datesForWeekday(weekday, from: fromDate, to: toDate, region: region).map { $0.date }
	}

    /// Returns the date at the given week number and week day preserving smaller components (hour, minute, seconds)
    ///
    /// For example: to get the third friday of next month
    ///         let today = DateInRegion()
    ///         let result = today.dateAt(weekdayOrdinal: 3, weekday: .friday, monthNumber: today.month + 1)
    ///
    /// - Parameters:
    ///     - weekdayOrdinal: the week number (by set position in a recurrence rule)
    ///     - weekday: WeekDay
    ///     - monthNumber: a number from 1 to 12 representing the month, optional parameter
    ///     - yearNumber: a number representing the year, optional parameter
    /// - Returns: new date created with the given parameters
    func dateAt(weekdayOrdinal: Int, weekday: WeekDay, monthNumber: Int? = nil,
                yearNumber: Int? = nil) -> Date {
        let date = DateInRegion(self, region: region)
        return date.dateAt(weekdayOrdinal: weekdayOrdinal, weekday: weekday, monthNumber: monthNumber, yearNumber: yearNumber).date
    }

    /// Returns the next weekday preserving smaller components (hour, minute, seconds)
    ///
    /// - Parameters:
    ///   - weekday: weekday to get.
    ///   - region: region target, omit to use `SwiftDate.defaultRegion`
    /// - Returns: `Date`
    func nextWeekday(_ weekday: WeekDay, region: Region = SwiftDate.defaultRegion) -> Date {
        let date = DateInRegion(self, region: region)
        return date.nextWeekday(weekday).date
    }

}
