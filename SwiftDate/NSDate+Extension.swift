//
// SwiftDate.swift
// SwiftDate
//
// Author:	Daniele Margutti (hello@danielemargutti.com | @danielemargutti)
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

//MARK: NSDate Extension

public extension NSDate {
	
	/**
	Initialize a new NSDate objects from passed components object.
	Returned object is expressed as absolute time in UTC timezone. Where there are insufficient components provided to completely
	specify an absolute time, a calendar uses values of its choice. If inconsistences were found formatter may ignore problematic
	components or return nil object.
	
	- parameter components: components. If your time is expressed in another format remeber to specify it in components.timeZone
							variable. Resulting time will be always expressed in UTC/absolute format. Use DateInRegion to get in in
							particular timezone or locale.
							Note: if components does not specify a timeZone/locale/calendar, Region.UTCRegion() settings will be used
							(Gregorian/UTC/Current Locale)
	
	- returns: absolute date in UTC timezone created by looking at passed components.
	*/
	convenience init?(components :NSDateComponents) {
		let rDate = (DateInRegion(components: components)?.UTCDate)
		if rDate == nil {
			return nil // failed to use passed components
		}
		// generate a new NSDate (absolute UTC format) from passed components
		self.init(timeIntervalSince1970: rDate!.timeIntervalSince1970)
	}
	
	/**
	Initialize a new NSDate instance by passing components in a dictionary.
	Each key of the component must be an NSCalendarUnit type. All values are supported.
	
	- parameter params: paramters dictionary, each key must be an NSCalendarUnit
	- parameter locale: NSLocale instance to assign. If missing default UTCRegion locale will be used instead (Current Locale)
	
	- returns: a new NSDate instance
	*/
	convenience init?(params :[NSCalendarUnit : AnyObject], locale : NSLocale = Region.UTCRegion().locale) {
		// generate a new NSDate (absolute UTC format) from passed components
		let rDate = DateInRegion(components: params, locale: locale)?.UTCDate
		self.init(timeIntervalSince1970: rDate!.timeIntervalSince1970)
	}
	

	/**
	Initialize a new NSDate instance by taking initial components from date object and setting only specified components if != nil
	
	- parameter date:              reference date
	- parameter era:               era to set (nil to ignore)
	- parameter year:              year to set  (nil to ignore)
	- parameter month:             month to set  (nil to ignore)
	- parameter day:               day to set  (nil to ignore)
	- parameter yearForWeekOfYear: yearForWeekOfYear to set  (nil to ignore)
	- parameter weekOfYear:        weekOfYear to set  (nil to ignore)
	- parameter weekday:           weekday to set  (nil to ignore)
	- parameter hour:              hour to set  (nil to ignore)
	- parameter minute:            minute to set  (nil to ignore)
	- parameter second:            second to set  (nil to ignore)
	- parameter nanosecond:        nanosecond to set  (nil to ignore)
	- parameter region:            region to set (if not specified Region.UTCRegion() will be used instead - Gregorian/UTC/Current Locale)
	
	- returns: a new date instance with components created from refDate and only specified components set by passing input params
	*/
	convenience init(refDate date : NSDate,
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
		region					: Region = Region.UTCRegion()) {
			
		let rDate = DateInRegion(date: date, era: era, year: year, month: month, day: day, yearForWeekOfYear: yearForWeekOfYear, weekOfYear: weekOfYear, weekday: weekday, hour: hour, minute: minute, second: second, nanosecond: nanosecond, region: region)
		self.init(timeIntervalSince1970: rDate.UTCDate!.timeIntervalSince1970)
	}
	
	/**
	Create a new DateInRegion object. It will represent an UTC date expressed in a particular world region.
	
	- parameter region: region to associate. If not specified defaultRegion() will be used instead. Use Region.setDefaultRegion() to define a default region for your application.
	
	- returns: a new DateInRegion instance representing this date in specified region. You can query for each component and it will be returned taking care of the region components specified.
	*/
	public func inRegion(region :Region = Region.defaultRegion()) -> DateInRegion {
		let dateInRegion = DateInRegion(UTCDate: self, region: region)!
		return dateInRegion
	}
	
	/**
	This is a shortcut to express the date into the default region of the app.
	You can specify a default region by calling Region.setDefaultRegion(). By default default region for you app is Gregorian Calendar/UTC TimeZone and current locale.
	
	- returns: a new DateInRegion instance representing this date in default region
	*/
	public func inDefaultRegion() -> DateInRegion {
		let dateInRegion = DateInRegion(UTCDate: self, region: Region.defaultRegion())!
		return dateInRegion
	}
	
	public func inUTCRegion() -> DateInRegion {
		let dateInRegion = DateInRegion(UTCDate: self, region: Region.UTCRegion())!
		return dateInRegion
	}
	
	/**
	Create a new date from self by adding specified component values. All values are optional. Date still remain expressed in UTC.
	
	- parameter years:       years to add
	- parameter months:      months to add
	- parameter weekOfYear:  week of year to add
	- parameter days:        days to add
	- parameter hours:       hours to add
	- parameter minutes:     minutes to add
	- parameter seconds:     seconds to add
	- parameter nanoseconds: nanoseconds to add
	
	- returns: a new UTC date from self plus passed components
	*/
	public func add(years years: Int? = nil, months: Int? = nil, weekOfYear: Int? = nil, days: Int? = nil,hours: Int? = nil, minutes: Int? = nil, seconds: Int? = nil, nanoseconds: Int? = nil) -> NSDate {
		
		let UTCRegion = DateInRegion.UTCRegion(self)
		UTCRegion.add(years: years, months: months, weekOfYear: weekOfYear, days: days, hours: hours, minutes: minutes, seconds: seconds, nanoseconds: nanoseconds)
		return UTCRegion.UTCDate
	}
	
	/**
	Add components to the current UTC date by passing an NSDateComponents intance
	
	- parameter components: components to add
	
	- returns: a new UTC date from self plus passed components
	*/
	public func add(components :NSDateComponents) -> NSDate {
		let UTCRegion = DateInRegion.UTCRegion(self).add(components)
		return UTCRegion.UTCDate
	}
	
	/**
	Add components to the current UTC date by passing NSCalendarUnit dictionary
	
	- parameter params: dictionary of NSCalendarUnit components
	
	- returns: a new UTC date from self plus passed components dictionary
	*/
	public func add(params :[NSCalendarUnit : AnyObject]) -> NSDate {
		let UTCRegion = DateInRegion.UTCRegion(self).add(components: params)
		return UTCRegion.UTCDate
	}
	
	/**
	Get the NSDateComponents from passed UTC date by converting it into specified region timezone
	
	- parameter region: region of destination
	
	- returns: date components
	*/
	public func components(inRegion region :Region = Region.UTCRegion()) -> NSDateComponents {
		return (DateInRegion(UTCDate: self, region: region)?.components!)!
	}
	
	/// The same of calling components() without specify a region: UTC region is used instead
	public var components : NSDateComponents {
		get {
			return components()
		}
	}
	
	/**
	Takes a date unit and returns a date at the start of that unit.
	
	- parameter unit:   unit
	- parameter region: region of the date
	
	- returns: the date representing that start of that unit
	*/
	public func startOf(unit :NSCalendarUnit, inRegion region :Region) -> NSDate {
		return (DateInRegion(startOfDate: self, unit: unit, region: region)?.UTCDate)!
	}
	
	/**
	Takes a date unit and returns a date at the end of that unit.
	
	- parameter unit:   unit
	- parameter region: region of the date
	
	- returns: the date representing that end of that unit
	*/
	public func endOf(unit :NSCalendarUnit, inRegion region :Region) -> NSDate {
		return (DateInRegion(endOfDate: self, unit: unit, region: region)?.UTCDate)!
	}
	
	/**
	Return the string representation the date in specified region
	
	- parameter format: format of date
	- parameter region: region of destination
	
	- returns: string representation of the date into the region
	*/
	public func toString(format :DateFormat, inRegion region :Region = Region.defaultRegion()) -> String? {
		return DateInRegion(UTCDate: self, region: region)?.toString(format)
	}
	
}

extension NSDate : Comparable {}

/**
Compare two UTC dates and return true if they are equals. Comparisor is made with the max resolution.

- parameter left:  date a
- parameter right: date b

- returns: true if both dates are equals
*/
public func == (left: NSDate, right: NSDate) -> Bool {
	return (left.compare(right) == NSComparisonResult.OrderedSame)
}

/**
Compare two dates and return true if the left date is earlier than the right date

- parameter left:  left date
- parameter right: right date

- returns: true if left < right
*/
public func < (left: NSDate, right: NSDate) -> Bool {
	return (left.compare(right) == NSComparisonResult.OrderedAscending)
}

/**
Compare two dates and return true if the left date is later than the right date

- parameter left:  left date
- parameter right: right date

- returns: true if left > right
*/
public func > (left: NSDate, right: NSDate) -> Bool {
	return (left.compare(right) == NSComparisonResult.OrderedDescending)
}

/**
Subtract from absolute seconds of UTC left date the number of absolute seconds of UTC right date

- parameter lhs: left date
- parameter rhs: right date

- returns: a new date result of the difference between two dates
*/
public func - (lhs: NSDate, rhs: NSDateComponents) -> NSDate {
	return lhs + (-rhs)
}

/**
Sum to absolute seconds of UTC left date the number of absolute seconds of UTC right date

- parameter lhs: left date
- parameter rhs: right date

- returns: a new date result of the sum between two dates
*/
public func + (lhs: NSDate, rhs: NSDateComponents) -> NSDate {
	return lhs.add(rhs)
}


public extension NSTimeInterval {
 
     var fromNow: NSDate? {
         return NSDate(timeIntervalSinceNow: self)
     }
 
     var ago: NSDate? {
        return NSDate(timeIntervalSinceNow: -self)
	}
}


public extension NSDate {
	
	/// Get the year component of the date in UTC region (use inRegion(...).year to get the year component in specified time zone)
	var year :Int {
		return self.inUTCRegion().year!
	}
	
	/// Get the month component of the date in UTC region (use inRegion(...).month to get the month component in specified time zone)
	var month :Int {
		return self.inUTCRegion().month!
	}
	
	/// Get the month name component of the date in UTC region (use inRegion(...).monthName to get the month's name component in specified time zone)
	var monthName :String {
		return self.inUTCRegion().monthName!
	}
	
	/// Get the week of month component of the date in UTC region (use inRegion(...).weekOfMonth to get the week of month component in specified time zone)
	var weekOfMonth :Int {
		return self.inUTCRegion().weekOfMonth!
	}
	
	/// Get the year for week of year component of the date in UTC region (use inRegion(...).yearForWeekOfYear to get the year week of year component in specified time zone)
	var yearForWeekOfYear :Int {
		return self.inUTCRegion().yearForWeekOfYear!
	}
	
	/// Get the week of year component of the date in UTC region (use inRegion(...).weekOfYear to get the week of year component in specified time zone)
	var weekOfYear :Int	{
		return self.inUTCRegion().weekOfYear!
	}
	
	/// Get the weekday component of the date in UTC region (use inRegion(...).weekday to get the weekday component in specified time zone)
	var weekday :Int {
		return self.inUTCRegion().weekday!
	}
	
	/// Get the weekday ordinal component of the date in UTC region (use inRegion(...).weekdayOrdinal to get the weekday ordinal component in specified time zone)
	var weekdayOrdinal :Int	{
		return self.inUTCRegion().weekdayOrdinal!
	}
	
	/// Get the day component of the date in UTC region (use inRegion(...).day to get the day component in specified time zone)
	var day :Int {
		return self.inUTCRegion().day!
	}
	
	/// Get the number of days of the current date's month in UTC region (use inRegion(...).monthDays to get it in specified time zone)
	var monthDays :Int {
		return self.inUTCRegion().monthDays!
	}
	
	/// Get the hour component of the current date's hour in UTC region (use inRegion(...).hour to get it in specified time zone)
	var hour :Int {
		return self.inUTCRegion().hour!
	}
	
	/// Get the nearest hour component of the current date's hour in UTC region (use inRegion(...).nearestHour to get it in specified time zone)
	var nearestHour :Int {
		return self.inUTCRegion().nearestHour
	}
	
	/// Get the minute component of the current date's minute in UTC region (use inRegion(...).minute to get it in specified time zone)
	var minute :Int	{
		return self.inUTCRegion().minute!
	}
	
	/// Get the second component of the current date's second in UTC region (use inRegion(...).second to get it in specified time zone)
	var second :Int	{
		return self.inUTCRegion().second!
	}
	
	/// Get the nanoscend component of the current date's nanosecond in UTC region (use inRegion(...).nanosecond to get it in specified time zone)
	var nanosecond :Int	{
		return self.inUTCRegion().nanosecond!
	}
	
	/// Get the era component of the current date's era in UTC region (use inRegion(...).era to get it in specified time zone)
	var era :Int {
		return self.inUTCRegion().era!
	}
	
	/// Get the first day of the current date week in UTC region. Use inRegion(...).firstDayOfWeek to get it in specified time zone
	var firstDayOfWeek :Int {
		return self.inUTCRegion().firstDayOfWeek!
	}
	
	/// Get the last day of the current date week in UTC region. Use inRegion(...).lastDayOfWeek to get it in specified time zone
	var lastDayOfWeek :Int {
		return self.inUTCRegion().lastDayOfWeek!
	}
	
	public func isToday() -> Bool {
		return self.inUTCRegion().isToday()
	}
	
	public func isYesterday() -> Bool {
		return self.inUTCRegion().isYesterday()
	}
	
	public func isTomorrow() -> Bool {
		return self.inUTCRegion().isTomorrow()
	}
	
	/**
	Return true if date is a weekend day into specified region calendar
	
	- returns: true if date is tomorrow into specified region calendar
	*/
	public func isWeekend() -> Bool {
		return DateInRegion.DefaultRegion(self).isWeekend()
	}
	
	
}