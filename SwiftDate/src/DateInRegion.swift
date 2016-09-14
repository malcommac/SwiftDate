//
//  SwiftDate.swift
//  SwiftDate
//
//  Created by Daniele Margutti on 09/09/16.
//  Copyright © 2016 Daniele Margutti. All rights reserved.
//

import Foundation


/*	`DateInRegion` represent a Date in a specified world region: along with absolute date it essentially encapsulate
	all informations about the time zone (`TimeZone`), calendar (`Calendar`) and locale (`Locale`).
	These info are contained inside the `.region` property.

	Using `DateInRegion` you can:
		* Represent an absolute Date in a specific timezone/calendar/locale
		* Easy access to all date components (day,month,hour,minute etc.) of the date in specified region
		* Easily create a new date from string, date components or swift operators
		* Compare date using Swift operators like `==, !=, <, >, <=, >=` and several
			additional methods like `isInWeekend,isYesterday`...
		* Change date by adding or subtracting elements with Swift operators
			(e.g. `date + 2.days + 15.minutes`)
*/

public class DateInRegion: CustomStringConvertible {
	private(set) var region: Region
	private(set) var absoluteDate: Date
	
	
	/// Initialize a new `DateInRegion` object from an absolute date and a destination region.
	/// The new instance express given date into specified region.
	///
	/// - parameter absoluteDate: absolute `Date` object
	/// - parameter region:       region in which you would express given date (absolute time will be converted into passed region)
	///
	/// - returns: a new instance of the `DateInRegion` object
	public init(absoluteDate: Date, in region: Region? = nil) {
		let srcRegion = region ?? Region.Local()
		self.absoluteDate = absoluteDate
		self.region = srcRegion
	}
	
	public init(components: DateComponents) throws {
		guard let srcRegion = Region(components: components) else {
			throw DateError.MissingCalTzOrLoc
		}
		guard let absDate = srcRegion.calendar.date(from: components) else {
			throw DateError.FailedToParse
		}
		self.absoluteDate = absDate
		self.region = srcRegion
	}
	
	public init(components: [Calendar.Component : Int], fromRegion region: Region?) throws {
		let srcRegion = region ?? Region.Local()
		var components = DateInRegion.componentsFrom(values: components)
		components.timeZone = srcRegion.timeZone
		components.calendar = srcRegion.calendar
		components.calendar!.locale = srcRegion.locale
		guard let absDate = srcRegion.calendar.date(from: components) else {
			throw DateError.FailedToParse
		}
		self.absoluteDate = absDate
		self.region = srcRegion
	}
	
	public init(string: String, format: DateFormat, fromRegion region: Region?) throws {
		let srcRegion = region ?? Region.Local()
		switch format {
		case .custom(let format):
			guard let date = srcRegion.formatter(format: format).date(from: string) else {
				throw DateError.FailedToParse
			}
			self.absoluteDate = date
		case .iso8601(let options):
			guard let date = srcRegion.iso8601Formatter(options: options).date(from: string) else {
				throw DateError.FailedToParse
			}
			self.absoluteDate = date
		case .extended:
			let format = "eee dd-MMM-yyyy GG HH:mm:ss.SSS zzz"
			guard let date = srcRegion.formatter(format: format).date(from: string) else {
				throw DateError.FailedToParse
			}
			self.absoluteDate = date
		case .rss(let isAltRSS):
			let format = (isAltRSS ? "d MMM yyyy HH:mm:ss ZZZ" : "EEE, d MMM yyyy HH:mm:ss ZZZ")
			guard let date = srcRegion.formatter(format: format).date(from: string) else {
				throw DateError.FailedToParse
			}
			self.absoluteDate = date
		case .dotNET:
			guard let secsSince1970 = string.dotNETParseSeconds() else {
				throw DateError.FailedToParse
			}
			self.absoluteDate = Date(timeIntervalSince1970: secsSince1970)
		}
		self.region = srcRegion
	}
	
	public func toRegion(_ newRegion: Region) -> DateInRegion {
		return DateInRegion(absoluteDate: self.absoluteDate, in: newRegion)
	}
	
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
