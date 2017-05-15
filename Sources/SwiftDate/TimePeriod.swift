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

import Foundation

public class TimePeriod : Equatable, Comparable, CustomStringConvertible {
	
	/// Period initial date
	internal(set) var startDate: DateInRegion? = nil
	
	/// Period end date
	internal(set) var endDate: DateInRegion? = nil
	
	public init() { }
	
	/// Description of the period
	public var description: String {
		return "TimePeriod from \(String(describing: self.startDate)) to \(String(describing: self.endDate))"
	}
	
	/// Initialize a new period with a closed time interval.
	///
	/// - Parameters:
	///   - sDate: start date of the interval
	///   - eDate: end date of the intervsal
	public init(from sDate: DateInRegion?, to eDate: DateInRegion?) {
		self.startDate = sDate
		self.endDate = eDate
	}
	
	/// Initialize a new period from a beginning date with a fixed duration.
	/// End date is evaluated by adding given interval to specified start date.
	///
	/// - Parameters:
	///   - sDate: start date of the interval
	///   - duration: duration of the interval
	public init(from sDate: DateInRegion, duration: TimeInterval) {
		self.startDate = sDate
		self.endDate = sDate.add(interval: duration)
	}
	
	/// Initialize a new period starting from the end date.
	/// Start date is evaluated by subtracting specified duration from end date.
	///
	/// - Parameters:
	///   - eDate: end date
	///   - duration: duration of the interval
	public init(to eDate: DateInRegion, duration: TimeInterval) {
		self.endDate = eDate
		self.startDate = eDate.add(interval: -duration)
	}
	
	/// Initialize a new time period from start date.
	/// End date is evaluated by adding specific fragment to start date.
	///
	/// - Parameters:
	///   - sDate: start date
	///   - fragment: fragment to add
	public init(from sDate: DateInRegion, fragment: TimeFragment) {
		self.startDate = sDate
		self.endDate = sDate + fragment
	}
	
	
	/// Initialize a new time period which ends at specified date.
	/// Start date is evaluated by subtracting passed fragment from end date,
	///
	/// - Parameters:
	///   - eDate: end date
	///   - fragment: fragment to subtract
	public init(to eDate: DateInRegion, fragment: TimeFragment) {
		self.endDate = eDate
		self.startDate = eDate - fragment
	}
	
	
	/// Initialize a new time period which starts from current Date in `Region.local(),
	/// End date is evaluated by adding fragment to the start date.
	///
	/// - Parameter fragment: fragment to add
	public init(fragment: TimeFragment) {
		self.startDate = DateInRegion()
		self.endDate = self.startDate! + fragment
	}
	
	/// In place shift the time period by a specified interval (both start and end)
	///
	/// - Parameter timeInterval: interval of the shift in seconds
	public func shift(byInterval timeInterval: TimeInterval) {
		self.startDate?.addInterval(timeInterval)
		self.startDate?.addInterval(timeInterval)
		self.endDate?.addInterval(timeInterval)
	}
	
	
	/// Shift period by a given interval expressed in seconds
	///
	/// - Parameter interval: shift interval
	/// - Returns: a new time period with shifted interval
	public func shifted(byInterval interval: TimeInterval) -> TimePeriod {
		let from_date: DateInRegion? = self.startDate?.add(interval: interval)
		let to_date: DateInRegion? = self.endDate?.add(interval: interval)
		return TimePeriod(from: from_date, to: to_date)
	}
	
	
	/// Shift period by sa given time fragment
	///
	/// - Parameter fragment: fragment to shift
	/// - Returns: a new time period with shifted fragment
	public func shifted(byFragment fragment: TimeFragment) throws -> TimePeriod {
		let from_date: DateInRegion? = try self.startDate?.add(components: fragment.dateComponents)
		let to_date: DateInRegion? = try self.endDate?.add(components: fragment.dateComponents)
		return TimePeriod(from: from_date, to: to_date)
	}
	
	
	/// Lengthened the period by a given interval optionally anchoring a date
	///
	/// - Parameters:
	///   - interval: The time interval to lengthen the period by
	///   - anchor: The anchor point from which to make the change
	/// - Returns: a new shifted period
	public func lengthened(byInterval interval: TimeInterval, at anchor: TimeAnchor) -> TimePeriod {
		let newPeriod = TimePeriod()
		switch anchor {
		case .start:
			newPeriod.startDate = self.startDate
			newPeriod.endDate = self.endDate?.add(interval: interval)
		case .center:
			newPeriod.startDate = self.startDate?.add(interval: interval)
			newPeriod.endDate = self.endDate?.add(interval: interval)
		case .end:
			newPeriod.startDate = self.startDate?.add(interval: -interval)
			newPeriod.endDate = self.endDate
		}
		return newPeriod
	}
	
	
	/// Lengthen the period by given fragment
	///
	/// - Parameters:
	///   - fragment: The time fragment to lengthen the period by
	///   - anchor: The anchor point from which to make the change
	/// - Returns: the new lengthened period
	/// - Throws: throw an exception
	public func lengthened(byFragment fragment: TimeFragment, at anchor: TimeAnchor) throws -> TimePeriod {
		let newPeriod = TimePeriod()
		switch anchor {
		case .start:
			newPeriod.startDate = self.startDate
			newPeriod.endDate = try self.endDate?.add(components: fragment.dateComponents)
		case .center:
			fatalError("Mutation via fragment from center anchor not supported")
		case .end:
			newPeriod.startDate = try self.startDate?.add(components: -fragment.dateComponents)
			newPeriod.endDate = self.endDate
		}
		return newPeriod
	}
	
	
	/// Shorten the period by a given interval
	///
	/// - Parameters:
	///   - interval: The time interval to shorten the period by
	///   - anchor: The anchor point from which to make the change
	/// - Returns: The new, shortened period
	public func shortened(byInterval interval: TimeInterval, at anchor: TimeAnchor) -> TimePeriod {
		let newPeriod = TimePeriod()
		switch anchor {
		case .start:
			newPeriod.startDate = self.startDate
			newPeriod.endDate = self.endDate?.add(interval: -interval)
		case .center:
			newPeriod.startDate = self.startDate?.add(interval: -interval/2)
			newPeriod.endDate = self.endDate?.add(interval: interval/2)
		case .end:
			newPeriod.startDate = self.startDate?.add(interval: interval)
			newPeriod.endDate = self.endDate
		}
		return newPeriod
	}
	
	
	/// Shorten the period by a given fragment
	///
	/// - Parameters:
	///   - fragment: The time fragment to shorten the period by
	///   - anchor: The anchor point from which to make the change
	/// - Returns: The new, shortened period
	/// - Throws: throws an exception if cannot be evaluated
	public func shortened(byFragment fragment: TimeFragment, at anchor: TimeAnchor) throws -> TimePeriod {
		let newPeriod = TimePeriod()
		switch anchor {
		case .start:
			newPeriod.startDate = self.startDate
			newPeriod.endDate = try self.endDate?.add(components: -fragment.dateComponents)
		case .center:
			fatalError("Mutation via fragment from center anchor not supported")
		case .end:
			newPeriod.startDate = try self.startDate?.add(components: -fragment.dateComponents)
			newPeriod.endDate = self.endDate
		}
		return newPeriod
	}
	
	//MARK: - Relation
	
	
	/// Return the relationship between self and another passed period.
	/// Return `.unknown` if start or end dates are not defined.
	/// Also return `.unknown` if time periods has not of positive durations
	///
	/// More info:
	/// * [GitHub](https://github.com/MatthewYork/DateTools#relationships),
	/// * [CodeProject](http://www.codeproject.com/Articles/168662/Time-Period-Library-for-NET)
	///
	/// - Parameter period: period to compare against to
	/// - Returns: relationship between two periods
	public func relation(to period: TimePeriod) -> TimePeriodRelation? {
		// Validate period bounds
		guard	let fStart = self.startDate, let fEnd = self.endDate,
				let tStart = period.startDate, let tEnd = period.endDate else {
			return .unknown
		}
		
		// Make sure time periods are of positive durations
		guard fStart < fEnd && tStart < tEnd else {
			return .unknown
		}
		
		if tEnd < fStart {
			return .after
		}
		else if tEnd == fStart {
			return .startTouching
		}
		else if tStart < fStart && tEnd < fEnd {
			return .startInside
		}
		else if tStart == fStart && tEnd > fEnd {
			return .insideStartTouching
		}
		else if tStart == fStart && tEnd < fEnd {
			return .enclosingStartTouching
		}
		else if tStart > fStart && tEnd < fEnd {
			return .enclosing
		}
		else if tStart > fStart && tEnd == fEnd {
			return .enclosingEndTouching
		}
		else if tStart == fStart && tEnd == fEnd {
			return .exactMatch
		}
		else if tStart < fStart && fEnd > fEnd {
			return .inside
		}
		else if tStart < fStart && tEnd == fEnd {
			return .insideEndTouching
		}
		else if tStart < fEnd && tEnd > fEnd {
			return .endInside
		}
		else if tStart == fEnd && tEnd > fEnd {
			return .endTouching
		}
		else if tStart > fEnd {
			return .before
		}
		return .unknown
	}
	
	/// If the given `DateInRegion` is after `self.startDate` and before `self.endDate`.
	///
	/// - Parameter date: The time period to compare to self
	/// - Parameter interval: Whether the edge of the date is included in the calculation
	/// - Returns: `true` if the given `TimePeriod` is inside of self
	public func contains(_ date: DateInRegion, interval: TimePeriodType) -> Bool {
		guard let s = self.startDate, let e = self.endDate else { return false }
		switch interval {
		case .opened:
			return s.absoluteDate < date.absoluteDate && e.absoluteDate > date.absoluteDate
		case .closed:
			return s.absoluteDate <= date.absoluteDate && e.absoluteDate >= date.absoluteDate
		}
	}
	
	/// Return if the given `TimePeriod`'s beginning is before `self.startDate` and if the given 'TimePeriod`'s end is after `self.endDate`.
	///
	/// - Parameter period: The time period to compare to `self`
	/// - Returns: `true` if `self` is inside of the given `TimePeriod`, `false` otherwise (even if periods are not closed)
	public func isInside(period: TimePeriod) -> Bool {
		guard	let s_start = self.startDate, let s_end = self.endDate,
			let p_start = period.startDate, let p_end = period.endDate else {
				return false
		}
		return p_start <= s_start && p_end >= s_end
	}
	
	
	/// Return if the given `TimePeriod`'s beginning is after `self.startDate` and if the given 'TimePeriod`'s after is after `self.endDate`.
	///
	/// - Parameter period: The time period to compare to `self`
	/// - Returns: `true` if the given `TimePeriod` is inside of `self`, `false` otherwise
	public func contains(period: TimePeriod) -> Bool {
		guard	let s_start = self.startDate, let s_end = self.endDate,
			let p_start = period.startDate, let p_end = period.endDate else {
				return false
		}
		return s_start <= p_start && s_end >= p_end
	}
	
	
	/// Return if `self` and the given `TimePeriod` share any sub-`TimePeriod`.
	///
	/// - Parameter period: The time period to compare to `self`
	/// - Returns: `true` if there is a period of time that is shared by both `TimePeriod`s, `false` otherwise
	public func overlaps(period: TimePeriod) -> Bool {
		guard	let s_start = self.startDate, let s_end = self.endDate,
			let p_start = period.startDate, let p_end = period.endDate else {
				return false
		}
		
		if p_start < s_start && p_end >= s_start { // outside -> inside
			return true
		}
		else if p_start >= s_start && p_end <= s_end { // enclosing
			return true
		}
		else if p_start < s_end && p_end > s_end { // inside -> out
			return true
		}
		return false
	}
	
	
	/// Return if `self` and the given `TimePeriod` overlap or the period's edges touch.
	///
	/// - Parameter period: The time period to compare to `self`
	/// - Returns: `true` if there is a period of time or moment that is shared by both `TimePeriod`s
	public func intersect(period: TimePeriod) -> Bool {
		guard let relation_with_period = self.relation(to: period) else {
			return false
		}
		return (relation_with_period != .after && relation_with_period != .before)
	}
	
	
	/// Return if `self` and the given `TimePeriod` have no overlap or touching edges.
	///
	/// - Parameter period: The time period to compare to `self`
	/// - Returns: `true` if there is a period of time between self and the given `TimePeriod` not contained by either period, `false` otherwise
	public func hasGap(period: TimePeriod) -> Bool {
		return self < period || self > period
	}
	
	/// Return `true` if period has a start date
	public var hasStartDate: Bool {
		return (self.startDate != nil)
	}
	
	/// Return `true` if period has an end date
	public var hasEndDate: Bool {
		return (self.endDate != nil)
	}
	
	/// The period of time between `self` and the given `TimePeriod` not contained by either.
	///
	/// - Parameter period: The time period to compare to `self`
	/// - Returns: The gap between the periods. Zero if there is no gap. `nil` if not evaluatable (periods are not closed)
	public func gap(between period: TimePeriod) -> TimeInterval? {
		guard	let s_start = self.startDate, let s_end = self.endDate,
			let p_start = period.startDate, let p_end = period.endDate else {
				return nil
		}
		
		if s_end < p_start {
			return abs(s_end.absoluteDate.timeIntervalSince(p_start.absoluteDate))
		}
		else if p_end < s_start {
			return abs(p_end.absoluteDate.timeIntervalSince(s_start.absoluteDate))
		}
		return 0
	}
	
	
	/// The period of time between `self` and the given `TimePeriod` not contained by either as a `TimeFragment`.
	///
	/// - Parameter period: The time period to compare to `self`
	/// - Returns: The gap between the periods, zero if there is no gap
	public func gap(between period: TimePeriod) -> TimeFragment? {
		guard let s_end = self.endDate, let p_start = period.startDate else {
			return nil
		}
		return s_end.fragment(with: p_start)
	}
	
	/// Return if the given `DateInRegion` is after `self.startDate` and before `self.endDate`.
	///
	/// - Parameters:
	///   - date: The time period to compare to `self`
	///   - type: Whether the edge of the date is included in the calculation
	/// - Returns: `true` if the given `TimePeriod` is inside of `self`
	public func contains(_ date: DateInRegion, type: TimePeriodType) -> Bool {
		guard let start = self.startDate, let end = self.endDate else {
			return false
		}
		switch type {
		case .opened:
			return start < date && end > date
		case .closed:
			return start <= date && end >= date
		}
	}

	
	//MARK: - Properties
	
	/// Return the duration of the period expressed as fragment
	public var fragment: TimeFragment? {
		guard let s = self.startDate, let e = self.endDate else { return nil }
		let calendar = s.region.calendar
		let cmps: Set<Calendar.Component> = [.year, .month, .day, .hour, .minute, .second]
		let comps_btw = calendar.dateComponents(cmps, from: s.absoluteDate, to: e.absoluteDate)
		return TimeFragment(components: comps_btw)
	}

	/// Length of time of the period expressed in seconds
	/// Return `nil` if start or end dates are not defined
	public var duration: TimeInterval? {
		guard let s = self.startDate, let e = self.endDate else { return nil }
		return s.absoluteDate.timeIntervalSince(e.absoluteDate)
	}
	
	/// Return `true` if period's duration is zero
	public var isMoment: Bool {
		return (self.startDate == self.endDate)
	}
	
	/// The duration of the period in years
	/// Return `Int.max` if beginning or end are `nil`
	public var years: Int? {
		guard let s = self.startDate, let e = self.endDate else { return Int.max }
		return abs(e - s).in(.year)
	}
	
	/// The duration of the period in weeks (where a week is 7 days long)
	/// Return `Int.max` if beginning or end are `nil`
	public var weeks: Int? {
		guard let s = self.startDate, let e = self.endDate else { return Int.max }
		guard let days = abs(e - s).in(.day) else { return nil }
		return days / Int(DAYS_IN_WEEK)
	}
	
	/// The duration of the period in days
	/// Return `Int.max` if beginning or end are `nil`
	public var days: Int? {
		guard let s = self.startDate, let e = self.endDate else { return Int.max }
		return abs(e - s).in(.day)
	}
	
	/// The duration of the period in hours
	/// Return `Int.max` if beginning or end are `nil`
	public var hours: Int? {
		guard let s = self.startDate, let e = self.endDate else { return Int.max }
		return abs(e - s).in(.hour)
	}
	
	/// The duration of the period in minutes
	/// Return `Int.max` if beginning or end are `nil`
	public var minutes: Int? {
		guard let s = self.startDate, let e = self.endDate else { return Int.max }
		return abs(e - s).in(.minute)
	}
	
	/// The duration of the period in seconds
	/// Return `Int.max` if beginning or end are `nil`
	public var seconds: Int? {
		guard let s = self.startDate, let e = self.endDate else { return Int.max }
		return abs(e - s).in(.second)
	}
	
	//MARK: - Operation with TimePeriods, TimeFragment and TimeInterval
	
	public static func ==(lhs: TimePeriod, rhs: TimePeriod) -> Bool {
		return (lhs.startDate == rhs.startDate) && (lhs.endDate == rhs.endDate)
	}
	
	public static func +(lhs: TimePeriod, rhs: TimeInterval) -> TimePeriod {
		return lhs.lengthened(byInterval: rhs, at: .start)
	}
	
	public static func +(lhs: TimePeriod, rhs: TimeFragment) -> TimePeriod {
		return try! lhs.lengthened(byFragment: rhs, at: .start)
	}
	
	public static func -(lhs: TimePeriod, rhs: TimeInterval) -> TimePeriod {
		return lhs.shortened(byInterval: rhs, at: .start)
	}
	
	public static func -(lhs: TimePeriod, rhs: TimeFragment) -> TimePeriod {
		return try! lhs.shortened(byFragment: rhs, at: .start)
	}

	public static func <(lhs: TimePeriod, rhs: TimePeriod) -> Bool {
		return lhs.relation(to: rhs) == .before
	}
	
	public static func >(lhs: TimePeriod, rhs: TimePeriod) -> Bool {
		return lhs.relation(to: rhs) == .after
	}

}
