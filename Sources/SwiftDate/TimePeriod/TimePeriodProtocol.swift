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

public protocol TimePeriodProtocol {

	/// The start date for a TimePeriod representing the starting boundary of the time period
	var start: DateInRegion? { get set }

	/// The end date for a TimePeriod representing the ending boundary of the time period
	var end: DateInRegion? { get set }

}

public extension TimePeriodProtocol {

	/// Return `true` if time period has both start and end dates
	var hasFiniteRange: Bool {
		guard start != nil && end != nil else { return false }
		return true
	}

	/// Return `true` if period has a start date
	var hasStart: Bool {
		return (start != nil)
	}

	/// Return `true` if period has a end date
	var hasEnd: Bool {
		return (end != nil)
	}

	/// Check if receiver is equal to given period (both start/end groups are equals)
	///
	/// - Parameter period: period to compare against to.
	/// - Returns: true if are equals
	func equals(_ period: TimePeriodProtocol) -> Bool {
		return (start == period.start && end == period.end)
	}

	/// If the given `TimePeriod`'s beginning is before `beginning` and
	/// if the given 'TimePeriod`'s end is after `end`.
	///
	/// - Parameter period: The time period to compare to self
	/// - Returns: True if self is inside of the given `TimePeriod`
	func isInside(_ period: TimePeriodProtocol) -> Bool {
		guard hasFiniteRange, period.hasFiniteRange else { return false }
		return (period.start! <= start! && period.end! >= end!)
	}

	/// If the given Date is after `beginning` and before `end`.
	///
	/// - Parameters:
	///   - date: The time period to compare to self
	///   - interval: Whether the edge of the date is included in the calculation
	/// - Returns: True if the given `TimePeriod` is inside of self
	func contains(date: DateInRegion, interval: IntervalType = .closed) -> Bool {
		guard hasFiniteRange else { return false }
		switch interval {
		case .closed:	return (start! <= date && end! >= date)
		case .open:		return (start! < date && end! > date)
		}
	}

	/// If the given `TimePeriod`'s beginning is after `beginning` and
	/// if the given 'TimePeriod`'s after is after `end`.
	///
	/// - Parameter period: The time period to compare to self
	/// - Returns: True if the given `TimePeriod` is inside of self
	func contains(_ period: TimePeriodProtocol) -> Bool {
		guard hasFiniteRange, period.hasFiniteRange else { return false }
		if period.start! < start! && period.end! > start! {
			return true // Outside -> Inside
		} else if period.start! >= start! && period.end! <= end! {
			return true // Enclosing
		} else if period.start! < end! && period.end! > end! {
			return true // Inside -> Out
		}
		return false
	}

	/// If self and the given `TimePeriod` share any sub-`TimePeriod`.
	///
	/// - Parameter period: The time period to compare to self
	/// - Returns: True if there is a period of time that is shared by both `TimePeriod`s
	func overlaps(with period: TimePeriodProtocol) -> Bool {
		if period.start! < start! && period.end! > start! {
			return true // Outside -> Inside
		} else if period.start! >= start! && period.end! <= end! {
			return true // Enclosing
		} else if period.start! < end! && period.end! > end! {
			return true // Inside -> Out
		}
		return false
	}

	/// If self and the given `TimePeriod` overlap or the period's edges touch.
	///
	/// - Parameter period: The time period to compare to self
	/// - Returns: True if there is a period of time or moment that is shared by both `TimePeriod`s
	func intersects(with period: TimePeriodProtocol) -> Bool {
		let relation = self.relation(to: period)
		return (relation != .after && relation != .before)
	}

	/// If self is before the given `TimePeriod` chronologically. (A gap must exist between the two).
	///
	/// - Parameter period: The time period to compare to self
	/// - Returns: True if self is after the given `TimePeriod`
	func isBefore(_ period: TimePeriodProtocol) -> Bool {
		return (relation(to: period) == .before)
	}

	/// If self is after the given `TimePeriod` chronologically. (A gap must exist between the two).
	///
	/// - Parameter period: The time period to compare to self
	/// - Returns: True if self is after the given `TimePeriod`
	func isAfter(_ period: TimePeriodProtocol) -> Bool {
		return (relation(to: period) == .after)
	}

	/// The period of time between self and the given `TimePeriod` not contained by either.
	///
	/// - Parameter period: The time period to compare to self
	/// - Returns: The gap between the periods. Zero if there is no gap.
	func hasGap(between period: TimePeriodProtocol) -> Bool {
		return (isBefore(period) || isAfter(period))
	}

	/// The period of time between self and the given `TimePeriod` not contained by either.
	///
	/// - Parameter period: The time period to compare to self
	/// - Returns: The gap between the periods. Zero if there is no gap.
	func gap(between period: TimePeriodProtocol) -> TimeInterval {
		guard hasFiniteRange, period.hasFiniteRange else { return TimeInterval.greatestFiniteMagnitude }
		if end! < period.start! {
			return abs(end!.timeIntervalSince(period.start!))
		} else if period.end! < start! {
			return abs(end!.timeIntervalSince(start!))
		}
		return 0
	}

	/// In place, shift the `TimePeriod` by a `TimeInterval`
	///
	/// - Parameter timeInterval: The time interval to shift the period by
	mutating func shift(by timeInterval: TimeInterval) {
		start?.addTimeInterval(timeInterval)
		end?.addTimeInterval(timeInterval)
	}

	/// In place, lengthen the `TimePeriod`, anchored at the beginning, end or center
	///
	/// - Parameters:
	///   - timeInterval: The time interval to lengthen the period by
	///   - anchor: The anchor point from which to make the change
	mutating func lengthen(by timeInterval: TimeInterval, at anchor: TimePeriodAnchor) {
		switch anchor {
		case .beginning:
			end?.addTimeInterval(timeInterval)
		case .end:
			start?.addTimeInterval(timeInterval)
		case .center:
			start = start?.addingTimeInterval(-timeInterval / 2.0)
			end = end?.addingTimeInterval(timeInterval / 2.0)
		}
	}

	/// In place, shorten the `TimePeriod`, anchored at the beginning, end or center
	///
	/// - Parameters:
	///   - timeInterval: The time interval to shorten the period by
	///   - anchor: The anchor point from which to make the change
	mutating func shorten(by timeInterval: TimeInterval, at anchor: TimePeriodAnchor) {
		switch anchor {
		case .beginning:
			end?.addTimeInterval(-timeInterval)
		case .end:
			start?.addTimeInterval(timeInterval)
		case .center:
			start?.addTimeInterval(timeInterval / 2.0)
			end?.addTimeInterval(-timeInterval / 2.0)
		}
	}

	/// The relationship of the self `TimePeriod` to the given `TimePeriod`.
	/// Relations are stored in Enums.swift. Formal defnitions available in the provided
	/// links:
	/// [GitHub](https://github.com/MatthewYork/DateTools#relationships),
	/// [CodeProject](http://www.codeproject.com/Articles/168662/Time-Period-Library-for-NET)
	///
	/// - Parameter period: The time period to compare to self
	/// - Returns: The relationship between self and the given time period
	func relation(to period: TimePeriodProtocol) -> TimePeriodRelation {
		//Make sure that all start and end points exist for comparison
		guard hasFiniteRange, period.hasFiniteRange else { return .none }
		//Make sure time periods are of positive durations
		guard start! < end! && period.start! < period.end! else { return .none }
		//Make comparisons
		if period.start! < start! {
			return .after
		} else if period.end! == start! {
			return .startTouching
		} else if period.start! < start! && period.end! < end! {
			return .startInside
		} else if period.start! == start! && period.end! > end! {
			return .insideStartTouching
		} else if period.start! == start! && period.end! < end! {
			return .enclosingStartTouching
		} else if period.start! > start! && period.end! < end! {
			return .enclosing
		} else if period.start! > start! && period.end! == end! {
			return .enclosingEndTouching
		} else if period.start == start! && period.end! == end! {
			return .exactMatch
		} else if period.start! < start! && period.end! > end! {
			return .inside
		} else if period.start! < start! && period.end! == end! {
			return .insideEndTouching
		} else if period.start! < end! && period.end! > end! {
			return .endInside
		} else if period.start! == end! && period.end! > end! {
			return .endTouching
		} else if period.start! > end! {
			return .before
		}
		return .none
	}

	/// Return `true` if period is zero-seconds long or less than specified precision.
	///
	/// - Parameter precision: precision in seconds; by default is 0.
	/// - Returns: true if start/end has the same value or less than specified precision
	func isMoment(precision: TimeInterval = 0) -> Bool {
		guard hasFiniteRange else { return false }
		return (abs(start!.date.timeIntervalSince1970 - end!.date.timeIntervalSince1970) <= precision)
	}

	/// Returns the duration of the receiver expressed with given time unit.
	/// If time period has not a finite range it returns `nil`.
	///
	/// - Parameter unit: unit of the duration
	/// - Returns: duration, `nil` if period has not a finite range
	func durationIn(_ units: Set<Calendar.Component>) -> DateComponents? {
		guard hasFiniteRange else { return nil }
		return start!.calendar.dateComponents(units, from: start!.date, to: end!.date)
	}

	/// Returns the duration of the receiver expressed with given time unit.
	/// If time period has not a finite range it returns `nil`.
	///
	/// - Parameter unit: unit of the duration
	/// - Returns: duration, `nil` if period has not a finite range
	func durationIn(_ unit: Calendar.Component) -> Int? {
		guard hasFiniteRange else { return nil }
		return start!.calendar.dateComponents([unit], from: start!.date, to: end!.date).value(for: unit)
	}

	/// The duration of the `TimePeriod` in years.
	/// Returns the `Int.max` if beginning or end are `nil`.
	var years: Int {
		guard let b = start, let e = end else { return Int.max }
		return b.toUnit(.year, to: e)
	}

	/// The duration of the `TimePeriod` in months.
	/// Returns the `Int.max` if beginning or end are `nil`.
	var months: Int {
		guard let b = start, let e = end else { return Int.max }
		return b.toUnit(.month, to: e)
	}

	/// The duration of the `TimePeriod` in weeks.
	/// Returns the `Int.max` if beginning or end are `nil`.
	var weeks: Int {
		guard let b = start, let e = end else { return Int.max }
		return b.toUnit(.weekOfMonth, to: e)
	}

	/// The duration of the `TimePeriod` in days.
	/// Returns the `Int.max` if beginning or end are `nil`.
	var days: Int {
		guard let b = start, let e = end else { return Int.max }
		return b.toUnit(.day, to: e)
	}

	/// The duration of the `TimePeriod` in hours.
	/// Returns the `Int.max` if beginning or end are `nil`.
	var hours: Int {
		guard let b = start, let e = end else { return Int.max }
		return b.toUnit(.hour, to: e)
	}

	/// The duration of the `TimePeriod` in years.
	/// Returns the `Int.max` if beginning or end are `nil`.
	var minutes: Int {
		guard let b = start, let e = end else { return Int.max }
		return b.toUnit(.minute, to: e)
	}

	/// The duration of the `TimePeriod` in seconds.
	/// Returns the `Int.max` if beginning or end are `nil`.
	var seconds: Int {
		guard let b = start, let e = end else { return Int.max }
		return b.toUnit(.second, to: e)
	}

	/// The length of time between the beginning and end dates of the
	/// `TimePeriod` as a `TimeInterval`.
	/// If intervals are not nil returns `Double.greatestFiniteMagnitude`
	var duration: TimeInterval {
		guard let b = start, let e = end else {
			return TimeInterval(Double.greatestFiniteMagnitude)
		}
		return abs(b.date.timeIntervalSince(e.date))
	}

}
