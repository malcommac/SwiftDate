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

// MARK: - Region

/// Region encapsulate information about the TimeZone, Calendar and Locale of an absolute time
public struct Region: CustomStringConvertible {
	public fileprivate(set) var timeZone: TimeZone
	public fileprivate(set) var calendar: Calendar
	public fileprivate(set) var locale: Locale
	
	public var description: String {
		return "Region with timezone: \(self.timeZone), calendar: \(self.calendar), locale: \(self.locale)"
	}
	
	/// Initialize a new Region by passing `TimeZone`, `Calendar` and `Locale` objects
	///
	/// - parameter tz:  timezone to use
	/// - parameter cal: calendar to use
	/// - parameter loc: locale to use
	///
	/// - returns: a new `Region`
	public init(tz: TimeZone, cal: Calendar, loc: Locale) {
		self.timeZone = tz
		self.calendar = cal
		self.calendar.timeZone = tz
		self.locale = loc
	}
	
	/// Initialize a new region by passing names for TimeZone, Calendar and Locale
	///
	/// - parameter tz:  timezone name to use (see `TimeZoneName`)
	/// - parameter cal: calendar name to use (see `CalendarName`)
	/// - parameter loc: locale name to use (see `LocaleName`)
	///
	/// - returns: a new `Region`
	public init(tz: TimeZoneName, cal: CalendarName, loc: LocaleName) {
		self.timeZone = tz.timeZone
		self.calendar = cal.calendar
		self.calendar.timeZone = tz.timeZone
		self.locale = loc.locale
	}
	
	/// Initialize a new region by passing a `DateComponents` instance
	/// Region is created by reading object's `.timezone`, `.calendar` and `.calendar.locale`
	///
	/// - parameter components: components to use
	///
	/// - returns: a new `Region`
	public init?(components: DateComponents) {
		let tz = components.timeZone ?? TimeZoneName.current.timeZone
		let cal = components.calendar ?? CalendarName.gregorian.calendar
		let loc = cal.locale ?? LocaleName.current.locale
		self.init(tz: tz, cal: cal, loc: loc)
	}
	
	/// Generate a new region which uses `GMT` timezone and current's device `Calendar` and `Locale`
	///
	/// - returns: a new `Region`
	public static func GMT() -> Region {
		let tz = TimeZoneName.gmt.timeZone
		let cal = CalendarName.current.calendar
		let loc = LocaleName.current.locale
		return Region(tz: tz, cal: cal, loc: loc)
	}
	
	/// Generate a new regione which uses current device's local settings (`Calendar`,`TimeZone` and `Locale`)
	///
	/// - parameter auto: `true` to get automatically new settings when device's timezone/calendar/locale changes
	///
	/// - returns: a new `Region`
	public static func Local(autoUpdate auto: Bool = true) -> Region {
		let tz = (auto ? TimeZoneName.currentAutoUpdating : TimeZoneName.current).timeZone
		let cal = (auto ? CalendarName.currentAutoUpdating : CalendarName.current).calendar
		let loc = (auto ? Locale.autoupdatingCurrent : Locale.current)
		return Region(tz: tz, cal: cal, loc: loc)
	}
		
	/// Identify the first weekday of the calendar.
	/// By default is `sunday`.
	public var firstWeekday: WeekDay {
		set {
			self.calendar.firstWeekday = newValue.rawValue
		}
		get {
			return WeekDay(rawValue: self.calendar.firstWeekday)!
		}
	}

}


// MARK: - Region Equatable Protocol

extension Region: Equatable {}


/// See if two regions are equal by comparing timezone, calendar and locale
///
/// - parameter left:  first region for comparision
/// - parameter right: second region for comparision
///
/// - returns: `true` if both region represent the same geographic/cultural location
public func == (left: Region, right: Region) -> Bool {
	if left.calendar.identifier != right.calendar.identifier {
		return false
	}
	
	if left.timeZone.identifier != right.timeZone.identifier {
		return false
	}
	
	if left.locale.identifier != right.locale.identifier {
		return false
	}
	
	return true
}


// MARK: - Region Hashable Protocol 

extension Region: Hashable {
	public var hashValue: Int {
		return self.calendar.hashValue ^ self.timeZone.hashValue ^ self.locale.hashValue
	}
}

