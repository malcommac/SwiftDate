//
//  ISO8601Formatter.swift
//  SwiftDate
//
//  Created by Daniele Margutti on 06/06/2018.
//  Copyright © 2018 SwiftDate. All rights reserved.
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

		/// Evaluate formatting string
		public var dateFormat: String {
			if self.contains(.withInternetDateTimeExtended) {
				return "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
			}

			if self.contains(.withInternetDateTime) {
				return "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
			}

			var format: String = ""
			if self.contains(.withFullDate) {
				format += "yyyy-MM-dd"
			} else {
				if self.contains(.withYear) {
					if self.contains(.withWeekOfYear) {
						format += "YYYY"
					} else if self.contains(.withMonth) || self.contains(.withDay) {
						format += "yyyy"
					} else {
						// not valid
					}
				}
				if self.contains(.withMonth) {
					if self.contains(.withYear) || self.contains(.withDay) || self.contains(.withWeekOfYear) {
						format += "MM"
					} else {
						// not valid
					}
				}
				if self.contains(.withWeekOfYear) {
					if self.contains(.withDay) {
						format += "'W'ww"
					} else {
						if self.contains(.withYear) || self.contains(.withMonth) {
							if self.contains(.withDashSeparatorInDate) {
								format += "-'W'ww"
							} else {
								format += "'W'ww"
							}
						} else {
							// not valid
						}
					}
				}

				if self.contains(.withDay) {
					if self.contains(.withWeekOfYear) {
						format += "FF"
					} else if self.contains(.withMonth) {
						format += "dd"
					} else if self.contains(.withYear) {
						if self.contains(.withDashSeparatorInDate) {
							format += "-DDD"
						} else {
							format += "DDD"
						}
					} else {
						// not valid
					}
				}
			}

			let hasDate = (self.contains(.withFullDate) || self.contains(.withMonth) || self.contains(.withDay) || self.contains(.withWeekOfYear) || self.contains(.withYear))
			if hasDate && (self.contains(.withFullTime) || self.contains(.withTimeZone)) {
				if self.contains(.withSpaceBetweenDateAndTime) {
					format += " "
				} else {
					format += "'T'"
				}
			}

			if self.contains(.withFullTime) {
				format += "HH:mm:ssZZZZZ"
			} else {
				if self.contains(.withTime) {
					format += "HH:mm:ss"
				}
				if self.contains(.withTimeZone) {
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
		}
		return formatter.string(from: date.date)
	}

}
