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
	static func randomDates(count: Int, between initial: DateInRegion, and final: DateInRegion,
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
	static func randomDate(withinDaysBeforeToday days: Int,
								  region: Region = SwiftDate.defaultRegion) -> DateInRegion {
		let today = DateInRegion(region: region)
		let earliest = DateInRegion(today.date.addingTimeInterval(TimeInterval(-days * 24 * 60 * 60)), region: region)
		return DateInRegion.randomDate(between: earliest, and: today)
	}

	/// Generate a random date in given region.
	///
	/// - Parameter region: destination region, `nil` to use the default region
	/// - Returns: random date
	static func randomDate(region: Region = SwiftDate.defaultRegion) -> DateInRegion {
		let randomTime = TimeInterval(UInt32.random(in: UInt32.min..<UInt32.max))
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
	static func randomDate(between initial: DateInRegion, and final: DateInRegion,
								  region: Region = SwiftDate.defaultRegion) -> DateInRegion {
		let interval = final.timeIntervalSince(initial)
		let randomInterval = TimeInterval(UInt32.random(in: UInt32.min..<UInt32(interval)))
		return initial.addingTimeInterval(randomInterval)
	}

	/// Return the oldest date in given list (timezone is ignored, comparison uses absolute date).
	///
	/// - Parameter list: list of dates
	/// - Returns: a tuple with the index of the oldest date and its instance.
	static func oldestIn(list: [DateInRegion]) -> DateInRegion? {
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
	static func sortedByOldest(list: [DateInRegion]) -> [DateInRegion] {
		return list.sorted(by: { $0.date.compare($1.date) == .orderedAscending })
	}

	/// Sort date by newest, with the newest date on top.
	///
	/// - Parameter list: list to sort
	/// - Returns: sorted array
	static func sortedByNewest(list: [DateInRegion]) -> [DateInRegion] {
		return list.sorted(by: { $0.date.compare($1.date) == .orderedDescending })
	}

	/// Return the oldest date in given list (timezone is ignored, comparison uses absolute date).
	///
	/// - Parameter list: list of dates
	/// - Returns: a tuple with the index of the oldest date and its instance.
	static func newestIn(list: [DateInRegion]) -> DateInRegion? {
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
	static func enumerateDates(from startDate: DateInRegion, to endDate: DateInRegion, increment: DateComponents) -> [DateInRegion] {
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
	static func enumerateDates(from startDate: DateInRegion, to endDate: DateInRegion, increment: ((DateInRegion) -> (DateComponents))) -> [DateInRegion] {
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
	func dateAtStartOf(_ unit: Calendar.Component) -> DateInRegion {
		#if os(Linux)
		guard let result = (region.calendar as NSCalendar).range(of: unit.nsCalendarUnit, for: date) else {
			return self
		}
		return DateInRegion(result.start, region: region)
		#else
		var start: NSDate?
		var interval: TimeInterval = 0
		guard (region.calendar as NSCalendar).range(of: unit.nsCalendarUnit, start: &start, interval: &interval, for: date),
			let startDate = start else {
				return self
		}
		return DateInRegion(startDate as Date, region: region)
		#endif
	}

	/// Return a new DateInRegion that is initialized at the start of the specified components
	/// executed in order.
	///
	/// - Parameter units: sequence of transformations as time unit components
	/// - Returns: new date at the beginning of the passed components, intermediate results if fails.
	func dateAtStartOf(_ units: [Calendar.Component]) -> DateInRegion {
		return units.reduce(self) { (currentDate, currentUnit) -> DateInRegion in
			return currentDate.dateAtStartOf(currentUnit)
		}
	}

	/// Returns a new Moment that is initialized at the end of a specified unit of time.
	///
	/// - parameter unit: time unit value.
	///
	/// - returns: A new Moment instance.
	func dateAtEndOf(_ unit: Calendar.Component) -> DateInRegion {
		// RangeOfUnit returns the start of the next unit; we will subtract one thousandth of a second
		#if os(Linux)
		guard let result = (region.calendar as NSCalendar).range(of: unit.nsCalendarUnit, for: date) else {
			return self
		}
		let startOfNextUnit = result.start.addingTimeInterval(result.duration)
		let endOfThisUnit = Date(timeInterval: -0.001, since: startOfNextUnit)
		return DateInRegion(endOfThisUnit, region: region)
		#else
		var start: NSDate?
		var interval: TimeInterval = 0
		guard (self.region.calendar as NSCalendar).range(of: unit.nsCalendarUnit, start: &start, interval: &interval, for: date),
		let startDate = start else {
			return self
		}
		let startOfNextUnit = startDate.addingTimeInterval(interval)
		let endOfThisUnit = Date(timeInterval: -0.001, since: startOfNextUnit as Date)
		return DateInRegion(endOfThisUnit, region: region)
		#endif
	}

	/// Return a new DateInRegion that is initialized at the end of the specified components
	/// executed in order.
	///
	/// - Parameter units: sequence of transformations as time unit components
	/// - Returns: new date at the end of the passed components, intermediate results if fails.
	func dateAtEndOf(_ units: [Calendar.Component]) -> DateInRegion {
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
	func dateBySet(_ components: [Calendar.Component: Int?]) -> DateInRegion? {
		var dateComponents = DateComponents()
		dateComponents.year = (components[.year] ?? year)
		dateComponents.month = (components[.month] ?? month)
		dateComponents.day = (components[.day] ?? day)
		dateComponents.hour = (components[.hour] ?? hour)
		dateComponents.minute = (components[.minute] ?? minute)
		dateComponents.second = (components[.second] ?? second)
		dateComponents.nanosecond = (components[.nanosecond] ?? nanosecond)

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

		guard let newDate = calendar.date(from: dateComponents) else { return nil }
		return DateInRegion(newDate, region: region)
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
	func dateBySet(hour: Int?, min: Int?, secs: Int?, ms: Int? = nil, options: TimeCalculationOptions = TimeCalculationOptions()) -> DateInRegion? {
		guard let date = calendar.date(bySettingHour: (hour ?? self.hour),
											minute: (min ?? self.minute),
											second: (secs ?? self.second),
											of: self.date,
											matchingPolicy: options.matchingPolicy,
											repeatedTimePolicy: options.repeatedTimePolicy,
											direction: options.direction) else { return nil }
		guard let ms = ms else {
			return DateInRegion(date, region: region)
		}
		var timestamp = date.timeIntervalSince1970.rounded(.down)
		timestamp += Double(ms) / 1000.0
		return DateInRegion(Date(timeIntervalSince1970: timestamp), region: region)
	}

	/// Creates a new instance by truncating the components
	///
	/// - Parameter components: components to truncate.
	/// - Returns: new date with truncated components.
	func dateTruncated(at components: [Calendar.Component]) -> DateInRegion? {
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

		guard let newDate = calendar.date(from: dateComponents) else { return nil }
		return DateInRegion(newDate, region: region)
	}

	/// Creates a new instance by truncating the components starting from given components down the granurality.
	///
	/// - Parameter component: The component to be truncated from.
	/// - Returns: new date with truncated components.
	func dateTruncated(from component: Calendar.Component) -> DateInRegion? {
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
	func dateRoundedAt(_ style: RoundDateMode) -> DateInRegion {
		switch style {
		case .to5Mins:			return dateRoundedAt(.toMins(5))
		case .to10Mins:			return dateRoundedAt(.toMins(10))
		case .to30Mins:			return dateRoundedAt(.toMins(30))
		case .toCeil5Mins:		return dateRoundedAt(.toCeilMins(5))
		case .toCeil10Mins:		return dateRoundedAt(.toCeilMins(10))
		case .toCeil30Mins:		return dateRoundedAt(.toCeilMins(30))
		case .toFloor5Mins:		return dateRoundedAt(.toFloorMins(5))
		case .toFloor10Mins:	return dateRoundedAt(.toFloorMins(10))
		case .toFloor30Mins:	return dateRoundedAt(.toFloorMins(30))

		case .toMins(let minuteInterval):
			let onesDigit: Int = (minute % 10)
			if onesDigit < 5 {
				return dateRoundedAt(.toFloorMins(minuteInterval))
			} else {
				return dateRoundedAt(.toCeilMins(minuteInterval))
			}

		case .toCeilMins(let minuteInterval):
			let remain: Int = (minute % minuteInterval)
			let value = (( Int(1.minutes.timeInterval) * (minuteInterval - remain)) - second)
			return dateByAdding(value, .second)

		case .toFloorMins(let minuteInterval):
			let remain: Int = (minute % minuteInterval)
			let value = -((Int(1.minutes.timeInterval) * remain) + second)
			return dateByAdding(value, .second)

		}
	}

	/// Offset a date by n calendar components.
	/// Note: This operation can be functionally chained.
	///
	/// - Parameters:
	///   - count: value of the offset (maybe negative).
	///   - component: component to offset.
	/// - Returns: new altered date.
	func dateByAdding(_ count: Int, _ component: Calendar.Component) -> DateInRegion {
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

		guard let newDate = region.calendar.date(byAdding: newComponent, to: date) else {
			return self // failed to add component, return unmodified date
		}
		return DateInRegion(newDate, region: region)
	}

	/// Return related date starting from the receiver attributes.
	///
	/// - Parameter type: related date to obtain.
	/// - Returns: instance of the related date; if fails the same unmodified date is returned
	func dateAt(_ type: DateRelatedType) -> DateInRegion {
		switch type {
		case .startOfDay:
			return calendar.startOfDay(for: date).in(region: region)
		case .endOfDay:
			return dateByAdding(1, .day).dateAt(.startOfDay).dateByAdding(-1, .second)
		case .startOfWeek:
			let components = calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: date)
			return calendar.date(from: components)!.in(region: region)
		case .endOfWeek:
			return dateAt(.startOfWeek).dateByAdding(7, .day).dateByAdding(-1, .second)
		case .startOfMonth:
			return dateBySet([.day: 1, .hour: 1, .minute: 1, .second: 1, .nanosecond: 1])!
		case .endOfMonth:
			return dateByAdding((monthDays - day), .day).dateAtEndOf(.day)
		case .tomorrow:
			return dateByAdding(1, .day)
		case .tomorrowAtStart:
			return dateByAdding(1, .day).dateAtStartOf(.day)
		case .yesterday:
			return dateByAdding(-1, .day)
		case .yesterdayAtStart:
			return dateByAdding(-1, .day).dateAtStartOf(.day)
		case .nearestMinute(let nearest):
			let minutes = (minute + nearest / 2) / nearest * nearest
			return dateBySet([.minute: minutes])!
		case .nearestHour(let nearest):
			let hours = (hour + nearest / 2) / nearest * nearest
			return dateBySet([.hour: hours, .minute: 0])!
		case .nextWeekday(let weekday):
			var cal = Calendar(identifier: calendar.identifier)
			cal.firstWeekday = 2 // Sunday = 1, Saturday = 7
			var components = DateComponents()
			components.weekday = weekday.rawValue
			guard let next = cal.nextDate(after: date, matching: components, matchingPolicy: .nextTimePreservingSmallerComponents) else {
				return self
			}
			return DateInRegion(next, region: region)
		case .nextDSTDate:
			guard let nextDate = region.timeZone.nextDaylightSavingTimeTransition(after: date) else {
				return self
			}
			return DateInRegion(nextDate, region: region)
		case .prevMonth:
			return dateByAdding(-1, .month).dateAtStartOf(.month).dateAtStartOf(.day)
		case .nextMonth:
			return dateByAdding(1, .month).dateAtStartOf(.month).dateAtStartOf(.day)
		case .prevWeek:
			return dateByAdding(-1, .weekOfYear).dateAtStartOf(.weekOfYear).dateAtStartOf(.day)
		case .nextWeek:
			return dateByAdding(1, .weekOfYear).dateAtStartOf(.weekOfYear).dateAtStartOf(.day)
		case .nextYear:
			return dateByAdding(1, .year).dateAtStartOf(.year)
		case .prevYear:
			return dateByAdding(-1, .year).dateAtStartOf(.year)
		case .nextDSTTransition:
			guard let transitionDate = region.timeZone.nextDaylightSavingTimeTransition(after: date) else {
				return self
			}
			return DateInRegion(transitionDate, region: region)
		}
	}

	/// Create a new instance of the date in the same region with time shifted by given time interval.
	///
	/// - Parameter interval: time interval to shift; maybe negative.
	/// - Returns: new instance of the `DateInRegion`
	func addingTimeInterval(_ interval: TimeInterval) -> DateInRegion {
		return DateInRegion(date.addingTimeInterval(interval), region: region)
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
	func convertTo(calendar: CalendarConvertible? = nil, timezone: ZoneConvertible? = nil, locale: LocaleConvertible? = nil) -> DateInRegion {
		let newRegion = Region(calendar: (calendar ?? region.calendar),
							   zone: (timezone ?? region.timeZone),
							   locale: (locale ?? region.locale))
		return convertTo(region: newRegion)
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
									   region: Region = SwiftDate.defaultRegion) -> [DateInRegion] {
		let fromDate = DateInRegion(year: year, month: month, day: 1, hour: 0, minute: 0, second: 0, nanosecond: 0, region: region)
		let toDate = fromDate.dateAt(.endOfMonth)
		return DateInRegion.datesForWeekday(weekday, from: fromDate, to: toDate, region: region)
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
	static func datesForWeekday(_ weekday: WeekDay, from startDate: DateInRegion, to endDate: DateInRegion,
									   region: Region = SwiftDate.defaultRegion) -> [DateInRegion] {

		let calendarObj = region.calendar
		let startDateWeekDay = Int(calendarObj.component(.weekday, from: startDate.date))
		let desiredDay = weekday.rawValue

		let offset = (desiredDay - startDateWeekDay + 7) % 7
		let firstOccurrence = calendarObj.startOfDay(for: calendarObj.date(byAdding: DateComponents(day: offset), to: startDate.date)!)
		guard firstOccurrence.timeIntervalSince1970 < endDate.timeIntervalSince1970 else {
			return []
		}
		var dateOccurrences = [DateInRegion(firstOccurrence, region: region)]
		while true {
			let nextDate = DateInRegion(calendarObj.date(byAdding: DateComponents(day: 7), to: dateOccurrences.last!.date)!,
										region: region)
			guard nextDate < endDate else {
				break
			}
			dateOccurrences.append(nextDate)
		}
		return dateOccurrences
	}

}
