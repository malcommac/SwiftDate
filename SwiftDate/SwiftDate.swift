//
// SwiftDate.swift
// SwiftDate
//
// Copyright (c) 2015 Daniele Margutti
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

//MARK: STRING EXTENSION SHORTCUTS

public extension String {
	
	/**
	Create a new NSDate object with passed custom format string
	
	:param: format format as string
	
	:returns: a new NSDate instance with parsed date, or nil if it's fail
	*/
	func toDate(formatString formatString: String!) -> NSDate? {
		return NSDate.date(fromString: self, format: DateFormat.Custom(formatString))
	}
	
	/**
	Create a new NSDate object with passed date format
	
	:param: format format
	
	:returns: a new NSDate instance with parsed date, or nil if it's fail
	*/
	func toDate(format format: DateFormat) -> NSDate? {
		return NSDate.date(fromString: self, format: format)
	}
}

//MARK: ACCESS TO DATE COMPONENTS

public extension NSDate {
	
	// Use this as shortcuts for the most common formats for dates
	class var commonFormats : [String] {
		return [
			"yyyy-MM-ddTHH:mm:ssZ", // ISO8601
			"yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'",
			"yyyy-MM-dd",
			"h:mm:ss A",
			"h:mm A",
			"MM/dd/yyyy",
			"MMMM d, yyyy",
			"MMMM d, yyyy LT",
			"dddd, MMMM D, yyyy LT",
			"yyyyyy-MM-dd",
			"yyyy-MM-dd",
			"GGGG-[W]WW-E",
			"GGGG-[W]WW",
			"yyyy-ddd",
			"HH:mm:ss.SSSS",
			"HH:mm:ss",
			"HH:mm",
			"HH"
		]
	}
	
	/// Get the year component of the date
	var year : Int			{ return components.year }
	/// Get the month component of the date
	var month : Int			{ return components.month }
	// Get the week of the month component of the date
	var weekOfMonth: Int	{ return components.weekOfMonth }
	// Get the week of the month component of the date
	var weekOfYear: Int		{ return components.weekOfYear }
	/// Get the weekday component of the date
	var weekday: Int		{ return components.weekday }
	/// Get the weekday ordinal component of the date
	var weekdayOrdinal: Int	{ return components.weekdayOrdinal }
	/// Get the day component of the date
	var day: Int			{ return components.day }
	/// Get the hour component of the date
	var hour: Int			{ return components.hour }
	/// Get the minute component of the date
	var minute: Int			{ return components.minute }
	// Get the second component of the date
	var second: Int			{ return components.second }
	// Get the era component of the date
	var era: Int			{ return components.era }
	// Get the current month name based upon current locale
	var monthName: String {
		let dateFormatter = NSDate.localThreadDateFormatter()
		dateFormatter.locale = NSLocale.autoupdatingCurrentLocale()
		return dateFormatter.monthSymbols[month - 1] as String
	}
	// Get the current weekday name
	var weekdayName: String {
		let dateFormatter = NSDate.localThreadDateFormatter()
		dateFormatter.locale = NSLocale.autoupdatingCurrentLocale()
		dateFormatter.dateFormat = "EEEE"
		dateFormatter.timeZone = NSTimeZone.localTimeZone()
		return dateFormatter.stringFromDate(self)
	}
	
	
	private func firstWeekDate()-> (date : NSDate!, interval: NSTimeInterval) {
		// Sunday 1, Monday 2, Tuesday 3, Wednesday 4, Friday 5, Saturday 6
		let calendar = NSCalendar.currentCalendar()
		calendar.firstWeekday = NSCalendar.currentCalendar().firstWeekday
		var startWeek: NSDate? = nil
		var duration: NSTimeInterval = 0
		
		calendar.rangeOfUnit(NSCalendarUnit.WeekOfYear, startDate: &startWeek, interval: &duration, forDate: self)
		return (startWeek,duration)
	}
	
	/// Return the first day of the current date's week
	var firstDayOfWeek : Int {
		let (date,_) = self.firstWeekDate()
		return date.day
	}
	
	/// Return the last day of the week
	var lastDayOfWeek : Int {
		let (startWeek,interval) = self.firstWeekDate()
		let endWeek = startWeek?.dateByAddingTimeInterval(interval-1)
		return endWeek!.day
	}
	
	/// Return the nearest hour of the date
	var nearestHour:NSInteger{
		let aTimeInterval = NSDate.timeIntervalSinceReferenceDate() + Double(D_MINUTE) * Double(30);
		
		let newDate = NSDate(timeIntervalSinceReferenceDate:aTimeInterval);
		let components = NSCalendar.currentCalendar().components(NSCalendarUnit.Hour, fromDate: newDate);
		return components.hour;
	}
}

//MARK: CREATE AND MANIPULATE DATE COMPONENTS

public extension NSDate {
	
	/**
	Create a new NSDate instance from passed string with given format
	
	:param: string date as string
	:param: format parse formate.
	
	:returns: a new instance of the string
	*/
	class func date(fromString string: String, format: DateFormat) -> NSDate? {
		if string.isEmpty {
			return nil
		}
		
		let dateFormatter = NSDate.localThreadDateFormatter()
		switch format {
		case .ISO8601: // 1972-07-16T08:15:30-05:00
			dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
			dateFormatter.timeZone = NSTimeZone.localTimeZone()
			dateFormatter.dateFormat = ISO8601Formatter(fromString: string)
			return dateFormatter.dateFromString(string)
		case .AltRSS: // 09 Sep 2011 15:26:08 +0200
			var formattedString : NSString = string
			if formattedString.hasSuffix("Z") {
				formattedString = formattedString.substringToIndex(formattedString.length-1) + "GMT"
			}
			dateFormatter.dateFormat = "d MMM yyyy HH:mm:ss ZZZ"
			return dateFormatter.dateFromString(formattedString as String)
		case .RSS: // Fri, 09 Sep 2011 15:26:08 +0200
			var formattedString : NSString = string
			if formattedString.hasSuffix("Z") {
				formattedString = formattedString.substringToIndex(formattedString.length-1) + "GMT"
			}
			dateFormatter.dateFormat = "EEE, d MMM yyyy HH:mm:ss ZZZ"
			return dateFormatter.dateFromString(formattedString as String)
		case .Custom(let dateFormat):
			dateFormatter.dateFormat = dateFormat
			return dateFormatter.dateFromString(string)
		}
	}
	
	/**
	Attempts to handle all different ISO8601 formatters
	and returns correct date format for string
	http://www.w3.org/TR/NOTE-datetime
	*/
	class func ISO8601Formatter(fromString string: String) -> String {
		
		enum IS08601Format: Int {
			// YYYY (eg 1997)
			case Year = 4
			
			// YYYY-MM (eg 1997-07)
			case YearAndMonth = 7
			
			// YYYY-MM-DD (eg 1997-07-16)
			case CompleteDate = 10
			
			// YYYY-MM-DDThh:mmTZD (eg 1997-07-16T19:20+01:00)
			case CompleteDatePlusHoursAndMinutes = 22
			
			// YYYY-MM-DDThh:mmTZD (eg 1997-07-16T19:20Z)
			case CompleteDatePlusHoursAndMinutesAndZ = 17
			
			// YYYY-MM-DDThh:mm:ssTZD (eg 1997-07-16T19:20:30+01:00)
			case CompleteDatePlusHoursMinutesAndSeconds = 25
			
			// YYYY-MM-DDThh:mm:ssTZD (eg 1997-07-16T19:20:30Z)
			case CompleteDatePlusHoursAndMinutesAndSecondsAndZ = 20
			
			// YYYY-MM-DDThh:mm:ss.sTZD (eg 1997-07-16T19:20:30.45+01:00)
			case CompleteDatePlusHoursMinutesSecondsAndDecimalFractionOfSecond = 28
			
			// YYYY-MM-DDThh:mm:ss.sTZD (eg 1997-07-16T19:20:30.45Z)
			case CompleteDatePlusHoursMinutesSecondsAndDecimalFractionOfSecondAndZ = 23
		}
		
		var dateFormatter = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
		
		if let dateStringCount = IS08601Format(rawValue: string.characters.count) {
			switch dateStringCount {
			case .Year:
				dateFormatter = "yyyy"
			case .YearAndMonth:
				dateFormatter = "yyyy-MM"
			case .CompleteDate:
				dateFormatter = "yyyy-MM-dd"
			case .CompleteDatePlusHoursAndMinutes, .CompleteDatePlusHoursAndMinutesAndZ:
				dateFormatter = "yyyy-MM-dd'T'HH:mmZ"
			case .CompleteDatePlusHoursMinutesAndSeconds, .CompleteDatePlusHoursAndMinutesAndSecondsAndZ:
				dateFormatter = "yyyy-MM-dd'T'HH:mm:ssZ"
			case .CompleteDatePlusHoursMinutesSecondsAndDecimalFractionOfSecond, .CompleteDatePlusHoursMinutesSecondsAndDecimalFractionOfSecondAndZ:
				dateFormatter = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
			}
		}
		return dateFormatter
	}
	
    /**
    Create a new NSDate instance based on refDate (if nil uses current date) and set components

    :param: refDate reference date instance (nil to use NSDate())
    :param: year    year component (nil to leave it untouched)
    :param: month   month component (nil to leave it untouched)
    :param: day     day component (nil to leave it untouched)
    :param: hour    hour component (nil to leave it untouched)
    :param: minute  minute component (nil to leave it untouched)
    :param: second  second component (nil to leave it untouched)
    :param: tz      time zone component (it's the abbreviation of NSTimeZone, like 'UTC' or 'GMT+2', nil to use current time zone)

    :returns: a new NSDate with components changed according to passed params
    */
    class func date(refDate refDate: NSDate? = nil, year: Int? = nil, month: Int? = nil, day: Int? = nil, hour: Int? = nil, minute: Int? = nil, second: Int? = nil, tz: String? = nil) -> NSDate {
        let referenceDate = refDate ?? NSDate()
        return referenceDate.set(year: year, month: month, day: day, hour: hour, minute: minute, second: second, tz: tz)
    }
    
    
    /**
    Create a new NSDate instance based on refDate (if nil uses current date) and set components

    :param: refDate reference date instance (nil to use NSDate())
    :param: year    year component (nil to leave it untouched)
    :param: month   month component (nil to leave it untouched)
    :param: day     day component (nil to leave it untouched)
    :param: hour    hour component (nil to leave it untouched)
    :param: minute  minute component (nil to leave it untouched)
    :param: second  second component (nil to leave it untouched)
    :param: tz      time zone component (it's the abbreviation of NSTimeZone, like 'UTC' or 'GMT+2', nil to use current time zone)

    :returns: a new NSDate with components changed according to passed params
    */
    convenience init(var refDate: NSDate? = nil, year: Int, month: Int, day: Int, hour: Int? = nil, minute: Int? = nil, second: Int? = nil, let tz: String? = nil) {

        if (refDate == nil) {

            // If refDate == nil, we want a reference date of 2001-01-01 00:00:00.000 in the tz time zone
            refDate = NSDate().set(year: 2001, month: 1, day: 1, hour: 0, minute: 0, second: 0, tz: tz)
        }

        let newDate = refDate!.set(year: year, month: month, day: day, hour: hour, minute: minute, second: second, tz: tz)
        self.init(timeIntervalSinceReferenceDate: newDate.timeIntervalSinceReferenceDate)
    }



	/**
	Return a new NSDate instance with the current date and time set to 00:00:00
	
	:param: tz optional timezone abbreviation
	
	:returns: a new NSDate instance of the today's date
	*/
	class func today(tz: String? = nil) -> NSDate! {
		let nowDate = NSDate()
		return NSDate.date(refDate: nowDate, year: nowDate.year, month: nowDate.month, day: nowDate.day, tz: tz)
	}
	
	/**
	Return a new NSDate istance with the current date minus one day
	
	:param: tz optional timezone abbreviation
	
	:returns: a new NSDate instance which represent yesterday's date
	*/
	class func yesterday(tz: String? = nil) -> NSDate! {
		return today(tz)-1.days
	}
	
	/**
	Return a new NSDate istance with the current date plus one day
	
	:param: tz optional timezone abbreviation
	
	:returns: a new NSDate instance which represent tomorrow's date
	*/
	class func tomorrow(tz: String? = nil) -> NSDate! {
		return today(tz)+1.days
	}
	
	/**
	Individual set single component of the current date instance
	
	:param: year   a non-nil value to change the year component of the instance
	:param: month  a non-nil value to change the month component of the instance
	:param: day    a non-nil value to change the day component of the instance
	:param: hour   a non-nil value to change the hour component of the instance
	:param: minute a non-nil value to change the minute component of the instance
	:param: second a non-nil value to change the second component of the instance
	:param: tz     a non-nil value (timezone abbreviation string as for NSTimeZone) to change the timezone component of the instance
	
	:returns: a new NSDate instance with changed values
	*/
    func set(year year: Int?=nil, month: Int?=nil, day: Int?=nil, hour: Int?=nil, minute: Int?=nil, second: Int?=nil, tz: String?=nil) -> NSDate! {
        let components = self.components
        if year != nil { components.year = year! }
        if month != nil { components.month = month! }
        if day != nil { components.day = day! }
        if hour != nil { components.hour = hour! }
        if minute != nil { components.minute = minute! }
        if second != nil { components.second = second! }
        components.timeZone = (tz != nil ? NSTimeZone(abbreviation: tz!) : NSTimeZone.defaultTimeZone())

        // Set weekday stuff to undefined to prevent dateFromComponents to get confused
        components.yearForWeekOfYear = NSDateComponentUndefined
        components.weekOfYear = NSDateComponentUndefined
        components.weekday = NSDateComponentUndefined
        components.weekdayOrdinal = NSDateComponentUndefined

        // Set calendar time zone to desired time zone
        let calendar = NSCalendar.currentCalendar()
        calendar.timeZone = components.timeZone!

        return calendar.dateFromComponents(components)
    }

	/**
	Allows you to set individual date components by passing an array of components name and associated values
	
	:param: componentsDict components dict. Accepted keys are year,month,day,hour,minute,second
	
	:returns: a new date instance with altered components according to passed dictionary
	*/
	func set(componentsDict componentsDict: [String:Int]!) -> NSDate? {
		if componentsDict.count == 0 {
			return self
		}
		let components = self.components
		for (thisComponent,value) in componentsDict {
			let unit : NSCalendarUnit = thisComponent._sdToCalendarUnit()
			components.setValue(value, forComponent: unit);
		}
		return NSCalendar.currentCalendar().dateFromComponents(components)
	}
	
	/**
	Allows you to set a single component by passing it's name (year,month,day,hour,minute,second are accepted).
	Please note: this method return a new immutable NSDate instance (NSDate are immutable, damn!). So while you
	can chain multiple set calls, if you need to alter more than one component see the method above which accept
	different params.
	
	:param: name  the name of the component to alter (year,month,day,hour,minute,second are accepted)
	:param: value the value of the component
	
	:returns: a new date instance
	*/
	func set(name : String!, value : Int!) -> NSDate? {
		let unit : NSCalendarUnit = name._sdToCalendarUnit()
		if unit == [] {
			return nil
		}
		let components = self.components
		components.setValue(value, forComponent: unit);
		return NSCalendar.currentCalendar().dateFromComponents(components)
	}
	
	/**
	Add or subtract (via negative values) components from current date instance
	
	:param: years   nil or +/- years to add or subtract from date
	:param: months  nil or +/- months to add or subtract from date
	:param: weeks   nil or +/- weeks to add or subtract from date
	:param: days    nil or +/- days to add or subtract from date
	:param: hours   nil or +/- hours to add or subtract from date
	:param: minutes nil or +/- minutes to add or subtract from date
	:param: seconds nil or +/- seconds to add or subtract from date
	
	:returns: a new NSDate instance with changed values
	*/
    func add(years years: Int=0, months: Int=0, weeks: Int=0, days: Int=0,hours: Int=0,minutes: Int=0,seconds: Int=0) -> NSDate? {
		let components = NSDateComponents()
        components.year = years
        components.month = months
        components.weekOfYear = weeks
        components.day = days
        components.hour = hours
        components.minute = minutes
        components.second = seconds
		return self.addComponents(components)
	}
	
	/**
	Add/substract (based on sign) specified component with value
	
	:param: name  component name (year,month,day,hour,minute,second)
	:param: value value of the component
	
	:returns: new date with altered component
	*/
	func add(name : String!, value : Int!) -> NSDate? {
		let unit : NSCalendarUnit = name._sdToCalendarUnit()
		if unit == [] {
			return nil
		}
		let components = NSDateComponents()
		components.setValue(value, forComponent: unit);
		return self.addComponents(components)
	}
	
	/**
	Add value specified by components in passed dictionary to the current date
	
	:param: componentsDict dictionary of the component to alter with value (year,month,day,hour,minute,second)
	
	:returns: new date with altered components
	*/
	func add(componentsDict componentsDict: [String:Int]!) -> NSDate? {
		if componentsDict.count == 0 {
			return self
		}
		let components = NSDateComponents()
		for (thisComponent,value) in componentsDict {
			let unit : NSCalendarUnit = thisComponent._sdToCalendarUnit()
			components.setValue(value, forComponent: unit);
		}
		return self.addComponents(components)
	}
}

//MARK: TIMEZONE UTILITIES

public extension NSDate {
	/**
	Return a new NSDate in UTC format from the current system timezone
	
	:returns: a new NSDate instance
	*/
	func toUTC() -> NSDate {
		let tz : NSTimeZone = NSTimeZone.localTimeZone()
		let secs : Int = tz.secondsFromGMTForDate(self)
		return NSDate(timeInterval: NSTimeInterval(secs), sinceDate: self)
	}
	
	/**
	Convert an UTC NSDate instance to a local time NSDate (note: NSDate object does not contains info about the timezone!)
	
	:returns: a new NSDate instance
	*/
	func toLocalTime() -> NSDate {
		let tz : NSTimeZone = NSTimeZone.localTimeZone()
		let secs : Int = -tz.secondsFromGMTForDate(self)
		return NSDate(timeInterval: NSTimeInterval(secs), sinceDate: self)
	}
	
	/**
	Convert an UTC NSDate instance to passed timezone (note: NSDate object does not contains info about the timezone!)
	
	:param: abbreviation abbreviation of the time zone
	
	:returns: a new NSDate instance
	*/
	func toTimezone(abbreviation : String!) -> NSDate? {
		let tz : NSTimeZone? = NSTimeZone(abbreviation: abbreviation)
		if tz == nil {
			return nil
		}
		let secs : Int = tz!.secondsFromGMTForDate(self)
		return NSDate(timeInterval: NSTimeInterval(secs), sinceDate: self)
	}
}

//MARK: COMPARE DATES

public extension NSDate {
    
	/**
	Return the difference in terms of NSDateComponents between two dates.
	
	- parameter toDate:    other date to compare
	- parameter unitFlags: components to compare
	
	- returns: result of comparision as NSDateComponents
	*/
	func difference(toDate: NSDate, unitFlags: NSCalendarUnit) -> NSDateComponents {
		let calendar = NSCalendar.currentCalendar()
		let components = calendar.components(unitFlags, fromDate: self, toDate: toDate, options: NSCalendarOptions(rawValue: 0))
		return components
	}
	
	/**
	*  This function is deprecated. See -difference
	*/
	@available(*, deprecated=1.2, obsoleted=1.4, renamed="difference")
	func secondsAfterDate(date: NSDate) -> Int {
		let interval = self.timeIntervalSinceDate(date)
		return Int(interval)
	}
	
	/**
	*  This function is deprecated. See -difference
	*/
	@available(*, deprecated=1.2, obsoleted=1.4, renamed="difference")
	func secondsBeforeDate(date: NSDate) -> Int {
		let interval = date.timeIntervalSinceDate(self)
		return Int(interval)
	}
	
	/**
	*  This function is deprecated. See -difference
	*/
	@available(*, deprecated=1.2, obsoleted=1.4, renamed="difference")
	func minutesAfterDate(date: NSDate) -> Int {
		let interval = self.timeIntervalSinceDate(date)
		return Int(interval / NSTimeInterval(D_MINUTE))
	}
	
	/**
	*  This function is deprecated. See -difference
	*/
	@available(*, deprecated=1.2, obsoleted=1.4, renamed="difference")
	func minutesBeforeDate(date: NSDate) -> Int {
		let interval = date.timeIntervalSinceDate(self)
		return Int(interval / NSTimeInterval(D_MINUTE))
	}
	
	/**
	*  This function is deprecated. See -difference
	*/
	@available(*, deprecated=1.2, obsoleted=1.4, renamed="difference")
	func hoursAfterDate(date: NSDate) -> Int {
		let interval = self.timeIntervalSinceDate(date)
		return Int(interval / NSTimeInterval(D_HOUR))
	}
	
	/**
	*  This function is deprecated. See -difference
	*/
	@available(*, deprecated=1.2, obsoleted=1.4, renamed="difference")
	func hoursBeforeDate(date: NSDate) -> Int {
		let interval = date.timeIntervalSinceDate(self)
		return Int(interval / NSTimeInterval(D_HOUR))
	}
	
	/**
	*  This function is deprecated. See -difference
	*/
	@available(*, deprecated=1.2, obsoleted=1.4, renamed="difference")
	func daysAfterDate(date: NSDate) -> Int {
		let interval = self.timeIntervalSinceDate(date)
		return Int(interval / NSTimeInterval(D_DAY))
	}
	
	/**
	*  This function is deprecated. See -difference
	*/
	@available(*, deprecated=1.2, obsoleted=1.4, renamed="difference")
	func daysBeforeDate(date: NSDate) -> Int {
		let interval = date.timeIntervalSinceDate(self)
		return Int(interval / NSTimeInterval(D_DAY))
	}
	
	/**
	Compare two dates and return true if they are equals
	
	:param: date       date to compare with
	:param: ignoreTime true to ignore time of the date
	
	:returns: true if two dates are equals
	*/
	func isEqualToDate(date: NSDate, ignoreTime: Bool) -> Bool {
		if ignoreTime {
			let comp1 = NSDate.components(fromDate: self)
			let comp2 = NSDate.components(fromDate: date)
			return ((comp1.era == comp2.era) && (comp1.year == comp2.year) && (comp1.month == comp2.month) && (comp1.day == comp2.day))
		} else {
			return self.isEqualToDate(date)
		}
	}
	
	/**
	Return true if given date's time in passed range
	
	:param: minTime min time interval (by default format is "HH:mm", but you can specify your own format in format parameter)
	:param: maxTime max time interval (by default format is "HH:mm", but you can specify your own format in format parameter)
	:param: format  nil or a valid format string used to parse minTime and maxTime from their string representation (when nil HH:mm is used)
	
	:returns: true if date's time component falls into given range
	*/
	func isInTimeRange(minTime: String!, maxTime: String!, format: String?) -> Bool {
		let dateFormatter = NSDate.localThreadDateFormatter()
		dateFormatter.dateFormat = format ?? "HH:mm"
		dateFormatter.timeZone = NSTimeZone(abbreviation: "UTC")
		let minTimeDate = dateFormatter.dateFromString(minTime)
		let maxTimeDate = dateFormatter.dateFromString(maxTime)
		if minTimeDate == nil || maxTimeDate == nil {
			return false
		}
		let inBetween = (self.compare(minTimeDate!) == NSComparisonResult.OrderedDescending &&
			self.compare(maxTimeDate!) == NSComparisonResult.OrderedAscending)
		return inBetween
	}
	
	/**
	Return true if the date's year is a leap year
	
	:returns: true if date's year is a leap year
	*/
	func isLeapYear() -> Bool {
		let year = self.year
		return year % 400 == 0 ? true : ((year % 4 == 0) && (year % 100 != 0))
	}
	
	/**
	Return the number of days in current date's month
	
	:returns: number of days of the month
	*/
	func monthDays () -> Int {
		return NSCalendar.currentCalendar().rangeOfUnit(NSCalendarUnit.Day, inUnit: NSCalendarUnit.Month, forDate: self).length
	}
	
	/**
	True if the date is the current date
	
	:returns: true if date is today
	*/
	func isToday() -> Bool {
		return self.isEqualToDate(NSDate(), ignoreTime: true)
	}
	
	/**
	True if the date is the current date plus one day (tomorrow)
	
	:returns: true if date is tomorrow
	*/
	func isTomorrow() -> Bool {
		return self.isEqualToDate(NSDate()+1.day, ignoreTime:true)
	}
	
	/**
	True if the date is the current date minus one day (yesterday)
	
	:returns: true if date is yesterday
	*/
	func isYesterday() -> Bool {
		return self.isEqualToDate(NSDate()-1.day, ignoreTime:true)
	}
	
	/**
	Return true if the date falls into the current week
	
	:returns: true if date is inside the current week days range
	*/
	func isThisWeek() -> Bool {
		return self.isSameWeekOf(NSDate())
	}
	
	/**
	Return true if the date falls into the current month
	
	:returns: true if date is inside the current month
	*/
	func isThisMonth() -> Bool {
		return self.isSameMonthOf(NSDate())
	}
	
	/**
	Return true if the date falls into the current year
	
	:returns: true if date is inside the current year
	*/
	func isThisYear() -> Bool {
		return self.isSameYearOf(NSDate())
	}
	
	/**
	Return true if the date is in the same week of passed date
	
	:param: date date to compare with
	
	:returns: true if both dates falls in the same week
	*/
	func isSameWeekOf(date: NSDate) -> Bool {
		let comp1 = NSDate.components(fromDate: self)
		let comp2 = NSDate.components(fromDate: date)
		// Must be same week. 12/31 and 1/1 will both be week "1" if they are in the same week
		if comp1.weekOfYear != comp2.weekOfYear {
			return false
		}
		// Must have a time interval under 1 week
		let weekInSeconds = NSTimeInterval(D_WEEK)
		return abs(self.timeIntervalSinceDate(date)) < weekInSeconds
	}
	
	/**
	Return the first day of the passed date's week (Sunday)
	
	:returns: NSDate with the date of the first day of the week
	*/
	func dateAtWeekStart() -> NSDate {
		let flags : NSCalendarUnit = [NSCalendarUnit.Year,NSCalendarUnit.Month ,
			NSCalendarUnit.WeekOfYear,
			NSCalendarUnit.Weekday]
		let components = NSCalendar.currentCalendar().components(flags, fromDate: self)
		components.weekday = 1 // Sunday
		components.hour = 0
		components.minute = 0
		components.second = 0
		return NSCalendar.currentCalendar().dateFromComponents(components)!
	}
	
	/// Return a date which represent the beginning of the current day (at 00:00:00)
	var beginningOfDay: NSDate {
		return set(hour: 0, minute: 0, second: 0)
	}
	
	/// Return a date which represent the end of the current day (at 23:59:59)
	var endOfDay: NSDate {
		return set(hour: 23, minute: 59, second: 59)
	}
	
	/// Return the first day of the month of the current date
	var beginningOfMonth: NSDate {
		return set(day: 1, hour: 0, minute: 0, second: 0)
	}
	
	/// Return the last day of the month of the current date
	var endOfMonth: NSDate {
		let lastDay = NSCalendar.currentCalendar().rangeOfUnit(.Day, inUnit: .Month, forDate: self).length
		return set(day: lastDay, hour: 23, minute: 59, second: 59)
	}
	
	/// Returns true if the date is in the same month of passed date
	func isSameMonthOf(date: NSDate) -> Bool {
        let beginningOfMonth = date.beginningOfMonth
        return self >= beginningOfMonth && self < beginningOfMonth.add(months: 1)
	}
	
	/// Return the first day of the year of the current date
	var beginningOfYear: NSDate {
		return set(month: 1, day: 1, hour: 0, minute: 0, second: 0)
	}
	
	/// Return the last day of the year of the current date
	var endOfYear: NSDate {
		return set(month: 12, day: 31, hour: 23, minute: 59, second: 59)
	}
	
	/// Returns true if the date is in the same year of passed date
	func isSameYearOf(date: NSDate) -> Bool {
        let beginningOfYear = date.beginningOfYear
        return self >= beginningOfYear && self < beginningOfYear.add(years: 1)
	}
	
	/**
	Return true if current date's day is not a weekend day
	
	:returns: true if date's day is a week day, not a weekend day
	*/
	func isWeekday() -> Bool {
		return !self.isWeekend()
	}
	
	/**
	Return true if the date is the weekend
	
	:returns: true or false
	*/
	func isWeekend() -> Bool {
		let range = NSCalendar.currentCalendar().maximumRangeOfUnit(NSCalendarUnit.Weekday)
		return (self.weekday == range.location || self.weekday == range.length)
	}
	
}

//MARK: CONVERTING DATE TO STRING

public extension NSDate {
	
	/**
	Return a formatted string with passed style for date and time
	
	:param: dateStyle    style of the date component into the output string
	:param: timeStyle    style of the time component into the output string
	:param: relativeDate true to use relative date style
	
	:returns: string representation of the date
	*/
	public func toString(dateStyle dateStyle: NSDateFormatterStyle, timeStyle: NSDateFormatterStyle, relativeDate: Bool = false) -> String {
		let dateFormatter = NSDate.localThreadDateFormatter()
		dateFormatter.dateStyle = dateStyle
		dateFormatter.timeStyle = timeStyle
		dateFormatter.doesRelativeDateFormatting = relativeDate
		return dateFormatter.stringFromDate(self)
	}
	
	/**
	Return a new string which represent the NSDate into passed format
	
	:param: format format of the output string. Choose one of the available format or use a custom string
	
	:returns: a string with formatted date
	*/
	public func toString(format format: DateFormat) -> String {
		var dateFormat: String
		switch format {
		case .ISO8601:
			dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
		case .RSS:
			dateFormat = "EEE, d MMM yyyy HH:mm:ss ZZZ"
		case .AltRSS:
			dateFormat = "d MMM yyyy HH:mm:ss ZZZ"
		case .Custom(let string):
			dateFormat = string
		}
		let dateFormatter = NSDate.localThreadDateFormatter()
		dateFormatter.dateFormat = dateFormat
		return dateFormatter.stringFromDate(self)
	}
	
	/**
	Return an ISO8601 formatted string from the current date instance
	
	:returns: string with date in ISO8601 format
	*/
	public func toISOString() -> String {
		let dateFormatter = NSDate.localThreadDateFormatter()
		dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
		dateFormatter.timeZone = NSTimeZone(abbreviation: "UTC")
		dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
		return dateFormatter.stringFromDate(self).stringByAppendingString("Z")
	}
	
	/**
	Return a relative string which represent the date instance
	
	:param: fromDate    comparison date (by default is the current NSDate())
	:param: abbreviated true to use abbreviated unit forms (ie. "ys" instead of "years")
	:param: maxUnits    max detail units to print (ie. "1 hour 47 minutes" is maxUnit=2, "1 hour" is maxUnit=1)
	
	:returns: formatted string
	*/
	public func toRelativeString(fromDate: NSDate = NSDate(), abbreviated : Bool = false, maxUnits: Int = 1) -> String {
		let seconds = fromDate.timeIntervalSinceDate(self)
		if fabs(seconds) < 1 {
			return "just now"._sdLocalize
		}
		
		let significantFlags : NSCalendarUnit = NSDate.componentFlags()
		let components = NSCalendar.currentCalendar().components(significantFlags, fromDate: fromDate, toDate: self, options: [])
		
		var string = String()
		//var isApproximate:Bool = false
		var numberOfUnits:Int = 0
		let unitList : [String] = ["year", "month", "weekOfYear", "day", "hour", "minute", "second"]
		for unitName in unitList {
			let unit : NSCalendarUnit = unitName._sdToCalendarUnit()
			if ((significantFlags.rawValue & unit.rawValue) != 0) &&
				(_sdCompareCalendarUnit(NSCalendarUnit.Second, other: unit) != .OrderedDescending) {
					let number:NSNumber = NSNumber(float: fabsf(components.valueForKey(unitName)!.floatValue))
					if Bool(number.integerValue) {
						let singular = (number.unsignedIntegerValue == 1)
						let suffix = String(format: "%@ %@", arguments: [number, _sdLocalizeStringForValue(singular, unit: unit, abbreviated: abbreviated)])
						if string.isEmpty {
							string = suffix
						} else if numberOfUnits < maxUnits {
							string += String(format: " %@", arguments: [suffix])
						} else {
						//	isApproximate = true
						}
						numberOfUnits += 1
					}
			}
		}
		
		/*if string.isEmpty == false {
			if seconds > 0 {
				string = String(format: "%@ %@", arguments: [string, "ago"._sdLocalize])
			} else {
				string = String(format: "%@ %@", arguments: [string, "from now"._sdLocalize])
			}
			
			if (isApproximate) {
				string = String(format: "about %@", arguments: [string])
			}
		}*/
		return string
	}
	
	/**
	Return a string representation of the date where both date and time are in short style format
	
	:returns: date's string representation
	*/
	public func toShortString() -> String {
		return toString(dateStyle: NSDateFormatterStyle.ShortStyle, timeStyle: NSDateFormatterStyle.ShortStyle)
	}
	
	/**
	Return a string representation of the date where both date and time are in medium style format
	
	:returns: date's string representation
	*/
	public func toMediumString() -> String {
		return toString(dateStyle: NSDateFormatterStyle.MediumStyle, timeStyle: NSDateFormatterStyle.MediumStyle)
	}
	
	/**
	Return a string representation of the date where both date and time are in long style format
	
	:returns: date's string representation
	*/
	public func toLongString() -> String {
		return toString(dateStyle: NSDateFormatterStyle.LongStyle, timeStyle: NSDateFormatterStyle.LongStyle)
	}
	
	/**
	Return a string representation of the date with only the date in short style format (no time)
	
	:returns: date's string representation
	*/
	public func toShortDateString() -> String {
		return toString(dateStyle: NSDateFormatterStyle.ShortStyle, timeStyle: NSDateFormatterStyle.NoStyle)
	}
	
	/**
	Return a string representation of the date with only the time in short style format (no date)
	
	:returns: date's string representation
	*/
	public func toShortTimeString() -> String {
		return toString(dateStyle: NSDateFormatterStyle.NoStyle, timeStyle: NSDateFormatterStyle.ShortStyle)
	}
	
	/**
	Return a string representation of the date with only the date in medium style format (no date)
	
	:returns: date's string representation
	*/
	public func toMediumDateString() -> String {
		return toString(dateStyle: NSDateFormatterStyle.MediumStyle, timeStyle: NSDateFormatterStyle.NoStyle)
	}
	
	/**
	Return a string representation of the date with only the time in medium style format (no date)
	
	:returns: date's string representation
	*/
	public func toMediumTimeString() -> String {
		return toString(dateStyle: NSDateFormatterStyle.NoStyle, timeStyle: NSDateFormatterStyle.MediumStyle)
	}
	
	/**
	Return a string representation of the date with only the date in long style format (no date)
	
	:returns: date's string representation
	*/
	public func toLongDateString() -> String {
		return toString(dateStyle: NSDateFormatterStyle.LongStyle, timeStyle: NSDateFormatterStyle.NoStyle)
	}
	
	/**
	Return a string representation of the date with only the time in long style format (no date)
	
	:returns: date's string representation
	*/
	public func toLongTimeString() -> String {
		return toString(dateStyle: NSDateFormatterStyle.NoStyle, timeStyle: NSDateFormatterStyle.LongStyle)
	}
	
}

//MARK: PRIVATE ACCESSORY METHODS

private extension NSDate {
	
	private class func components(fromDate fromDate: NSDate) -> NSDateComponents! {
		return NSCalendar.currentCalendar().components(NSDate.componentFlags(), fromDate: fromDate)
	}
	
	private func addComponents(components: NSDateComponents) -> NSDate? {
		let calendar = NSCalendar.currentCalendar()
		return calendar.dateByAddingComponents(components, toDate: self, options: [])
	}
	
	private class func componentFlags() -> NSCalendarUnit {
		return [NSCalendarUnit.Era ,
			NSCalendarUnit.Year ,
			NSCalendarUnit.Month ,
			NSCalendarUnit.Day,
			NSCalendarUnit.WeekOfYear,
			NSCalendarUnit.Hour ,
			NSCalendarUnit.Minute ,
			NSCalendarUnit.Second ,
			NSCalendarUnit.Weekday ,
			NSCalendarUnit.WeekdayOrdinal,
			NSCalendarUnit.WeekOfYear]
	}
	
	/// Return the NSDateComponents which represent current date
	private var components: NSDateComponents {
		return  NSCalendar.currentCalendar().components(NSDate.componentFlags(), fromDate: self)
	}
	
	/**
	This function uses NSThread dictionary to store and retrive a thread-local object, creating it if it has not already been created
	
	:param: key    identifier of the object context
	:param: create create closure that will be invoked to create the object
	
	:returns: a cached instance of the object
	*/
	private class func cachedObjectInCurrentThread<T: AnyObject>(key: String, create: () -> T) -> T {
		if let threadDictionary = NSThread.currentThread().threadDictionary as NSMutableDictionary? {
			if let cachedObject = threadDictionary[key] as! T? {
				return cachedObject
			} else {
				let newObject = create()
				threadDictionary[key] = newObject
				return newObject
			}
		} else {
			assert(false, "Current NSThread dictionary is nil. This should never happens, we will return a new instance of the object on each call")
			return create()
		}
	}
	
	/**
	Return a thread-cached NSDateFormatter instance
	
	:returns: instance of NSDateFormatter
	*/
	private class func localThreadDateFormatter() -> NSDateFormatter {
		return NSDate.cachedObjectInCurrentThread("com.library.swiftdate.dateformatter") {
			let dateFormatter = NSDateFormatter()
			dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
			return dateFormatter
		}
	}
}

//MARK: RELATIVE NSDATE CONVERSION PRIVATE METHODS

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

//MARK: OPERATIONS WITH DATES (==,!=,<,>,<=,>=)

extension NSDate : Comparable {}

public func == (left: NSDate, right: NSDate) -> Bool {
	return (left.compare(right) == NSComparisonResult.OrderedSame)
}

public func < (left: NSDate, right: NSDate) -> Bool {
	return (left.compare(right) == NSComparisonResult.OrderedAscending)
}

public func > (left: NSDate, right: NSDate) -> Bool {
	return (left.compare(right) == NSComparisonResult.OrderedDescending)
}

//MARK: ARITHMETIC OPERATIONS WITH DATES (-,-=,+,+=)


// MARK: - Operators

extension NSDate {
    func difference(toDate: NSDate, unitFlags: NSCalendarUnit, withCalendar calendar: NSCalendar = NSCalendar.currentCalendar()) -> NSDateComponents? {
        return calendar.components(unitFlags, fromDate: self, toDate: toDate, options: NSCalendarOptions(rawValue: 0))
    }

    func addComponents(components: NSDateComponents, withCalendar calendar: NSCalendar = NSCalendar.currentCalendar()) -> NSDate? {
        return calendar.dateByAddingComponents(components, toDate: self, options: NSCalendarOptions.MatchStrictly)
    }
}

public func - (lhs: NSDate, rhs: NSDateComponents) -> NSDate? {
    return lhs + (-rhs)
}

public func + (lhs: NSDate, rhs: NSDateComponents) -> NSDate? {
    return lhs.addComponents(rhs)
}


public prefix func - (dateComponents: NSDateComponents) -> NSDateComponents {

    // For looping through a set of units
    let componentFlagSet: [NSCalendarUnit] = [.Day, .Month, .Year, .Hour, .Minute, .Second, .Nanosecond, .YearForWeekOfYear, .WeekOfYear, .Weekday, .Quarter, .WeekdayOrdinal]

    let result = NSDateComponents()
    for unit in componentFlagSet {
        let value = dateComponents.valueForComponent(unit)
        if value != Int(NSDateComponentUndefined) {
            result.setValue(-value, forComponent: unit)
        }
    }
    return result
}

// MARK: - Helpers to enable expressions e.g. date + 1.days - 20.seconds

public extension Int {
    var nanoseconds: NSDateComponents {
        let dateComponents = NSDateComponents()
        dateComponents.nanosecond = self
        return dateComponents
    }
    var seconds: NSDateComponents {
        let dateComponents = NSDateComponents()
        dateComponents.second = self
        return dateComponents
    }

    var minutes: NSDateComponents {
        let dateComponents = NSDateComponents()
        dateComponents.minute = self
        return dateComponents
    }

    var hours: NSDateComponents {
        let dateComponents = NSDateComponents()
        dateComponents.hour = self
        return dateComponents
    }

    var days: NSDateComponents {
        let dateComponents = NSDateComponents()
        dateComponents.day = self
        return dateComponents
    }

    var weeks: NSDateComponents {
        let dateComponents = NSDateComponents()
        dateComponents.weekOfYear = self
        return dateComponents
    }

    var months: NSDateComponents {
        let dateComponents = NSDateComponents()
        dateComponents.month = self
        return dateComponents
    }

    var years: NSDateComponents {
        let dateComponents = NSDateComponents()
        dateComponents.year = self
        return dateComponents
    }
}



public func - (left : NSDate, right: NSTimeInterval) -> NSDate {
	return left.dateByAddingTimeInterval(-right)
}

public func -= (inout left: NSDate, right: NSTimeInterval) {
	left = left.dateByAddingTimeInterval(-right)
}

public func + (left: NSDate, right: NSTimeInterval) -> NSDate {
	return left.dateByAddingTimeInterval(right)
}

public func += (inout left: NSDate, right: NSTimeInterval) {
	left = left.dateByAddingTimeInterval(right)
}

public func - (left: NSDate, right: CalendarType) -> NSDate {
	let calendarType = right.copy()
	calendarType.amount = -calendarType.amount
	let calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
	let dateComponents = calendarType.dateComponents()
	let finalDate = calendar.dateByAddingComponents(dateComponents, toDate: left, options: [])!
	return finalDate
}

public func -= (inout left: NSDate, right: CalendarType) {
	left = left - right
}

public func + (left: NSDate, right: CalendarType) -> NSDate {
	let calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
	return calendar.dateByAddingComponents(right.dateComponents(), toDate: left, options: [])!
}

public func += (inout left: NSDate, right: CalendarType) {
	left = left + right
}

public func - (left: NSDate, right: NSDate) -> NSTimeInterval {
    return left.timeIntervalSinceDate(right)
}

//MARK: SUPPORTING STRUCTURES

public class CalendarType {
	var calendarUnit : NSCalendarUnit
	var amount : Int
	
	init(amount : Int) {
		self.calendarUnit = []
		self.amount = amount
	}
	
	init(amount: Int, calendarUnit: NSCalendarUnit) {
		self.calendarUnit = calendarUnit
		self.amount = amount
	}
	
	func dateComponents() -> NSDateComponents {
		return NSDateComponents()
	}
	
	func copy() -> CalendarType {
		return CalendarType(amount: self.amount, calendarUnit: self.calendarUnit)
	}
}

public class MonthCalendarType : CalendarType {
	
	override init(amount : Int) {
		super.init(amount: amount)
		self.calendarUnit = NSCalendarUnit.Month
	}
	
	override func dateComponents() -> NSDateComponents {
		let components = super.dateComponents()
		components.month = self.amount
		return components
	}
	
	override func copy() -> MonthCalendarType {
		let objCopy =  MonthCalendarType(amount: self.amount)
		objCopy.calendarUnit = self.calendarUnit
		return objCopy;
	}
}

public class YearCalendarType : CalendarType {
	
	override init(amount : Int) {
		super.init(amount: amount, calendarUnit: NSCalendarUnit.Year)
	}
	
	override func dateComponents() -> NSDateComponents {
		let components = super.dateComponents()
		components.year = self.amount
		return components
	}
	
	override func copy() -> YearCalendarType {
		let objCopy =  YearCalendarType(amount: self.amount)
		objCopy.calendarUnit = self.calendarUnit
		return objCopy
	}
}


//MARK: PRIVATE STRING EXTENSION

private extension String {
	
	var _sdLocalize: String {
		return NSBundle.mainBundle().localizedStringForKey(self, value: nil, table: "SwiftDates")
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
		default:
			return []
		}
	}
}

public enum DateFormat {
	case ISO8601, RSS, AltRSS
	case Custom(String)
}

let D_SECOND = 1
let D_MINUTE = 60
let D_HOUR = 3600
let D_DAY = 86400
let D_WEEK = 604800
let D_YEAR = 31556926
