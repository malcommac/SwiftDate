//
//  SwiftDate
//  Parse, validate, manipulate, and display dates, time and timezones in Swift
//
//  Created by Daniele Margutti
//   - Web: https://www.danielemargutti.com
//   - Twitter: https://twitter.com/danielemargutti
//   - Mail: hello@danielemargutti.com
//
//  Copyright © 2019 Daniele Margutti. Licensed under MIT License.
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

	/// Day of year unit of the receiver
	var dayOfYear: Int { get }

	/// The number of day in ordinal style format for the receiver in current locale.
	/// For example, in the en_US locale, the number 3 is represented as 3rd;
	/// in the fr_FR locale, the number 3 is represented as 3e.
	@available(iOS 9.0, macOS 10.11, *)
	var ordinalDay: String { get }

	/// Hour unit of the receiver.
	var hour: Int { get }

	/// Nearest rounded hour from the date
	var nearestHour: Int { get }

	/// Minute unit of the receiver.
	var minute: Int { get }

	/// Second unit of the receiver.
	var second: Int { get }

	/// Nanosecond unit of the receiver.
	var nanosecond: Int { get }

	/// Milliseconds in day of the receiver
	/// This field behaves exactly like a composite of all time-related fields, not including the zone fields.
	/// As such, it also reflects discontinuities of those fields on DST transition days.
	/// On a day of DST onset, it will jump forward. On a day of DST cessation, it will jump backward.
	/// This reflects the fact that is must be combined with the offset field to obtain a unique local time value.
	var msInDay: Int { get }

	/// Weekday unit of the receiver.
	/// The weekday units are the numbers 1-N (where for the Gregorian calendar N=7 and 1 is Sunday).
	var weekday: Int { get }

	/// Name of the weekday expressed in given format style.
	///
	/// - Parameter style: style to express the value.
	/// - Parameter locale: locale to use; ignore it to use default's region locale.
	/// - Returns: weekday name
	func weekdayName(_ style: SymbolFormatStyle, locale: LocaleConvertible?) -> String

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
	/// - Parameter locale: locale to use; ignore it to use default's region locale.
	/// - Returns: quarter name
	func quarterName(_ style: SymbolFormatStyle, locale: LocaleConvertible?) -> String

	/// Era value of the receiver.
	var era: Int { get }

	/// Name of the era expressed in given format style.
	///
	/// - Parameter style: style to express the value.
	/// - Parameter locale: locale to use; ignore it to use default's region locale.
	/// - Returns: era
	func eraName(_ style: SymbolFormatStyle, locale: LocaleConvertible?) -> String

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

	/// Returns whether the given date is in today as boolean.
	var isToday: Bool { get }

	/// Returns whether the given date is in yesterday.
	var isYesterday: Bool { get }

	/// Returns whether the given date is in tomorrow.
	var isTomorrow: Bool { get }

	/// Returns whether the given date is in the weekend.
	var isInWeekend: Bool { get }

	/// Return true if given date represent a passed date
	var isInPast: Bool { get }

	/// Return true if given date represent a future date
	var isInFuture: Bool { get }

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
	init?(components configuration: ((inout DateComponents) -> Void), region: Region?)

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
	func convertTo(region: Region) -> DateInRegion

	// MARK: - To String Formatting

	/// Convert date to a string using passed pre-defined style.
	///
	/// - Parameter style: formatter style, `nil` to use `standard` style
	/// - Returns: string representation of the date
	func toString(_ style: DateToStringStyles?) -> String

	/// Convert date to a string using custom date format.
	///
	/// - Parameters:
	/// 	- format: format of the string representation
	///		- locale: locale to fix a custom locale, `nil` to use associated region's locale
	/// - Returns: string representation of the date
	func toFormat(_ format: String, locale: LocaleConvertible?) -> String

	/// Convert a date to a string representation relative to another reference date (or current
	/// if not passed).
	///
	/// - Parameters:
	///   - since: reference date, if `nil` current is used.
	///   - style: style to use to format relative date.
	///	  - locale: force locale print, `nil` to use the date own region's locale
	/// - Returns: string representation of the date.
	func toRelative(since: DateInRegion?, style: RelativeFormatter.Style?, locale: LocaleConvertible?) -> String

	/// Return ISO8601 representation of the date
	///
	/// - Parameter options: optional options, if nil extended iso format is used
	func toISO(_ options: ISOFormatter.Options?) -> String

	/// Return DOTNET compatible representation of the date.
	///
	/// - Returns: string representation of the date
	func toDotNET() -> String

	/// Return SQL compatible representation of the date.
	///
	/// - Returns: string represenation of the date
	func toSQL() -> String

	/// Return RSS compatible representation of the date
	///
	/// - Parameter alt: `true` to return altRSS version, `false` to return the standard RSS representation
	/// - Returns: string representation of the date
	func toRSS(alt: Bool) -> String

	// MARK: - Extract Components

	/// Extract time components for elapsed interval between the receiver date
	/// and a reference date.
	///
	/// - Parameters:
	///   - units: units to extract.
	///   - refDate: reference date
	/// - Returns: extracted time units
	func toUnits(_ units: Set<Calendar.Component>, to refDate: DateRepresentable) -> [Calendar.Component: Int]

	/// Extract time unit component from given date.
	///
	/// - Parameters:
	///   - unit: time component to extract
	///   - refDate: reference date
	/// - Returns: extracted time unit value
	func toUnit(_ unit: Calendar.Component, to refDate: DateRepresentable) -> Int

}

public extension DateRepresentable {

	// MARK: - Common Properties

	var calendar: Calendar {
		return region.calendar
	}

	// MARK: - Date Components Properties

	var year: Int {
		return dateComponents.year!
	}

	var month: Int {
		return dateComponents.month!
	}

	var monthDays: Int {
		return calendar.range(of: .day, in: .month, for: date)!.count
	}

	func monthName(_ style: SymbolFormatStyle) -> String {
		let formatter = self.formatter(format: nil)
		let idx = (month - 1)
		switch style {
		case .default:				return formatter.monthSymbols[idx]
		case .defaultStandalone:	return formatter.standaloneMonthSymbols[idx]
		case .short:				return formatter.shortMonthSymbols[idx]
		case .standaloneShort:		return formatter.shortStandaloneMonthSymbols[idx]
		case .veryShort:			return formatter.veryShortMonthSymbols[idx]
		case .standaloneVeryShort:	return formatter.veryShortStandaloneMonthSymbols[idx]
		}
	}

	var day: Int {
		return dateComponents.day!
	}

	var dayOfYear: Int {
		return calendar.ordinality(of: .day, in: .year, for: date)!
	}

	@available(iOS 9.0, macOS 10.11, *)
	var ordinalDay: String {
		let day = self.day
		return DateFormatter.sharedOrdinalNumberFormatter(locale: region.locale).string(from: day as NSNumber) ?? "\(day)"
	}

	var hour: Int {
		return dateComponents.hour!
	}

	var nearestHour: Int {
		let newDate = (date + (date.minute >= 30 ? 60 - date.minute : -date.minute).minutes)
		return newDate.in(region: region).hour
	}

	var minute: Int {
		return dateComponents.minute!
	}

	var second: Int {
		return dateComponents.second!
	}

	var nanosecond: Int {
		return dateComponents.nanosecond!
	}

	var msInDay: Int {
		return (calendar.ordinality(of: .second, in: .day, for: date)! * 1000)
	}

	var weekday: Int {
		return dateComponents.weekday!
	}

	func weekdayName(_ style: SymbolFormatStyle, locale: LocaleConvertible? = nil) -> String {
		let formatter = self.formatter(format: nil) {
			$0.locale = (locale ?? self.region.locale).toLocale()
		}
		let idx = (weekday - 1)
		switch style {
		case .default:				return formatter.weekdaySymbols[idx]
		case .defaultStandalone:	return formatter.standaloneWeekdaySymbols[idx]
		case .short:				return formatter.shortWeekdaySymbols[idx]
		case .standaloneShort:		return formatter.shortStandaloneWeekdaySymbols[idx]
		case .veryShort:			return formatter.veryShortWeekdaySymbols[idx]
		case .standaloneVeryShort:	return formatter.veryShortStandaloneWeekdaySymbols[idx]
		}
	}

	var weekOfYear: Int {
		return dateComponents.weekOfYear!
	}

	var weekOfMonth: Int {
		return dateComponents.weekOfMonth!
	}

	var weekdayOrdinal: Int {
		return dateComponents.weekdayOrdinal!
	}

	var yearForWeekOfYear: Int {
		return dateComponents.yearForWeekOfYear!
	}

	var firstDayOfWeek: Int {
		return date.dateAt(.startOfWeek).day
	}

	var lastDayOfWeek: Int {
		return date.dateAt(.endOfWeek).day
	}

	var quarter: Int {
		let monthsInQuarter = Double(Calendar.current.monthSymbols.count) / 4.0
		return Int(ceil( Double(month) / monthsInQuarter))
	}

	var isToday: Bool {
		return calendar.isDateInToday(date)
	}

	var isYesterday: Bool {
		return calendar.isDateInYesterday(date)
	}

	var isTomorrow: Bool {
		return calendar.isDateInTomorrow(date)
	}

	var isInWeekend: Bool {
		return calendar.isDateInWeekend(date)
	}

	var isInPast: Bool {
		return date < Date()
	}

	var isInFuture: Bool {
		return date > Date()
	}

	func quarterName(_ style: SymbolFormatStyle, locale: LocaleConvertible? = nil) -> String {
		let formatter = self.formatter(format: nil) {
			$0.locale = (locale ?? self.region.locale).toLocale()
		}
		let idx = (quarter - 1)
		switch style {
		case .default:									return formatter.quarterSymbols[idx]
		case .defaultStandalone:						return formatter.standaloneQuarterSymbols[idx]
		case .short, .veryShort:						return formatter.shortQuarterSymbols[idx]
		case .standaloneShort, .standaloneVeryShort:	return formatter.shortStandaloneQuarterSymbols[idx]
		}
	}

	var era: Int {
		return dateComponents.era!
	}

	func eraName(_ style: SymbolFormatStyle, locale: LocaleConvertible? = nil) -> String {
		let formatter = self.formatter(format: nil) {
			$0.locale = (locale ?? self.region.locale).toLocale()
		}
		let idx = (era - 1)
		switch style {
		case .default, .defaultStandalone:								return formatter.longEraSymbols[idx]
		case .short, .standaloneShort, .veryShort, .standaloneVeryShort:	return formatter.eraSymbols[idx]
		}
	}

	var DSTOffset: TimeInterval {
		return region.timeZone.daylightSavingTimeOffset(for: date)
	}

	// MARK: - Date Formatters

	func formatter(format: String? = nil, configuration: ((DateFormatter) -> Void)? = nil) -> DateFormatter {
		let formatter = (customFormatter ?? sharedFormatter)
		if let dFormat = format {
			formatter.dateFormat = dFormat
		}
		configuration?(formatter)
		return formatter
	}

	func formatterForRegion(format: String? = nil, configuration: ((inout DateFormatter) -> Void)? = nil) -> DateFormatter {
		var formatter = self.formatter(format: format, configuration: {
            $0.timeZone = self.region.timeZone
			$0.calendar = self.calendar
			$0.locale = self.region.locale
		})
		configuration?(&formatter)
		return formatter
	}

	var sharedFormatter: DateFormatter {
		return DateFormatter.sharedFormatter(forRegion: region)
	}

	func toString(_ style: DateToStringStyles? = nil) -> String {
		guard let style = style else {
			return DateToStringStyles.standard.toString(self)
		}
		return style.toString(self)
	}

	func toFormat(_ format: String, locale: LocaleConvertible? = nil) -> String {
		guard let fixedLocale = locale else {
			return DateToStringStyles.custom(format).toString(self)
		}
		let fixedRegion = Region(calendar: region.calendar, zone: region.timeZone, locale: fixedLocale)
		let fixedDate = DateInRegion(date.date, region: fixedRegion)
		return DateToStringStyles.custom(format).toString(fixedDate)
	}

	func toRelative(since: DateInRegion? = nil, style: RelativeFormatter.Style? = nil, locale: LocaleConvertible? = nil) -> String {
		return RelativeFormatter.format(date: self, to: since, style: style, locale: locale?.toLocale())
	}

	func toISO(_ options: ISOFormatter.Options? = nil) -> String {
		return DateToStringStyles.iso( (options ?? ISOFormatter.Options([.withInternetDateTime])) ).toString(self)
	}

	func toDotNET() -> String {
		return DOTNETFormatter.format(self, options: nil)
	}

	func toRSS(alt: Bool) -> String {
		switch alt {
		case true: 		return DateToStringStyles.altRSS.toString(self)
		case false: 	return DateToStringStyles.rss.toString(self)
		}
	}

	func toSQL() -> String {
		return DateToStringStyles.sql.toString(self)
	}

	// MARK: - Conversion

	func convertTo(region: Region) -> DateInRegion {
		return DateInRegion(date, region: region)
	}

	// MARK: - Extract Time Components

	func toUnits(_ units: Set<Calendar.Component>, to refDate: DateRepresentable) -> [Calendar.Component: Int] {
		let cal = region.calendar
		let components = cal.dateComponents(units, from: date, to: refDate.date)
		return components.toDict()
	}

	func toUnit(_ unit: Calendar.Component, to refDate: DateRepresentable) -> Int {
		let cal = region.calendar
		let components = cal.dateComponents([unit], from: date, to: refDate.date)
		return components.value(for: unit)!
	}

}
