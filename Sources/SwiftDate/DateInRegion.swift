// SwiftDate
// Manage Date/Time & Timezone in Swift
//
// Created by: Daniele Margutti
// Email: <hello@danielemargutti.com>
// Web: <http://www.danielemargutti.com>
//
// Licensed under MIT License.
import Foundation

public class DateInRegion: CustomStringConvertible {
	
	/// region in which the `DateInRegion` is expressed
	
	/// Region in which
	public fileprivate(set) var region: Region
	
	/// Absolute date represented outside the `region`
	public internal(set) var absoluteDate: Date
	
	/// This is a reference to use formatters
	public fileprivate(set) var formatters: Formatters
	
	public class Formatters {
		private var timeZone: TimeZone
		private var calendar: Calendar
		private var locale: Locale
		
		/// `DateFormatter` reserved instance (nil unless you set `.useSharedFormatters = false`)
		private var customDateFormatter: DateFormatter? = nil
		
		/// `ISO8601DateTimeFormatter` reserved instance (nil unless you set `.useSharedFormatters = false`)
		private var customISO8601Formatter: ISO8601DateTimeFormatter? = nil
		
		/// `DateIntervalFormatter` reserved instance (nil unless you set `.useSharedFormatters = false`)
		private var customDateIntervalFormatter: DateIntervalFormatter? = nil

		/// If true this instance of `DateInRegion` will use formatters shared along calling thread.
		/// If false a new date formatter is created automatically and used only by a single `DateInRegion`
		/// Usually you don't need to create a single formatter for each DateInRegion because this
		/// operation is expensive.
		/// Unless you need of a particular behaviour you will be happy enough to share a single formatter
		/// for each thread.
		public var useSharedFormatters: Bool = true
		
		public init(region: Region) {
			self.timeZone = region.timeZone
			self.calendar = region.calendar
			self.locale = region.locale
		}
		
		public func isoFormatter() -> ISO8601DateTimeFormatter {
			var formatter: ISO8601DateTimeFormatter? = nil
			if useSharedFormatters == true {
				let name = "SwiftDate_\(NSStringFromClass(ISO8601DateTimeFormatter.self))"
				formatter = localThreadSingleton(key: name, create: { () -> ISO8601DateTimeFormatter in
					return ISO8601DateTimeFormatter()
				})
			} else {
				if customISO8601Formatter == nil {
					customISO8601Formatter = ISO8601DateTimeFormatter()
					formatter = customISO8601Formatter
				}
			}
			formatter!.locale = self.locale
			return formatter!
		}
		
		/// Return an `DateFormatter` instance. Returned instance is the one shared along calling thread
		/// if `.useSharedFormatters = false`; otherwise a reserved instance is created for this `DateInRegion`
		///
		/// - parameter format: if not nil a new `.dateFormat` is also set
		///
		/// - returns: a new instance of the formatter
		public func dateFormatter(format: String? = nil, heuristics: Bool = true) -> DateFormatter {
			var formatter: DateFormatter? = nil
			if useSharedFormatters == true {
				let name = "SwiftDate_\(NSStringFromClass(DateFormatter.self))"
				formatter = localThreadSingleton(key: name, create: { () -> DateFormatter in
					return DateFormatter()
				})
			} else {
				if customDateFormatter == nil {
					customDateFormatter = DateFormatter()
					formatter = customDateFormatter
				}
			}
			if format != nil {
				formatter!.dateFormat = format!
			}
			formatter!.timeZone = self.timeZone
			formatter!.calendar = self.calendar
			formatter!.locale = self.locale
			formatter!.isLenient = heuristics
			return formatter!
		}
		
		/// Return an `DateIntervalFormatter` instance. Returned instance is the one shared along calling thread
		/// if `.useSharedFormatters = false`; otherwise a reserved instance is created for this `DateInRegion`
		///
		/// - returns: a new instance of the formatter
		public  func intervalFormatter() -> DateIntervalFormatter {
			var formatter: DateIntervalFormatter? = nil
			if useSharedFormatters == true {
				let name = "SwiftDate_\(NSStringFromClass(DateIntervalFormatter.self))"
				formatter = localThreadSingleton(key: name, create: { () -> DateIntervalFormatter in
					return DateIntervalFormatter()
				})
			} else {
				if customDateIntervalFormatter == nil {
					customDateIntervalFormatter = DateIntervalFormatter()
					formatter = customDateIntervalFormatter
				}
			}
			formatter!.timeZone = self.timeZone
			formatter!.calendar = self.calendar
			formatter!.locale = self.locale
			return formatter!
		}
	}
	
	/// Initialize a new `DateInRegion` object from an absolute date and a destination region.
	/// The new instance express given date into specified region.
	///
	/// - parameter absoluteDate: absolute `Date` object
	/// - parameter region:       `Region` in which you would express given date (absolute time will be converted into passed region)
	///
	/// - returns: a new instance of the `DateInRegion` object
	public init(absoluteDate: Date, in region: Region? = nil) {
		let srcRegion = region ?? Region.Local()
		self.absoluteDate = absoluteDate
		self.region = srcRegion
		self.formatters = Formatters(region: srcRegion)
	}
	
	/// Initialize a new DateInRegion set to the current date in local's device region (`Region.Local()`).
	///
	/// - returns: a new DateInRegion object
	public init() {
		self.absoluteDate = Date()
		self.region = Region.Local()
		self.formatters = Formatters(region: self.region)
	}
	
	/// Initialize a new `DateInRegion` object from a `DateComponents` object.
	/// Both `TimeZone`, `Locale` and `Calendar` must be specified in `DateComponents` instance in order to get a valid result; if omitted a `MissingCalTzOrLoc` exception will thrown.
	/// If from given components a valid Date cannot be created a `FailedToParse`
	/// exception will thrown.
	///
	/// - parameter components: `DateComponents` with valid components used to generate a new date
	///
	/// - returns: a new `DateInRegion` from given components
	public init?(components: DateComponents) {
		guard let srcRegion = Region(components: components) else {
			return nil
		}
		guard let absDate = srcRegion.calendar.date(from: components) else {
			return nil
		}
		self.absoluteDate = absDate
		self.region = srcRegion
		self.formatters = Formatters(region: srcRegion)
	}
	
	/// Initialize a new `DateInRegion` where components are specified in an dictionary
	/// where the key is `Calendar.Component` and the value is an int; region informations
	/// (timezone, locale and calendars) are specified separately by the region parameter.
	///
	/// - parameter components: calendar components keys and values to assign
	/// - parameter region:     region in which the date is expressed. If `nil` local region will used instead (`Region.Local()`)
	///
	/// - returns: a new `DateInRegion` instance expressed in passed region, `nil` if parse fails
	public init?(components: [Calendar.Component : Int], fromRegion region: Region? = nil) {
		let srcRegion = region ?? Region.Local()
		self.formatters = Formatters(region: srcRegion)
		let cmp = DateInRegion.componentsFrom(values: components, setRegion: srcRegion)
		guard let absDate = srcRegion.calendar.date(from: cmp) else {
			return nil
		}
		self.absoluteDate = absDate
		self.region = srcRegion
	}
	
	
	/// Parse a string using given formats; the first format which produces a valid `DateInRegion`
	/// instance returns parsed instance. If none of passed formats can produce a valid region `nil`
	/// is returned.
	///
	/// - Parameters:
	///   - string: string to parse
	///   - formats: formats used for parsing. Formats are evaluated in order.
	/// - parameter region:     region in which the date is expressed. If `nil` local region will used instead (`Region.Local()`). When `.iso8601` or `.iso8601Auto` is used, `region` parameter is ignored (timezone is set automatically by reading the string.
	/// - returns: a new `DateInRegion` instance expressed in passed region, `nil` if parse fails
	public class func date(string: String, formats: [DateFormat], fromRegion region: Region? = nil) -> DateInRegion? {
		for format in formats {
			if let date = DateInRegion(string: string, format: format, fromRegion: region) {
				return date
			}
		}
		return nil
	}
	
	/// Initialize a new `DateInRegion` created from passed format rexpressed in specified region.
	///
	/// - parameter string: string with date to parse
	/// - parameter format: format in which the date is expressed (see `DateFormat`)
	/// - parameter region: region in which the date should be expressed (if nil `Region.Local()` will be used instead)
	///						When `.iso8601` or `.iso8601Auto` is used, `region.timezone' is ignored (timezone is set automatically by reading the string; Region `calendar` and `locale` are used)
	/// - returns: a new DateInRegion from given string
	public init?(string: String, format: DateFormat, fromRegion region: Region? = nil) {
		var srcRegion = region ?? Region.Local()
		self.formatters = Formatters(region: srcRegion)
		switch format {
		case .custom(let format):
			guard let date = self.formatters.dateFormatter(format: format).date(from: string) else {
				return nil
			}
			self.absoluteDate = date
		case .strict(let format):
			guard let date = self.formatters.dateFormatter(format: format, heuristics: false).date(from: string) else {
				return nil
			}
			self.absoluteDate = date
		case .iso8601(_), .iso8601Auto:
			let configuration = ISO8601Configuration(calendar: srcRegion.calendar)
			guard let parser = ISO8601Parser(string, config: configuration), let date = parser.parsedDate, let tz = parser.parsedTimeZone else { return nil }
			self.absoluteDate = date
			srcRegion = Region(tz: tz, cal: srcRegion.calendar, loc: srcRegion.locale)
		case .extended:
			let format = "eee dd-MMM-yyyy GG HH:mm:ss.SSS zzz"
			guard let date = self.formatters.dateFormatter(format: format).date(from: string) else {
				return nil
			}
			self.absoluteDate = date
		case .rss(let isAltRSS):
			let format = (isAltRSS ? "d MMM yyyy HH:mm:ss ZZZ" : "EEE, d MMM yyyy HH:mm:ss ZZZ")
			guard let date = self.formatters.dateFormatter(format: format).date(from: string) else {
				return nil
			}
			self.absoluteDate = date
		case .dotNET:
			guard let parsed_date = DOTNETDateTimeFormatter.date(string, calendar: srcRegion.calendar) else {
				return nil
			}
			self.absoluteDate = parsed_date.date
			srcRegion = Region(tz: parsed_date.tz, cal: srcRegion.calendar, loc: srcRegion.locale)
		}
		self.region = srcRegion
	}
	
	/// Convert a `DateInRegion` instance to a new specified `Region`
	///
	/// - parameter newRegion: destination region in which returned `DateInRegion` instance will be expressed in
	///
	/// - returns: a new `DateInRegion` expressed in passed destination region
	public func toRegion(_ newRegion: Region) -> DateInRegion {
		return DateInRegion(absoluteDate: self.absoluteDate, in: newRegion)
	}
	
	/// Modify absolute date value of the `DateInRegion` instance by adding a fixed value of seconds
	///
	/// - parameter interval: seconds to add
	public func add(interval: TimeInterval) {
		self.absoluteDate.addTimeInterval(interval)
	}
	
	/// Return a description of the `DateInRegion`
	public var description: String {
		let formatter = DateFormatter()
		formatter.dateStyle = .medium
		formatter.timeStyle = .long
		formatter.locale = self.region.locale
		formatter.calendar = self.region.calendar
		formatter.timeZone = self.region.timeZone
		return formatter.string(from: self.absoluteDate)
	}
	
}
