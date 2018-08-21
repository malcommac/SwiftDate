//
//  DateInRegion+Compare.swift
//  SwiftDate
//
//  Created by Daniele Margutti on 07/06/2018.
//  Copyright © 2018 SwiftDate. All rights reserved.
//

import Foundation

// MARK: - Comparing DateInRegion

public func == (lhs: DateInRegion, rhs: DateInRegion) -> Bool {
	return (lhs.date.timeIntervalSince1970 == rhs.date.timeIntervalSince1970)
}

public func <= (lhs: DateInRegion, rhs: DateInRegion) -> Bool {
	let result = lhs.date.compare(rhs.date)
	return (result == .orderedAscending || result == .orderedSame)
}

public func >= (lhs: DateInRegion, rhs: DateInRegion) -> Bool {
	let result = lhs.date.compare(rhs.date)
	return (result == .orderedDescending || result == .orderedSame)
}

public func < (lhs: DateInRegion, rhs: DateInRegion) -> Bool {
	return lhs.date.compare(rhs.date) == .orderedAscending
}

public func > (lhs: DateInRegion, rhs: DateInRegion) -> Bool {
	return lhs.date.compare(rhs.date) == .orderedDescending
}

// The type of comparison to do against today's date or with the suplied date.
///
/// - isToday: hecks if date today.
/// - isTomorrow: Checks if date is tomorrow.
/// - isYesterday: Checks if date is yesterday.
/// - isSameDay: Compares date days
/// - isThisWeek: Checks if date is in this week.
/// - isNextWeek: Checks if date is in next week.
/// - isLastWeek: Checks if date is in last week.
/// - isSameWeek: Compares date weeks
/// - isThisMonth: Checks if date is in this month.
/// - isNextMonth: Checks if date is in next month.
/// - isLastMonth: Checks if date is in last month.
/// - isSameMonth: Compares date months
/// - isThisYear: Checks if date is in this year.
/// - isNextYear: Checks if date is in next year.
/// - isLastYear: Checks if date is in last year.
/// - isSameYear: Compare date years
/// - isInTheFuture: Checks if it's a future date
/// - isInThePast: Checks if the date has passed
/// - isEarlier: Checks if earlier than date
/// - isLater: Checks if later than date
/// - isWeekday: Checks if it's a weekday
/// - isWeekend: Checks if it's a weekend
/// - isInDST: Indicates whether the represented date uses daylight saving time.
/// - isMorning: Return true if date is in the morning (>=5 - <12)
/// - isAfternoon: Return true if date is in the afternoon (>=12 - <17)
/// - isEvening: Return true if date is in the morning (>=17 - <21)
/// - isNight: Return true if date is in the morning (>=21 - <5)
public enum DateComparisonType {

	// Days
	case isToday
	case isTomorrow
	case isYesterday
	case isSameDay(_ : DateRepresentable)

	// Weeks
	case isThisWeek
	case isNextWeek
	case isLastWeek
	case isSameWeek(_: DateRepresentable)

	// Months
	case isThisMonth
	case isNextMonth
	case isLastMonth
	case isSameMonth(_: DateRepresentable)

	// Years
	case isThisYear
	case isNextYear
	case isLastYear
	case isSameYear(_: DateRepresentable)

	// Relative Time
	case isInTheFuture
	case isInThePast
	case isEarlier(than: DateRepresentable)
	case isLater(than: DateRepresentable)
	case isWeekday
	case isWeekend

	// Day time
	case isMorning
	case isAfternoon
	case isEvening
	case isNight

	// TZ
	case isInDST
}

public extension DateInRegion {

	/// Decides whether a DATE is "close by" another one passed in parameter,
	/// where "Being close" is measured using a precision argument
	/// which is initialized a 300 seconds, or 5 minutes.
	///
	/// - Parameters:
	///   - refDate: reference date compare against to.
	///   - precision: The precision of the comparison (default is 5 minutes, or 300 seconds).
	/// - Returns: A boolean; true if close by, false otherwise.
	public func compareCloseTo(_ refDate: DateInRegion, precision: TimeInterval = 300) -> Bool {
		return (abs(self.date.timeIntervalSince(refDate.date)) <= precision)
	}

	/// Compare the date with the rule specified in the `compareType` parameter.
	///
	/// - Parameter compareType: comparison type.
	/// - Returns: `true` if comparison succeded, `false` otherwise
	public func compare(_ compareType: DateComparisonType) -> Bool {
		switch compareType {
		case .isToday:
			return self.compare(.isSameDay(self.region.nowInThisRegion()))

		case .isTomorrow:
			let tomorrow = DateInRegion(region: self.region).dateByAdding(1, .day)
			return self.compare(.isSameDay(tomorrow))

		case .isYesterday:
			let yesterday = DateInRegion(region: self.region).dateByAdding(-1, .day)
			return self.compare(.isSameDay(yesterday))

		case .isSameDay(let refDate):
			return self.calendar.isDate(self.date, inSameDayAs: refDate.date)

		case .isThisWeek:
			return self.compare(.isSameWeek(self.region.nowInThisRegion()))

		case .isNextWeek:
			let nextWeek = self.region.nowInThisRegion().dateByAdding(1, .weekOfYear)
			return self.compare(.isSameWeek(nextWeek))

		case .isLastWeek:
			let lastWeek = self.region.nowInThisRegion().dateByAdding(-1, .weekOfYear)
			return self.compare(.isSameWeek(lastWeek))

		case .isSameWeek(let refDate):
			guard self.weekOfYear == refDate.weekOfYear else {
				return false
			}
			// Ensure time interval is under 1 week
			return (abs(self.date.timeIntervalSince(refDate.date)) < 1.weeks.timeInterval)

		case .isThisMonth:
			return self.compare(.isSameMonth(self.region.nowInThisRegion()))

		case .isNextMonth:
			let nextMonth = self.region.nowInThisRegion().dateByAdding(1, .month)
			return self.compare(.isSameMonth(nextMonth))

		case .isLastMonth:
			let lastMonth = self.region.nowInThisRegion().dateByAdding(-1, .month)
			return self.compare(.isSameMonth(lastMonth))

		case .isSameMonth(let refDate):
			return (self.date.year == refDate.date.year) && (self.date.month == refDate.date.month)

		case .isThisYear:
			return self.compare(.isSameYear(self.region.nowInThisRegion()))

		case .isNextYear:
			let nextYear = self.region.nowInThisRegion().dateByAdding(1, .year)
			return self.compare(.isSameYear(nextYear))

		case .isLastYear:
			let lastYear = self.region.nowInThisRegion().dateByAdding(-1, .year)
			return self.compare(.isSameYear(lastYear))

		case .isSameYear(let refDate):
			return (self.date.year == refDate.date.year)

		case .isInTheFuture:
			return self.compare(.isLater(than: self.region.nowInThisRegion()))

		case .isInThePast:
			return self.compare(.isEarlier(than: self.region.nowInThisRegion()))

		case .isEarlier(let refDate):
			return ((self.date as NSDate).earlierDate(refDate.date) == self.date)

		case .isLater(let refDate):
			return ((self.date as NSDate).laterDate(refDate.date) == self.date)

		case .isWeekday:
			return !self.compare(.isWeekend)

		case .isWeekend:
			let range = self.calendar.maximumRange(of: Calendar.Component.weekday)!
			return (self.weekday == range.lowerBound || self.weekday == range.upperBound - range.lowerBound)

		case .isInDST:
			return self.region.timeZone.isDaylightSavingTime(for: self.date)

		case .isMorning:
			return (self.hour >= 5 && self.hour < 12)

		case .isAfternoon:
			return (self.hour >= 12 && self.hour < 17)

		case .isEvening:
			return (self.hour >= 17 && self.hour < 21)

		case .isNight:
			return (self.hour >= 21 || self.hour < 5)

		}
	}

	/// Returns a ComparisonResult value that indicates the ordering of two given dates based on
	/// their components down to a given unit granularity.
	///
	/// - parameter date:        date to compare.
	/// - parameter granularity: The smallest unit that must, along with all larger units
	/// - returns: `ComparisonResult`
	func compare(toDate refDate: DateInRegion, granularity: Calendar.Component) -> ComparisonResult {
		switch granularity {
		case .nanosecond:
			// There is a possible rounding error using Calendar to compare two dates below the minute granularity
			// So we've added this trick and use standard Date compare which return correct results in this case
			// https://github.com/malcommac/SwiftDate/issues/346
			return self.date.compare(refDate.date)
		default:
			return self.region.calendar.compare(self.date, to: refDate.date, toGranularity: granularity)
		}
	}

	/// Compares whether the receiver is before/before equal `date` based on their components down to a given unit granularity.
	///
	/// - Parameters:
	///   - refDate: reference date
	///   - orEqual: `true` to also check for equality
	///   - granularity: smallest unit that must, along with all larger units, be less for the given dates
	/// - Returns: Boolean
	public func isBeforeDate(_ date: DateInRegion, orEqual: Bool = false, granularity: Calendar.Component) -> Bool {
		let result = self.compare(toDate: date, granularity: granularity)
		return (orEqual ? (result == .orderedSame || result == .orderedAscending) : result == .orderedAscending)
	}

	/// Compares whether the receiver is after `date` based on their components down to a given unit granularity.
	///
	/// - Parameters:
	///   - refDate: reference date
	///   - orEqual: `true` to also check for equality
	///   - granularity: Smallest unit that must, along with all larger units, be greater for the given dates.
	/// - Returns: Boolean
	public func isAfterDate(_ refDate: DateInRegion, orEqual: Bool = false, granularity: Calendar.Component) -> Bool {
		let result = self.compare(toDate: refDate, granularity: granularity)
		return (orEqual ? (result == .orderedSame || result == .orderedDescending) : result == .orderedDescending)
	}
	
	/// Compares equality of two given dates based on their components down to a given unit
	/// granularity.
	///
	/// - parameter date:        date to compare
	/// - parameter granularity: The smallest unit that must, along with all larger units, be equal for the given
	///         dates to be considered the same.
	///
	/// - returns: `true` if the dates are the same down to the given granularity, otherwise `false`
	public func isInside(date: DateInRegion, granularity: Calendar.Component) -> Bool {
		return (self.compare(toDate: date, granularity: granularity) == .orderedSame)
	}

	/// Return `true` if receiver data is contained in the range specified by two dates.
	///
	/// - Parameters:
	///   - startDate: range upper bound date
	///   - endDate: range lower bound date
	///   - orEqual: `true` to also check for equality on date and date2, default is `true`
	///   - granularity: smallest unit that must, along with all larger units, be greater
	/// - Returns: Boolean
	public func isInRange(date startDate: DateInRegion, and endDate: DateInRegion, orEqual: Bool = true, granularity: Calendar.Component = .nanosecond) -> Bool {
		return self.isAfterDate(startDate, orEqual: orEqual, granularity: granularity) && self.isBeforeDate(endDate, orEqual: orEqual, granularity: granularity)
	}

	// MARK: - Date Earlier/Later

	/// Return the earlier of two dates, between self and a given date.
	///
	/// - Parameter date: The date to compare to self
	/// - Returns: The date that is earlier
	public func earlierDate(_ date: DateInRegion) -> DateInRegion {
		return (self.date.timeIntervalSince1970 <= date.date.timeIntervalSince1970) ? self : date
	}

	/// Return the later of two dates, between self and a given date.
	///
	/// - Parameter date: The date to compare to self
	/// - Returns: The date that is later
	public func laterDate(_ date: DateInRegion) -> DateInRegion {
		return (self.date.timeIntervalSince1970 >= date.date.timeIntervalSince1970) ? self : date
	}

}
