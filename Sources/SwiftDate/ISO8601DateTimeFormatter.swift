// SwiftDate
// Manage Date/Time & Timezone in Swift
//
// Created by: Daniele Margutti
// Email: <hello@danielemargutti.com>
// Web: <http://www.danielemargutti.com>
//
// Licensed under MIT License.

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
		
		/// Evaluate formatting string
		public var formatterString: String {
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
	
	/// Options for generating and parsing ISO 8601 date representations.
	@available(*, deprecated: 4.1.0, message: "This property is not used anymore. Use string(from:options:) to format a date to string or class func date(from:config:) to transform a string to date")
	public var formatOptions: ISO8601DateTimeFormatter.Options = ISO8601DateTimeFormatter.Options(rawValue: 0)
	
	/// The time zone used to create and parse date representations. When unspecified, GMT is used.
	@available(*, deprecated: 4.1.0, message: "This property is not used anymore. Parsing is done automatically by reading specified timezone. If not specified UTC is used.")
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
	
	public init() { }
	
	/// Creates and returns an ISO 8601 formatted string representation of the specified date.
	///
	/// - parameter date: The date to be represented.
	///
	/// - returns: A user-readable string representing the date.
	@available(*, deprecated: 4.1.0, message: "Use string(from:options:) function instead")
	public func string(from date: Date) -> String {
		self.formatter.dateFormat = self.formatOptions.formatterString
		return self.formatter.string(from: date)
	}
	
	/// Creates and returns a date object from the specified ISO 8601 formatted string representation.
	///
	/// - parameter string: The ISO 8601 formatted string representation of a date.
	///
	/// - returns: A date object, or nil if no valid date was found.
	@available(*, deprecated: 4.1.0, message: "Use ISO8601DateTimeFormatter class func date(from:config) instead")
	public func date(from string: String) -> Date? {
		//self.formatter.dateFormat = self.formatOptions.formatterString
		//return self.formatter.date(from: string)
		return ISO8601DateTimeFormatter.date(from: string)
	}
	
	
	/// Creates and return a date object from the specified ISO8601 formatted string representation
	///
	/// - Parameters:
	///   - string: valid ISO8601 string to parse
	///   - config: configuration to use. `nil` uses default configuration
	/// - Returns: a valid `Date` object or `nil` if parse fails
	public class func date(from string: String, config: ISO8601Configuration = ISO8601Configuration()) -> Date? {
		return ISO8601Parser(string, config: config)?.parsedDate
	}
	
	/// Creates and returns an ISO 8601 formatted string representation of the specified date.
	///
	/// - Parameters:
	///   - date: The date to be represented.
	///   - options: Formastting style
	/// - Returns: a string description of the date
	public func string(from date: Date, tz: TimeZone, options: ISO8601DateTimeFormatter.Options = [.withInternetDateTime]) -> String {
		self.formatter.dateFormat = options.formatterString
		formatter.locale = LocaleName.englishUnitedStatesComputer.locale // fix for 12/24h
		formatter.timeZone = tz
		let string = self.formatter.string(from: date)
		return string
	}
	
	/// Creates a representation of the specified date with a given time zone and format options.
	///
	/// - parameter date:          The date to be represented.
	/// - parameter timeZone:      The time zone used.
	/// - parameter formatOptions: The options used. For possible values, see ISO8601DateTimeFormatter.Options.
	///
	/// - returns: A user-readable string representing the date.
	@available(*, deprecated: 4.1.0, message: "Use ISO8601DateTimeFormatter class func string(from:options:) instead")
	public class func string(from date: Date, timeZone: TimeZone, formatOptions: ISO8601DateTimeFormatter.Options = []) -> String {
		return ISO8601DateTimeFormatter.string(from: date, tz: timeZone, options: formatOptions)
	}
	
	
	/// Creates a representation of the specified date with a given time zone and format options.
	///
	/// - Parameters:
	///   - date: The date to be represented.
	///	  - tz: Destination timezone
	///   - options: The options used. For possible values, see ISO8601DateTimeFormatter.Options.
	/// - returns: A user-readable string representing the date.
	public class func string(from date: Date, tz: TimeZone, options: ISO8601DateTimeFormatter.Options = []) -> String {
		let formatter = ISO8601DateTimeFormatter()
		formatter.locale = LocaleName.englishUnitedStatesComputer.locale // fix for 12/24h
		return formatter.string(from: date, tz: tz, options: options)
	}
}
