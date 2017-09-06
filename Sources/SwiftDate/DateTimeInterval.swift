//
//	SwiftDate, Full featured Swift date library for parsing, validating, manipulating, and formatting dates and timezones.
//	Created by:				Daniele Margutti
//	Main contributors:		Jeroen Houtzager
//
//
//	Permission is hereby granted, free of charge, to any person obtaining a copy
//	of this software and associated documentation files (the "Software"), to deal
//	in the Software without restriction, including without limitation the rights
//	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//	copies of the Software, and to permit persons to whom the Software is
//	furnished to do so, subject to the following conditions:
//
//	The above copyright notice and this permission notice shall be included in
//	all copies or substantial portions of the Software.
//
//	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//	THE SOFTWARE.


// Compatibility classes for iOS 9 or older

import Foundation

/// DateTimeInterval represents a closed date interval in the form of [startDate, endDate].
/// It is possible for the start and end dates to be the same with a duration of 0.
/// Negative intervals, where end date occurs earlier in time than the start date, are supported but comparisor and
/// intersections functions will adjust them to the right order.

public struct DateTimeInterval : Comparable {
	/// The start date.
	public var start: Date
	
	/// The end date.
	public var end: Date {
		get {
			return start.addingTimeInterval(duration)
		}
		set {
			duration = newValue.timeIntervalSinceReferenceDate - start.timeIntervalSinceReferenceDate
		}
	}
	
	/// Absolute start. If duration is < 0 the oldest date is returned as start date.
	internal var absStart: Date {
		get { return (duration > 0 ? start : end) }
	}
	
	/// Absolute start. If duration is < 0 the newest date is returned as end date.
	internal var absEnd: Date {
		get { return (duration > 0 ? end : start) }
	}
	
	/// Return absolute duration regardeless the order of the dates
	internal var absDuration: TimeInterval {
		get { return abs(duration) }
	}
	
	/// The duration of the interval
	public var duration: TimeInterval
	
	/// Initializes a `DateTimeInterval` with start and end dates set to the current date and the duration set to `0`.
	public init() {
		let d = Date()
		start = d
		duration = 0
	}
	
	/// Initialize a `DateTimeInterval` with the specified start and end date.
	public init(start: Date, end: Date) {
		self.start = start
		duration = end.timeIntervalSince(start)
	}
	
	/// Initialize a `DateTimeInterval` with the specified start date and duration.
	public init(start: Date, duration: TimeInterval) {
		self.start = start
		self.duration = duration
	}
	
	/// Compare two DateTimeInterval
	/// Note: if duration is less than zero (end date occurs earlier in time than the start date) are adjusted automatically.
	///
	/// This method prioritizes ordering by start date. If the start dates are equal, then it will order by duration.
	/// e.g. Given intervals a and b
	/// ```
	/// a.   |-----|
	/// b.      |-----|
	/// ```
	///
	/// `a.compare(b)` would return `.OrderedAscending` because a's start date is earlier in time than b's start date.
	///
	/// In the event that the start dates are equal, the compare method will attempt to order by duration.
	/// e.g. Given intervals c and d
	/// ```
	/// c.  |-----|
	/// d.  |---|
	/// ```
	/// `c.compare(d)` would result in `.OrderedDescending` because c is longer than d.
	///
	/// If both the start dates and the durations are equal, then the intervals are considered equal and `.OrderedSame` is returned as the result.
	///
	/// - Parameter dateInterval: date interval to compare
	/// - Returns: ComparisonResult
	public func compare(_ dateInterval: DateTimeInterval) -> ComparisonResult {
		let result = absStart.compare(dateInterval.absStart)
		if result == .orderedSame {
			if self.absDuration < dateInterval.absDuration { return .orderedAscending }
			if self.absDuration > dateInterval.absDuration { return .orderedDescending }
			return .orderedSame
		}
		return result
	}
	
	/// Returns `true` if `self` intersects the `dateInterval`.
	/// Note: if duration is less than zero (end date occurs earlier in time than the start date) are adjusted automatically.
	///
	/// - Parameter dateInterval: date interval to intersect
	/// - Returns: `true` if self intersects input date, `false` otherwise
	public func intersects(_ other: DateTimeInterval) -> Bool {
		return contains(other.absStart) || contains(other.absEnd) || other.contains(absStart) || other.contains(absEnd)
	}
	
	/// Returns a DateTimeInterval that represents the interval where the given date interval and the current instance intersect.
	/// Note: if duration is less than zero (end date occurs earlier in time than the start date) are adjusted automatically.
	///
	/// In the event that there is no intersection, the method returns nil.
	public func intersection(with dateInterval: DateTimeInterval) -> DateTimeInterval? {
		if !intersects(dateInterval) {
			return nil
		}
		
		if self == dateInterval {
			return self
		}
		
		let timeIntervalForSelfStart = absStart.timeIntervalSinceReferenceDate
		let timeIntervalForSelfEnd = absEnd.timeIntervalSinceReferenceDate
		let timeIntervalForGivenStart = dateInterval.absStart.timeIntervalSinceReferenceDate
		let timeIntervalForGivenEnd = dateInterval.absEnd.timeIntervalSinceReferenceDate
		
		let resultStartDate : Date
		if timeIntervalForGivenStart >= timeIntervalForSelfStart {
			resultStartDate = dateInterval.absStart
		} else {
			// self starts after given
			resultStartDate = absStart
		}
		
		let resultEndDate : Date
		if timeIntervalForGivenEnd >= timeIntervalForSelfEnd {
			resultEndDate = absEnd
		} else {
			// given ends before self
			resultEndDate = dateInterval.absEnd
		}
		
		return DateTimeInterval(start: resultStartDate, end: resultEndDate)
	}
	
	/// Returns `true` if `self` contains `date`.
	/// Note: if duration is less than zero (end date occurs earlier in time than the start date) are adjusted automatically.
	///
	/// - Parameter date: date check
	/// - Returns: Boolean
	public func contains(_ date: Date) -> Bool {
		let timeIntervalForGivenDate = date.timeIntervalSinceReferenceDate
		let timeIntervalForSelfStart = absStart.timeIntervalSinceReferenceDate
		let timeIntervalforSelfEnd = absEnd.timeIntervalSinceReferenceDate
		if (timeIntervalForGivenDate >= timeIntervalForSelfStart) && (timeIntervalForGivenDate <= timeIntervalforSelfEnd) {
			return true
		}
		return false
	}
	
	
	/// Compare if two date intervals are equal.
	/// Note: Inverted date intervals with same duration are different.
	///
	/// - Parameters:
	///   - lhs: left operand
	///   - rhs: right operand
	/// - Returns: Boolean
	public static func ==(lhs: DateTimeInterval, rhs: DateTimeInterval) -> Bool {
		return lhs.start == rhs.start && lhs.duration == rhs.duration
	}
	
	
	/// Compare if duration of the left operand is is smaller than duration of the right operand.
	/// Note: if duration is less than zero (end date occurs earlier in time than the start date) are adjusted automatically.
	///
	/// - Parameters:
	///   - lhs: left operand
	///   - rhs: right operand
	/// - Returns: Boolean
	public static func <(lhs: DateTimeInterval, rhs: DateTimeInterval) -> Bool {
		return lhs.compare(rhs) == .orderedAscending
	}
}

extension DateTimeInterval : CustomStringConvertible, CustomDebugStringConvertible, CustomReflectable {
	public var description: String {
		return "(Start Date) \(start) + (Duration) \(duration) seconds = (End Date) \(end)"
	}
	
	public var debugDescription: String {
		return description
	}
	
	public var customMirror: Mirror {
		var c: [(label: String?, value: Any)] = []
		c.append((label: "start", value: start))
		c.append((label: "end", value: end))
		c.append((label: "duration", value: duration))
		return Mirror(self, children: c, displayStyle: Mirror.DisplayStyle.struct)
	}
}
