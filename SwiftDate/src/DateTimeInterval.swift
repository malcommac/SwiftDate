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

/// DateTimeInterval represents a closed date interval in the form of [startDate, endDate].  It is possible for the start and end dates to be the same with a duration of 0.  DateTimeInterval does not support reverse intervals i.e. intervals where the duration is less than 0 and the end date occurs earlier in time than the start date.
public struct DateTimeInterval : Comparable {
	/// The start date.
	public var start: Date
	
	/// The end date.
	///
	/// - precondition: `end >= start`
	public var end: Date {
		get {
			return start.addingTimeInterval(duration)
		}
		set {
			precondition(newValue >= start, "Reverse intervals are not allowed")
			duration = newValue.timeIntervalSinceReferenceDate - start.timeIntervalSinceReferenceDate
		}
	}
	
	/// The duration.
	///
	/// - precondition: `duration >= 0`
	public var duration: TimeInterval {
		willSet {
			precondition(newValue >= 0, "Negative durations are not allowed")
		}
	}
	
	/// Initializes a `DateTimeInterval` with start and end dates set to the current date and the duration set to `0`.
	public init() {
		let d = Date()
		start = d
		duration = 0
	}
	
	/// Initialize a `DateTimeInterval` with the specified start and end date.
	///
	/// - precondition: `end >= start`
	public init(start: Date, end: Date) {
		if end < start {
			fatalError("Reverse intervals are not allowed")
		}
		
		self.start = start
		duration = end.timeIntervalSince(start)
	}
	
	/// Initialize a `DateTimeInterval` with the specified start date and duration.
	///
	/// - precondition: `duration >= 0`
	public init(start: Date, duration: TimeInterval) {
		precondition(duration >= 0, "Negative durations are not allowed")
		self.start = start
		self.duration = duration
	}
	
	/**
	Compare two DateTimeInterval.
	
	This method prioritizes ordering by start date. If the start dates are equal, then it will order by duration.
	e.g. Given intervals a and b
	```
	a.   |-----|
	b.      |-----|
	```
	
	`a.compare(b)` would return `.OrderedAscending` because a's start date is earlier in time than b's start date.
	
	In the event that the start dates are equal, the compare method will attempt to order by duration.
	e.g. Given intervals c and d
	```
	c.  |-----|
	d.  |---|
	```
	`c.compare(d)` would result in `.OrderedDescending` because c is longer than d.
	
	If both the start dates and the durations are equal, then the intervals are considered equal and `.OrderedSame` is returned as the result.
	*/
	public func compare(_ dateInterval: DateTimeInterval) -> ComparisonResult {
		let result = start.compare(dateInterval.start)
		if result == .orderedSame {
			if self.duration < dateInterval.duration { return .orderedAscending }
			if self.duration > dateInterval.duration { return .orderedDescending }
			return .orderedSame
		}
		return result
	}
	
	/// Returns `true` if `self` intersects the `dateInterval`.
	public func intersects(_ dateInterval: DateTimeInterval) -> Bool {
		return contains(dateInterval.start) || contains(dateInterval.end) || dateInterval.contains(start) || dateInterval.contains(end)
	}
	
	/// Returns a DateTimeInterval that represents the interval where the given date interval and the current instance intersect.
	///
	/// In the event that there is no intersection, the method returns nil.
	public func intersection(with dateInterval: DateTimeInterval) -> DateTimeInterval? {
		if !intersects(dateInterval) {
			return nil
		}
		
		if self == dateInterval {
			return self
		}
		
		let timeIntervalForSelfStart = start.timeIntervalSinceReferenceDate
		let timeIntervalForSelfEnd = end.timeIntervalSinceReferenceDate
		let timeIntervalForGivenStart = dateInterval.start.timeIntervalSinceReferenceDate
		let timeIntervalForGivenEnd = dateInterval.end.timeIntervalSinceReferenceDate
		
		let resultStartDate : Date
		if timeIntervalForGivenStart >= timeIntervalForSelfStart {
			resultStartDate = dateInterval.start
		} else {
			// self starts after given
			resultStartDate = start
		}
		
		let resultEndDate : Date
		if timeIntervalForGivenEnd >= timeIntervalForSelfEnd {
			resultEndDate = end
		} else {
			// given ends before self
			resultEndDate = dateInterval.end
		}
		
		return DateTimeInterval(start: resultStartDate, end: resultEndDate)
	}
	
	/// Returns `true` if `self` contains `date`.
	public func contains(_ date: Date) -> Bool {
		let timeIntervalForGivenDate = date.timeIntervalSinceReferenceDate
		let timeIntervalForSelfStart = start.timeIntervalSinceReferenceDate
		let timeIntervalforSelfEnd = end.timeIntervalSinceReferenceDate
		if (timeIntervalForGivenDate >= timeIntervalForSelfStart) && (timeIntervalForGivenDate <= timeIntervalforSelfEnd) {
			return true
		}
		return false
	}
	
	public static func ==(lhs: DateTimeInterval, rhs: DateTimeInterval) -> Bool {
		return lhs.start == rhs.start && lhs.duration == rhs.duration
	}
	
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
