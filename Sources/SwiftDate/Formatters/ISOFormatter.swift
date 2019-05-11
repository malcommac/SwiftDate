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

public class ISOFormatter: DateToStringTrasformable {

	public struct Options: OptionSet {
		public let rawValue: Int

		public init(rawValue: Int) {
			self.rawValue = rawValue
		}

		/// The date representation includes the year. The format for year is inferred based on the other specified options.
		/// - If withWeekOfYear is specified, YYYY is used.
		/// - Otherwise, yyyy is used.
		public static let withYear = ISOFormatter.Options(rawValue: 1 << 0)

		/// The date representation includes the month. The format for month is MM.
		public static let withMonth = ISOFormatter.Options(rawValue: 1 << 1)

		/// The date representation includes the week of the year.
		/// The format for week of year is ww, including the W prefix.
		public static let withWeekOfYear = ISOFormatter.Options(rawValue: 1 << 2)

		/// The date representation includes the day. The format for day is inferred based on provided options:
		/// - If withMonth is specified, dd is used.
		/// - If withWeekOfYear is specified, ee is used.
		/// - Otherwise, DDD is used.
		public static let withDay = ISOFormatter.Options(rawValue: 1 << 3)

		/// The date representation includes the time. The format for time is HH:mm:ss.
		public static let withTime = ISOFormatter.Options(rawValue: 1 << 4)

		/// The date representation includes the timezone. The format for timezone is ZZZZZ.
		public static let withTimeZone = ISOFormatter.Options(rawValue: 1 << 5)

		/// The date representation uses a space ( ) instead of T between the date and time.
		public static let withSpaceBetweenDateAndTime = ISOFormatter.Options(rawValue: 1 << 6)

		/// The date representation uses the dash separator (-) in the date.
		public static let withDashSeparatorInDate = ISOFormatter.Options(rawValue: 1 << 7)

		/// The date representation uses the colon separator (:) in the time.
		public static let withFullDate = ISOFormatter.Options(rawValue: 1 << 8)

		/// The date representation includes the hour, minute, and second.
		public static let withFullTime = ISOFormatter.Options(rawValue: 1 << 9)

		/// The format used for internet date times, according to the RFC 3339 standard.
		/// Equivalent to specifying withFullDate, withFullTime, withDashSeparatorInDate,
		/// withColonSeparatorInTime, and withColonSeparatorInTimeZone.
		public static let withInternetDateTime = ISOFormatter.Options(rawValue: 1 << 10)

		// The format used for internet date times; it's similar to .withInternetDateTime
		// but include milliseconds ('yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ').
		public static let withInternetDateTimeExtended = ISOFormatter.Options(rawValue: 1 << 11)

		/// Print the timezone in format `ZZZ` instead of `ZZZZZ`
		/// An example outout maybe be `+0200` instead of `+02:00`.
		public static let withoutTZSeparators = ISOFormatter.Options(rawValue: 1 << 12)

		/// Evaluate formatting string
		public var dateFormat: String {
			if contains(.withInternetDateTimeExtended) || contains(.withoutTZSeparators) {
				if contains(.withoutTZSeparators) {
					return "yyyy-MM-dd'T'HH:mm:ss.SSSZZZ"
				}
				return "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
			}

			if contains(.withInternetDateTime) {
				if contains(.withoutTZSeparators) {
					return "yyyy-MM-dd'T'HH:mm:ss.SSSZZZ"
				}
				return "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
			}

			var format: String = ""
			if contains(.withFullDate) {
				format += "yyyy-MM-dd"
			} else {
				if contains(.withYear) {
					if contains(.withWeekOfYear) {
						format += "YYYY"
					} else if contains(.withMonth) || contains(.withDay) {
						format += "yyyy"
					} else {
						// not valid
					}
				}
				if contains(.withMonth) {
					if contains(.withYear) || contains(.withDay) || contains(.withWeekOfYear) {
						format += "MM"
					} else {
						// not valid
					}
				}
				if contains(.withWeekOfYear) {
					if contains(.withDay) {
						format += "'W'ww"
					} else {
						if contains(.withYear) || contains(.withMonth) {
							if contains(.withDashSeparatorInDate) {
								format += "-'W'ww"
							} else {
								format += "'W'ww"
							}
						} else {
							// not valid
						}
					}
				}

				if contains(.withDay) {
					if contains(.withWeekOfYear) {
						format += "FF"
					} else if contains(.withMonth) {
						format += "dd"
					} else if contains(.withYear) {
						if contains(.withDashSeparatorInDate) {
							format += "-DDD"
						} else {
							format += "DDD"
						}
					} else {
						// not valid
					}
				}
			}

			let hasDate = (contains(.withFullDate) || contains(.withMonth) || contains(.withDay) || contains(.withWeekOfYear) || contains(.withYear))
			if hasDate && (contains(.withFullTime) || contains(.withTimeZone) || contains(.withTime)) {
				if contains(.withSpaceBetweenDateAndTime) {
					format += " "
				} else {
					format += "'T'"
				}
			}

			if contains(.withFullTime) {
				format += "HH:mm:ssZZZZZ"
			} else {
				if contains(.withTime) {
					format += "HH:mm:ss"
				}
				if contains(.withTimeZone) {
					if contains(.withoutTZSeparators) {
						return "yyyy-MM-dd'T'HH:mm:ss.SSSZZZ"
					}
					format += "ZZZZZ"
				}
			}

			return format
		}
	}

	public static func format(_ date: DateRepresentable, options: Any?) -> String {
		let formatOptions = ((options as? ISOFormatter.Options) ?? ISOFormatter.Options([.withInternetDateTime]))
		let formatter = date.formatter(format: formatOptions.dateFormat) {
			$0.locale = Locales.englishUnitedStatesComputer.toLocale() // fix for 12/24h
			$0.timeZone = date.region.timeZone
			$0.calendar = Calendars.gregorian.toCalendar()
		}
		return formatter.string(from: date.date)
	}

}
