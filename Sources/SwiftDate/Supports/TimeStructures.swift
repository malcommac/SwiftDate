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

// MARK: - Weekday

/// This define the weekdays for some functions.
public enum WeekDay: Int {
	case sunday = 1, monday, tuesday, wednesday, thursday, friday, saturday

	/// Returns the name of the day given a specific locale.
	/// For example, for the `Friday` enum value, the en_AU locale would return "Friday" and fr_FR would return "samedi"
	///
	/// - Parameter locale: locale of the output, omit to use the `defaultRegion`'s locale.
	/// - Returns: display name
	public func name(style: SymbolFormatStyle = .`default`, locale: LocaleConvertible = SwiftDate.defaultRegion.locale) -> String {
		let region = Region(calendar: SwiftDate.defaultRegion.calendar, zone: SwiftDate.defaultRegion.timeZone, locale: locale)
		let formatter = DateFormatter.sharedFormatter(forRegion: region, format: nil)

		let idx = (self.rawValue - 1)
		switch style {
		case .default:				return formatter.weekdaySymbols[idx]
		case .defaultStandalone:	return formatter.standaloneWeekdaySymbols[idx]
		case .short:				return formatter.shortWeekdaySymbols[idx]
		case .standaloneShort:		return formatter.shortStandaloneWeekdaySymbols[idx]
		case .veryShort:			return formatter.veryShortWeekdaySymbols[idx]
		case .standaloneVeryShort:	return formatter.veryShortStandaloneWeekdaySymbols[idx]
		}
	}

	/// Adds a number of days to the current weekday and returns the new weekday.
	///
	/// - Parameter months: number of months to add
	/// - Returns: new month.
	public func add(days: Int) -> WeekDay {
		let normalized = days % 7
		return WeekDay(rawValue: ((self.rawValue + normalized + 7 - 1) % 7) + 1)!
	}

	/// Subtracts a number of days from the current weekday and returns the new weekday.
	///
	/// - Parameter months: number of days to subtract. May be negative, in which case it will be added
	/// - Returns: new weekday.
	public func subtract(days: Int) -> WeekDay {
		return add(days: -(days % 7))
	}

}

// MARK: - Year

public struct Year: CustomStringConvertible, Equatable {
	let year: Int

	public var description: String {
		return "\(self.year)"
	}

	/// Constructs a `Year` from the passed value.
	///
	/// - Parameter year: year value. Can be negative.
	public init(_ year: Int) {
		self.year = year
	}

	/// Returns whether this year is a leap year
	///
	/// - Returns: A boolean indicating whether this year is a leap year
	public func isLeap() -> Bool {
		return ((year & 3) == 0) && ((year % 100) != 0 || (year % 400) == 0)
	}

	/// Returns the number of days in this year
	///
	/// - Returns: The number of days in this year
	public func numberOfDays() -> Int {
		return self.isLeap() ? 366 : 365
	}

}

// MARK: - Month

/// Defines months in a year
public enum Month: Int, CustomStringConvertible, Equatable {
	case january = 0, february, march, april, may, june, july, august, september, october, november, december

	public var description: String {
		return self.name()
	}

	/// Returns the name of the month given a specific locale.
	/// For example, for the `January` enum value, the en_AU locale would return "January" and fr_FR would return "janvier"
	///
	/// - Parameter locale: locale of the output, omit to use the `defaultRegion`'s locale.
	/// - Returns: display name
	public func name(style: SymbolFormatStyle = .`default`, locale: LocaleConvertible = SwiftDate.defaultRegion.locale) -> String {
		let region = Region(calendar: SwiftDate.defaultRegion.calendar, zone: SwiftDate.defaultRegion.timeZone, locale: locale)
		let formatter = DateFormatter.sharedFormatter(forRegion: region, format: nil)
		switch style {
		case .default:				return formatter.monthSymbols[self.rawValue]
		case .defaultStandalone:	return formatter.standaloneMonthSymbols[self.rawValue]
		case .short:				return formatter.shortMonthSymbols[self.rawValue]
		case .standaloneShort:		return formatter.shortStandaloneMonthSymbols[self.rawValue]
		case .veryShort:			return formatter.veryShortMonthSymbols[self.rawValue]
		case .standaloneVeryShort:	return formatter.veryShortStandaloneMonthSymbols[self.rawValue]
		}
	}

	/// Adds a number of months to the current month and returns the new month.
	///
	/// - Parameter months: number of months to add
	/// - Returns: new month.
	public func add(months: Int) -> Month {
		let normalized = months % 12
		return Month(rawValue: (self.rawValue + normalized + 12) % 12)!
	}

	/// Subtracts a number of months from the current month and returns the new month.
	///
	/// - Parameter months: number of months to subtract. May be negative, in which case it will be added
	/// - Returns: new month.
	public func subtract(months: Int) -> Month {
		return add(months: -(months % 12))
	}

	/// Returns the number of days in a this month for a given year
	///
	/// - Parameter year: reference year.
	/// - Returns: The number of days in this month.
	public func numberOfDays(year: Int) -> Int {
		switch self {
		case .february:
			return Year(year).isLeap() ? 29 : 28
		case .april, .june, .september, .november:
			return 30
		default:
			return 31
		}
	}

}
