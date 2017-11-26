// SwiftDate
// Manage Date/Time & Timezone in Swift
//
// Created by: Daniele Margutti
// Email: <hello@danielemargutti.com>
// Web: <http://www.danielemargutti.com>
//
// Licensed under MIT License.

import Foundation


/// This defines all possible errors you can encounter parsing ISO8601 string
///
/// - eof: end of file
/// - notDigit: expected digit, value cannot be parsed as int
/// - notDouble: expected double digit, value cannot be parsed as double
/// - invalid: invalid state reached. Something in the format is not correct
public enum ISO8601ParserError: Error {
	case eof
	case notDigit
	case notDouble
	case invalid
}


// MARK: - Internal Extension for UnicodeScalar type

internal extension UnicodeScalar {
	
	/// return `true` if current character is a digit (arabic), `false` otherwise
	var isDigit: Bool {
		return "0"..."9" ~= self
	}
	
	/// return `true` if current character is a space
	var isSpace: Bool {
		return CharacterSet.whitespaces.contains(self)
	}
	
}


// MARK: - Internal Extension for Int type

internal extension Int {
	
	/// Return `true` if current year is a leap year, `false` otherwise
	var isLeapYear: Bool {
		return ((self % 4) == 0) && (((self % 100) != 0) || ((self % 400) == 0))
	}
	
}


/// Parser configuration
/// This configuration can be used to define custom behaviour of the parser itself.
public struct ISO8601Configuration {
	
	/// Time separator character. By default is `:`.
	var time_separator:		ISO8601Parser.ISOChar = ":"
	
	/// Strict parsing. By default is `false`.
	var strict:				Bool = false
	
	/// Calendar used to generate the date. By default is the current system calendar
	var calendar:			Calendar = Calendar.current
	
	public init(strict: Bool = false, calendar: Calendar? = nil) {
		self.strict = strict
		self.calendar = calendar ?? Calendar.current
	}
}


/// Internal structure
internal enum Weekday: Int {
	case monday			= 0
	case tuesday		= 1
	case wednesday		= 2
	case thursday		= 3
}


/// This is the ISO8601 Parser class: it evaluates automatically the format of the ISO8601 date
/// and attempt to parse it in a valid `Date` object.
/// Resulting date also includes Time Zone settings and a property which allows you to inspect
/// single date components.
///
/// This work is inspired to the original ISO8601DateFormatter class written in ObjC by
/// Peter Hosey (available here https://bitbucket.org/boredzo/iso-8601-parser-unparser).
/// I've made a Swift porting and fixed some issues when parsing several ISO8601 date variants.
public class ISO8601Parser {
	
	/// Some typealias to make the code cleaner
	public typealias ISOString		= String.UnicodeScalarView
	public typealias ISOIndex		= String.UnicodeScalarView.Index
	public typealias ISOChar		= UnicodeScalar
	public typealias ISOParsedDate	= (date: Date?, timezone: TimeZone?)
	
	/// This represent the internal parser status representation
	public struct ParsedDate {
		
		/// Type of date parsed
		///
		/// - monthAndDate: month and date style
		/// - week: date with week number
		/// - dateOnly: date only
		public enum DateStyle {
			case monthAndDate
			case week
			case dateOnly
		}
		
		/// Parsed year value
		var year:			Int = 0
		
		/// Parsed month or week number
		var month_or_week:	Int = 0
		
		/// Parsed day value
		var day:			Int = 0
		
		/// Parsed hour value
		var hour:			Int = 0
		
		/// Parsed minutes value
		var minute:			TimeInterval = 0.0
		
		/// Parsed seconds value
		var seconds:		TimeInterval = 0.0
		
		/// Parsed nanoseconds value
		var nanoseconds:	TimeInterval = 0.0
		
		/// Parsed weekday number (1=monday, 7=sunday)
		/// If `nil` source string has not specs about weekday.
		var weekday:		Int? = nil
		
		
		/// Timezone parsed hour value
		var tz_hour:		Int = 0
		
		/// Timezone parsed minute value
		var tz_minute:		Int = 0
		
		/// Type of parsed date
		var type:			DateStyle = .monthAndDate
		
		/// Parsed timezone object
		var timezone:		TimeZone?
	}
	
	
	/// Source raw parsed values
	private var date:		ParsedDate = ParsedDate()
	
	/// Source string represented as unicode scalars
	private let string:		ISOString
	
	/// Current position of the parser in source string.
	/// Initially is equal to `string.startIndex`
	private var cIdx:		ISOIndex
	
	/// Just a shortcut to the last index in source string
	private var eIdx:		ISOIndex
	
	/// Lenght of the string
	private var length:		Int
	
	/// Number of hyphens characters found before any value
	/// Consequential "-" are used to define implicit values in dates.
	private var hyphens:	Int = 0
	
	/// Private date components used for default values
	private var now_cmps:	DateComponents
	
	/// Configuration used for parser
	private var cfg: ISO8601Configuration
	
	/// Date components parsed
	private(set) var date_components: DateComponents?
	
	/// Parsed date
	private(set) var parsedDate: Date?
	
	/// Parsed timezone
	private(set) var parsedTimeZone: TimeZone?
	
	/// Date adjusted at parsed timezone
	private var dateInTimezone: Date? {
		get {
			self.cfg.calendar.timeZone = date.timezone ?? TimeZone(identifier: "UTC")!
			return self.cfg.calendar.date(from: self.date_components!)
		}
	}
	
	/// Formatter used to transform a date to a valid ISO8601 string
	private(set) var formatter: DateFormatter = DateFormatter()
	
	/// Initialize a new parser with a source ISO8601 string to parse
	/// Parsing is done during initialization; any exception is reported
	/// before allocating.
	///
	/// - Parameters:
	///   - src: source ISO8601 string
	///   - config: configuration used for parsing
	/// - Throws: throw an `ISO8601Error` if parsing operation fails
	public init?(_ src: String, config: ISO8601Configuration = ISO8601Configuration()) {
		let src_trimmed = src.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
		guard src_trimmed.count > 0 else {
			return nil
		}
		self.string = src_trimmed.unicodeScalars
		self.length = src_trimmed.count
		self.cIdx = string.startIndex
		self.eIdx = string.endIndex
		self.cfg = config
		self.now_cmps = cfg.calendar.dateComponents([.year,.month,.day], from: Date())
		
		var idx = self.cIdx
		while idx < self.eIdx {
			if string[idx] == "-" { hyphens += 1 }
			else { break }
			idx = string.index(after: idx)
		}
		
		do {
			try self.parse()
		} catch {
			return nil
		}
	}
	
	
	/// Return a date parsed from a valid ISO8601 string
	///
	/// - Parameter string: source string
	/// - Returns: a valid `Date` object or `nil` if date cannot be parsed
	public static func date(from string: String) -> ISOParsedDate? {
		guard let parser = ISO8601Parser(string) else {
			return nil
		}
		return (parser.parsedDate,parser.parsedTimeZone)
	}
	
	//MARK: - Internal Parser
	
	/// Private parsing function
	///
	/// - Throws: throw an `ISO8601Error` if parsing operation fails
	@discardableResult
	private func parse() throws -> ISOParsedDate {
		
		// PARSE DATE
		
		if current() == "T" {
			// There is no date here, only a time.
			// Set the date to now; then we'll parse the time.
			next()
			guard current().isDigit else {
				throw ISO8601ParserError.invalid
			}
			
			date.year = now_cmps.year!
			date.month_or_week = now_cmps.month!
			date.day = now_cmps.day!
		} else {
			moveUntil(is: "-")
			let is_time_only = (string.contains("T") == false && string.contains(":") && !string.contains("-"))
			
			if is_time_only == false {
				var (num_digits,segment) = try read_int()
				switch num_digits {
				case 0:		try parse_digits_0(num_digits, &segment)
				case 8:		try parse_digits_8(num_digits, &segment)
				case 6:		try parse_digits_6(num_digits, &segment)
				case 4:		try parse_digits_4(num_digits, &segment)
				case 1:		try parse_digits_1(num_digits, &segment)
				case 2:		try parse_digits_2(num_digits, &segment)
				case 7:		try parse_digits_7(num_digits, &segment) //YYYY DDD (ordinal date)
				case 3:		try parse_digits_3(num_digits, &segment) //--DDD (ordinal date, implicit year)
				default:	throw ISO8601ParserError.invalid
				}
			} else {
				date.year = now_cmps.year!
				date.month_or_week = now_cmps.month!
				date.day = now_cmps.day!
			}
		}
		
		var hasTime = false
		if current().isSpace || current() == "T" {
			hasTime = true
			next()
		}
		
		// PARSE TIME
		
		if current().isDigit == true {
			let time_sep = cfg.time_separator
			let hasTimeSeparator = string.contains(time_sep)
			
			date.hour = try read_int(2).value
			
			if hasTimeSeparator == false && hasTime{
				date.minute = TimeInterval(try read_int(2).value)
			}
			else if current() == time_sep {
				next()
				
				if time_sep == "," || time_sep == "." {
					//We can't do fractional minutes when '.' is the segment separator.
					//Only allow whole minutes and whole seconds.
					date.minute = TimeInterval(try read_int(2).value)
					if current() == time_sep {
						next()
						date.seconds = TimeInterval(try read_int(2).value)
					}
				} else {
					//Allow a fractional minute.
					//If we don't get a fraction, look for a seconds segment.
					//Otherwise, the fraction of a minute is the seconds.
					date.minute = try read_double().value
					
					if current() != ":" {
						var int_part: Double = 0.0
						var frac_part: Double = 0.0
						frac_part = modf(date.minute, &int_part)
						date.minute = int_part
						date.seconds = frac_part
						if date.seconds > Double.ulpOfOne {
							// Convert fraction (e.g. .5) into seconds (e.g. 30).
							date.seconds = date.seconds * 60
						} else if current() == time_sep {
							next()
						//	date.seconds = try read_double().value
							let value = try modf(read_double().value)
							date.nanoseconds = TimeInterval(round(value.1 * 1000) * 1000000)
							date.seconds = TimeInterval(value.0)
						}
					} else {
						// fractional minutes
						next()
						let value = try modf(read_double().value)
						date.nanoseconds = TimeInterval(round(value.1 * 1000) * 1000000)
						date.seconds = TimeInterval(value.0)
					}
				}
			}
			
			if cfg.strict == false {
				if current().isSpace == true {
					next()
				}
			}
			
			switch current() {
			case "Z":
				date.timezone = TimeZone(abbreviation: "UTC")
				
			case "+","-":
				let is_negative = current() == "-"
				next()
				if current().isDigit == true {
					//Read hour offset.
					date.tz_hour = try read_int(2).value
					if is_negative == true { date.tz_hour = -date.tz_hour }
					
					// Optional separator
					if current() == time_sep {
						next()
					}
					
					if current().isDigit {
						// Read minute offset
						date.tz_minute = try read_int(2).value
						if is_negative == true { date.tz_minute = -date.tz_minute }
					}
					
					let timezone_offset = (date.tz_hour * 3600) + (date.tz_minute * 60)
					date.timezone = TimeZone(secondsFromGMT: timezone_offset)
				}
			default:
				break
			}
		}
		
		
		self.date_components = DateComponents()
		self.date_components!.year = date.year
		self.date_components!.day = date.day
		self.date_components!.hour = date.hour
		self.date_components!.minute = Int(date.minute)
		self.date_components!.second = Int(date.seconds)
		self.date_components!.nanosecond = Int(date.nanoseconds)
		
		switch date.type {
		case .monthAndDate:
			self.date_components!.month = date.month_or_week
		case .week:
			//Adapted from <http://personal.ecu.edu/mccartyr/ISOwdALG.txt>.
			//This works by converting the week date into an ordinal date, then letting the next case handle it.
			let prevYear = date.year - 1
			let YY = prevYear % 100
			let C = prevYear - YY
			let G = YY + YY / 4
			let isLeapYear = (((C / 100) % 4) * 5)
			let Jan1Weekday = ((isLeapYear + G) % 7)
			
			var day = ((8 - Jan1Weekday) + (7 * (Jan1Weekday > Weekday.thursday.rawValue ? 1 : 0)))
			day += (date.day - 1) + (7 * (date.month_or_week - 2))
			
			if let weekday = date.weekday {
				//self.date_components!.weekday = weekday
				self.date_components!.day = day + weekday
			} else {
				self.date_components!.day = day
			}
		case .dateOnly: //An "ordinal date".
			break
			
		}
		
		//self.cfg.calendar.timeZone = date.timezone ?? TimeZone(identifier: "UTC")!
		//self.parsedDate = self.cfg.calendar.date(from: self.date_components!)
		
		let tz = date.timezone ?? TimeZone(identifier: "UTC")!
		self.parsedTimeZone = tz
		self.cfg.calendar.timeZone = tz
		self.parsedDate = self.cfg.calendar.date(from: self.date_components!)

		return (self.parsedDate,self.parsedTimeZone)
	}
	
	
	private func parse_digits_3(_ num_digits: Int, _ segment: inout Int) throws {
		//Technically, the standard only allows one hyphen. But it says that two hyphens is the logical implementation, and one was dropped for brevity. So I have chosen to allow the missing hyphen.
		if hyphens < 1 || (hyphens > 2 && cfg.strict == false) {
			throw ISO8601ParserError.invalid
		}
		
		date.day = segment
		date.year = now_cmps.year!
		date.type = .dateOnly
		if cfg.strict == true && (date.day > (365 + (date.year.isLeapYear ? 1 : 0))) {
			throw ISO8601ParserError.invalid
		}
	}
	
	private func parse_digits_7(_ num_digits: Int, _ segment: inout Int) throws {
		guard hyphens == 0 else { throw ISO8601ParserError.invalid }
		
		date.day = segment % 1000
		date.year = segment / 1000
		date.type = .dateOnly
		if cfg.strict == true && (date.day > (365 + (date.year.isLeapYear ? 1 : 0))) {
			throw ISO8601ParserError.invalid
		}
	}
	
	private func parse_digits_2(_ num_digits: Int, _ segment: inout Int) throws {
		
		func parse_hyphens_3(_ num_digits: Int, _ segment: inout Int) throws {
			date.year = now_cmps.year!
			date.month_or_week = now_cmps.month!
			date.day = segment
		}
		
		func parse_hyphens_2(_ num_digits: Int, _ segment: inout Int) throws {
			date.year = now_cmps.year!
			date.month_or_week = segment
			if current() == "-" {
				next()
				date.day = try read_int(2).value
			} else {
				date.day = 1
			}
		}
		
		func parse_hyphens_1(_ num_digits: Int, _ segment: inout Int) throws {
			let current_year = now_cmps.year!
			let current_century = (current_year % 100)
			date.year = segment + (current_year - current_century)
			if num_digits == 1 { // implied decade
				date.year += current_century - (current_year % 10)
			}
			
			if current() == "-" {
				next()
				if current() == "W" {
					next()
					date.type = .week
				}
				date.month_or_week = try read_int(2).value
				
				if current() == "-" {
					next()
					if date.type == .week {
						// weekday number
						let weekday = try read_int().value
						if weekday > 7 {
							throw ISO8601ParserError.invalid
						}
						date.weekday = weekday
					} else {
						date.day = try read_int().value
						if date.day == 0 {
							date.day = 1
						}
						if date.month_or_week == 0 {
							date.month_or_week = 1
						}
					}
				} else {
					date.day = 1
				}
			} else {
				date.month_or_week = 1
				date.day = 1
			}
		}
		
		func parse_hyphens_0(_ num_digits: Int, _ segment: inout Int) throws {
			if current() == "-" {
				// Implicit century
				date.year = now_cmps.year!
				date.year -= (date.year % 100)
				date.year += segment
				
				next()
				if current() == "W" {
					try parseWeekAndDay()
				} else if current().isDigit == false {
					try centuryOnly(&segment)
				} else {
					// Get month and/or date.
					let (v_count,v_seg) = try read_int()
					switch v_count {
					case 4: // YY-MMDD
						date.day = v_seg % 100
						date.month_or_week = v_seg / 100
					case 1: // YY-M; YY-M-DD (extension)
						if cfg.strict == true {
							throw ISO8601ParserError.invalid
						}
					case 2: // YY-MM; YY-MM-DD
						date.month_or_week = v_seg
						if current() == "-" {
							next()
							if current().isDigit == true {
								date.day = try read_int(2).value
							} else {
								date.day = 1
							}
						} else {
							date.day = 1
						}
					case 3: // Ordinal date
						date.day = v_seg
						date.type = .dateOnly
					default:
						break
					}
				}
			} else if current() == "W" {
				date.year = now_cmps.year!
				date.year -= (date.year % 100)
				date.year += segment
				
				try parseWeekAndDay()
			} else {
				try centuryOnly(&segment)
			}
		}
		
		switch hyphens {
		case 0:		try parse_hyphens_0(num_digits, &segment)
		case 1:		try parse_hyphens_1(num_digits, &segment) //-YY; -YY-MM (implicit century)
		case 2:		try parse_hyphens_2(num_digits, &segment) //--MM; --MM-DD
		case 3:		try parse_hyphens_3(num_digits, &segment) //---DD
		default:	throw ISO8601ParserError.invalid
		}
	}
	
	private func parse_digits_1(_ num_digits: Int, _ segment: inout Int) throws {
		if cfg.strict == true {
			// Two digits only - never just one.
			guard hyphens == 1 else { throw ISO8601ParserError.invalid }
			if current() == "-" {
				next()
			}
			next()
			guard current() == "W" else { throw ISO8601ParserError.invalid }
			
			date.year = now_cmps.year!
			date.year -= (date.year % 10)
			date.year += segment
		} else {
			try parse_digits_2(num_digits, &segment)
		}
	}
	
	private func parse_digits_4(_ num_digits: Int, _ segment: inout Int) throws {
		
		func parse_hyphens_0(_ num_digits: Int, _ segment: inout Int) throws {
			date.year = segment
			if current() == "-" {
				next()
			}
			
			if current().isDigit == false {
				if current() == "W" {
					try parseWeekAndDay()
				} else {
					date.month_or_week = 1
					date.day = 1
				}
			} else {
				let (v_num,v_seg) = try read_int()
				switch v_num {
				case 4: // MMDD
					date.day = v_seg % 100
					date.month_or_week = v_seg / 100
				case 2: // MM
					date.month_or_week = v_seg
					
					if current() == "-" {
						next()
					}
					if current().isDigit == false {
						date.day = 1
					} else {
						date.day = try read_int().value
					}
				case 3: // DDD
					date.day = v_seg % 1000
					date.type = .dateOnly
					if cfg.strict == true && (date.day > 365 + (date.year.isLeapYear ? 1 : 0)) {
						throw ISO8601ParserError.invalid
					}
				default:
					throw ISO8601ParserError.invalid
				}
			}
		}
		
		func parse_hyphens_1(_ num_digits: Int, _ segment: inout Int) throws {
			date.month_or_week = segment % 100
			date.year = segment / 100
			
			if current() == "-" {
				next()
			}
			if current().isDigit == false {
				date.day = 1
			} else {
				date.day = try read_int().value
			}
		}
		
		func parse_hyphens_2(_ num_digits: Int, _ segment: inout Int) throws {
			date.day = segment % 100
			date.month_or_week = segment / 100
			date.year = now_cmps.year!
		}
		
		switch hyphens {
		case 0:		try parse_hyphens_0(num_digits, &segment) // YYYY
		case 1:		try parse_hyphens_1(num_digits, &segment) // YYMM
		case 2:		try parse_hyphens_2(num_digits, &segment) // MMDD
		default:	throw ISO8601ParserError.invalid
		}
		
	}
	
	private func parse_digits_6(_ num_digits: Int, _ segment: inout Int) throws {
		// YYMMDD (implicit century)
		guard hyphens == 0 else { throw ISO8601ParserError.invalid }
		
		date.day = segment % 100
		segment /= 100
		date.month_or_week = segment % 100
		date.year = now_cmps.year!
		date.year -= (date.year % 100)
		date.year += (segment / 100)
	}
	
	private func parse_digits_8(_ num_digits: Int, _ segment: inout Int) throws {
		// YYYY MM DD
		guard hyphens == 0 else {
			throw ISO8601ParserError.invalid
		}
		
		date.day = segment % 100
		segment /= 100
		date.month_or_week = segment % 100
		date.year = segment / 100
	}
	
	private func parse_digits_0(_ num_digits: Int, _ segment: inout Int) throws {
		guard current() == "W" else {
			throw ISO8601ParserError.invalid
		}
		
		if seek(1) == "-" && isDigit(seek(2)) &&
			((hyphens == 1 || hyphens == 2) && cfg.strict == false) {
			
			date.year = now_cmps.year!
			date.month_or_week = 1
			next(2)
			try parseDayAfterWeek()
		} else if hyphens == 1 {
			date.year = now_cmps.year!
			if current() == "W" {
				next()
				date.month_or_week = try read_int(2).value
				date.type = .week
				try parseWeekday()
			} else {
				try parseDayAfterWeek()
			}
		} else {
			throw ISO8601ParserError.invalid
		}
	}
	
	private func parseWeekday() throws {
		if current() == "-" {
			next()
		}
		let weekday = try read_int().value
		if weekday > 7 {
			throw ISO8601ParserError.invalid
		}
		date.type = .week
		date.weekday = weekday
	}
	
	private func parseWeekAndDay() throws {
		next()
		if current().isDigit == false {
			//Not really a week-based date; just a year followed by '-W'.
			guard cfg.strict == false else {
				throw ISO8601ParserError.invalid
			}
			date.month_or_week = 1
			date.day = 1
		} else {
			date.month_or_week = try read_int(2).value
			try parseWeekday()
		}
	}
	
	private func parseDayAfterWeek() throws {
		date.day = current().isDigit == true ? try read_int(2).value : 1
		date.type = .week
	}
	
	private func centuryOnly(_ segment: inout Int) throws {
		date.year = segment * 100 + now_cmps.year! % 100
		date.month_or_week = 1
		date.day = 1
	}
	
	
	/// Return `true` if given character is a char
	///
	/// - Parameter char: char to evaluate
	/// - Returns: `true` if char is a digit, `false` otherwise
	private func isDigit(_ char: UnicodeScalar?) -> Bool {
		guard let char = char else { return false }
		return char.isDigit
	}
	
	/// MARK: - Scanner internal functions
	
	
	/// Get the value at specified offset from current scanner position without
	/// moving the current scanner's index.
	///
	/// - Parameter offset: offset to move
	/// - Returns: char at given position, `nil` if not found
	@discardableResult
	public func seek(_ offset: Int = 1) -> ISOChar? {
		let move_idx = string.index(cIdx, offsetBy: offset)
		guard move_idx < eIdx else {
			return nil
		}
		return string[move_idx]
	}
	
	/// Return the char at the current position of the scanner
	///
	/// - Parameter next: if `true` return the current char and move to the next position
	/// - Returns: the char sat the current position of the scanner
	@discardableResult
	public func current(_ next: Bool = false) -> ISOChar {
		let current = string[cIdx]
		if next == true { cIdx = string.index(after: cIdx) }
		return current
	}
	
	/// Move by `offset` characters the index of the scanner and return the char at the current
	/// position. If EOF is reached `nil` is returned.
	///
	/// - Parameter offset: offset value (use negative number to move backwards)
	/// - Returns: character at the current position.
	@discardableResult
	private func next(_ offset: Int = 1) -> ISOChar? {
		let next = string.index(cIdx, offsetBy: offset)
		guard next < eIdx else {
			return nil
		}
		cIdx = next
		return string[cIdx]
	}
	
	
	/// Read from the current scanner index and parse the value as Int.
	///
	/// - Parameter max_count: number of characters to move. If nil scanners continues until a non
	///   digit value is encountered.
	/// - Returns: parsed value
	/// - Throws: throw an exception if parser fails
	@discardableResult
	private func read_int(_ max_count: Int? = nil) throws -> (count: Int, value: Int) {
		var move_idx = cIdx
		var count = 0
		while move_idx < eIdx {
			if let max = max_count, count >= max { break }
			if string[move_idx].isDigit == false { break }
			count += 1
			move_idx = string.index(after: move_idx)
		}
		
		let raw_value = String(string[cIdx..<move_idx])
		if raw_value == "" {
			return (count,0)
		}
		guard let value = Int(raw_value) else {
			throw ISO8601ParserError.notDigit
		}
		
		cIdx = move_idx
		return (count, value)
	}
	
	
	/// Read from the current scanner index and parse the value as Double.
	/// If parser fails an exception is throw.
	/// Unit separator can be `-` or `,`.
	///
	/// - Returns: double value
	/// - Throws: throw an exception if parser fails
	@discardableResult
	private func read_double() throws -> (count: Int, value: Double) {
		var move_idx = cIdx
		var count = 0
		var fractional_start = false
		while move_idx < eIdx {
			let char = string[move_idx]
			if char == "." || char == "," {
				if fractional_start == true { throw ISO8601ParserError.notDouble }
				else { fractional_start = true }
			} else {
				if char.isDigit == false { break }
			}
			count += 1
			move_idx = string.index(after: move_idx)
		}
		
		let raw_value = String(string[cIdx..<move_idx]).replacingOccurrences(of: ",", with: ".")
		if raw_value == "" {
			return (count,0.0)
		}
		guard let value = Double(raw_value) else {
			throw ISO8601ParserError.notDouble
		}
		cIdx = move_idx
		return (count,value)
	}
	
	/// Move the current scanner index to the next position until the current char of the scanner
	/// is the given `char` value.
	///
	/// - Parameter char: char
	/// - Returns: the number of characters passed
	@discardableResult
	private func moveUntil(is char: UnicodeScalar) -> Int {
		var move_idx = cIdx
		var count = 0
		while move_idx < eIdx {
			guard string[move_idx] == char else { break }
			move_idx = string.index(after: move_idx)
			count += 1
		}
		cIdx = move_idx
		return count
	}
	
	
	/// Move the current scanner index to the next position until passed `char` value is
	/// encountered or `eof` is reached.
	///
	/// - Parameter char: char
	/// - Returns: the number of characters passed
	@discardableResult
	private func moveUntil(isNot char: UnicodeScalar) -> Int {
		var move_idx = cIdx
		var count = 0
		while move_idx < eIdx {
			guard string[move_idx] != char else { break }
			move_idx = string.index(after: move_idx)
			count += 1
		}
		cIdx = move_idx
		return count
	}
	
}
