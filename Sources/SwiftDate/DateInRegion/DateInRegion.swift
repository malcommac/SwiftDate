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

public struct DateInRegion: DateRepresentable, Decodable, Encodable, CustomStringConvertible, Comparable, Hashable {

	/// Absolute date represented. This date is not associated with any timezone or calendar
	/// but represent the absolute number of seconds since Jan 1, 2001 at 00:00:00 UTC.
	public internal(set) var date: Date

	/// Associated region which define where the date is represented into the world.
	public let region: Region

	/// Formatter used to transform this object in a string. By default is `nil` because SwiftDate
	/// uses the thread shared formatter in order to avoid expensive init of the `DateFormatter` object.
	/// However, if you need of a custom behaviour you can set a valid value.
	public var customFormatter: DateFormatter?

	/// Extract date components by taking care of the region in which the date is expressed.
	public var dateComponents: DateComponents {
		return region.calendar.dateComponents(DateComponents.allComponentsSet, from: date)
	}

	/// Description of the date
	public var description: String {
		let absISODate = DateFormatter.sharedFormatter(forRegion: Region.UTC).string(from: date)
		let representedDate = formatter(format: DateFormats.iso8601).string(from: date)
		return "{abs_date='\(absISODate)', rep_date='\(representedDate)', region=\(region.description)"
	}

	/// The interval between the date value and 00:00:00 UTC on 1 January 1970.
	public var timeIntervalSince1970: TimeInterval {
		return date.timeIntervalSince1970
	}

	/// Initialize with an absolute date and represent it into given geographic region.
	///
	/// - Parameters:
	///   - date: absolute date to represent.
	///   - region: region in which the date is represented. If ignored `defaultRegion` is used instead.
	public init(_ date: Date = Date(), region: Region = SwiftDate.defaultRegion) {
		self.date = date
		self.region = region
	}

	/// Initialize a new `DateInRegion` by parsing given string.
	/// If you know the format of the string you should pass it in order to speed up the parsing process.
	/// If you don't know the format leave it `nil` and parse is done between all formats in `DateFormats.builtInAutoFormats`
	/// and the ordered list you can provide in `SwiftDate.autoParseFormats` (with attempt priority set on your list).
	///
	/// - Parameters:
	///   - string: string with the date.
	///   - format: format of the date.
	///   - region: region in which the date is expressed.
	public init?(_ string: String, format: String? = nil, region: Region = SwiftDate.defaultRegion) {
		guard let date = DateFormats.parse(string: string,
										   format: format,
										   region: region) else {
			return nil // failed to parse date
		}
		self.date = date
		self.region = region
	}

	/// Initialize a new `DateInRegion` by parsing given string with the ordered list of passed formats.
	/// If you know the format of the string you should pass it in order to speed up the parsing process.
	/// If you don't know the format leave it `nil` and parse is done between all formats in `DateFormats.builtInAutoFormats`
	/// and the ordered list you can provide in `SwiftDate.autoParseFormats` (with attempt priority set on your list).
	///
	/// - Parameters:
	///   - string: string with the date.
	///   - formats: ordered list of formats to use.
	///   - region: region in which the date is expressed.
	public init?(_ string: String, formats: [String]?, region: Region = SwiftDate.defaultRegion) {
		guard let date = DateFormats.parse(string: string,
										   formats: (formats ?? SwiftDate.autoFormats),
										   region: region) else {
			return nil // failed to parse date
		}
		self.date = date
		self.region = region
	}

	/// Initialize a new date from the number of seconds passed since Unix Epoch.
	///
	/// - Parameters:
	///   - interval: seconds since Unix Epoch.
	///   - region: the region in which the date must be expressed, `nil` uses the default region at UTC timezone
	public init(seconds interval: TimeInterval, region: Region = Region.UTC) {
		self.date = Date(timeIntervalSince1970: interval)
		self.region = region
	}

	/// Initialize a new date corresponding to the number of milliseconds since the Unix Epoch.
	///
	/// - Parameters:
	///   - interval: seconds since the Unix Epoch timestamp.
	///   - region: region in which the date must be expressed, `nil` uses the default region at UTC timezone
	public init(milliseconds interval: Int, region: Region = Region.UTC) {
		self.date = Date(timeIntervalSince1970: TimeInterval(interval) / 1000)
		self.region = region
	}

	/// Initialize a new date with the opportunity to configure single date components via builder pattern.
	/// Date is therfore expressed in passed region (`DateComponents`'s `timezone`,`calendar` and `locale` are ignored
	/// and overwritten by the region if not `nil`).
	///
	/// - Parameters:
	///   - configuration: configuration callback
	///   - region: region in which the date is expressed.
	///				Ignore to use `SwiftDate.defaultRegion`, `nil` to use `DateComponents` data.
	public init?(components configuration: ((inout DateComponents) -> Void), region: Region? = SwiftDate.defaultRegion) {
		var components = DateComponents()
		configuration(&components)
		let r = (region ?? Region(fromDateComponents: components))
		guard let date = r.calendar.date(from: components) else {
			return nil
		}
		self.date = date
		self.region = r
	}

	/// Initialize a new date with given components.
	///
	/// - Parameters:
	///   - components: components of the date.
	///   - region: region in which the date is expressed.
	///				Ignore to use `SwiftDate.defaultRegion`, `nil` to use `DateComponents` data.
	public init?(components: DateComponents, region: Region?) {
		let r = (region ?? Region(fromDateComponents: components))
		guard let date = r.calendar.date(from: components) else {
			return nil
		}
		self.date = date
		self.region = r
	}

	/// Initialize a new date with given components.
	public init(year: Int, month: Int, day: Int, hour: Int = 0, minute: Int = 0, second: Int = 0, nanosecond: Int = 0, region: Region = SwiftDate.defaultRegion) {
		var components = DateComponents()
		components.year = year
		components.month = month
		components.day = day
		components.hour = hour
		components.minute = minute
		components.second = second
		components.nanosecond = nanosecond
		components.timeZone = region.timeZone
		components.calendar = region.calendar
		self.date = region.calendar.date(from: components)!
		self.region = region
	}

	/// Return a date in the distant past.
	///
	/// - Returns: Date instance.
	public static func past() -> DateInRegion {
		return DateInRegion(Date.distantPast, region: SwiftDate.defaultRegion)
	}

	/// Return a date in the distant future.
	///
	/// - Returns: Date instance.
	public static func future() -> DateInRegion {
		return DateInRegion(Date.distantFuture, region: SwiftDate.defaultRegion)
	}

	// MARK: - Codable Support

	enum CodingKeys: String, CodingKey {
		case date
		case region
	}

}
