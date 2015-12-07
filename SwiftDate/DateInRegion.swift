//
// SwiftDate.swift
// SwiftDate
//
//  Author:
//	Daniele Margutti
//	mail:		hello@danielemargutti.com
//	twitter:	@danielemargutti
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import Foundation

public class DateInRegion :CustomStringConvertible,CustomDebugStringConvertible {
	//MARK: - Properties
	
	/// This is the absolute time
	public			var absoluteTime		:NSDate!
	
	/// This is the region in which the date is represented. A region is defined by a calendar, a timezone and a locale.
	private(set)	var region		:Region
	
	/// Return the UTCDate represented into current timezone region. Note: NSDate is always expressed in UTC (so the final date is the original UTC date plus/minus differences between UTC and the currently specified timezone)
	public var localDate : NSDate? {
		return absoluteTime.dateByAddingTimeInterval(NSTimeInterval(region.timeZone.secondsFromGMT))
	}
	
	/// return the components of the date into defined region
	public var components :NSDateComponents? {
		return region.calendar.components(DateInRegion.flags, fromDate: absoluteTime)
	}
	
	// Private flags container
	static let flags: NSCalendarUnit = [.Day, .Month, .Year, .Hour, .Minute, .Second, .Nanosecond, .TimeZone, .Calendar, .YearForWeekOfYear, .WeekOfYear, .Weekday, .Quarter, .WeekOfMonth]
	internal static let componentFlagSet: [NSCalendarUnit] = [.Day, .Month, .Year, .Hour, .Minute, .Second, .Nanosecond, .YearForWeekOfYear, .WeekOfYear, .Weekday, .Quarter, .WeekdayOrdinal, .WeekOfMonth]
	
	//MARK: - Initialize a new DateInRegion
	
	/**
	Initialize a new DateInRegion instance with passed date and GMT as region property.
	
	- parameter date: an absolute UTC date
	
	- returns: a DateInRegion for UTC region with given date
	*/
	public static func UTCRegion(date :NSDate!) -> DateInRegion {
		let inUTCRegion = DateInRegion(absoluteTime: date, region: Region(tzType: TimeZoneNames.Other.GMT))!
		return inUTCRegion
	}

	/**
	Initialize a new DateInRegion instance by using the default region of Region
	
	- parameter date: an absolute UTC date
	
	- returns: a DateInRegion in default region with given date
	*/
	public static func DefaultRegion(date :NSDate!) -> DateInRegion {
		let inDefRegion = DateInRegion(absoluteTime: date, region: Region.defaultRegion())
		return inDefRegion!
	}
	
	/**
	Initialize a new DateInRegion by passing a reference date and a set of parameters allowed to create a Region structure inside.
	
	- returns: a new DateInRegion
	*/
	public init(refDate :NSDate = NSDate(), cal :CalendarType = CalendarType.Current, tz :TimeZoneCountry = TimeZoneNames.Other.GMT, locale :NSLocale = NSLocale.currentLocale()) {
		region = Region(calType :cal, tzType: tz, loc :locale)
		absoluteTime = refDate
	}
	
	/**
	Initialize a new DateInRegion with a date sepcified by passing a dictionary with calendar units and a locale
	
	- parameter dict:   dictionary with date components used for creation of the date
	- parameter locale: locale to set (UTCRegion() locale is used if not specified)
	
	- returns: a new DateInRegion with absoluteTime created by passing a dictionary of components
	*/
	public init?(components dict : [NSCalendarUnit : AnyObject], locale : NSLocale = Region.UTCRegion().locale) {
		let calendar = dict[NSCalendarUnit.Calendar] ?? Region.UTCRegion().calendar
		let timeZone = dict[NSCalendarUnit.TimeZone] ?? Region.UTCRegion().timeZone
		let components = DateInRegion.dateFromComponentsDict(dict)
		
		region = Region(cal: calendar as? NSCalendar, tz: timeZone as? NSTimeZone, loc: locale)
		absoluteTime = region.calendar.dateFromComponents(components)
		if absoluteTime == nil {
			return nil
		}
	}
	
	/**
	Initialize a new DateInRegion instance by passing an NSDateComponents object. Remember, this object can contain timeZone and calendar properties you can set and will be used to set the default region of the object. Be sure to specify them.
	
	- parameter components: components
	
	- returns: a new DateInRegion instance for specified date in passed timezone
	*/
	public init?(components :NSDateComponents) {
		let calendar = components.calendar ?? Region.UTCRegion().calendar
		let timeZone = components.timeZone ?? Region.UTCRegion().timeZone
		let locale = components.calendar?.locale ?? Region.UTCRegion().locale
		
		region = Region(cal: calendar, tz: timeZone, loc: locale)
		absoluteTime = region.calendar.dateFromComponents(components)
		if absoluteTime == nil {
			return nil
		}
	}
	
	/**
	Initialize a new DateInRegion object with specified UTC Date and region.
	
	- parameter date:   UTC date
	- parameter region: Destination region
	
	- returns: a new DateInRegion instance expressed into passed region
	*/
	public init?(absoluteTime date :NSDate? = NSDate(), region :Region = Region.defaultRegion()) {
		self.absoluteTime = date
		self.region = region
	}
	
	/**
	Initialize a new DateInRegion instance by passing calendar components. You can omit some properties according to NSDateComponents: When there are insufficient components provided to completely specify an absolute time, a calendar uses default values of its choice. When there is inconsistent information, a calendar may ignore some of the components parameters or the method may return nil. Unnecessary components are ignored (for example, Day takes precedence over Weekday and Weekday ordinals).
	
	- parameter date:              reference date to start (current if nil)
	- parameter era:               era value or nil to ignore it
	- parameter year:              year value or nil to ignore it
	- parameter month:             month value or nil to ignore it
	- parameter day:               day value or nil to ignore it
	- parameter yearForWeekOfYear: yearForWeekOfYear value or nil to ignore it
	- parameter weekOfYear:        weekOfYear value or nil to ignore it
	- parameter weekday:           weekday value or nil to ignore it
	- parameter hour:              hour value or nil to ignore it
	- parameter minute:            minute value or nil to ignore it
	- parameter second:            second value or nil to ignore it
	- parameter nanosecond:        nanosecond value or nil to ignore it
	- parameter region:            region to set (if not specified Region.defaultRegion() will be used instead)
	
	- returns: a new DateInRegion instance created from passed components and region
	*/
	public init(date					: NSDate? = NSDate(),
				era						: Int? = nil,
				year					: Int? = nil,
				month					: Int? = nil,
				day						: Int? = nil,
				yearForWeekOfYear		: Int? = nil,
				weekOfYear				: Int? = nil,
				weekday					: Int? = nil,
				hour					: Int? = nil,
				minute					: Int? = nil,
				second					: Int? = nil,
				nanosecond				: Int? = nil,
				region					: Region = Region.defaultRegion()) {
			
			
			self.region = region
			
			let components :NSDateComponents
			if date == nil {
				components = NSDateComponents()
			} else {
				components = region.calendar.components(DateInRegion.flags, fromDate: date!)
			}
			
			if let era = era { components.era = era }
			if let year = year { components.year = year }
			if let month = month { components.month = month }
			if let day = day { components.day = day }
			if let yearForWeekOfYear = yearForWeekOfYear { components.yearForWeekOfYear = yearForWeekOfYear }
			if let weekOfYear = weekOfYear { components.weekOfYear = weekOfYear }
			if let weekday = weekday { components.weekday = weekday }
			if let hour = hour { components.hour = hour }
			if let minute = minute { components.minute = minute }
			if let second = second { components.second = second }
			if let nanosecond = nanosecond { components.nanosecond = nanosecond }
			
			components.timeZone = region.timeZone
			components.calendar = region.calendar
			
			// determine way of conversion: year month day or year week weekday
			var ymdFactor = 0
			if components.year != NSDateComponentUndefined { ymdFactor++ }
			if components.month != NSDateComponentUndefined { ymdFactor++ }
			if components.day != NSDateComponentUndefined { ymdFactor++ }
			
			var ywwFactor = 0
			if components.yearForWeekOfYear != NSDateComponentUndefined { ywwFactor++ }
			if components.weekOfYear != NSDateComponentUndefined { ywwFactor++ }
			if components.weekday != NSDateComponentUndefined { ywwFactor++ }
			
			if ywwFactor > ymdFactor {
				components.year = NSDateComponentUndefined
				components.month = NSDateComponentUndefined
				components.day = NSDateComponentUndefined
			} else if ymdFactor > 0 {
				components.yearForWeekOfYear = NSDateComponentUndefined
				components.weekOfYear = NSDateComponentUndefined
				components.weekday = NSDateComponentUndefined
				components.weekOfMonth = NSDateComponentUndefined
			}
			
			absoluteTime = region.calendar.dateFromComponents(components)
	}
	
	/**
	Initialize a new DateInRegion by taking passed date unit and using a ref date at the start of that unit.
	So, for example, if you have a 2015-11-15T03:43:10UTC and you call this method by passing NSCalendarUnit.Hour you will
	get a new DateInRegion with UTC's date of this type: 2015-11-15T03:00:00UTC.
	If you use NSCalendarUnit. Month you will get 2015-11-01T00:00:00UTC.
	
	- parameter date:   reference date
	- parameter unit:   parameter used to compose the region's new date at the start of the unit of passed reference date
	- parameter region: destination region
	
	- returns: a new DateInRegion instance
	*/
	public init?(startOfDate date : NSDate = NSDate(), unit :NSCalendarUnit!, region :Region = Region.defaultRegion()) {
		self.region = region
		self.absoluteTime = self.startOfDateForUnit(unit, date: date)
	}
	
	/**
	Initialize a new DateInRegion by taking passed date unit and using a ref date at the end of that unit.
	
	- parameter date:   reference date
	- parameter unit:   parameter used to compose the region's new date at the end of the unit of passed reference date
	- parameter region: destination region
	
	- returns: a new DateInRegion instance
	*/
	public init?(endOfDate date : NSDate = NSDate(), unit :NSCalendarUnit!, region :Region = Region.defaultRegion()) {
		self.region = region
		var nextDate = region.calendar.dateByAddingUnit(unit, value: 1, toDate: date, options: NSCalendarOptions(rawValue: 0))!
		nextDate = self.startOfDateForUnit(unit, date: nextDate)!
		nextDate = region.calendar.dateByAddingUnit(.Nanosecond, value: -1000000, toDate: nextDate, options: NSCalendarOptions(rawValue: 0))!
		self.absoluteTime = nextDate
	}
	
	/**
	Initialize a new DateInRegion string from a specified date string, a given format and a destination region for the date
	
	- parameter date:   date value as string
	- parameter format: format used to parse string
	- parameter region: region of destination (date is parsed with the format specified by the string value)
	
	- returns: a new DateInRegion instance
	*/
	public init?(fromString date :String, format :DateFormat, region :Region = Region.defaultRegion()) {
		
		self.region = region
		
		let cachedFormatter = NSDateFormatter.cachedFormatter().saveState()
		let parsedDate :NSDate?
		
		switch format {
		case .ISO8601: // 1972-07-16T08:15:30-05:00
			cachedFormatter.formatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
			cachedFormatter.formatter.timeZone = NSTimeZone.localTimeZone()
			cachedFormatter.formatter.dateFormat = String.ISO8601Formatter(fromString: date)
			parsedDate = cachedFormatter.formatter.dateFromString(date)
		case .ISO8601Date:
			cachedFormatter.formatter.dateFormat = "yyyy-MM-dd"
			parsedDate = cachedFormatter.formatter.dateFromString(date)
		case .AltRSS: // 09 Sep 2011 15:26:08 +0200
			var formattedString : NSString = date
			if formattedString.hasSuffix("Z") {
				formattedString = formattedString.substringToIndex(formattedString.length-1) + "GMT"
			}
			cachedFormatter.formatter.dateFormat = "d MMM yyyy HH:mm:ss ZZZ"
			parsedDate = cachedFormatter.formatter.dateFromString(formattedString as String)
		case .RSS: // Fri, 09 Sep 2011 15:26:08 +0200
			var formattedString : NSString = date
			if formattedString.hasSuffix("Z") {
				formattedString = formattedString.substringToIndex(formattedString.length-1) + "GMT"
			}
			cachedFormatter.formatter.dateFormat = "EEE, d MMM yyyy HH:mm:ss ZZZ"
			parsedDate = cachedFormatter.formatter.dateFromString(formattedString as String)
		case .Extended:
			cachedFormatter.formatter.dateFormat = "eee dd-MMM-yyyy GG HH:mm:ss.SSS zzz"
			parsedDate = cachedFormatter.formatter.dateFromString(date)
		case .Custom(let dateFormat):
			cachedFormatter.formatter.dateFormat = dateFormat
			cachedFormatter.formatter.timeZone = region.timeZone
			cachedFormatter.formatter.calendar = region.calendar
			cachedFormatter.formatter.locale = region.locale
			parsedDate = cachedFormatter.formatter.dateFromString(date)
		}
		
		self.absoluteTime = parsedDate
		cachedFormatter.restoreState()
	}
	
	//MARK: Private Methods -
	
	private func startOfDateForUnit(unit: NSCalendarUnit, date: NSDate) -> NSDate? {
		let components = region.calendar.components(DateInRegion.flags, fromDate: date)
		switch unit {
		case NSCalendarUnit.Era:
			components.year = 1
			components.month = 1
			components.day = 1
			components.hour = 0
			components.minute = 0
			components.second = 0
			components.nanosecond = 0
			components.yearForWeekOfYear = NSDateComponentUndefined
			components.weekOfYear = NSDateComponentUndefined
			components.weekday = NSDateComponentUndefined
		case NSCalendarUnit.Year:
			components.month = 1
			components.day = 1
			components.hour = 0
			components.minute = 0
			components.second = 0
			components.nanosecond = 0
			components.yearForWeekOfYear = NSDateComponentUndefined
			components.weekOfYear = NSDateComponentUndefined
			components.weekday = NSDateComponentUndefined
		case NSCalendarUnit.Month:
			components.day = 1
			components.hour = 0
			components.minute = 0
			components.second = 0
			components.nanosecond = 0
			components.yearForWeekOfYear = NSDateComponentUndefined
			components.weekOfYear = NSDateComponentUndefined
			components.weekday = NSDateComponentUndefined
			components.weekOfMonth = NSDateComponentUndefined
			components.quarter = NSDateComponentUndefined
		case NSCalendarUnit.Day, NSCalendarUnit.Weekday:
			components.hour = 0
			components.minute = 0
			components.second = 0
			components.nanosecond = 0
			components.yearForWeekOfYear = NSDateComponentUndefined
			components.weekOfYear = NSDateComponentUndefined
			components.weekday = NSDateComponentUndefined
		case NSCalendarUnit.Hour:
			components.minute = 0
			components.second = 0
			components.nanosecond = 0
			components.yearForWeekOfYear = NSDateComponentUndefined
			components.weekOfYear = NSDateComponentUndefined
			components.weekday = NSDateComponentUndefined
		case NSCalendarUnit.Minute:
			components.second = 0
			components.nanosecond = 0
			components.yearForWeekOfYear = NSDateComponentUndefined
			components.weekOfYear = NSDateComponentUndefined
			components.weekday = NSDateComponentUndefined
		case NSCalendarUnit.Second:
			components.nanosecond = 0
			components.yearForWeekOfYear = NSDateComponentUndefined
			components.weekOfYear = NSDateComponentUndefined
			components.weekday = NSDateComponentUndefined
		case NSCalendarUnit.YearForWeekOfYear:
			components.weekOfYear = 1
			components.weekday = region.calendar.firstWeekday
			components.hour = 0
			components.minute = 0
			components.second = 0
			components.nanosecond = 0
			components.year = NSDateComponentUndefined
			components.month = NSDateComponentUndefined
			components.day = NSDateComponentUndefined
		case NSCalendarUnit.WeekOfYear:
			components.weekday = region.calendar.firstWeekday
			components.hour = 0
			components.minute = 0
			components.second = 0
			components.nanosecond = 0
			components.year = NSDateComponentUndefined
			components.month = NSDateComponentUndefined
			components.day = NSDateComponentUndefined
		default:
			return nil
		}
		return region.calendar.dateFromComponents(components)
	}
	
	//MARK: - Description
	
	public var description :String {
		get {
			return debugDescription
		}
	}
	
	public var debugDescription :String {
		get {
			guard let _ = absoluteTime else { return "DateInRegion has not absoluteTime set" }
			let descUTC = self.absoluteTime!.description
			let descLocal = "\(self.toString(DateFormat.ISO8601)) | \(region.timeZone.name) | \(region.calendar.calendarIdentifier) | (\(region.locale.localeIdentifier))"
			return "UTC: \(descUTC) (LOCAL: \(descLocal))"
		}
	}
	
	//MARK: - Change TimeZone and Locale
	
	/**
	Convert this region's timezone into another region's timezone
	
	- parameter tz: destination timezone
	
	- returns: a new DateInRegion with the same date expressed in another timezone
	*/
	public func withTimeZone(tz : TimeZoneCountry) -> DateInRegion {
		region.timeZone = NSTimeZone.fromType(tz)
		return self
	}
	
	/**
	Convert DateInRegion into another Region
	
	- parameter region: destination region
	
	- returns: DateInRegion instance with date in this world's region
	*/
	public func inRegion(anotherRegion region: Region) -> DateInRegion {
		let dateInRegion = DateInRegion(absoluteTime: absoluteTime, region: region)
		return dateInRegion!
	}
	
	/**
	Convert this region's locale into another region's locale
	
	- parameter loc: destination locale
	
	- returns: a new DateInRegion with the same date and timezone but a different locale
	*/
	public func withLocale(loc : NSLocale) -> DateInRegion {
		region.locale = loc
		return self
	}
}

// MARK: - Manage DateInRegion Date Components -

public extension DateInRegion {
	
	/**
	Return if a specified UTC date represented in current region is inside a time range
	
	- parameter minTime: minimum time (must be < maxTime)
	- parameter maxTime: max time (must be > minTime)
	- parameter format:  format of both minTime and maxTime (if not specified 'HH:MM' hours/minutes is used)
	
	- returns: true if time of the date is inside specified time range of the current represented region
	*/
	public func inTimeRange(minTime: String!, maxTime: String!, format: String?) -> Bool {
		let dateFormatter = NSDateFormatter.cachedFormatter().saveState()
		dateFormatter.formatter.dateFormat = format ?? "HH:mm"
		dateFormatter.formatter.timeZone = NSTimeZone(abbreviation: "UTC")
		let minTimeDate = dateFormatter.formatter.dateFromString(minTime)
		let maxTimeDate = dateFormatter.formatter.dateFromString(maxTime)
		if minTimeDate == nil || maxTimeDate == nil {
			dateFormatter.restoreState()
			return false
		}
		let inBetween = (self.absoluteTime.compare(minTimeDate!) == NSComparisonResult.OrderedDescending &&
			self.absoluteTime.compare(maxTimeDate!) == NSComparisonResult.OrderedAscending)
		
		dateFormatter.restoreState()
		return inBetween
		
		
		/*let dateFormatter = NSDate.localThreadDateFormatter()
		dateFormatter.dateFormat = format ?? "HH:mm"
		dateFormatter.timeZone = NSTimeZone(abbreviation: "UTC")
		let minTimeDate = dateFormatter.dateFromString(minTime)
		let maxTimeDate = dateFormatter.dateFromString(maxTime)*/
		
		/*		let minArray = minTime.componentsSeparatedByString(":")
		let minTimeDate = NSDate().set(componentsDict: ["hour":Int(minArray[0])!, "minute":Int(minArray[1])!])
		
		let maxArray = maxTime.componentsSeparatedByString(":")
		let maxTimeDate = NSDate().set(componentsDict: ["hour":Int(maxArray[0])!, "minute":Int(maxArray[1])!])
		
		if minTimeDate == nil || maxTimeDate == nil {
		return false
		}
		let inBetween = (self.compare(minTimeDate!) == NSComparisonResult.OrderedDescending &&
		self.compare(maxTimeDate!) == NSComparisonResult.OrderedAscending)
		
		print("minTimeDate: \(minTimeDate)")
		print("maxTimeDate: \(maxTimeDate)")
		print("current: \(self)")
		
		return inBetween*/
	}
	
	public func difference(otherDate :DateInRegion, flags :NSCalendarUnit) -> NSDateComponents {
		let components = region.calendar.components(flags, fromDate: self.absoluteTime, toDate: otherDate.absoluteTime, options: NSCalendarOptions(rawValue: 0))
		return components
	}
	
	/**
	Return the value of a component of the date expressed in specified region
	
	- parameter flag: component to get
	
	- returns: value of the component into specified region's timezone
	*/
	public func valueFor(component flag :NSCalendarUnit) -> Int? {
		guard let _ = absoluteTime else { return nil }
		region.calendar.timeZone = region.timeZone
		region.calendar.locale = region.locale
		let value = region.calendar.component(flag, fromDate: self.absoluteTime!)
		return value
	}
	
	/**
	Return a dictionary with all valid (non-nil) date component values of the date expressed into specified region
	
	- parameter flags: list of flags to get
	
	- returns: a dictionary with flag,value of the absoluteTime specified in region's timezone
	*/
	public func valueFor(components flags : [NSCalendarUnit]) -> [NSCalendarUnit : AnyObject] {
		var resultDict : [NSCalendarUnit : AnyObject] = [:]
		for flag in flags {
			let value = valueFor(component: flag)
			if value != nil {
				resultDict[flag] = value!
			}
		}
		return resultDict
	}
	
	/**
	Return true if date is today into specified region's timezone
	
	- returns: true if date is today into specified region's timezone
	*/
	public func isToday() -> Bool {
		return region.calendar.isDateInToday(absoluteTime)
	}
	
	/**
	Return true if date is yesterday into specified region's timezone
	
	- returns: true if date is yesterday into specified region's timezone
	*/
	public func isYesterday() -> Bool {
		return region.calendar.isDateInYesterday(absoluteTime)
	}
	
	/**
	Return true if date is tomorrow into specified region's timezone
	
	- returns: true if date is tomorrow into specified region's timezone
	*/
	public func isTomorrow() -> Bool {
		return region.calendar.isDateInTomorrow(absoluteTime)
	}
	
	/**
	Return true if date is a weekend day into specified region calendar
	
	- returns: true if date is tomorrow into specified region calendar
	*/
	public func isWeekend() -> Bool {
		return region.calendar.isDateInWeekend(absoluteTime)
	}
	
	/// Era of the date expressed in this region's timezone
	public var era :Int? {
		return valueFor(component: .Era)
	}
	
	/// Year of the date expressed in this region's timezone
	public var year :Int? {
		return valueFor(component: .Year)
	}
	
	/// Month of the date expressed in this region's timezone
	public var month :Int? {
		return valueFor(component: .Month)
	}
	
	/// Month name of the date expressed in this region's timezone using region's locale
	public var monthName :String? {
		guard let _ = absoluteTime else { return nil }
		let cachedFormatter = NSDateFormatter.cachedFormatter().saveState()
		cachedFormatter.formatter.locale = region.locale
		let value = cachedFormatter.formatter.monthSymbols[self.month! - 1] as String
		cachedFormatter.restoreState()
		return value
	}
	
	/// Week day name of the date expressed in this region's locale
	var weekdayName: String? {
		guard let _ = absoluteTime else { return nil }
		let cachedFormatter = NSDateFormatter.cachedFormatter().saveState()
		
		cachedFormatter.formatter.dateFormat = "EEEE"
		cachedFormatter.formatter.locale = region.locale
		let value = cachedFormatter.formatter.stringFromDate(absoluteTime)
		
		cachedFormatter.restoreState()
		return value
	}
	
	/// Day of the date expressed in this region's timezone
	public var day :Int? {
		return valueFor(component: .Day)
	}
	
	/// Hour of the date expressed in this region's timezone
	public var hour :Int? {
		return valueFor(component: .Hour)
	}
	
	/// Nearest rounded hour from the date expressed in this region's timezone
	public var nearestHour :Int {
		let date = (self + 30.minutes)!
		return Int(date.hour!);
	}
	
	/// Minute of the date expressed in this region's timezone
	public var minute :Int? {
		return valueFor(component: .Minute)
	}
	
	/// Seconds of the date expressed in this region's timezone
	public var second :Int? {
		return valueFor(component: .Second)
	}
	
	/// Nanoseconds of the date expressed in this region's timezone
	public var nanosecond :Int? {
		return valueFor(component: .Nanosecond)
	}
	
	/// Year for week of year of the date expressed in this region's timezone
	public var yearForWeekOfYear :Int? {
		return valueFor(component: .YearForWeekOfYear)
	}
	
	/// Week of year of the date expressed in this region's timezone, calendar and locale
	public var weekOfYear :Int? {
		return valueFor(component: .WeekOfYear)
	}
	
	/// Weekday number of the date expressed in this region's timezone, calendar and locale
	public var weekday :Int? {
		return valueFor(component: .Weekday)
	}
	
	/// Weekday ordinal value of the date expressed in this region's timezone, calendar and locale
	public var weekdayOrdinal :Int? {
		return valueFor(component: .WeekdayOrdinal)
	}
	
	/// Week of the month of the date expressed in this region's timezone, calendar and locale
	public var weekOfMonth :Int? {
		return valueFor(component: .WeekOfMonth)
	}
	
	/// Return the first day number of the week from current date expressed in current region
	var firstDayOfWeek : Int? {
		return DateInRegion(startOfDate: absoluteTime, unit: .WeekOfYear, region: region)?.day
	}
	
	/// Return the last day number of the week from current date expressed in current region
	var lastDayOfWeek : Int? {
		return DateInRegion(endOfDate: absoluteTime, unit: .WeekOfYear, region: region)?.day
	}
	
	/// Nmber of days into current's date month expressed in current region calendar and locale
	public var monthDays :Int? {
		guard let _ = absoluteTime else { return nil }
		return region.calendar.rangeOfUnit(NSCalendarUnit.Day, inUnit: NSCalendarUnit.Month, forDate: absoluteTime).length
	}
	
	/// True if current date's year is a leap year
	public var leapYear: Bool {
		// Library function for leap contains a bug for Gregorian calendars, implemented workaround
		if region.calendar.calendarIdentifier == NSCalendarIdentifierGregorian {
			let testRegion = DateInRegion(date: absoluteTime,  month: 2, day: 1)
			return testRegion.region.calendar.components([.Day, .Month, .Year], fromDate: absoluteTime).leapMonth
		}
		
		// For other calendars:
		return region.calendar.components([.Day, .Month, .Year], fromDate: absoluteTime).leapMonth
	}
	
	/// True if current's date month is a leap month
	public var leapMonth: Bool {
		// Library function for leap contains a bug for Gregorian calendars, implemented workaround
		if region.calendar.calendarIdentifier == NSCalendarIdentifierGregorian && year >= 1582 {
			let range = region.calendar.rangeOfUnit(NSCalendarUnit.Day, inUnit: NSCalendarUnit.Month, forDate: absoluteTime)
			return range.length == 29
		}
		
		// For other calendars:
		return region.calendar.components([.Day, .Month, .Year], fromDate: absoluteTime).leapMonth
	}
	
}

//MARK: - Extension of Int To Manage Operations -

public extension NSDateComponents {
	
	/**
	Create a new date from a specific date by adding self components
	
	- parameter refDate: reference date
	- parameter region: optional region to define the timezone and calendar. By default is UTC Region
	
	- returns: a new NSDate instance in UTC format
	*/
	public func fromDate(refDate :NSDate!, inRegion region: Region = Region.defaultRegion()) -> NSDate {
		let date = region.calendar.dateByAddingComponents(self, toDate: refDate, options: NSCalendarOptions(rawValue: 0))
		return date!
	}
	
	/**
	Create a new date from a specific date by subtracting self components
	
	- parameter refDate: reference date
	- parameter region: optional region to define the timezone and calendar. By default is UTC Region
	
	- returns: a new NSDate instance in UTC format
	*/
	public func agoFromDate(refDate :NSDate!, inRegion region: Region = Region.defaultRegion()) -> NSDate {
		for unit in DateInRegion.componentFlagSet {
			let value = self.valueForComponent(unit)
			if value != NSDateComponentUndefined {
				self.setValue((value * -1), forComponent: unit)
			}
		}
		return region.calendar.dateByAddingComponents(self, toDate: refDate, options: NSCalendarOptions(rawValue: 0))!
	}
	
	/**
	Create a new date from current date and add self components.
	So you can make something like:
		let date = 4.days.fromNow()
	
	- parameter region: optional region to define the timezone and calendar. By default is UTC Region
	
	- returns: a new NSDate instance in UTC format
	*/
	public func fromNow(inRegion region: Region = Region.UTCRegion()) -> NSDate {
		return fromDate(NSDate(), inRegion: region)
	}
	
	/**
	Create a new date from current date and substract self components
	So you can make something like:
		let date = 5.hours.ago()
	
	- parameter region: optional region to define the timezone and calendar. By default is UTC Region
	
	- returns: a new NSDate instance in UTC format
	*/
	public func ago(inRegion region: Region = Region.UTCRegion()) -> NSDate {
		return agoFromDate(NSDate())
	}
	
	/// The same of calling fromNow() with default UTC region
	public var fromNow : NSDate {
		get {
			return fromDate(NSDate())
		}
	}
	
	/// The same of calling ago() with default UTC region
	public var ago : NSDate {
		get {
			return agoFromDate(NSDate())
		}
	}
	
	public var inUTCRegion : DateInRegion? {
		get {
			return inRegion()
		}
	}
	
	public func inRegion(region : Region = Region.UTCRegion()) -> DateInRegion? {
		let dInRegion = DateInRegion(components: self)
		dInRegion?.region = region
		return dInRegion
	}
	
	/**
	Create an NSDate from a date specified by a list of components expressed in a specific time format
	Resulting NSDate instance will be the UTC translation of the date expressed in another formast.
	If you want to keep the origin timezone and date use DateInRegion instead.
	
	- parameter cal: calendar (gregorian if not specified)
	- parameter tz:  timezone of the parsed date (non optional)
	
	- returns: an UTC representation of given date expressed in passed timezone and calendar
	*/
	public func fromTimeZone(cal :CalendarType = CalendarType.Gregorian, tz :TimeZoneCountry!, locale :NSLocale = NSLocale.currentLocale()) -> NSDate? {
		self.calendar = cal.toCalendar()
		self.calendar?.timeZone = tz.toTimeZone()!
		self.calendar?.locale = locale
		return self.date
	}
	
	public func inUTCDate(cal :CalendarType = CalendarType.Gregorian, locale :NSLocale = NSLocale.currentLocale()) -> NSDate? {
		self.calendar = cal.toCalendar()
		self.calendar?.timeZone = TimeZoneNames.Other.GMT.toTimeZone()!
		self.calendar?.locale = locale
		return self.date
	}
	
}


//MARK: - Combine NSDateComponents -

public func | (lhs: NSDateComponents, rhs :NSDateComponents) -> NSDateComponents {
	let dc = NSDateComponents()
	for unit in DateInRegion.componentFlagSet {
		let lhs_value = lhs.valueForComponent(unit)
		let rhs_value = rhs.valueForComponent(unit)
		if lhs_value != NSDateComponentUndefined {
			dc.setValue(lhs_value, forComponent: unit)
		}
		if rhs_value != NSDateComponentUndefined {
			dc.setValue(rhs_value, forComponent: unit)
		}
	}
	return dc
}

public func + (lhs: NSDateComponents, rhs: NSDateComponents) -> NSDateComponents {
	return sumDateComponents(lhs, rhs: rhs)
}

public func - (lhs: NSDateComponents, rhs: NSDateComponents) -> NSDateComponents {
	return sumDateComponents(lhs, rhs: rhs, sum: false)
}

private func sumDateComponents(lhs :NSDateComponents, rhs :NSDateComponents, sum :Bool = true) -> NSDateComponents {
	let newComponents = NSDateComponents()
	let components = DateInRegion.componentFlagSet
	for unit in components {
		let leftValue = lhs.valueForComponent(unit)
		let rightValue = rhs.valueForComponent(unit)
		
		if leftValue == NSDateComponentUndefined && rightValue == NSDateComponentUndefined {
			continue // unit we won't touch
		}
		
		if leftValue != NSDateComponentUndefined && rightValue != NSDateComponentUndefined {
			let finalValue =  ((leftValue + rightValue) * (sum == true ? 1 : -1))
			newComponents.setValue( finalValue, forComponent: unit)
		} else {
			let finalValue = ( (leftValue != NSDateComponentUndefined ? leftValue : rightValue) * (sum == true ? 1 : -1))
			newComponents.setValue(finalValue, forComponent: unit)
		}
	}
	return newComponents
}

//MARK: - Combine Time Components -

public extension Int {
	
	/// allows to make math operation with date components (like 1.seconds + 2.hours etc.)
	public var nanoseconds :NSDateComponents {
		let dateComponents = NSDateComponents()
		dateComponents.nanosecond = self
		return dateComponents
	}
	
	/// allows to make math operation with date components (like 1.seconds + 2.hours etc.)
	public var seconds :NSDateComponents {
		let dateComponents = NSDateComponents()
		dateComponents.second = self
		return dateComponents
	}
	
	/// allows to make math operation with date components (like 1.seconds + 2.hours etc.)
	public var minutes :NSDateComponents {
		let dateComponents = NSDateComponents()
		dateComponents.minute = self
		return dateComponents
	}
	
	/// allows to make math operation with date components (like 1.seconds + 2.hours etc.)
	public var hours :NSDateComponents {
		let dateComponents = NSDateComponents()
		dateComponents.hour = self
		return dateComponents
	}
	
	/// allows to make math operation with date components (like 1.seconds + 2.hours etc.)
	public var days :NSDateComponents {
		let dateComponents = NSDateComponents()
		dateComponents.day = self
		return dateComponents
	}
	
	/// allows to make math operation with date components (like 1.seconds + 2.hours etc.)
	public var weeks :NSDateComponents {
		let dateComponents = NSDateComponents()
		dateComponents.weekOfYear = self
		return dateComponents
	}
	
	/// allows to make math operation with date components (like 1.seconds + 2.hours etc.)
	public var months :NSDateComponents {
		let dateComponents = NSDateComponents()
		dateComponents.month = self
		return dateComponents
	}
	
	/// allows to make math operation with date components (like 1.seconds + 2.hours etc.)
	public var years :NSDateComponents {
		let dateComponents = NSDateComponents()
		dateComponents.year = self
		return dateComponents
	}
}

//MARK: - DateInRegion Formatters -

public extension String {
	
	/**
	Convert a string into NSDate by passing conversion format
	
	- parameter format: format used to parse the string
	
	- returns: a new NSDate instance or nil if something went wrong during parsing
	*/
	public func toDate(format :DateFormat) -> NSDate? {
		return toRegion(format, region: Region.UTCRegion())?.absoluteTime
	}
	
	/**
	Convert a string which represent an ISO8601 date into NSDate
	
	- returns: NSDate instance or nil if string cannot be parsed
	*/
	public func toDateFromISO8601() -> NSDate? {
		let date = toRegion(DateFormat.ISO8601)?.absoluteTime
		return date
	}
	
	/**
	Create a new DateInRegion from a string which represent a date
	
	- parameter format: format to parse string
	- parameter region: region to assign
	
	- returns: a new DateInRegion with parsed date or nil if something went wrong
	*/
	public func toRegion(format :DateFormat, region :Region = Region.defaultRegion()) -> DateInRegion? {
		if self.isEmpty {
			return nil
		}
		return DateInRegion(fromString: self, format: format, region: region)
	}
	
	var _sdLocalize: String {
		return NSBundle.mainBundle().localizedStringForKey(self, value: nil, table: "SwiftDate")
	}
	
	func _sdToCalendarUnit() -> NSCalendarUnit {
		switch self {
		case "year":
			return NSCalendarUnit.Year
		case "month":
			return NSCalendarUnit.Month
		case "weekOfYear":
			return NSCalendarUnit.WeekOfYear
		case "day":
			return NSCalendarUnit.Day
		case "hour":
			return NSCalendarUnit.Hour
		case "minute":
			return NSCalendarUnit.Minute
		case "second":
			return NSCalendarUnit.Second
		case "nanosecond":
			return NSCalendarUnit.Nanosecond
		default:
			return []
		}
	}
}

//MARK: - From DateInRegion to String -

public extension DateInRegion {
	
	/**
	Return an ISO8601 string from current UTC Date of the region
	
	- returns: a new string or nil if DateInRegion does not contains any valid date
	*/
	public func toISO8601String() -> String? {
		guard let _ = absoluteTime else {
			return nil
		}
		let cachedFormatter = NSDateFormatter.cachedFormatter().saveState()
		
		cachedFormatter.formatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
		cachedFormatter.formatter.timeZone = NSTimeZone(abbreviation: "UTC")
		cachedFormatter.formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
		let value = cachedFormatter.formatter.stringFromDate(absoluteTime).stringByAppendingString("Z")
		
		cachedFormatter.restoreState()
		return value
	}
	
	/**
	Convert a DateInRegion to a string using region's timezone, locale and calendar
	
	- parameter dateFormat: format of the string
	
	- returns: a new string or nil if DateInRegion does not contains any valid date
	*/
	public func toString(dateFormat :DateFormat!) -> String? {
		guard let _ = absoluteTime else {
			return nil
		}
		let cachedFormatter = NSDateFormatter.cachedFormatter().saveState()
		
		let dateFormatString = dateFormat.formatString
		cachedFormatter.formatter.dateFormat = dateFormatString
		cachedFormatter.formatter.timeZone = region.timeZone
		cachedFormatter.formatter.calendar = region.calendar
		cachedFormatter.formatter.calendar.locale = region.calendar.locale
		let value = cachedFormatter.formatter.stringFromDate(self.absoluteTime!)
		
		cachedFormatter.restoreState()
		return value
	}
	
	/**
	Convert a DateInRegion date into a date with date & time style specific format style
	
	- parameter style:     style to format both date and time (if you specify this you don't need to specify dateStyle,timeStyle)
	- parameter dateStyle: style to format the date
	- parameter timeStyle: style to format the time
	
	- returns: a new string which represent the date expressed into the current region or nil if region does not contain valid date
	*/
	public func toString(style: NSDateFormatterStyle? = nil, dateStyle: NSDateFormatterStyle? = nil, timeStyle: NSDateFormatterStyle? = nil) -> String? {
		guard let _ = absoluteTime else {
			return nil
		}
		let cachedFormatter = NSDateFormatter.cachedFormatter().saveState()
		
		cachedFormatter.formatter.dateStyle = style ?? dateStyle ?? .NoStyle
		cachedFormatter.formatter.timeStyle = style ?? timeStyle ?? .NoStyle
		if cachedFormatter.formatter.dateStyle == .NoStyle && cachedFormatter.formatter.timeStyle == .NoStyle {
			cachedFormatter.formatter.dateStyle = .MediumStyle
			cachedFormatter.formatter.timeStyle = .MediumStyle
		}
		cachedFormatter.formatter.locale = region.locale
		cachedFormatter.formatter.calendar = region.calendar
		cachedFormatter.formatter.timeZone = region.timeZone
		let value = cachedFormatter.formatter.stringFromDate(absoluteTime)
		
		cachedFormatter.restoreState()
		return value
	}
	
	public func toShortString(date :Bool? = true, time :Bool? = true) -> String? {
		return toString(dateStyle: (date == true ? NSDateFormatterStyle.ShortStyle : NSDateFormatterStyle.NoStyle),
			timeStyle: (time == true ? NSDateFormatterStyle.ShortStyle : NSDateFormatterStyle.NoStyle))
	}
	
	public func toMediumString(date :Bool? = true, time :Bool? = true) -> String? {
		return toString(dateStyle: (date == true ? NSDateFormatterStyle.MediumStyle : NSDateFormatterStyle.NoStyle),
			timeStyle: (time == true ? NSDateFormatterStyle.MediumStyle : NSDateFormatterStyle.NoStyle))
	}
	
	public func toLongString(date :Bool? = true, time :Bool? = true) -> String? {
		return toString(dateStyle: (date == true ? NSDateFormatterStyle.LongStyle : NSDateFormatterStyle.NoStyle),
						timeStyle: (time == true ? NSDateFormatterStyle.LongStyle : NSDateFormatterStyle.NoStyle))
	}
	
	public func toRelativeCocoaString() -> String? {
		let formatter = NSDateFormatter()
		formatter.locale = region.locale
		formatter.calendar = region.calendar
		formatter.timeZone = region.timeZone
		formatter.dateStyle = .MediumStyle
		formatter.doesRelativeDateFormatting = true
		return formatter.stringFromDate(absoluteTime)
	}
	
	public func toRelativeString(fromDate: DateInRegion!, abbreviated : Bool = false, maxUnits: Int = 1) -> String {
		let seconds = fromDate.absoluteTime.timeIntervalSinceDate(absoluteTime)
		if fabs(seconds) < 1 {
			return "just now"._sdLocalize
		}
		
		let significantFlags : NSCalendarUnit = DateInRegion.flags
		let components = region.calendar.components(significantFlags, fromDate: fromDate.absoluteTime, toDate: absoluteTime, options: [])
		
		var string = String()
		var numberOfUnits:Int = 0
		let unitList : [String] = ["year", "month", "weekOfYear", "day", "hour", "minute", "second", "nanosecond"]
		for unitName in unitList {
			let unit : NSCalendarUnit = unitName._sdToCalendarUnit()
			if ((significantFlags.rawValue & unit.rawValue) != 0) &&
				(absoluteTime._sdCompareCalendarUnit(NSCalendarUnit.Nanosecond, other: unit) != .OrderedDescending) {
					let number:NSNumber = NSNumber(float: fabsf(components.valueForKey(unitName)!.floatValue))
					if Bool(number.integerValue) {
						let singular = (number.unsignedIntegerValue == 1)
						let suffix = String(format: "%@ %@", arguments: [number, absoluteTime._sdLocalizeStringForValue(singular, unit: unit, abbreviated: abbreviated)])
						if string.isEmpty {
							string = suffix
						} else if numberOfUnits < maxUnits {
							string += String(format: " %@", arguments: [suffix])
						}
						numberOfUnits += 1
					}
			}
		}
		return string
	}
}

private extension NSDate {
	func _sdCompareCalendarUnit(unit:NSCalendarUnit, other:NSCalendarUnit) -> NSComparisonResult {
		let nUnit = _sdNormalizedCalendarUnit(unit)
		let nOther = _sdNormalizedCalendarUnit(other)
		
		if (nUnit == NSCalendarUnit.WeekOfYear) != (nOther == NSCalendarUnit.WeekOfYear) {
			if nUnit == NSCalendarUnit.WeekOfYear {
				switch nUnit {
				case NSCalendarUnit.Year, NSCalendarUnit.Month:
					return .OrderedAscending
				default:
					return .OrderedDescending
				}
			} else {
				switch nOther {
				case NSCalendarUnit.Year, NSCalendarUnit.Month:
					return .OrderedDescending
				default:
					return .OrderedAscending
				}
			}
		} else {
			if nUnit.rawValue > nOther.rawValue {
				return .OrderedAscending
			} else if (nUnit.rawValue < nOther.rawValue) {
				return .OrderedDescending
			} else {
				return .OrderedSame
			}
		}
	}
	
	private func _sdNormalizedCalendarUnit(unit:NSCalendarUnit) -> NSCalendarUnit {
		switch unit {
		case NSCalendarUnit.WeekOfMonth, NSCalendarUnit.WeekOfYear:
			return NSCalendarUnit.WeekOfYear
		case NSCalendarUnit.Weekday, NSCalendarUnit.WeekdayOrdinal:
			return NSCalendarUnit.Day
		default:
			return unit;
		}
	}
	
	
	func _sdLocalizeStringForValue(singular : Bool, unit: NSCalendarUnit, abbreviated: Bool = false) -> String {
		var toTranslate : String = ""
		switch unit {
			
		case NSCalendarUnit.Year where singular:		toTranslate = (abbreviated ? "yr" : "year")
		case NSCalendarUnit.Year where !singular:		toTranslate = (abbreviated ? "yrs" : "years")
			
		case NSCalendarUnit.Month where singular:		toTranslate = (abbreviated ? "mo" : "month")
		case NSCalendarUnit.Month where !singular:		toTranslate = (abbreviated ? "mos" : "months")
			
		case NSCalendarUnit.WeekOfYear where singular:	toTranslate = (abbreviated ? "wk" : "week")
		case NSCalendarUnit.WeekOfYear where !singular: toTranslate = (abbreviated ? "wks" : "weeks")
			
		case NSCalendarUnit.Day where singular:			toTranslate = "day"
		case NSCalendarUnit.Day where !singular:		toTranslate = "days"
			
		case NSCalendarUnit.Hour where singular:		toTranslate = (abbreviated ? "hr" : "hour")
		case NSCalendarUnit.Hour where !singular:		toTranslate = (abbreviated ? "hrs" : "hours")
			
		case NSCalendarUnit.Minute where singular:		toTranslate = (abbreviated ? "min" : "minute")
		case NSCalendarUnit.Minute where !singular:		toTranslate = (abbreviated ? "mins" : "minutes")
			
		case NSCalendarUnit.Second where singular:		toTranslate = (abbreviated ? "s" : "second")
		case NSCalendarUnit.Second where !singular:		toTranslate = (abbreviated ? "s" : "seconds")
			
		case NSCalendarUnit.Nanosecond where singular:		toTranslate = (abbreviated ? "ns" : "nanosecond")
		case NSCalendarUnit.Nanosecond where !singular:		toTranslate = (abbreviated ? "ns" : "nanoseconds")
			
		default:													toTranslate = ""
		}
		return toTranslate._sdLocalize
	}
	
	func localizedSimpleStringForComponents(components:NSDateComponents) -> String {
		if (components.year == -1) {
			return "last year"._sdLocalize
		} else if (components.month == -1 && components.year == 0) {
			return "last month"._sdLocalize
		} else if (components.weekOfYear == -1 && components.year == 0 && components.month == 0) {
			return "last week"._sdLocalize
		} else if (components.day == -1 && components.year == 0 && components.month == 0 && components.weekOfYear == 0) {
			return "yesterday"._sdLocalize
		} else if (components == 1) {
			return "next year"._sdLocalize
		} else if (components.month == 1 && components.year == 0) {
			return "next month"._sdLocalize
		} else if (components.weekOfYear == 1 && components.year == 0 && components.month == 0) {
			return "next week"._sdLocalize
		} else if (components.day == 1 && components.year == 0 && components.month == 0 && components.weekOfYear == 0) {
			return "tomorrow"._sdLocalize
		}
		return ""
	}
}

//MARK: - DateInRegion Operations -



extension DateInRegion : Comparable {}
extension DateInRegion : Equatable {}

public func <(ldate: DateInRegion, rdate: DateInRegion) -> Bool {
	return ldate.absoluteTime.compare(rdate.absoluteTime) == .OrderedAscending
}


public func >(ldate: DateInRegion, rdate: DateInRegion) -> Bool {
	return ldate.absoluteTime.compare(rdate.absoluteTime) == .OrderedDescending
}


public extension DateInRegion {
	
	public func compare(date: DateInRegion, toUnitGranularity unit: NSCalendarUnit) -> NSComparisonResult {
		return region.calendar.compareDate(absoluteTime, toDate: date.absoluteTime, toUnitGranularity: unit)
	}
	
	public func isEqualToDate(right: DateInRegion) -> Bool {
		return absoluteTime.isEqualToDate(right.absoluteTime)
	}
	
	public func isSameDayOf(otherDate date :DateInRegion) -> Bool {
		return region.calendar.isDate(self.absoluteTime, inSameDayAsDate: date.absoluteTime)
	}
	
	public func add(years years: Int? = nil, months: Int? = nil, weekOfYear: Int? = nil, days: Int? = nil,hours: Int? = nil, minutes: Int? = nil, seconds: Int? = nil, nanoseconds: Int? = nil) -> DateInRegion {
		let components = NSDateComponents()
		
		components.year = years ?? NSDateComponentUndefined
		components.month = months ?? NSDateComponentUndefined
		components.weekOfYear = weekOfYear ?? NSDateComponentUndefined
		components.day = days ?? NSDateComponentUndefined
		components.hour = hours ?? NSDateComponentUndefined
		components.minute = minutes ?? NSDateComponentUndefined
		components.second = seconds ?? NSDateComponentUndefined
		components.nanosecond = nanoseconds ?? NSDateComponentUndefined
		
		self.absoluteTime = region.calendar.dateByAddingComponents(components, toDate: self.absoluteTime, options: NSCalendarOptions(rawValue: 0))
		return self
	}
	
	public func add(components: NSDateComponents) -> DateInRegion {
		let newDate = region.calendar.dateByAddingComponents(components, toDate: absoluteTime, options: NSCalendarOptions(rawValue: 0))
		absoluteTime = newDate
		return self
	}
	
	public func add(components dict: [NSCalendarUnit : AnyObject]) -> DateInRegion {
		let components = DateInRegion.dateFromComponentsDict(dict)
		let newDate = region.calendar.dateByAddingComponents(components, toDate: absoluteTime, options: NSCalendarOptions(rawValue: 0))
		absoluteTime = newDate
		return self
	}
	
	public class func dateFromComponentsDict(dict : [NSCalendarUnit : AnyObject]) -> NSDateComponents {
		let components = NSDateComponents()
		for (unit, value) in dict {
			switch unit {
			case NSCalendarUnit.Era:					components.era = value as! Int
			case NSCalendarUnit.Year:					components.year = value as! Int
			case NSCalendarUnit.Month:					components.month = value as! Int
			case NSCalendarUnit.Day:					components.day = value as! Int
			case NSCalendarUnit.YearForWeekOfYear:		components.yearForWeekOfYear = value as! Int
			case NSCalendarUnit.WeekOfYear:				components.weekOfYear = value as! Int
			case NSCalendarUnit.Weekday:				components.weekday = value as! Int
			case NSCalendarUnit.WeekdayOrdinal:			components.weekdayOrdinal = value as! Int
			case NSCalendarUnit.Quarter:				components.quarter = value as! Int
			case NSCalendarUnit.Hour:					components.hour = value as! Int
			case NSCalendarUnit.Minute:					components.minute = value as! Int
			case NSCalendarUnit.Second:					components.second = value as! Int
			case NSCalendarUnit.Nanosecond:				components.nanosecond = value as! Int
			case NSCalendarUnit.Calendar:				components.calendar = value as? NSCalendar
			case NSCalendarUnit.TimeZone:				components.timeZone = value as? NSTimeZone
			default:
				break
			}
		}
		return components
	}
	
	public func regionByAdding(components: NSDateComponents) -> DateInRegion {
		let newDate = region.calendar.dateByAddingComponents(components, toDate: absoluteTime, options: NSCalendarOptions(rawValue: 0))
		return DateInRegion(absoluteTime: newDate, region: region)!
	}
}

public func ==(left: DateInRegion, right: DateInRegion) -> Bool {
	
	// Compare the content, first the date
	guard left.absoluteTime.isEqualToDate(right.absoluteTime) else {
		return false
	}
	
	// Then the calendar
	guard left.region.calendar.calendarIdentifier == right.region.calendar.calendarIdentifier else {
		return false
	}
	
	// Then the time zone
	guard left.region.timeZone.secondsFromGMTForDate(left.absoluteTime) == right.region.timeZone.secondsFromGMTForDate(right.absoluteTime) else {
		return false
	}
	
	// Then the locale
	guard left.region.locale.localeIdentifier == right.region.locale.localeIdentifier else {
		return false
	}
	
	// We have made it! They are equal!
	return true
}

public func + (lhs: DateInRegion, rhs: NSDateComponents) -> DateInRegion? {
	return lhs.regionByAdding(rhs)
}

public func - (lhs: DateInRegion, rhs: NSDateComponents) -> DateInRegion? {
	return lhs + (-rhs)
}

public prefix func - (dateComponents: NSDateComponents) -> NSDateComponents {
	let result = NSDateComponents()
	for unit in DateInRegion.componentFlagSet {
		let value = dateComponents.valueForComponent(unit)
		if value != Int(NSDateComponentUndefined) {
			result.setValue(-value, forComponent: unit)
		}
	}
	return result
}