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

/// Region define a context both for `Date` and `DateInRegion`.
/// Each `Date` is assigned to the currently set `SwiftDate.default
public struct Region: Decodable, Encodable, Equatable, Hashable, CustomStringConvertible {

	// MARK: - Properties

	/// Calendar associated with region
	public let calendar: Calendar

	/// Locale associated with region
	public var locale: Locale { return calendar.locale! }

	/// Timezone associated with region
	public var timeZone: TimeZone { return calendar.timeZone }

	/// Description of the object
	public var description: String {
        "{calendar='\(calendar.identifier)', timezone='\(timeZone.identifier)', locale='\(locale.identifier)'}"
	}

	public func hash(into hasher: inout Hasher) {
		hasher.combine(calendar)
	}

	// MARK: Initialization

	/// Initialize a new region with given parameters.
	///
	/// - Parameters:
	///   - calendar: calendar for region, if not specified `defaultRegions`'s calendar is used instead.
	///   - timezone: timezone for region, if not specified `defaultRegions`'s timezone is used instead.
	///   - locale: locale for region, if not specified `defaultRegions`'s locale is used instead.
	public init(calendar: CalendarConvertible = SwiftDate.defaultRegion.calendar,
				zone: ZoneConvertible = SwiftDate.defaultRegion.timeZone,
				locale: LocaleConvertible = SwiftDate.defaultRegion.locale) {
		self.calendar = Calendar.newCalendar(calendar, configure: {
			$0.timeZone = zone.toTimezone()
			$0.locale = locale.toLocale()
		})
	}

	/// Initialize a new Region by reading the `timeZone`,`calendar` and `locale`
	/// parameters from the passed `DateComponents` instance.
	/// For any `nil` parameter the correspondent `SwiftDate.defaultRegion` is used instead.
	///
	/// - Parameter fromDateComponents: date components
	public init(fromDateComponents components: DateComponents) {
		let tz = (components.timeZone ?? Zones.current.toTimezone())
		let cal = (components.calendar ?? Calendars.gregorian.toCalendar())
		let loc = (cal.locale ?? Locales.current.toLocale())
        self.init(calendar: cal, zone: tz, locale: loc)
	}

	public static var UTC: Region {
		return Region(calendar: Calendar.autoupdatingCurrent,
					  zone: Zones.gmt.toTimezone(),
					  locale: Locale.autoupdatingCurrent)
	}

	/// Return the current local device's region where all attributes are set to the device's values.
	///
	/// - Returns: Region
	public static var local: Region {
		return Region(calendar: Calendar.autoupdatingCurrent,
					  zone: TimeZone.autoupdatingCurrent,
					  locale: Locale.autoupdatingCurrent)
	}

	/// ISO Region is defined by the gregorian calendar, gmt timezone and english posix locale
	public static var ISO: Region {
		return Region(calendar: Calendars.gregorian.toCalendar(),
					  zone: Zones.gmt.toTimezone(),
					  locale: Locales.englishUnitedStatesComputer)
	}

	/// Return an auto updating region where all settings are obtained from the current's device settings.
	///
	/// - Returns: Region
	public static var current: Region {
		return Region(calendar: Calendar.autoupdatingCurrent,
					  zone: TimeZone.autoupdatingCurrent,
					  locale: Locale.autoupdatingCurrent)
	}

	/// Return a new region in current's device timezone with optional adjust of the calendar and locale.
	///
	/// - Parameters:
	///   - locale: locale to set
	///   - calendar: calendar to set
	/// - Returns: region
	public static func currentIn(locale: LocaleConvertible? = nil, calendar: CalendarConvertible? = nil) -> Region {
		return Region(calendar: (calendar ?? SwiftDate.defaultRegion.calendar),
					  zone: SwiftDate.defaultRegion.timeZone,
					  locale: (locale ?? SwiftDate.defaultRegion.locale))
	}

	/// Return the current date expressed into the receiver region.
	///
	/// - Returns: `DateInRegion` instance
	public func nowInThisRegion() -> DateInRegion {
		return DateInRegion(Date(), region: self)
	}

	// MARK: - Codable Support

	enum CodingKeys: String, CodingKey {
		case calendar
		case locale
		case timezone
	}

	public func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(calendar.timeZone.identifier, forKey: .timezone)
		try container.encode(calendar.locale!.identifier, forKey: .locale)
		try container.encode(calendar.identifier.description, forKey: .calendar)
	}

	public init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		let calId = Calendar.Identifier( try values.decode(String.self, forKey: .calendar))
		let tz = (TimeZone(identifier: try values.decode(String.self, forKey: .timezone)) ?? SwiftDate.defaultRegion.timeZone)
		let lc = Locale(identifier: try values.decode(String.self, forKey: .locale))
		calendar = Calendar.newCalendar(calId, configure: {
			$0.timeZone = tz
			$0.locale = lc
		})
	}

	// MARK: - Comparable

	public static func == (lhs: Region, rhs: Region) -> Bool {
		// Note: equality does not consider other parameters than the identifier of the major
		// attributes (calendar, timezone and locale). Deeper comparisor must be made directly
		// between Calendar (it may fail when you encode/decode autoUpdating calendars).
		return
			(lhs.calendar.identifier == rhs.calendar.identifier) &&
			(lhs.timeZone.identifier == rhs.timeZone.identifier) &&
			(lhs.locale.identifier == rhs.locale.identifier)
	}
}
