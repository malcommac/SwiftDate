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
	var beginning: DateRepresentable? { get set }
	
	/// The end date for a TimePeriod representing the ending boundary of the time period
	var end: DateRepresentable? { get set }
	
}

public extension TimePeriodProtocol {
	
	public func equals(_ period: TimePeriodProtocol) -> Bool {
		return (self.beginning == period.beginning && self.end == period.end)
	}

	/// Return `true` if period is zero-seconds long
	public var isMoment: Bool {
		return (self.beginning?.date == self.end?.date)
	}
	
	/// The duration of the `TimePeriod` in years.
	/// Returns the `Int.max` if beginning or end are `nil`.
	public var years: Int {
		guard let b = self.beginning, let e = self.end else { return Int.max }
		return b.toUnit(.year, to: e)!
	}
	
	/// The duration of the `TimePeriod` in months.
	/// Returns the `Int.max` if beginning or end are `nil`.
	public var months: Int {
		guard let b = self.beginning, let e = self.end else { return Int.max }
		return b.toUnit(.month, to: e)!
	}
	
	/// The duration of the `TimePeriod` in weeks.
	/// Returns the `Int.max` if beginning or end are `nil`.
	public var weeks: Int {
		guard let b = self.beginning, let e = self.end else { return Int.max }
		return b.toUnit(.weekOfMonth, to: e)!
	}
	
	/// The duration of the `TimePeriod` in days.
	/// Returns the `Int.max` if beginning or end are `nil`.
	public var days: Int {
		guard let b = self.beginning, let e = self.end else { return Int.max }
		return b.toUnit(.day, to: e)!
	}
	
	/// The duration of the `TimePeriod` in hours.
	/// Returns the `Int.max` if beginning or end are `nil`.
	public var hours: Int {
		guard let b = self.beginning, let e = self.end else { return Int.max }
		return b.toUnit(.hour, to: e)!
	}
	
	/// The duration of the `TimePeriod` in years.
	/// Returns the `Int.max` if beginning or end are `nil`.
	public var minutes: Int {
		guard let b = self.beginning, let e = self.end else { return Int.max }
		return b.toUnit(.minute, to: e)!
	}
	
	/// The duration of the `TimePeriod` in seconds.
	/// Returns the `Int.max` if beginning or end are `nil`.
	public var seconds: Int {
		guard let b = self.beginning, let e = self.end else { return Int.max }
		return b.toUnit(.second, to: e)!
	}
	
	/// The length of time between the beginning and end dates of the
	/// `TimePeriod` as a `TimeInterval`.
	/// If intervals are not nil returns `Double.greatestFiniteMagnitude`
	public var duration: TimeInterval {
		guard let b = self.beginning, let e = self.end else {
			return TimeInterval(Double.greatestFiniteMagnitude)
		}
		return abs(b.date.timeIntervalSince(e.date))
	}
	

	
	
}

