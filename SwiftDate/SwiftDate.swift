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

// Addition functions copied thankfully from Axel Schlueter's timeDateExtensions.swift


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
    var yearForWeekOfYear: Int  { return components.yearForWeekOfYear }
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
    // Get the nanosecond component of the date
    var nanosecond: Int			{ return components.nanosecond }
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
		guard !string.isEmpty else {
			return nil
		}
		
		let dateFormatter = NSDate.localThreadDateFormatter()
		switch format {
		case .ISO8601: // 1972-07-16T08:15:30-05:00
            var formattedString : NSString = string
            if formattedString.hasSuffix("Z") {
                formattedString = formattedString.substringToIndex(formattedString.length-1) + "UTC"
            }
			dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
			dateFormatter.dateFormat = ISO8601Formatter(fromString: string)
			return dateFormatter.dateFromString(string)
		case .AltRSS: // 09 Sep 2011 15:26:08 +0200
			var formattedString : NSString = string
			if formattedString.hasSuffix("Z") {
				formattedString = formattedString.substringToIndex(formattedString.length-1) + "UTC"
			}
			dateFormatter.dateFormat = "d MMM yyyy HH:mm:ss ZZZ"
			return dateFormatter.dateFromString(formattedString as String)
		case .RSS: // Fri, 09 Sep 2011 15:26:08 +0200
			var formattedString : NSString = string
			if formattedString.hasSuffix("Z") {
				formattedString = formattedString.substringToIndex(formattedString.length-1) + "UTC"
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
	Create a new NSDate instance based on set components, nil components will default to their values of the reference date (1-Jan-2001 00:00:00.000Z) in a gregorian calendar
	
	:param: year    year component (nil = 2001)
	:param: month   month component (nil = 1)
	:param: day     day component (nil = 1)
	:param: hour    hour component (nil = 0)
	:param: minute  minute component (nil = 0)
    :param: second  second component (nil = 0)
    :param: nanosecond  nanosecond component (nil = 0)
    :param: timeZoneAbbreviation    time zone component (nil = UTC)
    :param: calendarIdentifier      calendar component (nil = Gregorian)

	:returns: a new NSDate with components changed according to passed params
	*/
    class func date(year year: Int? = nil, month: Int? = nil, day: Int? = nil, hour: Int? = nil, minute: Int? = nil, second: Int? = nil, nanosecond: Int? = nil, timeZoneAbbreviation: String? = nil, calendarIdentifier: String? = nil) -> NSDate? {

        let referenceDate = NSDate(timeIntervalSinceReferenceDate: 0)
        let calendar = calendarIdentifier == nil ? NSCalendar.currentCalendar() : NSCalendar(calendarIdentifier: calendarIdentifier!)!
        let components = calendar.components([.Year, .Month, .Day, .Hour, .Minute, .Second, .Nanosecond, .TimeZone, .Calendar], fromDate: referenceDate)

        if year != nil { components.year = year! }
        if month != nil { components.month = month! }
        if day != nil { components.day = day! }
        if hour != nil { components.hour = hour! }
        if minute != nil { components.minute = minute! }
        if second != nil { components.second = second! }
        if nanosecond != nil { components.nanosecond = nanosecond! }
        if timeZoneAbbreviation != nil { components.timeZone = NSTimeZone(abbreviation: timeZoneAbbreviation!) }

        let date = calendar.dateFromComponents(components)
        return date
    }

    /**
    Create a new NSDate instance based on week oriented set components, nil components will default to their values of the reference date (1-Jan-2001 00:00:00.000Z) in a gregorian calendar

    :param: yearOfWeekOfYear        yearOfWeekOfYear component (nil = 2001)
    :param: weekOfYear              weekOfYear component (nil = 1)
    :param: weekday                 weekday component (nil = 1)
    :param: hour                    hour component (nil = 0)
    :param: minute                  minute component (nil = 0)
    :param: second                  second component (nil = 0)
    :param: nanosecond              nanosecond component (nil = 0)
    :param: timeZoneAbbreviation    time zone component (nil = UTC)
    :param: calendarIdentifier      calendar component (nil = Gregorian)

    :returns: a new NSDate with components changed according to passed params
    */
  class func date(yearForWeekOfYear yearForWeekOfYear: Int? = nil, weekOfYear: Int? = nil, weekday: Int? = nil, hour: Int? = nil, minute: Int? = nil, second: Int? = nil, nanosecond: Int? = nil, timeZoneAbbreviation: String? = nil, calendarIdentifier: String? = nil) -> NSDate? {

        let referenceDate = NSDate(timeIntervalSinceReferenceDate: 0)
        let calendar = calendarIdentifier == nil ? NSCalendar.currentCalendar() : NSCalendar(calendarIdentifier: calendarIdentifier!)!
        let components = calendar.components([.YearForWeekOfYear, .WeekOfYear, .Weekday, .Hour, .Minute, .Second, .Nanosecond, .TimeZone, .Calendar], fromDate: referenceDate)

        if yearForWeekOfYear != nil { components.yearForWeekOfYear = yearForWeekOfYear! }
        if weekOfYear != nil { components.weekOfYear = weekOfYear! }
        if weekday != nil { components.weekday = weekday! }
        if hour != nil { components.hour = hour! }
        if minute != nil { components.minute = minute! }
        if second != nil { components.second = second! }
        if nanosecond != nil { components.nanosecond = nanosecond! }
        if timeZoneAbbreviation != nil { components.timeZone = NSTimeZone(abbreviation: timeZoneAbbreviation!) }

        let date = calendar.dateFromComponents(components)
        return date
    }

    /**
	Return a new NSDate instance with the current date and time set to 00:00:00
	
	:param: tz optional timezone abbreviation
	
	:returns: a new NSDate instance of the today's date
	*/
	class func today(tz: String? = nil) -> NSDate! {
        return NSDate().startOf(.Day)
	}
	
	/**
	Return a new NSDate istance with the current date minus one day
	
	:param: tz optional timezone abbreviation
	
	:returns: a new NSDate instance which represent yesterday's date
	*/
	class func yesterday(tz: String? = nil) -> NSDate! {
		return today(tz) - 1.days
	}
	
	/**
	Return a new NSDate istance with the current date plus one day
	
	:param: tz optional timezone abbreviation
	
	:returns: a new NSDate instance which represent tomorrow's date
	*/
	class func tomorrow(tz: String? = nil) -> NSDate! {
		return today(tz) + 1.days
	}
	
	/**
	Individual set single component of the current date instance
	
	:param: year   a non-nil value to change the year component of the instance
	:param: month  a non-nil value to change the month component of the instance
	:param: day    a non-nil value to change the day component of the instance
	:param: hour   a non-nil value to change the hour component of the instance
	:param: minute a non-nil value to change the minute component of the instance
    :param: second a non-nil value to change the second component of the instance
    :param: nanosecond a non-nil value to change the nanosecond component of the instance
	:param: tz     a non-nil value (timezone abbreviation string as for NSTimeZone) to change the timezone component of the instance
	
	:returns: a new NSDate instance with changed values
	*/
    func set(year: Int?=nil, month: Int?=nil, day: Int?=nil, hour: Int?=nil, minute: Int?=nil, second: Int?=nil, nanosecond: Int?=nil, tz: String?=nil) -> NSDate! {
        let components = self.components
        components.year = year ?? self.year
        components.month = month ?? self.month
        components.day = day ?? self.day
        components.hour = hour ?? self.hour
        components.minute = minute ?? self.minute
        components.second = second ?? self.second
        components.nanosecond = nanosecond ?? self.nanosecond
        components.timeZone = (tz != nil ? NSTimeZone(abbreviation: tz!) : components.timeZone)
        print(components)
        return NSCalendar.currentCalendar().dateFromComponents(components)
    }
    
    func set(yearForWeekOfYear: Int?=nil, weekOfYear: Int?=nil, weekday: Int?=nil, hour: Int?=nil, minute: Int?=nil, second: Int?=nil, nanosecond: Int?=nil, tz: String?=nil) -> NSDate! {
        let components = self.components
        components.yearForWeekOfYear = yearForWeekOfYear ?? self.yearForWeekOfYear
        components.weekOfYear = weekOfYear ?? self.weekOfYear
        components.weekday = weekday ?? self.weekday
        components.hour = hour ?? self.hour
        components.minute = minute ?? self.minute
        components.second = second ?? self.second
        components.nanosecond = nanosecond ?? self.nanosecond
        components.timeZone = (tz != nil ? NSTimeZone(abbreviation: tz!) : components.timeZone)
        print(components)
        return NSCalendar.currentCalendar().dateFromComponents(components)
    }

    func set(hour: Int?=nil, minute: Int?=nil, second: Int?=nil, nanosecond: Int?=nil, tz: String?=nil) -> NSDate! {
        let components = self.components
        components.hour = hour ?? self.hour
        components.minute = minute ?? self.minute
        components.second = second ?? self.second
        components.nanosecond = nanosecond ?? self.nanosecond
        components.timeZone = (tz != nil ? NSTimeZone(abbreviation: tz!) : components.timeZone)
        print(components)
        return NSCalendar.currentCalendar().dateFromComponents(components)
    }

	/**
	Allows you to set individual date components by passing an array of components name and associated values
	
	:param: componentsDict components dict. Accepted keys are year,month,day,hour,minute,second,nanosecond
	
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
	Allows you to set a single component by passing it's name (year,month,day,hour,minute,second,nanosecond are accepted).
	Please note: this method return a new immutable NSDate instance (NSDate are immutable, damn!). So while you
	can chain multiple set calls, if you need to alter more than one component see the method above which accept
	different params.
	
	:param: name  the name of the component to alter (year,month,day,hour,minute,second,nanosecond are accepted)
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
    :param: nanoseconds nil or +/- nanoseconds to add or subtract from date

	:returns: a new NSDate instance with changed values
	*/
    func add(years years: Int=0, months: Int=0, weeks: Int=0, days: Int=0,hours: Int=0,minutes: Int=0,seconds: Int=0,nanoseconds: Int=0) -> NSDate {
		let components = NSDateComponents()
        components.year = years
        components.month = months
        components.weekOfYear = weeks
        components.day = days
        components.hour = hours
        components.minute = minutes
        components.second = seconds
        components.nanosecond = nanosecond
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

// MARK: Bring order to NSCalendarUnits

prefix func --(unit: NSCalendarUnit) -> NSCalendarUnit? {
    let calendarUnitsYMD: [NSCalendarUnit] = [.Era, .Year, .Month, .Day, .Hour, .Minute, .Second, .Nanosecond]
    let calendarUnitsYWD: [NSCalendarUnit] = [.YearForWeekOfYear, .WeekOfYear, .Weekday, .Hour]

    if let index = calendarUnitsYMD.indexOf(unit) {
        let nextIndex = index + 1
        if nextIndex > calendarUnitsYMD.count {
            return nil
        }
        return calendarUnitsYMD[nextIndex]
    }
    if let index = calendarUnitsYWD.indexOf(unit) {
        let nextIndex = index + 1
        if nextIndex > calendarUnitsYWD.count {
            return nil
        }
        return calendarUnitsYWD[nextIndex]
    }

    return nil
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
	
    @available(*, introduced=1.2, message="Replaces secondsAfterDate and secondsBeforeDate")
    func secondsDifference(toDate: NSDate) -> Int {
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(NSCalendarUnit.Second, fromDate: self, toDate: toDate, options: NSCalendarOptions(rawValue: 0))
        return components.second
    }

    @available(*, introduced=1.2, message="Replaces minutesAfterDate and minutesBeforeDate")
    func minutesDifference(toDate: NSDate) -> Int {
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(NSCalendarUnit.Minute, fromDate: self, toDate: toDate, options: NSCalendarOptions(rawValue: 0))
        return components.minute
    }

    @available(*, introduced=1.2, message="Replaces hoursAfterDate and hoursBeforeDate")
    func hoursDifference(toDate: NSDate) -> Int {
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(NSCalendarUnit.Hour, fromDate: self, toDate: toDate, options: NSCalendarOptions(rawValue: 0))
        return components.hour
    }

    @available(*, introduced=1.2, message="Replaces daysAfterDate and daysBeforeDate")
    func daysDifference(toDate: NSDate) -> Int {
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(NSCalendarUnit.Day, fromDate: self, toDate: toDate, options: NSCalendarOptions(rawValue: 0))
        return components.day
    }

    @available(*, introduced=1.2)
    func weeksDifference(toDate: NSDate) -> Int {
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(NSCalendarUnit.WeekOfYear, fromDate: self, toDate: toDate, options: NSCalendarOptions(rawValue: 0))
        return components.weekOfYear
    }

    @available(*, introduced=1.2)
    func monthsDifference(toDate: NSDate) -> Int {
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.Month, fromDate: self, toDate: toDate, options: NSCalendarOptions(rawValue: 0))
        return components.month
    }

    @available(*, introduced=1.2)
    func yearsDifference(toDate: NSDate) -> Int {
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.Year, fromDate: self, toDate: toDate, options: NSCalendarOptions(rawValue: 0))
        return components.year
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
			return ((comp1.year == comp2.year) && (comp1.month == comp2.month) && (comp1.day == comp2.day))
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
	Return true if the date's year is a leap year (Gregorian calendar only)
	
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
        let calendar = NSCalendar.currentCalendar()
		return calendar.isDateInToday(self)
	}
	
	/**
	True if the date is the current date plus one day (tomorrow)
	
	:returns: true if date is tomorrow
	*/
	func isTomorrow() -> Bool {
        let calendar = NSCalendar.currentCalendar()
        return calendar.isDateInTomorrow(self)
	}
	
	/**
	True if the date is the current date minus one day (yesterday)
	
	:returns: true if date is yesterday
	*/
	func isYesterday() -> Bool {
        let calendar = NSCalendar.currentCalendar()
        return calendar.isDateInYesterday(self)
	}
	
	/**
	Return true if the date falls into the current week
	
	:returns: true if date is inside the current week days range
	*/
	func isThisWeek() -> Bool {
        return self.isSame(.WeekOfYear, date: NSDate())
	}
	
	/**
	Return true if the date falls into the current month
	
	:returns: true if date is inside the current month
	*/
	func isThisMonth() -> Bool {
        return self.isSame(.Month, date: NSDate())
	}
	
	/**
	Return true if the date falls into the current year
	
	:returns: true if date is inside the current year
	*/
	func isThisYear() -> Bool {
		return self.isSame(.Year, date: NSDate())
	}
	
	/**
	Return true if the date is in the same week of passed date
	
	:param: date date to compare with
	
	:returns: true if both dates falls in the same week
	*/
    @available(*, deprecated=1.3, obsoleted=1.5, renamed="isSame(.WeekOfYear)")
	func isSameWeekOf(date: NSDate) -> Bool {
        let calendar = NSCalendar.currentCalendar()
        return calendar.isDate(self, equalToDate: date, toUnitGranularity: .WeekOfYear)
	}


    /**
    Return true if the date is in the same time unit of passed date

    :param: unit calendar unit to compare within
    :param: date date to compare with

    :returns: true if both dates falls in the same calendar unit
    */
    func isSame(unit: NSCalendarUnit, date: NSDate) -> Bool {
        let calendar = NSCalendar.currentCalendar()
        return calendar.isDate(self, equalToDate: date, toUnitGranularity: unit)
    }


    /**
    Return the start of a determined calendar unit based on self

    :returns: NSDate at the start of the NSCalendarUnit passed
    */
    func startOf(unit: NSCalendarUnit, timeZoneAbbreviation: String? = nil, calendarIdentifier: String? = nil) -> NSDate? {

        let calendar = calendarIdentifier == nil ? NSCalendar.currentCalendar() : NSCalendar(calendarIdentifier: calendarIdentifier!)!
        calendar.timeZone = timeZoneAbbreviation == nil ? NSTimeZone.localTimeZone() : NSTimeZone(abbreviation: timeZoneAbbreviation!)!

        let nextSmallerUnit = --unit
        guard nextSmallerUnit != nil else {
            return self
        }

        let range = calendar.rangeOfUnit(nextSmallerUnit!, inUnit: unit, forDate: self)
        let minimum = range.location
        let date = calendar.nextDateAfterDate(self, matchingUnit: nextSmallerUnit!, value: minimum, options: [NSCalendarOptions.SearchBackwards, NSCalendarOptions.MatchNextTime])
        return date
    }

    /**
    Return the end of a determined calendar unit based on self

    :returns: NSDate at the start of the NSCalendarUnit passed
    */
    func endOf(unit: NSCalendarUnit, timeZoneAbbreviation: String? = nil, calendarIdentifier: String? = nil) -> NSDate? {

        let calendar = calendarIdentifier == nil ? NSCalendar.currentCalendar() : NSCalendar(calendarIdentifier: calendarIdentifier!)!
        calendar.timeZone = timeZoneAbbreviation == nil ? NSTimeZone.localTimeZone() : NSTimeZone(abbreviation: timeZoneAbbreviation!)!

        let nextSmallerUnit = --unit
        guard nextSmallerUnit != nil else {
            return self
        }

        let x = self.startOf(unit)
        let y = calendar.dateByAddingUnit(unit, value: 1, toDate: x!, options: NSCalendarOptions.MatchStrictly)
        let z = calendar.dateByAddingUnit(.Nanosecond, value: -1, toDate: y!, options: NSCalendarOptions.MatchStrictly)
        return z
        
    }


    /**
	Return the first day of the passed date's week (Sunday)
	
	:returns: NSDate with the date of the first day of the week
	*/
    @available(*, deprecated=1.3, obsoleted=1.5, renamed="startOf(.WeekOfYear)")
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
    @available(*, deprecated=1.3, obsoleted=1.5, renamed="startOf(.Day)")
	var beginningOfDay: NSDate {
		return startOf(.Day)!
	}
	
	/// Return a date which represent the end of the current day (at 23:59:59)
    @available(*, deprecated=1.3, obsoleted=1.5, renamed="endOf(.Day)")
	var endOfDay: NSDate {
		return endOf(.Day)!
	}
	
	/// Return the first day of the month of the current date
    @available(*, deprecated=1.3, obsoleted=1.5, renamed="startOf(.Month)")
	var beginningOfMonth: NSDate {
		return set(day: 1, hour: 0, minute: 0, second: 0)
	}
	
	/// Return the last day of the month of the current date
    @available(*, deprecated=1.3, obsoleted=1.5, renamed="endOf(.Month)")
	var endOfMonth: NSDate {
		let lastDay = NSCalendar.currentCalendar().rangeOfUnit(.Day, inUnit: .Month, forDate: self).length
		return set(day: lastDay, hour: 23, minute: 59, second: 59)
	}
	
	/// Returns true if the date is in the same month of passed date
    @available(*, deprecated=1.3, obsoleted=1.5, renamed="isSame(.Month)")
	func isSameMonthOf(date: NSDate) -> Bool {
		return isSame(.Month, date: date)
	}
	
	/// Return the first day of the year of the current date
    @available(*, deprecated=1.3, obsoleted=1.5, renamed="startOf(.Year)")
	var beginningOfYear: NSDate {
		return set(month: 1, day: 1, hour: 0, minute: 0, second: 0)
	}
	
	/// Return the last day of the year of the current date
    @available(*, deprecated=1.3, obsoleted=1.5, renamed="endOf(.Year)")
	var endOfYear: NSDate {
		return set(month: 12, day: 31, hour: 23, minute: 59, second: 59)
	}
	
	/// Returns true if the date is in the same year of passed date
    @available(*, deprecated=1.3, obsoleted=1.5, renamed="isSame(.Year)")
	func isSameYearOf(date: NSDate) -> Bool {
		return isSame(.Year, date: date)
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
		let unitList : [String] = ["year", "month", "weekOfYear", "day", "hour", "minute", "second", "nanosecond"]
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
	
	private func addComponents(components: NSDateComponents) -> NSDate {
		let cal = NSCalendar.currentCalendar()
		return cal.dateByAddingComponents(components, toDate: self, options: [])!
	}
	
    private class func componentFlags() -> NSCalendarUnit {
        return [
            NSCalendarUnit.Era ,
            NSCalendarUnit.Year ,
            NSCalendarUnit.Month ,
            NSCalendarUnit.Day,
            NSCalendarUnit.Hour ,
            NSCalendarUnit.Minute ,
            NSCalendarUnit.Second ,
            NSCalendarUnit.Nanosecond ,
            NSCalendarUnit.YearForWeekOfYear ,
            NSCalendarUnit.WeekOfYear ,
            NSCalendarUnit.WeekOfMonth ,
            NSCalendarUnit.Weekday ,
            NSCalendarUnit.WeekdayOrdinal ,
            NSCalendarUnit.Quarter ,
            NSCalendarUnit.TimeZone ,
            NSCalendarUnit.Calendar]
    }

    /// Return the NSDateComponents which represent current date
    private var components: NSDateComponents {
        return NSDate.components(fromDate: self)
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

public func != (left: NSDate, right: NSDate) -> Bool {
	return !(left == right)
}

public func < (left: NSDate, right: NSDate) -> Bool {
	return (left.compare(right) == NSComparisonResult.OrderedAscending)
}

public func > (left: NSDate, right: NSDate) -> Bool {
	return (left.compare(right) == NSComparisonResult.OrderedDescending)
}

public func <= (left: NSDate, right: NSDate) -> Bool {
	return !(left > right)
}

public func >= (left: NSDate, right: NSDate) -> Bool {
	return !(left < right)
}

//MARK: ARITHMETIC OPERATIONS WITH DATES (-,-=,+,+=)

public func - (left : NSDate, right: NSDateComponents) -> NSDate {
	return left + (-right)
}

public func -= (inout left: NSDate, right: NSDateComponents) {
    left = left - right
}

/** subtracts the two sets of date components */
public func - (left: NSDateComponents, right: NSDateComponents) -> NSDateComponents {
    let dateComponents = NSDateComponents()
    dateComponents.nanosecond = (left.nanosecond != Int(NSDateComponentUndefined) ? left.nanosecond : 0) - (right.nanosecond != Int(NSDateComponentUndefined) ? right.nanosecond : 0)
    dateComponents.second = (left.second != Int(NSDateComponentUndefined) ? left.second : 0) - (right.second != Int(NSDateComponentUndefined) ? right.second : 0)
    dateComponents.minute = (left.minute != Int(NSDateComponentUndefined) ? left.minute : 0) - (right.minute != Int(NSDateComponentUndefined) ? right.minute : 0)
    dateComponents.hour = (left.hour != Int(NSDateComponentUndefined) ? left.hour : 0) - (right.hour != Int(NSDateComponentUndefined) ? right.hour : 0)
    dateComponents.day = (left.day != Int(NSDateComponentUndefined) ? left.day : 0) - (right.day != Int(NSDateComponentUndefined) ? right.day : 0)
    dateComponents.month = (left.month != Int(NSDateComponentUndefined) ? left.month : 0) - (right.month != Int(NSDateComponentUndefined) ? right.month : 0)
    dateComponents.year = (left.year != Int(NSDateComponentUndefined) ? left.year : 0) - (right.year != Int(NSDateComponentUndefined) ? right.year : 0)
    dateComponents.weekOfYear = (left.weekOfYear != Int(NSDateComponentUndefined) ? left.weekOfYear : 0) - (right.weekOfYear != Int(NSDateComponentUndefined) ? right.weekOfYear : 0)
    return dateComponents
}

public func + (left: NSDate, right: NSDateComponents) -> NSDate {
    let calendar = NSCalendar.currentCalendar()
    return calendar.dateByAddingComponents(right, toDate: left, options: NSCalendarOptions(rawValue: 0))!
}

public func += (inout left: NSDate, right: NSDateComponents) {
    left = left + right
}

/** adds the two sets of date components */
func + (left: NSDateComponents, right: NSDateComponents) -> NSDateComponents {
    let calendar = NSCalendar.currentCalendar()
    let leftDate = left.date!
    let resultDate = calendar.dateByAddingComponents(right, toDate: leftDate, options: NSCalendarOptions(rawValue: 0))
    return resultDate!.components

    /*
    let dateComponents = NSDateComponents()
    dateComponents.nanosecond = (left.nanosecond != Int(NSDateComponentUndefined) ? left.nanosecond : 0) + (right.nanosecond != Int(NSDateComponentUndefined) ? right.nanosecond : 0)
    dateComponents.second = (left.second != Int(NSDateComponentUndefined) ? left.second : 0) + (right.second != Int(NSDateComponentUndefined) ? right.second : 0)
    dateComponents.minute = (left.minute != Int(NSDateComponentUndefined) ? left.minute : 0) + (right.minute != Int(NSDateComponentUndefined) ? right.minute : 0)
    dateComponents.hour = (left.hour != Int(NSDateComponentUndefined) ? left.hour : 0) + (right.hour != Int(NSDateComponentUndefined) ? right.hour : 0)
    dateComponents.day = (left.day != Int(NSDateComponentUndefined) ? left.day : 0) + (right.day != Int(NSDateComponentUndefined) ? right.day : 0)
    dateComponents.month = (left.month != Int(NSDateComponentUndefined) ? left.month : 0) + (right.month != Int(NSDateComponentUndefined) ? right.month : 0)
    dateComponents.year = (left.year != Int(NSDateComponentUndefined) ? left.year : 0) + (right.year != Int(NSDateComponentUndefined) ? right.year : 0)
    dateComponents.weekOfYear = (left.weekOfYear != Int(NSDateComponentUndefined) ? left.weekOfYear : 0) + (right.weekOfYear != Int(NSDateComponentUndefined) ? right.weekOfYear : 0)
    dateComponents.yearForWeekOfYear = (left.yearForWeekOfYear != Int(NSDateComponentUndefined) ? left.yearForWeekOfYear : 0) + (right.yearForWeekOfYear != Int(NSDateComponentUndefined) ? right.yearForWeekOfYear : 0)
    return dateComponents
*/
}

/** negates the two sets of date components */
public prefix func - (dateComponents: NSDateComponents) -> NSDateComponents {
    let result = NSDateComponents()
    if(dateComponents.nanosecond != Int(NSDateComponentUndefined)) { result.nanosecond = -dateComponents.nanosecond }
    if(dateComponents.second != Int(NSDateComponentUndefined)) { result.second = -dateComponents.second }
    if(dateComponents.minute != Int(NSDateComponentUndefined)) { result.minute = -dateComponents.minute }
    if(dateComponents.hour != Int(NSDateComponentUndefined)) { result.hour = -dateComponents.hour }
    if(dateComponents.day != Int(NSDateComponentUndefined)) { result.day = -dateComponents.day }
    if(dateComponents.month != Int(NSDateComponentUndefined)) { result.month = -dateComponents.month }
    if(dateComponents.year != Int(NSDateComponentUndefined)) { result.year = -dateComponents.year }
    if(dateComponents.weekOfYear != Int(NSDateComponentUndefined)) { result.weekOfYear = -dateComponents.weekOfYear }
    return result
}

/** functions to convert integers into various time intervals */
public extension Int {
    var nanoseconds: NSDateComponents {
        let dateComponents = NSDateComponents()
        dateComponents.nanosecond = self;
        return dateComponents
    }
    var seconds: NSDateComponents {
        let dateComponents = NSDateComponents()
        dateComponents.second = self;
        return dateComponents
    }

    var minutes: NSDateComponents {
        let dateComponents = NSDateComponents()
        dateComponents.minute = self;
        return dateComponents
    }

    var hours: NSDateComponents {
        let dateComponents = NSDateComponents()
        dateComponents.hour = self;
        return dateComponents
    }

    var days: NSDateComponents {
        let dateComponents = NSDateComponents()
        dateComponents.day = self;
        return dateComponents
    }

    var weeks: NSDateComponents {
        let dateComponents = NSDateComponents()
        dateComponents.weekOfYear = self;
        return dateComponents
    }

    var months: NSDateComponents {
        let dateComponents = NSDateComponents()
        dateComponents.month = self;
        return dateComponents
    }

    var years: NSDateComponents {
        let dateComponents = NSDateComponents()
        dateComponents.year = self;
        return dateComponents
    }
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
        case "nanosecond":
            return NSCalendarUnit.Nanosecond
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
