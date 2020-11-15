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

// MARK: - DataParsable Protocol

public protocol DateParsable {

	/// Convert a string to a `DateInRegion` instance by parsing it with given parser
	/// or using one of the built-in parser (if you know the format of the date you
	/// should consider explicitly pass it to avoid unecessary computations).
	///
	/// - Parameters:
	///   - format: format of the date, `nil` to leave the library to found the best
	///				one via `SwiftDate.autoFormats`
	///   - region: region in which the date should be expressed in.
	///				Region's locale is used to format the date when using long readable unit names (like MMM
	///				for month).
	/// - Returns: date in region representation, `nil` if parse fails
	func toDate(_ format: String?, region: Region) -> DateInRegion?

	/// Convert a string to a `DateInRegion` instance by parsing it with the ordered
	/// list of provided formats.
	/// If `formats` array is not provided it uses the `SwiftDate.autoFormats` array instead.
	/// Note: if you knwo the format of the date you should consider explicitly pass it to avoid
	///       unecessary computations.
	///
	/// - Parameters:
	///   - format: ordered formats to parse date (if you don't have a list of formats you can pass `SwiftDate.autoFormats`)
	///   - region: region in which the date should be expressed in.
	///				Region's locale is used to format the date when using long readable unit names (like MMM
	///				for month).
	/// - Returns: date in region representation, `nil` if parse fails
	func toDate(_ formats: [String], region: Region) -> DateInRegion?

	/// Convert a string to a valid `DateInRegion` using passed style.
	///
	/// - Parameters:
	///   - style: parsing style.
	///   - region: region in which the date should be expressed in
	/// - Returns: date in region representation, `nil` if parse fails
	func toDate(style: StringToDateStyles, region: Region) -> DateInRegion?

	/// Convert to date from a valid ISO8601 string
	///
	/// - Parameters:
	///   - options: options of the parser
	///   - region: region in which the date should be expressed in (timzone is ignored and evaluated automatically)
	/// - Returns: date in region representation, `nil` if parse fails
	func toISODate(_ options: ISOParser.Options?, region: Region?) -> DateInRegion?

	/// Convert to date from a valid DOTNET string
	///
	///   - region: region in which the date should be expressed in (timzone is ignored and evaluated automatically)
	/// - Returns: date in region representation, `nil` if parse fails
	func toDotNETDate(region: Region) -> DateInRegion?

	/// Convert to a date from a valid RSS/ALT RSS string
	///
	/// - Parameters:
	///   - alt: `true` if string represent an ALT RSS formatted date, `false` if a standard RSS formatted date.
	///   - region: region in which the date should be expressed in (timzone is ignored and evaluated automatically)
	/// - Returns: date in region representation, `nil` if parse fails
	func toRSSDate(alt: Bool, region: Region) -> DateInRegion?

	/// Convert to a date from a valid SQL format string.
	///
	/// - Parameters:
	///   - region: region in which the date should be expressed in (timzone is ignored and evaluated automatically)
	/// - Returns: date in region representation, `nil` if parse fails
	func toSQLDate(region: Region) -> DateInRegion?

}

// MARK: - DataParsable Implementation for Strings

extension String: DateParsable {

	public func toDate(_ format: String? = nil, region: Region = SwiftDate.defaultRegion) -> DateInRegion? {
		return DateInRegion(self, format: format, region: region)
	}

	public func toDate(_ formats: [String], region: Region) -> DateInRegion? {
		return DateInRegion(self, formats: formats, region: region)
	}

	public func toDate(style: StringToDateStyles, region: Region = SwiftDate.defaultRegion) -> DateInRegion? {
		return style.toDate(self, region: region)
	}

	public func toISODate(_ options: ISOParser.Options? = nil, region: Region? = nil) -> DateInRegion? {
		return ISOParser.parse(self, region: region, options: options)
	}

	public func toDotNETDate(region: Region = Region.ISO) -> DateInRegion? {
		return DOTNETParser.parse(self, region: region, options: nil)
	}

	public func toRSSDate(alt: Bool, region: Region = Region.ISO) -> DateInRegion? {
		switch alt {
		case true: 	return StringToDateStyles.altRSS.toDate(self, region: region)
		case false: return StringToDateStyles.rss.toDate(self, region: region)
		}
	}

	public func toSQLDate(region: Region = Region.ISO) -> DateInRegion? {
		return StringToDateStyles.sql.toDate(self, region: region)
	}
	
	public func asLocale() -> Locale {
               Locale(identifier: self)
        }
}
