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
	
	public var hasFiniteRange: Bool {
		guard let _ = self.start, let _ = self.end else { return false }
		return true
	}
	
	public func equals(_ period: TimePeriodProtocol) -> Bool {
		return (self.start == period.start && self.end == period.end)
	}
	
	public func isInside(_ period: TimePeriodProtocol) -> Bool {
		guard self.hasFiniteRange, period.hasFiniteRange else { return false }
		return (period.start! <= self.start! && period.end! >= self.end!)
	}
	
	public func contains(date: DateInRegion, interval: IntervalType = .closed) -> Bool {
		guard self.hasFiniteRange else { return false }
		switch interval {
		case .closed:	return (self.start! <= date && self.end! >= date)
		case .open:		return (self.start! < date && self.end! > date)
		}
	}
	
	public func contains(_ period: TimePeriodProtocol) -> Bool {
		guard self.hasFiniteRange, period.hasFiniteRange else { return false }
		if period.start! < self.start! && period.end! > self.start! {
			return true // Outside -> Inside
		}
		else if period.start! >= self.start! && period.end! <= self.end! {
			return true // Enclosing
		}
		else if period.start! < self.end! && period.end! > self.end! {
			return true // Inside -> Out
		}
		return false
	}
	
	public func intersects(with period: TimePeriodProtocol) -> Bool {
		let relation = self.relation(to: period)
		return (relation != .after && relation != .before)
	}
	
	public func isBefore(_ period: TimePeriodProtocol) -> Bool {
		return (self.relation(to: period) == .before)
	}
	
	public func isAfter(_ period: TimePeriodProtocol) -> Bool {
		return (self.relation(to: period) == .after)
	}
	
	public func hasGap(between period: TimePeriodProtocol) -> Bool {
		return (self.isBefore(period) || self.isAfter(period))
	}
	
	public func gap(between period: TimePeriodProtocol) -> TimeInterval {
		guard self.hasFiniteRange, period.hasFiniteRange else { return TimeInterval.greatestFiniteMagnitude }
		if self.end! < period.start! {
			return abs(self.end!.timeIntervalSince(period.start!))
		}
		else if period.end! < self.start! {
			return abs(self.end!.timeIntervalSince(self.start!))
		}
		return 0
	}
	
	public mutating func shift(by timeInterval: TimeInterval) {
		self.start?.addTimeInterval(timeInterval)
		self.end?.addTimeInterval(timeInterval)
	}
	
	public mutating func lengthen(by timeInterval: TimeInterval, at anchor: TimePeriodAnchor) {
		switch anchor {
		case .beginning:
			self.end?.addTimeInterval(timeInterval)
		case .end:
			self.start?.addTimeInterval(timeInterval)
		case .center:
			self.start = self.start?.addingTimeInterval(-timeInterval/2.0)
			self.end = self.end?.addingTimeInterval(timeInterval/2.0)
		}
	}
	
	public mutating func shorten(by timeInterval: TimeInterval, at anchor: TimePeriodAnchor) {
		switch anchor {
		case .beginning:
			self.end?.addTimeInterval(-timeInterval)
		case .end:
			self.start?.addTimeInterval(timeInterval)
		case .center:
			self.start?.addTimeInterval(timeInterval/2.0)
			self.end?.addTimeInterval(-timeInterval/2.0)
		}
	}
	
	public func relation(to period: TimePeriodProtocol) -> TimePeriodRelation {
		//Make sure that all start and end points exist for comparison
		guard self.hasFiniteRange, period.hasFiniteRange else { return .none }
		//Make sure time periods are of positive durations
		guard self.start! < self.end! && period.start! < period.end! else { return .none }
		//Make comparisons
		if (period.start! < self.start!) {
			return .after
		}
		else if (period.end! == self.start!) {
			return .startTouching
		}
		else if (period.start! < self.start! && period.end! < self.end!) {
			return .startInside
		}
		else if (period.start! == self.start! && period.end! > self.end!) {
			return .insideStartTouching
		}
		else if (period.start! == self.start! && period.end! < self.end!) {
			return .enclosingStartTouching
		}
		else if (period.start! > self.start! && period.end! < self.end!) {
			return .enclosing
		}
		else if (period.start! > self.start! && period.end! == self.end!) {
			return .enclosingEndTouching
		}
		else if (period.start == self.start! && period.end! == self.end!) {
			return .exactMatch
		}
		else if (period.start! < self.start! && period.end! > self.end!) {
			return .inside
		}
		else if (period.start! < self.start! && period.end! == self.end!) {
			return .insideEndTouching
		}
		else if (period.start! < self.end! && period.end! > self.end!) {
			return .endInside
		}
		else if (period.start! == self.end! && period.end! > self.end!) {
			return .endTouching
		}
		else if (period.start! > self.end!) {
			return .before
		}
		return .none
	}

	/// Return `true` if period is zero-seconds long
	public var isMoment: Bool {
		return (self.start?.date == self.end?.date)
	}
	
	/// The duration of the `TimePeriod` in years.
	/// Returns the `Int.max` if beginning or end are `nil`.
	public var years: Int {
		guard let b = self.start, let e = self.end else { return Int.max }
		return b.toUnit(.year, to: e)!
	}
	
	/// The duration of the `TimePeriod` in months.
	/// Returns the `Int.max` if beginning or end are `nil`.
	public var months: Int {
		guard let b = self.start, let e = self.end else { return Int.max }
		return b.toUnit(.month, to: e)!
	}
	
	/// The duration of the `TimePeriod` in weeks.
	/// Returns the `Int.max` if beginning or end are `nil`.
	public var weeks: Int {
		guard let b = self.start, let e = self.end else { return Int.max }
		return b.toUnit(.weekOfMonth, to: e)!
	}
	
	/// The duration of the `TimePeriod` in days.
	/// Returns the `Int.max` if beginning or end are `nil`.
	public var days: Int {
		guard let b = self.start, let e = self.end else { return Int.max }
		return b.toUnit(.day, to: e)!
	}
	
	/// The duration of the `TimePeriod` in hours.
	/// Returns the `Int.max` if beginning or end are `nil`.
	public var hours: Int {
		guard let b = self.start, let e = self.end else { return Int.max }
		return b.toUnit(.hour, to: e)!
	}
	
	/// The duration of the `TimePeriod` in years.
	/// Returns the `Int.max` if beginning or end are `nil`.
	public var minutes: Int {
		guard let b = self.start, let e = self.end else { return Int.max }
		return b.toUnit(.minute, to: e)!
	}
	
	/// The duration of the `TimePeriod` in seconds.
	/// Returns the `Int.max` if beginning or end are `nil`.
	public var seconds: Int {
		guard let b = self.start, let e = self.end else { return Int.max }
		return b.toUnit(.second, to: e)!
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

