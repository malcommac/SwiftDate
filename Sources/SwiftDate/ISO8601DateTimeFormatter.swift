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

/// MARK: - ISO8601DateTimeFormatter

/// This is a re-implementation of the ISO8601DateFormatter which is compatible with iOS lower than version 10.
public class ISO8601DateTimeFormatter {
	
	public struct Options: OptionSet {
		public let rawValue: Int

		public init(rawValue: Int) {
			self.rawValue = rawValue
		}
		
		/// The date representation includes the year. The format for year is inferred based on the other specified options.
		/// - If withWeekOfYear is specified, YYYY is used.
		/// - Otherwise, yyyy is used.
		public static let withYear = ISO8601DateTimeFormatter.Options(rawValue: 1 << 0)
		
		/// The date representation includes the month. The format for month is MM.
		public static let withMonth = ISO8601DateTimeFormatter.Options(rawValue: 1 << 1)
		
		/// The date representation includes the week of the year.
		/// The format for week of year is ww, including the W prefix.
		public static let withWeekOfYear = ISO8601DateTimeFormatter.Options(rawValue: 1 << 2)
		
		/// The date representation includes the day. The format for day is inferred based on provided options:
		/// - If withMonth is specified, dd is used.
		/// - If withWeekOfYear is specified, ee is used.
		/// - Otherwise, DDD is used.
		public static let withDay = ISO8601DateTimeFormatter.Options(rawValue: 1 << 3)
		
		/// The date representation includes the time. The format for time is HH:mm:ss.
		public static let withTime = ISO8601DateTimeFormatter.Options(rawValue: 1 << 4)
		
		/// The date representation includes the timezone. The format for timezone is ZZZZZ.
		public static let withTimeZone = ISO8601DateTimeFormatter.Options(rawValue: 1 << 5)
		
		/// The date representation uses a space ( ) instead of T between the date and time.
		public static let withSpaceBetweenDateAndTime = ISO8601DateTimeFormatter.Options(rawValue: 1 << 6)
		
		/// The date representation uses the dash separator (-) in the date.
		public static let withDashSeparatorInDate = ISO8601DateTimeFormatter.Options(rawValue: 1 << 7)
		
		/// The date representation uses the colon separator (:) in the time.
		public static let withFullDate = ISO8601DateTimeFormatter.Options(rawValue: 1 << 8)
		
		/// The date representation includes the hour, minute, and second.
		public static let withFullTime = ISO8601DateTimeFormatter.Options(rawValue: 1 << 9)
		
		
		/// The format used for internet date times, according to the RFC 3339 standard.
		/// Equivalent to specifying withFullDate, withFullTime, withDashSeparatorInDate,
		/// withColonSeparatorInTime, and withColonSeparatorInTimeZone.
		public static let withInternetDateTime = ISO8601DateTimeFormatter.Options(rawValue: 1 << 10)
		
		// The format used for internet date times; it's similar to .withInternetDateTime
		// but include milliseconds ('yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ').
		public static let withInternetDateTimeExtended = ISO8601DateTimeFormatter.Options(rawValue: 1 << 11)
	}
	
	/// Options for generating and parsing ISO 8601 date representations.
	public var formatOptions: ISO8601DateTimeFormatter.Options = ISO8601DateTimeFormatter.Options(rawValue: 0)
	
	/// The time zone used to create and parse date representations. When unspecified, GMT is used.
	public var timeZone: TimeZone? {
		set {
			self.formatter.timeZone = newValue ?? TimeZone(secondsFromGMT: 0)
		}
		get {
			return self.formatter.timeZone
		}
	}
    
    public var locale: Locale? {
        get {
            return self.formatter.locale
        }
        set {
            self.formatter.locale = newValue
        }
    }
	
	/// formatter instance used for date
    private var formatter: DateFormatter = DateFormatter()
	
	public init() {
		self.timeZone = TimeZone(secondsFromGMT: 0)!
	}
	
	/// Creates and returns an ISO 8601 formatted string representation of the specified date.
	///
	/// - parameter date: The date to be represented.
	///
	/// - returns: A user-readable string representing the date.
	public func string(from date: Date) -> String {
		self.formatter.dateFormat = self.formatterString
		return self.formatter.string(from: date)
	}
	
	/// Creates and returns a date object from the specified ISO 8601 formatted string representation.
	///
	/// - parameter string: The ISO 8601 formatted string representation of a date.
	///
	/// - returns: A date object, or nil if no valid date was found.
	public func date(from string: String) -> Date? {
		self.formatter.dateFormat = self.formatterString
		return self.formatter.date(from: string)
	}
	
	/// Creates a representation of the specified date with a given time zone and format options.
	///
	/// - parameter date:          The date to be represented.
	/// - parameter timeZone:      The time zone used.
	/// - parameter formatOptions: The options used. For possible values, see ISO8601DateTimeFormatter.Options.
	///
	/// - returns: A user-readable string representing the date.
	class func string(from date: Date, timeZone: TimeZone, formatOptions: ISO8601DateTimeFormatter.Options = []) -> String {
		let formatter = ISO8601DateTimeFormatter()
		formatter.formatOptions = formatOptions
		return formatter.string(from: date)
	}
	
	/// Evaluate formatting string
	public var formatterString: String {
		if formatOptions.contains(.withInternetDateTimeExtended) {
			return "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
		}
		
		if formatOptions.contains(.withInternetDateTime) {
			return "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
		}

		var format: String = ""
		if formatOptions.contains(.withFullDate) {
			format += "yyyy-MM-dd"
		} else {
			if formatOptions.contains(.withYear) {
				if formatOptions.contains(.withWeekOfYear) {
					format += "YYYY"
				} else if formatOptions.contains(.withMonth) || formatOptions.contains(.withDay) {
					format += "yyyy"
				} else {
					// not valid
				}
			}
			if formatOptions.contains(.withMonth) {
				if formatOptions.contains(.withYear) || formatOptions.contains(.withDay) || formatOptions.contains(.withWeekOfYear) {
					format += "MM"
				} else {
					// not valid
				}
			}
			if formatOptions.contains(.withWeekOfYear) {
				if formatOptions.contains(.withDay) {
					format += "'W'ww"
				} else {
					if formatOptions.contains(.withYear) || formatOptions.contains(.withMonth) {
						if formatOptions.contains(.withDashSeparatorInDate) {
							format += "-'W'ww"
						} else {
							format += "'W'ww"
						}
					} else {
						// not valid
					}
				}
			}
			
			if formatOptions.contains(.withDay) {
				if formatOptions.contains(.withWeekOfYear) {
					format += "FF"
				} else if formatOptions.contains(.withMonth) {
					format += "dd"
				} else if formatOptions.contains(.withYear) {
					if formatOptions.contains(.withDashSeparatorInDate) {
						format += "-DDD"
					} else {
						format += "DDD"
					}
				} else {
					// not valid
				}
			}
		}

		let hasDate = (formatOptions.contains(.withFullDate) || formatOptions.contains(.withMonth) || formatOptions.contains(.withDay) || formatOptions.contains(.withWeekOfYear) || formatOptions.contains(.withYear))
		if hasDate && (formatOptions.contains(.withFullTime) || formatOptions.contains(.withTimeZone)) {
			if formatOptions.contains(.withSpaceBetweenDateAndTime) {
				format += " "
			} else {
				format += "'T'"
			}
		}
		
		if formatOptions.contains(.withFullTime) {
			format += "HH:mm:ssZZZZZ"
		} else {
			if formatOptions.contains(.withTime) {
				format += "HH:mm:ss"
			}
			if formatOptions.contains(.withTimeZone) {
				format += "ZZZZZ"
			}
		}
		
		return format
	}
}
