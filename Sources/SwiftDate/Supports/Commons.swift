//
//  DateFormatter.swift
//  SwiftDate
//
//  Created by Daniele Margutti on 06/06/2018.
//  Copyright © 2018 SwiftDate. All rights reserved.
//
import Foundation

public extension DateFormatter {

	/// Return the local thread shared formatter initialized with the configuration of the region passed.
	///
	/// - Parameters:
	///   - region: region used to pre-configure the cell.
	///   - format: optional format used to set the `dateFormat` property.
	/// - Returns: date formatter instance
	public static func sharedFormatter(forRegion region: Region?, format: String? = nil) -> DateFormatter {
		let name = "SwiftDate_\(NSStringFromClass(DateFormatter.self))"
		let formatter: DateFormatter = threadSharedObject(key: name, create: { return DateFormatter() })
		if let region = region {
			formatter.timeZone = region.timeZone
			formatter.calendar = region.calendar
			formatter.locale = region.locale
		}
		formatter.dateFormat = (format ?? DateFormats.iso8601)
		return formatter
	}

	/// Returned number formatter instance shared along calling thread to format ordinal numbers.
	///
	/// - Parameter locale: locale to set
	/// - Returns: number formatter instance
	@available(iOS 9.0, macOS 10.11, *)
	public static func sharedOrdinalNumberFormatter(locale: LocaleConvertible) -> NumberFormatter {
		var formatter: NumberFormatter?
		let name = "SwiftDate_\(NSStringFromClass(NumberFormatter.self))"
		formatter = threadSharedObject(key: name, create: { return NumberFormatter() })
		formatter!.numberStyle = .ordinal
		formatter!.locale = locale.toLocale()
		return formatter!
	}

}

/// This function create (if necessary) and return a thread singleton instance of the
/// object you want.
///
/// - Parameters:
///   - key: identifier of the object.
///   - create: create routine used the first time you are about to create the object in thread.
/// - Returns: instance of the object for caller's thread.
internal func threadSharedObject<T: AnyObject>(key: String, create: () -> T) -> T {
	if let cachedObj = Thread.current.threadDictionary[key] as? T {
		return cachedObj
	} else {
		let newObject = create()
		Thread.current.threadDictionary[key] = newObject
		return newObject
	}
}

/// Style used to format month, weekday, quarter symbols.
/// Stand-alone properties are for use in places like calendar headers.
/// Non-stand-alone properties are for use in context (for example, “Saturday, November 12th”).
///
/// - `default`: Default formatter (ie. `4th quarter` for quarter, `April` for months and `Wednesday` for weekdays)
/// - defaultStandalone:  See `default`; See `short`; stand-alone properties are for use in places like calendar headers.
/// - short: Short symbols (ie. `Jun` for months, `Fri` for weekdays, `Q1` for quarters).
/// - veryShort: Very short symbols (ie. `J` for months, `F` for weekdays, for quarter it just return `short` variant).
/// - standaloneShort: See `short`; stand-alone properties are for use in places like calendar headers.
/// - standaloneVeryShort: See `veryShort`; stand-alone properties are for use in places like calendar headers.
public enum SymbolFormatStyle {
	case `default`
	case defaultStandalone
	case short
	case veryShort
	case standaloneShort
	case standaloneVeryShort
}

/// Encapsulate the logic to use date format strings
public struct DateFormats {

	/// This is the built-in list of all supported formats for auto-parsing of a string to a date.
	internal static let builtInAutoFormat: [String] =  [
		DateFormats.iso8601,
		"yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'",
		"yyyy'-'MM'-'dd'T'HH':'mm':'ss'.'SSS'Z'",
		"yyyy-MM-dd'T'HH:mm:ss.SSSZ",
		"yyyy-MM-dd HH:mm:ss",
		"yyyy-MM-dd HH:mm",
		"yyyy-MM-dd",
		"h:mm:ss A",
		"h:mm A",
		"MM/dd/yyyy",
		"MMMM d, yyyy",
		"MMMM d, yyyy LT",
		"dddd, MMMM D, yyyy LT",
		"yyyyyy-MM-dd",
		"yyyy-MM-dd",
		"GGGG-[W]WW-E",
		"GGGG-[W]WW",
		"yyyy-ddd",
		"HH:mm:ss.SSSS",
		"HH:mm:ss",
		"HH:mm",
		"HH"
	]

	/// This is the ordered list of all formats SwiftDate can use in order to attempt parsing a passaed
	/// date expressed as string. Evaluation is made in order; you can add or remove new formats as you wish.
	/// In order to reset the list call `resetAutoFormats()` function.
	public static var autoFormats: [String] = DateFormats.builtInAutoFormat

	/// Default ISO8601 format string
	public static let iso8601: String = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"

	/// Extended format
	public static let extended: String = "eee dd-MMM-yyyy GG HH:mm:ss.SSS zzz"

	/// The Alternative RSS formatted date "d MMM yyyy HH:mm:ss ZZZ" i.e. "09 Sep 2011 15:26:08 +0200"
	public static let altRSS: String = "d MMM yyyy HH:mm:ss ZZZ"

	/// The RSS formatted date "EEE, d MMM yyyy HH:mm:ss ZZZ" i.e. "Fri, 09 Sep 2011 15:26:08 +0200"
	public static let rss: String = "EEE, d MMM yyyy HH:mm:ss ZZZ"

	/// The http header formatted date "EEE, dd MM yyyy HH:mm:ss ZZZ" i.e. "Tue, 15 Nov 1994 12:45:26 GMT"
	public static let httpHeader: String = "EEE, dd MM yyyy HH:mm:ss ZZZ"

	/// A generic standard format date i.e. "EEE MMM dd HH:mm:ss Z yyyy"
	public static let standard: String = "EEE MMM dd HH:mm:ss Z yyyy"

	/// SQL date format
	public static let sql: String = "yyyy-MM-dd'T'HH:mm:ss.SSSX"

	/// Reset the list of auto formats to the initial settings.
	public static func resetAutoFormats() {
		autoFormats = DateFormats.builtInAutoFormat
	}

	/// Parse a new string optionally passing the format in which is encoded. If no format is passed
	/// an attempt is made by cycling all the formats set in `autoFormats` property.
	///
	/// - Parameters:
	///   - string: date expressed as string.
	///   - suggestedFormat: optional format of the date expressed by the string (set it if you can in order to optimize the parse task).
	///   - region: region in which the date is expressed.
	/// - Returns: parsed absolute `Date`, `nil` if parse fails.
	public static func parse(string: String, format: String?, region: Region) -> Date? {
		let formats = (format != nil ? [format!] : DateFormats.autoFormats)
		return DateFormats.parse(string: string, formats: formats, region: region)
	}

	public static func parse(string: String, formats: [String], region: Region) -> Date? {
		let formatter = DateFormatter.sharedFormatter(forRegion: region)

		var parsedDate: Date?
		for format in formats {
			formatter.dateFormat = format
			formatter.locale = region.locale
			if let date = formatter.date(from: string) {
				parsedDate = date
				break
			}
		}
		return parsedDate
	}
}

// MARK: - Calendar Extension

public extension Calendar.Component {

	internal static func toSet(_ src: [Calendar.Component]) -> Set<Calendar.Component> {
		var l: Set<Calendar.Component> = []
		src.forEach { l.insert($0) }
		return l
	}

	internal var nsCalendarUnit: NSCalendar.Unit {
		switch self {
		case .era: return NSCalendar.Unit.era
		case .year: return NSCalendar.Unit.year
		case .month: return NSCalendar.Unit.month
		case .day: return NSCalendar.Unit.day
		case .hour: return NSCalendar.Unit.hour
		case .minute: return NSCalendar.Unit.minute
		case .second: return NSCalendar.Unit.second
		case .weekday: return NSCalendar.Unit.weekday
		case .weekdayOrdinal: return NSCalendar.Unit.weekdayOrdinal
		case .quarter: return NSCalendar.Unit.quarter
		case .weekOfMonth: return NSCalendar.Unit.weekOfMonth
		case .weekOfYear: return NSCalendar.Unit.weekOfYear
		case .yearForWeekOfYear: return NSCalendar.Unit.yearForWeekOfYear
		case .nanosecond: return NSCalendar.Unit.nanosecond
		case .calendar: return NSCalendar.Unit.calendar
		case .timeZone: return NSCalendar.Unit.timeZone
		}
	}
}

/// Rounding mode for dates.
/// Round off/up (ceil) or down (floor) target date.
public enum RoundDateMode {
	case to5Mins
	case to10Mins
	case to30Mins
	case toMins(_: Int)
	case toCeil5Mins
	case toCeil10Mins
	case toCeil30Mins
	case toCeilMins(_: Int)
	case toFloor5Mins
	case toFloor10Mins
	case toFloor30Mins
	case toFloorMins(_: Int)
}

/// Related type enum to get derivated date from a receiver date.
public enum DateRelatedType {
	case startOfDay
	case endOfDay
	case startOfWeek
	case endOfWeek
	case startOfMonth
	case endOfMonth
	case tomorrow
	case tomorrowAtStart
	case yesterday
	case yesterdayAtStart
	case nearestMinute(minute:Int)
	case nearestHour(hour:Int)
	case nextWeekday(_: WeekDay)
	case nextDSTDate
	case prevMonth
	case nextMonth
	case prevWeek
	case nextWeek
	case nextYear
	case prevYear
	case nextDSTTransition
}

public struct TimeCalculationOptions {

	/// Specifies the technique the search algorithm uses to find result
	public var matchingPolicy: Calendar.MatchingPolicy

	/// Specifies the behavior when multiple matches are found
	public var repeatedTimePolicy: Calendar.RepeatedTimePolicy

	/// Specifies the direction in time to search
	public var direction: Calendar.SearchDirection

	public init(matching: Calendar.MatchingPolicy = .nextTime,
				timePolicy: Calendar.RepeatedTimePolicy = .first,
				direction: Calendar.SearchDirection = .forward) {
		self.matchingPolicy = matching
		self.repeatedTimePolicy = timePolicy
		self.direction = direction
	}
}

// MARK: - compactMap for Swift 4.0 (not necessary > 4.0)

#if swift(>=4.1)
#else
	extension Collection {
		func compactMap<ElementOfResult>(
			_ transform: (Element) throws -> ElementOfResult?
			) rethrows -> [ElementOfResult] {
			return try flatMap(transform)
		}
	}
#endif
