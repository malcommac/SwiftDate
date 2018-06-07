//
//  DateRepresentable.swift
//  SwiftDate
//
//  Created by Daniele Margutti on 06/06/2018.
//  Copyright © 2018 SwiftDate. All rights reserved.
//

import Foundation

public protocol DateRepresentable {

	// MARK: - Date Components
	var year: Int { get }
	
	/// Represented month
	var month: Int { get }
	
	/// Represented month name with given style.
	///
	/// - Parameter style: style in which the name must be formatted.
	/// - Returns: name of the month
	func monthName(_ style: SymbolFormatStyle) -> String
	
	/// Number of the days in the receiver.
	var monthDays: Int { get }

	/// Day unit of the receiver.
	var day: Int { get }
	
	/// Hour unit of the receiver.
	var hour: Int { get }
	
	/// Nearest rounded hour from the date
	var nearestHour: Int { get }
	
	/// Minute unit of the receiver.
	var minute: Int { get }
	
	/// Return the nearesdt minute of the receiver.
	var nearestMinute: Int { get }
	
	/// Second unit of the receiver.
	var second: Int { get }
	
	/// Nanosecond unit of the receiver.
	var nanosecond: Int { get }
	
	/// Weekday unit of the receiver.
	/// The weekday units are the numbers 1-N (where for the Gregorian calendar N=7 and 1 is Sunday).
	var weekday: Int { get }
	
	/// Name of the weekday expressed in given format style.
	///
	/// - Parameter style: style to express the value.
	/// - Returns: weekday name
	func weekdayName(_ style: SymbolFormatStyle) -> String
	
	/// Week of a year of the receiver.
	var weekOfYear: Int { get }
	
	/// Week of a month of the receiver.
	var weekOfMonth: Int { get }
	
	/// Ordinal position within the month unit of the corresponding weekday unit.
	/// For example, in the Gregorian calendar a weekday ordinal unit of 2 for a
	/// weekday unit 3 indicates "the second Tuesday in the month".
	var weekdayOrdinal: Int { get }
	
	/// Return the first day number of the week where the receiver date is located.
	var firstDayOfWeek: Int { get }
	
	/// Return the last day number of the week where the receiver date is located.
	var lastDayOfWeek: Int { get }
	
	/// Relative year for a week within a year calendar unit.
	var yearForWeekOfYear: Int { get }
	
	/// Quarter value of the receiver.
	var quarter: Int { get }
	
	/// Quarter name expressed in given format style.
	///
	/// - Parameter style: style to express the value.
	/// - Returns: quarter name
	func quarterName(_ style: SymbolFormatStyle) -> String

	/// Era value of the receiver.
	var era: Int { get }
	
	/// Name of the era expressed in given format style.
	///
	/// - Parameter style: style to express the value.
	/// - Returns: era
	func eraName(_ style: SymbolFormatStyle) -> String
	
	/// The current daylight saving time offset of the represented date.
	var DSTOffset: TimeInterval { get }
	
	// MARK: - Common Properties

	/// Absolute representation of the date
	var date: Date { get }
	
	/// Associated region
	var region: Region { get }
	
	/// Associated calendar
	var calendar: Calendar { get }

	/// Extract the date components from the date
	var dateComponents: DateComponents { get }
	
	/// Use this object to format the date object.
	/// By default this object return the `customFormatter` instance (if set) or the
	/// local thread shared formatter (via `sharedFormatter()` func; this is the most typical scenario).
	///
	/// - Parameters:
	///   - format: format string to set.
	///   - configuration: optional callback used to configure the object inline.
	/// - Returns: formatter instance
	func formatter(format: String?, configuration: ((DateFormatter) -> Void)?) -> DateFormatter
	
	/// User this object to get an DateFormatter already configured to format the data object with the associated region.
	/// By default this object return the `customFormatter` instance (if set) configured for region or the
	/// local thread shared formatter even configured for region (via `sharedFormatter()` func; this is the most typical scenario).
	///
	///   - format: format string to set.
	///   - configuration: optional callback used to configure the object inline.
	/// - Returns: formatter instance
	func formatterForRegion(format: String?, configuration: ((inout DateFormatter) -> Void)?) -> DateFormatter

	/// Set a custom formatter for this object.
	/// Typically you should not need to set a value for this property.
	/// With a `nil` value SwiftDate will uses the threa shared formatter returned by `sharedFormatter()` function.
	/// In case you need to a custom formatter instance you can override the default behaviour by setting a value here.
	var customFormatter: DateFormatter? { get set }

	/// Return a formatter instance created as singleton into the current caller's thread.
	/// This object is used for formatting when no `dateFormatter` is set for the object
	/// (this is the common scenario where you want to avoid multiple formatter instances to
	/// parse dates; instances of DateFormatter are very expensive to create and you should
	/// use a single instance in each thread to perform this kind of tasks).
	///
	/// - Returns: formatter instance
	var sharedFormatter: DateFormatter { get }

	// MARK: - Init
	
	/// Initialize a new date by parsing a string.
	///
	/// - Parameters:
	///   - string: string with the date.
	///   - format: format used to parse date. Pass `nil` to use built-in formats
	///				(if you know you should pass it to optimize the parsing process)
	///   - region: region in which the date in `string` is expressed.
	init?(_ string: String, format: String?, region: Region)
	
	/// Initialize a new date from a number of seconds since the Unix Epoch.
	///
	/// - Parameters:
	///   - interval: seconds since the Unix Epoch timestamp.
	///   - region: region in which the date must be expressed.
	init(seconds interval: TimeInterval, region: Region)
	
	/// Initialize a new date corresponding to the number of milliseconds since the Unix Epoch.
	///
	/// - Parameters:
	///   - interval: seconds since the Unix Epoch timestamp.
	///   - region: region in which the date must be expressed.
	init(milliseconds interval: Int, region: Region)

	/// Initialize a new date with the opportunity to configure single date components via builder pattern.
	/// Date is therfore expressed in passed region (`DateComponents`'s `timezone`,`calendar` and `locale` are ignored
	/// and overwritten by the region if not `nil`).
	///
	/// - Parameters:
	///   - configuration: configuration callback
	///   - region: region in which the date is expressed. Ignore to use `SwiftDate.defaultRegion`,
	///				`nil` to use `DateComponents` data.
	init?(components configuration: ((inout DateComponents) -> (Void)), region: Region?)
	
	/// Initialize a new date with time components passed.
	///
	/// - Parameters:
	///   - components: date components
	///   - region: region in which the date is expressed. Ignore to use `SwiftDate.defaultRegion`,
	///				`nil` to use `DateComponents` data.
	init?(components: DateComponents, region: Region?)
	
	
	/// Initialize a new date with given components.
	init(year: Int, month: Int, day: Int, hour: Int, minute: Int, second: Int, nanosecond: Int, region: Region)
	
	// MARK: - Conversion
	
	/// Convert a date to another region.
	///
	/// - Parameter region: destination region in which the date must be represented.
	/// - Returns: converted date
	func convert(to region: Region) -> DateInRegion
	
	// MARK: - Formatting
	
	/// Convert date to a string using passed pre-defined style.
	///
	/// - Parameter style: formatter style
	/// - Returns: string representation of the date
	func string(as style: DateToStringStyles) -> String
	
	/// Convert date to a string using custom date format.
	///
	/// - Parameter format: format of the string representation
	/// - Returns: string representation of the date
	func string(_ format: String) -> String
	
}

public extension DateRepresentable {

	//MARK: - Common Properties
	
	public var calendar: Calendar {
		return self.region.calendar
	}
	
	//MARK: - Date Components Properties
	
	public var year: Int {
		return self.dateComponents.year!
	}
	
	public var month: Int {
		return self.dateComponents.month!
	}
	
	public var monthDays: Int {
		return self.calendar.range(of: .day, in: .month, for: self.date)!.count
	}
	
	func monthName(_ style: SymbolFormatStyle) -> String {
		let formatter = self.formatter(format: nil)
		let idx = (self.month - 1)
		switch style {
		case .default:				return formatter.monthSymbols[idx]
		case .defaultStandalone:	return formatter.standaloneMonthSymbols[idx]
		case .short:				return formatter.shortMonthSymbols[idx]
		case .standaloneShort:		return formatter.shortStandaloneMonthSymbols[idx]
		case .veryShort:			return formatter.veryShortMonthSymbols[idx]
		case .standaloneVeryShort:	return formatter.veryShortStandaloneMonthSymbols[idx]
		}
	}
	
	public var day: Int {
		return self.dateComponents.day!
	}
	
	public var hour: Int {
		return self.dateComponents.hour!
	}
	
	public var nearestHour: Int {
		return Int(self.date.addingTimeInterval(30.minutes.timeInterval).hour)
	}
	
	public var minute: Int {
		return self.dateComponents.minute!
	}
	
	public var nearestMinute: Int {
	return 0
		//	return (self.offset(.second, 30)).minute
	}
	
	public var second: Int {
		return self.dateComponents.second!
	}
	
	public var nanosecond: Int {
		return self.dateComponents.nanosecond!
	}
	
	public var weekday: Int {
		return self.dateComponents.weekday!
	}
	
	func weekdayName(_ style: SymbolFormatStyle) -> String {
		let formatter = self.formatter(format: nil)
		let idx = (self.weekday - 1)
		switch style {
		case .default:				return formatter.weekdaySymbols[idx]
		case .defaultStandalone:	return formatter.standaloneWeekdaySymbols[idx]
		case .short:				return formatter.shortWeekdaySymbols[idx]
		case .standaloneShort:		return formatter.shortStandaloneWeekdaySymbols[idx]
		case .veryShort:			return formatter.veryShortWeekdaySymbols[idx]
		case .standaloneVeryShort:	return formatter.veryShortStandaloneWeekdaySymbols[idx]
		}
	}
	
	public var weekOfYear: Int {
		return self.dateComponents.weekOfYear!
	}
	
	public var weekOfMonth: Int {
		return self.dateComponents.weekOfMonth!
	}
	
	public var weekdayOrdinal: Int {
		return self.dateComponents.weekdayOrdinal!
	}
	
	public var yearForWeekOfYear: Int {
		return self.dateComponents.yearForWeekOfYear!
	}
	
	public var firstDayOfWeek: Int {
		return self.date.dateAt(.startOfWeek).day
	}
	
	public var lastDayOfWeek: Int {
		return self.date.dateAt(.endOfWeek).day
	}

	public var quarter: Int {
		return self.dateComponents.quarter!
	}
	
	func quarterName(_ style: SymbolFormatStyle) -> String {
		let formatter = self.formatter(format: nil)
		let idx = (self.quarter - 1)
		switch style {
		case .default:								return formatter.quarterSymbols[idx]
		case .defaultStandalone:					return formatter.standaloneQuarterSymbols[idx]
		case .short,.veryShort:						return formatter.shortQuarterSymbols[idx]
		case .standaloneShort,.standaloneVeryShort:	return formatter.shortStandaloneQuarterSymbols[idx]
		}
	}
	
	var era: Int {
		return self.dateComponents.era!
	}
	
	func eraName(_ style: SymbolFormatStyle) -> String {
		let formatter = self.formatter(format: nil)
		let idx = (self.era - 1)
		switch style {
		case .default,.defaultStandalone:								return formatter.longEraSymbols[idx]
		case .short,.standaloneShort,.veryShort,.standaloneVeryShort:	return formatter.eraSymbols[idx]
		}
	}
	
	public var DSTOffset: TimeInterval {
		return self.region.timezone.daylightSavingTimeOffset(for: self.date)
	}
	
	//MARK: - Date Formatters
	
	func formatter(format: String? = nil, configuration: ((DateFormatter) -> Void)? = nil) -> DateFormatter {
		let formatter = (self.customFormatter ?? self.sharedFormatter)
		if let dFormat = format {
			formatter.dateFormat = dFormat
		}
		configuration?(formatter)
		return formatter
	}
	
	func formatterForRegion(format: String? = nil, configuration: ((inout DateFormatter) -> Void)? = nil) -> DateFormatter {
		var formatter = self.formatter(format: format, configuration: {
			$0.timeZone = self.region.timezone
			$0.calendar = self.calendar
			$0.locale = self.region.locale
		})
		configuration?(&formatter)
		return formatter
	}

	public var sharedFormatter: DateFormatter {
		return DateFormatter.sharedFormatter(forRegion: self.region)
	}
	
	public func string(as style: DateToStringStyles) -> String {
		return style.toString(self)
	}
	
	public func string(_ format: String) -> String {
		return DateToStringStyles.custom(format).toString(self)
	}
	
	// MARK: - Conversion
	
	public func convert(to region: Region) -> DateInRegion {
		return DateInRegion(self.date, region: region)
	}

	
}
