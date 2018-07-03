//
//  DateInRegion+Operations.swift
//  SwiftDate
//
//  Created by Daniele Margutti on 06/06/2018.
//  Copyright © 2018 SwiftDate. All rights reserved.
//

import Foundation

public extension DateInRegion {

	// MARK: - Random Date Generator

	/// Generate a sequence of dates between a range.
	///
	/// - Parameters:
	///   - count: number of dates to generate.
	///   - initial: lower date bound.
	///   - final: upper date bound.
	///   - region: region of the dates.
	/// - Returns: array of dates
	public static func randomDates(count: Int, between initial: DateInRegion, and final: DateInRegion,
								   region: Region = SwiftDate.defaultRegion) -> [DateInRegion] {
		var list: [DateInRegion] = []
		for _ in 0..<count {
			list.append(DateInRegion.randomDate(between: initial, and: final, region: region))
		}
		return list
	}

	/// Return a date between now and a specified amount days ealier.
	///
	/// - Parameters:
	///   - days: days range
	///   - region: destination region, `nil` to use the default region
	/// - Returns: random date
	public static func randomDate(withinDaysBeforeToday days: Int,
								  region: Region = SwiftDate.defaultRegion) -> DateInRegion {
		let today = DateInRegion(region: region)
		let earliest = DateInRegion(today.date.addingTimeInterval(TimeInterval(-days * 24 * 60 * 60)), region: region)
		return DateInRegion.randomDate(between: earliest, and: today)
	}

	/// Generate a random date in given region.
	///
	/// - Parameter region: destination region, `nil` to use the default region
	/// - Returns: random date
	public static func randomDate(region: Region = SwiftDate.defaultRegion) -> DateInRegion {
		let randomTime = TimeInterval(arc4random_uniform(UInt32.max))
		let absoluteDate = Date(timeIntervalSince1970: randomTime)
		return DateInRegion(absoluteDate, region: region)
	}

	/// Generate a random date between two intervals.
	///
	/// - Parameters:
	///   - initial: lower bound date
	///   - final: upper bound date
	///   - region: destination region, `nil` to use the default region
	/// - Returns: random Date
	public static func randomDate(between initial: DateInRegion, and final: DateInRegion,
								  region: Region = SwiftDate.defaultRegion) -> DateInRegion {
		let interval = final.timeIntervalSince(initial)
		let randomInterval = TimeInterval(arc4random_uniform(UInt32(interval)))
		return initial.addingTimeInterval(randomInterval)
	}

	/// Return the oldest date in given list (timezone is ignored, comparison uses absolute date).
	///
	/// - Parameter list: list of dates
	/// - Returns: a tuple with the index of the oldest date and its instance.
	public static func oldestIn(list: [DateInRegion]) -> DateInRegion? {
		guard list.count > 0 else { return nil }
		guard list.count > 1 else { return list.first! }
		return list.min(by: {
			return $0 < $1
		})
	}

	/// Sort date by oldest, with the oldest date on top.
	///
	/// - Parameter list: list to sort
	/// - Returns: sorted array
	public static func sortedByOldest(list: [DateInRegion]) -> [DateInRegion] {
		return list.sorted(by: { $0.date.compare($1.date) == .orderedAscending })
	}

	/// Sort date by newest, with the newest date on top.
	///
	/// - Parameter list: list to sort
	/// - Returns: sorted array
	public static func sortedByNewest(list: [DateInRegion]) -> [DateInRegion] {
		return list.sorted(by: { $0.date.compare($1.date) == .orderedDescending })
	}

	/// Return the oldest date in given list (timezone is ignored, comparison uses absolute date).
	///
	/// - Parameter list: list of dates
	/// - Returns: a tuple with the index of the oldest date and its instance.
	public static func newestIn(list: [DateInRegion]) -> DateInRegion? {
		guard list.count > 0 else { return nil }
		guard list.count > 1 else { return list.first! }
		return list.max(by: {
			return $0 < $1
		})
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
	public static func enumerateDates(from startDate: DateInRegion, to endDate: DateInRegion, increment: DateComponents) -> [DateInRegion] {
		return DateInRegion.enumerateDates(from: startDate, to: endDate, increment: { _ in
			return increment
		})
	}

	/// Enumerate dates between two intervals by adding specified time components defined in a closure and return an array of dates.
	/// `startDate` interval will be the first item of the resulting array.
	/// The last item of the array is evaluated automatically and maybe not equal to `endDate`.
	///
	/// - Parameters:
	///   - start: starting date
	///   - endDate: ending date
	///   - increment: increment function. It get the last generated date and require a valida `DateComponents` instance which define the increment
	/// - Returns: array of dates
	public static func enumerateDates(from startDate: DateInRegion, to endDate: DateInRegion, increment: ((DateInRegion) -> (DateComponents))) -> [DateInRegion] {
		guard startDate.calendar == endDate.calendar else {
			debugPrint("Cannot enumerate dates between two different region's calendars. Return empty array.")
			return []
		}

		var dates: [DateInRegion] = []
		var currentDate = startDate
		while currentDate <= endDate {
			dates.append(currentDate)
			currentDate = (currentDate + increment(currentDate))
		}
		return dates
	}

	/// Returns a new DateInRegion that is initialized at the start of a specified unit of time.
	///
	/// - Parameter unit: time unit value.
	/// - Returns: instance at the beginning of the time unit; `self` if fails.
	public func dateAtStartOf(_ unit: Calendar.Component) -> DateInRegion {
		guard let result = self.region.calendar.rangex(of: unit, for: self.date) else { return self }
		return DateInRegion(result.start, region: self.region)
	}

	/// Return a new DateInRegion that is initialized at the start of the specified components
	/// executed in order.
	///
	/// - Parameter units: sequence of transformations as time unit components
	/// - Returns: new date at the beginning of the passed components, intermediate results if fails.
	public func dateAtStartOf(_ units: [Calendar.Component]) -> DateInRegion {
		return units.reduce(self) { (currentDate, currentUnit) -> DateInRegion in
			return currentDate.dateAtStartOf(currentUnit)
		}
	}

	/// Returns a new Moment that is initialized at the end of a specified unit of time.
	///
	/// - parameter unit: time unit value.
	///
	/// - returns: A new Moment instance.
	public func dateAtEndOf(_ unit: Calendar.Component) -> DateInRegion {
		// RangeOfUnit returns the start of the next unit; we will subtract one thousandth of a second
		guard let result = self.region.calendar.rangex(of: unit, for: self.date) else { return self }
		let startOfNextUnit = result.start.addingTimeInterval(result.duration)
		let endOfThisUnit = Date(timeInterval: -0.001, since: startOfNextUnit)
		return DateInRegion(endOfThisUnit, region: self.region)
	}

	/// Return a new DateInRegion that is initialized at the end of the specified components
	/// executed in order.
	///
	/// - Parameter units: sequence of transformations as time unit components
	/// - Returns: new date at the end of the passed components, intermediate results if fails.
	public func dateAtEndOf(_ units: [Calendar.Component]) -> DateInRegion {
		return units.reduce(self) { (currentDate, currentUnit) -> DateInRegion in
			return currentDate.dateAtEndOf(currentUnit)
		}
	}

	/// Create a new date by altering specified components of the receiver.
	/// Note: `calendar` and `timezone` are ignored.
	/// Note: some components may alter the date cyclically (like setting both `.year` and `.yearForWeekOfYear`) and
	/// may results in a wrong evaluated date.
	///
	/// - Parameter components: components to alter with their new values.
	/// - Returns: new altered `DateInRegion` instance
	public func dateBySet(_ components: [Calendar.Component: Int?]) -> DateInRegion? {
		var dateComponents = DateComponents()
		dateComponents.year = (components[.year] ?? self.year)
		dateComponents.month = (components[.month] ?? self.month)
		dateComponents.day = (components[.day] ?? self.day)
		dateComponents.hour = (components[.hour] ?? self.hour)
		dateComponents.minute = (components[.minute] ?? self.minute)
		dateComponents.second = (components[.second] ?? self.second)
		dateComponents.nanosecond = (components[.nanosecond] ?? self.nanosecond)

		// Some components may interfer with others, so we'll set it them only if explicitly set.
		if let weekday = components[.weekday] {
			dateComponents.weekday = weekday
		}
		if let weekOfYear = components[.weekOfYear] {
			dateComponents.weekOfYear = weekOfYear
		}
		if let weekdayOrdinal = components[.weekdayOrdinal] {
			dateComponents.weekdayOrdinal = weekdayOrdinal
		}
		if let yearForWeekOfYear = components[.yearForWeekOfYear] {
			dateComponents.yearForWeekOfYear = yearForWeekOfYear
		}

		guard let newDate = self.calendar.date(from: dateComponents) else { return nil }
		return DateInRegion(newDate, region: self.region)
	}

	/// Create a new date by altering specified time components.
	///
	/// - Parameters:
	///   - hour: hour to set (`nil` to leave it unaltered)
	///   - min: min to set (`nil` to leave it unaltered)
	///   - secs: sec to set (`nil` to leave it unaltered)
	///   - options: options for calculation
	/// - Returns: new altered `DateInRegion` instance
	public func dateBySet(hour: Int?, min: Int?, secs: Int?, options: TimeCalculationOptions = TimeCalculationOptions()) -> DateInRegion? {
		guard let date = self.calendar.date(bySettingHour: (hour ?? self.hour),
											minute: (min ?? self.minute),
											second: (secs ?? self.second),
											of: self.date,
											matchingPolicy: options.matchingPolicy,
											repeatedTimePolicy: options.repeatedTimePolicy,
											direction: options.direction) else { return nil }
		return DateInRegion(date, region: self.region)
	}

	/// Creates a new instance by truncating the components
	///
	/// - Parameter components: components to truncate.
	/// - Returns: new date with truncated components.
	public func dateTruncated(at components: [Calendar.Component]) -> DateInRegion? {
		var dateComponents = self.dateComponents

		for component in components {
			switch component {
			case .month:		dateComponents.month = 1
			case .day:			dateComponents.day = 1
			case .hour:			dateComponents.hour = 0
			case .minute:		dateComponents.minute = 0
			case .second:		dateComponents.second = 0
			case .nanosecond:	dateComponents.nanosecond = 0
			default:			continue
			}
		}

		guard let newDate = self.calendar.date(from: dateComponents) else { return nil }
		return DateInRegion(newDate, region: self.region)
	}

	/// Creates a new instance by truncating the components starting from given components down the granurality.
	///
	/// - Parameter component: The component to be truncated from.
	/// - Returns: new date with truncated components.
	public func dateTruncated(from component: Calendar.Component) -> DateInRegion? {
		switch component {
		case .month:		return dateTruncated(at: [.month, .day, .hour, .minute, .second, .nanosecond])
		case .day:			return dateTruncated(at: [.day, .hour, .minute, .second, .nanosecond])
		case .hour:			return dateTruncated(at: [.hour, .minute, .second, .nanosecond])
		case .minute:		return dateTruncated(at: [.minute, .second, .nanosecond])
		case .second:		return dateTruncated(at: [.second, .nanosecond])
		case .nanosecond:	return dateTruncated(at: [.nanosecond])
		default:			return self
		}
	}

	/// Round a given date time to the passed style (off|up|down).
	///
	/// - Parameter style: rounding mode.
	/// - Returns: rounded date
	public func dateRoundedAt(_ style: RoundDateMode) -> DateInRegion {
		switch style {
		case .to5Mins:			return self.dateRoundedAt(.toMins(5))
		case .to10Mins:			return self.dateRoundedAt(.toMins(10))
		case .to30Mins:			return self.dateRoundedAt(.toMins(30))
		case .toCeil5Mins:		return self.dateRoundedAt(.toCeilMins(5))
		case .toCeil10Mins:		return self.dateRoundedAt(.toCeilMins(10))
		case .toCeil30Mins:		return self.dateRoundedAt(.toCeilMins(30))
		case .toFloor5Mins:		return self.dateRoundedAt(.toFloorMins(5))
		case .toFloor10Mins:	return self.dateRoundedAt(.toFloorMins(10))
		case .toFloor30Mins:	return self.dateRoundedAt(.toFloorMins(30))

		case .toMins(let minuteInterval):
			let onesDigit: Int = (self.minute % 10)
			if onesDigit < 5 {
				return self.dateRoundedAt(.toFloorMins(minuteInterval))
			} else {
				return self.dateRoundedAt(.toCeilMins(minuteInterval))
			}

		case .toCeilMins(let minuteInterval):
			let remain: Int = (self.minute % minuteInterval)
			let value = (( Int(1.minutes.timeInterval) * (minuteInterval - remain)) - self.second)
			return self.dateByAdding(value, .second)

		case .toFloorMins(let minuteInterval):
			let remain: Int = (self.minute % minuteInterval)
			let value = -((Int(1.minutes.timeInterval) * remain) + self.second)
			return self.dateByAdding(value, .second)

		}
	}

	/// Offset a date by n calendar components.
	/// Note: This operation can be functionally chained.
	///
	/// - Parameters:
	///   - count: value of the offset (maybe negative).
	///   - component: component to offset.
	/// - Returns: new altered date.
	public func dateByAdding(_ count: Int, _ component: Calendar.Component) -> DateInRegion {
		var newComponent = DateComponents(second: 0)
		switch component {
		case .era: 					newComponent = DateComponents(era: count)
		case .year: 				newComponent = DateComponents(year: count)
		case .month: 				newComponent = DateComponents(month: count)
		case .day: 					newComponent = DateComponents(day: count)
		case .hour: 				newComponent = DateComponents(hour: count)
		case .minute: 				newComponent = DateComponents(minute: count)
		case .second:				newComponent = DateComponents(second: count)
		case .weekday:				newComponent = DateComponents(weekday: count)
		case .weekdayOrdinal: 		newComponent = DateComponents(weekdayOrdinal: count)
		case .quarter: 				newComponent = DateComponents(quarter: count)
		case .weekOfMonth: 			newComponent = DateComponents(weekOfMonth: count)
		case .weekOfYear: 			newComponent = DateComponents(weekOfYear: count)
		case .yearForWeekOfYear: 	newComponent = DateComponents(yearForWeekOfYear: count)
		case .nanosecond: 			newComponent = DateComponents(nanosecond: count)
		default: break // .calendar and .timezone does nothing in this context
		}

		guard let newDate = self.region.calendar.date(byAdding: newComponent, to: self.date) else {
			return self // failed to add component, return unmodified date
		}
		return DateInRegion(newDate, region: self.region)
	}

	/// Return related date starting from the receiver attributes.
	///
	/// - Parameter type: related date to obtain.
	/// - Returns: instance of the related date; if fails the same unmodified date is returned
	public func dateAt(_ type: DateRelatedType) -> DateInRegion {
		switch type {
		case .startOfDay:
			return self.calendar.startOfDay(for: self.date).in(region: self.region)
		case .endOfDay:
			return self.dateByAdding(1, .day).dateAt(.startOfDay).dateByAdding(-1, .second)
		case .startOfWeek:
			let components = self.calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self.date)
			return self.calendar.date(from: components)!.in(region: self.region)
		case .endOfWeek:
			return self.dateAt(.startOfWeek).dateByAdding(7, .day).dateByAdding(-1, .second)
		case .startOfMonth:
			return self.dateBySet([.day: 1, .hour: 1, .minute: 1, .second: 1, .nanosecond: 1])!
		case .endOfMonth:
			return self.dateByAdding((self.monthDays - self.day), .day).dateAtEndOf(.day)
		case .tomorrow:
			return self.dateByAdding(1, .day)
		case .tomorrowAtStart:
			return self.dateByAdding(1, .day).dateAtStartOf(.day)
		case .yesterday:
			return self.dateByAdding(-1, .day)
		case .yesterdayAtStart:
			return self.dateByAdding(-1, .day).dateAtStartOf(.day)
		case .nearestMinute(let nearest):
			let minutes = (self.minute + nearest / 2) / nearest * nearest
			return dateBySet([.minute: minutes])!
		case .nearestHour(let nearest):
			let hours = (self.hour + nearest / 2) / nearest * nearest
			return dateBySet([.hour: hours, .minute: 0])!
		case .nextWeekday(let weekday):
			var cal = Calendar(identifier: self.calendar.identifier)
			cal.firstWeekday = 2 // Sunday = 1, Saturday = 7
			var components = DateComponents()
			components.weekday = weekday.rawValue
			guard let next = cal.nextDate(after: self.date, matching: components, matchingPolicy: .nextTimePreservingSmallerComponents) else {
				return self
			}
			return DateInRegion(next, region: self.region)
		case .nextDSTDate:
			guard let nextDate = self.region.timeZone.nextDaylightSavingTimeTransition(after: self.date) else {
				return self
			}
			return DateInRegion(nextDate, region: self.region)
		case .prevMonth:
			return self.dateByAdding(-1, .month).dateAtStartOf(.month).dateAtStartOf(.day)
		case .nextMonth:
			return self.dateByAdding(1, .month).dateAtStartOf(.month).dateAtStartOf(.day)
		case .prevWeek:
			return self.dateByAdding(-7, .weekOfYear).dateAtStartOf(.weekOfYear).dateAtStartOf(.day)
		case .nextWeek:
			return self.dateByAdding(7, .weekOfYear).dateAtStartOf(.weekOfYear).dateAtStartOf(.day)
		case .nextYear:
			return self.dateByAdding(1, .year).dateAtStartOf(.year)
		case .prevYear:
			return self.dateByAdding(-1, .year).dateAtStartOf(.year)
		case .nextDSTTransition:
			guard let transitionDate = self.region.timeZone.nextDaylightSavingTimeTransition(after: self.date) else {
				return self
			}
			return DateInRegion(transitionDate, region: self.region)
		}
	}

	/// Create a new instance of the date in the same region with time shifted by given time interval.
	///
	/// - Parameter interval: time interval to shift; maybe negative.
	/// - Returns: new instance of the `DateInRegion`
	public func addingTimeInterval(_ interval: TimeInterval) -> DateInRegion {
		return DateInRegion(self.date.addingTimeInterval(interval), region: self.region)
	}

	// MARK: - Conversion

	/// Convert a date to a new calendar/timezone/locale.
	/// Only non `nil` values are used, other values are inherithed by the receiver's region.
	///
	/// - Parameters:
	///   - calendar: non `nil` value to change the calendar
	///   - timezone: non `nil` value to change the timezone
	///   - locale: non `nil` value to change the locale
	/// - Returns: converted date
	public func convertTo(calendar: CalendarConvertible? = nil, timezone: ZoneConvertible? = nil, locale: LocaleConvertible? = nil) -> DateInRegion {
		let newRegion = Region(calendar: (calendar ?? self.region.calendar),
							   zone: (timezone ?? self.region.timeZone),
							   locale: (locale ?? self.region.locale))
		return self.convertTo(region: newRegion)
	}

}
