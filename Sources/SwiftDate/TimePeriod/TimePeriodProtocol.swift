//
//  TimePeriod.swift
//  SwiftDate
//
//  Created by Daniele Margutti on 14/06/2018.
//  Copyright © 2018 SwiftDate. All rights reserved.
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
	public var hasFiniteRange: Bool {
		guard self.start != nil && self.end != nil else { return false }
		return true
	}

	/// Return `true` if period has a start date
	public var hasStart: Bool {
		return (self.start != nil)
	}

	/// Return `true` if period has a end date
	public var hasEnd: Bool {
		return (self.end != nil)
	}

	/// Check if receiver is equal to given period (both start/end groups are equals)
	///
	/// - Parameter period: period to compare against to.
	/// - Returns: true if are equals
	public func equals(_ period: TimePeriodProtocol) -> Bool {
		return (self.start == period.start && self.end == period.end)
	}

	/// If the given `TimePeriod`'s beginning is before `self.beginning` and
	/// if the given 'TimePeriod`'s end is after `self.end`.
	///
	/// - Parameter period: The time period to compare to self
	/// - Returns: True if self is inside of the given `TimePeriod`
	public func isInside(_ period: TimePeriodProtocol) -> Bool {
		guard self.hasFiniteRange, period.hasFiniteRange else { return false }
		return (period.start! <= self.start! && period.end! >= self.end!)
	}

	/// If the given Date is after `self.beginning` and before `self.end`.
	///
	/// - Parameters:
	///   - date: The time period to compare to self
	///   - interval: Whether the edge of the date is included in the calculation
	/// - Returns: True if the given `TimePeriod` is inside of self
	public func contains(date: DateInRegion, interval: IntervalType = .closed) -> Bool {
		guard self.hasFiniteRange else { return false }
		switch interval {
		case .closed:	return (self.start! <= date && self.end! >= date)
		case .open:		return (self.start! < date && self.end! > date)
		}
	}

	/// If the given `TimePeriod`'s beginning is after `self.beginning` and
	/// if the given 'TimePeriod`'s after is after `self.end`.
	///
	/// - Parameter period: The time period to compare to self
	/// - Returns: True if the given `TimePeriod` is inside of self
	public func contains(_ period: TimePeriodProtocol) -> Bool {
		guard self.hasFiniteRange, period.hasFiniteRange else { return false }
		if period.start! < self.start! && period.end! > self.start! {
			return true // Outside -> Inside
		} else if period.start! >= self.start! && period.end! <= self.end! {
			return true // Enclosing
		} else if period.start! < self.end! && period.end! > self.end! {
			return true // Inside -> Out
		}
		return false
	}

	/// If self and the given `TimePeriod` share any sub-`TimePeriod`.
	///
	/// - Parameter period: The time period to compare to self
	/// - Returns: True if there is a period of time that is shared by both `TimePeriod`s
	public func overlaps(with period: TimePeriodProtocol) -> Bool {
		if period.start! < self.start! && period.end! > self.start! {
			return true // Outside -> Inside
		} else if period.start! >= self.start! && period.end! <= self.end! {
			return true // Enclosing
		} else if period.start! < self.end! && period.end! > self.end! {
			return true // Inside -> Out
		}
		return false
	}

	/// If self and the given `TimePeriod` overlap or the period's edges touch.
	///
	/// - Parameter period: The time period to compare to self
	/// - Returns: True if there is a period of time or moment that is shared by both `TimePeriod`s
	public func intersects(with period: TimePeriodProtocol) -> Bool {
		let relation = self.relation(to: period)
		return (relation != .after && relation != .before)
	}

	/// If self is before the given `TimePeriod` chronologically. (A gap must exist between the two).
	///
	/// - Parameter period: The time period to compare to self
	/// - Returns: True if self is after the given `TimePeriod`
	public func isBefore(_ period: TimePeriodProtocol) -> Bool {
		return (self.relation(to: period) == .before)
	}

	/// If self is after the given `TimePeriod` chronologically. (A gap must exist between the two).
	///
	/// - Parameter period: The time period to compare to self
	/// - Returns: True if self is after the given `TimePeriod`
	public func isAfter(_ period: TimePeriodProtocol) -> Bool {
		return (self.relation(to: period) == .after)
	}

	/// The period of time between self and the given `TimePeriod` not contained by either.
	///
	/// - Parameter period: The time period to compare to self
	/// - Returns: The gap between the periods. Zero if there is no gap.
	public func hasGap(between period: TimePeriodProtocol) -> Bool {
		return (self.isBefore(period) || self.isAfter(period))
	}

	/// The period of time between self and the given `TimePeriod` not contained by either.
	///
	/// - Parameter period: The time period to compare to self
	/// - Returns: The gap between the periods. Zero if there is no gap.
	public func gap(between period: TimePeriodProtocol) -> TimeInterval {
		guard self.hasFiniteRange, period.hasFiniteRange else { return TimeInterval.greatestFiniteMagnitude }
		if self.end! < period.start! {
			return abs(self.end!.timeIntervalSince(period.start!))
		} else if period.end! < self.start! {
			return abs(self.end!.timeIntervalSince(self.start!))
		}
		return 0
	}

	/// In place, shift the `TimePeriod` by a `TimeInterval`
	///
	/// - Parameter timeInterval: The time interval to shift the period by
	public mutating func shift(by timeInterval: TimeInterval) {
		self.start?.addTimeInterval(timeInterval)
		self.end?.addTimeInterval(timeInterval)
	}

	/// In place, lengthen the `TimePeriod`, anchored at the beginning, end or center
	///
	/// - Parameters:
	///   - timeInterval: The time interval to lengthen the period by
	///   - anchor: The anchor point from which to make the change
	public mutating func lengthen(by timeInterval: TimeInterval, at anchor: TimePeriodAnchor) {
		switch anchor {
		case .beginning:
			self.end?.addTimeInterval(timeInterval)
		case .end:
			self.start?.addTimeInterval(timeInterval)
		case .center:
			self.start = self.start?.addingTimeInterval(-timeInterval / 2.0)
			self.end = self.end?.addingTimeInterval(timeInterval / 2.0)
		}
	}

	/// In place, shorten the `TimePeriod`, anchored at the beginning, end or center
	///
	/// - Parameters:
	///   - timeInterval: The time interval to shorten the period by
	///   - anchor: The anchor point from which to make the change
	public mutating func shorten(by timeInterval: TimeInterval, at anchor: TimePeriodAnchor) {
		switch anchor {
		case .beginning:
			self.end?.addTimeInterval(-timeInterval)
		case .end:
			self.start?.addTimeInterval(timeInterval)
		case .center:
			self.start?.addTimeInterval(timeInterval / 2.0)
			self.end?.addTimeInterval(-timeInterval / 2.0)
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
	public func relation(to period: TimePeriodProtocol) -> TimePeriodRelation {
		//Make sure that all start and end points exist for comparison
		guard self.hasFiniteRange, period.hasFiniteRange else { return .none }
		//Make sure time periods are of positive durations
		guard self.start! < self.end! && period.start! < period.end! else { return .none }
		//Make comparisons
		if period.start! < self.start! {
			return .after
		} else if period.end! == self.start! {
			return .startTouching
		} else if period.start! < self.start! && period.end! < self.end! {
			return .startInside
		} else if period.start! == self.start! && period.end! > self.end! {
			return .insideStartTouching
		} else if period.start! == self.start! && period.end! < self.end! {
			return .enclosingStartTouching
		} else if period.start! > self.start! && period.end! < self.end! {
			return .enclosing
		} else if period.start! > self.start! && period.end! == self.end! {
			return .enclosingEndTouching
		} else if period.start == self.start! && period.end! == self.end! {
			return .exactMatch
		} else if period.start! < self.start! && period.end! > self.end! {
			return .inside
		} else if period.start! < self.start! && period.end! == self.end! {
			return .insideEndTouching
		} else if period.start! < self.end! && period.end! > self.end! {
			return .endInside
		} else if period.start! == self.end! && period.end! > self.end! {
			return .endTouching
		} else if period.start! > self.end! {
			return .before
		}
		return .none
	}

	/// Return `true` if period is zero-seconds long or less than specified precision.
	///
	/// - Parameter precision: precision in seconds; by default is 0.
	/// - Returns: true if start/end has the same value or less than specified precision
	public func isMoment(precision: TimeInterval = 0) -> Bool {
		guard self.hasFiniteRange else { return false }
		return (abs(self.start!.date.timeIntervalSince1970 - self.end!.date.timeIntervalSince1970) <= precision)
	}

	/// Returns the duration of the receiver expressed with given time unit.
	/// If time period has not a finite range it returns `nil`.
	///
	/// - Parameter unit: unit of the duration
	/// - Returns: duration, `nil` if period has not a finite range
	public func durationIn(_ units: Set<Calendar.Component>) -> DateComponents? {
		guard self.hasFiniteRange else { return nil }
		return self.start!.calendar.dateComponents(units, from: self.start!.date, to: self.end!.date)
	}

	/// Returns the duration of the receiver expressed with given time unit.
	/// If time period has not a finite range it returns `nil`.
	///
	/// - Parameter unit: unit of the duration
	/// - Returns: duration, `nil` if period has not a finite range
	public func durationIn(_ unit: Calendar.Component) -> Int? {
		guard self.hasFiniteRange else { return nil }
		return self.start!.calendar.dateComponents([unit], from: self.start!.date, to: self.end!.date).value(for: unit)
	}

	/// The duration of the `TimePeriod` in years.
	/// Returns the `Int.max` if beginning or end are `nil`.
	public var years: Int {
		guard let b = self.start, let e = self.end else { return Int.max }
		return b.toUnit(.year, to: e)
	}

	/// The duration of the `TimePeriod` in months.
	/// Returns the `Int.max` if beginning or end are `nil`.
	public var months: Int {
		guard let b = self.start, let e = self.end else { return Int.max }
		return b.toUnit(.month, to: e)
	}

	/// The duration of the `TimePeriod` in weeks.
	/// Returns the `Int.max` if beginning or end are `nil`.
	public var weeks: Int {
		guard let b = self.start, let e = self.end else { return Int.max }
		return b.toUnit(.weekOfMonth, to: e)
	}

	/// The duration of the `TimePeriod` in days.
	/// Returns the `Int.max` if beginning or end are `nil`.
	public var days: Int {
		guard let b = self.start, let e = self.end else { return Int.max }
		return b.toUnit(.day, to: e)
	}

	/// The duration of the `TimePeriod` in hours.
	/// Returns the `Int.max` if beginning or end are `nil`.
	public var hours: Int {
		guard let b = self.start, let e = self.end else { return Int.max }
		return b.toUnit(.hour, to: e)
	}

	/// The duration of the `TimePeriod` in years.
	/// Returns the `Int.max` if beginning or end are `nil`.
	public var minutes: Int {
		guard let b = self.start, let e = self.end else { return Int.max }
		return b.toUnit(.minute, to: e)
	}

	/// The duration of the `TimePeriod` in seconds.
	/// Returns the `Int.max` if beginning or end are `nil`.
	public var seconds: Int {
		guard let b = self.start, let e = self.end else { return Int.max }
		return b.toUnit(.second, to: e)
	}

	/// The length of time between the beginning and end dates of the
	/// `TimePeriod` as a `TimeInterval`.
	/// If intervals are not nil returns `Double.greatestFiniteMagnitude`
	public var duration: TimeInterval {
		guard let b = self.start, let e = self.end else {
			return TimeInterval(Double.greatestFiniteMagnitude)
		}
		return abs(b.date.timeIntervalSince(e.date))
	}

}
