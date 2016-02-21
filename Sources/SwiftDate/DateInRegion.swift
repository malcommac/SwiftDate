//
//	SwiftDate, an handy tool to manage date and timezones in swift
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

/**
   	`DateInRegion` is essentially a wrapper around `NSDate` which encapsulate
 		additional region informations like the timezone (`NSTimeZone`),
 		calendar (`NSCalendar`) and locale (`NSLocale`) and offer a set of method
 		and properties to access and manage date components.
		You can think `DateInRegion` as representation of an absolute `NSDate` expressed
 		in a particular world location.
		In order to specify region attributes each `DateInRegion` object contains
 		a `Region` object.

   	Using `DateInRegion` you can:
		* Represent an absolute NSDate in a specific timezone/calendar/locale
		* Easy access to all date components (day,month,hour,minute etc.) of the date in specified region
		* Easily create a new date from string, date components or swift operators
		* Compare date using Swift operators like `==, !=, <, >, <=, >=` and several
 			additional methods like `isInWeekend,isYesterday`...
		* Change date by adding or subtracting elements with Swift operators
 			(e.g. `date + 2.days + 15.minutes`)

*/
public struct DateInRegion {

    /// Set to loop throuhg all NSCalendarUnit values
    ///
    internal static let componentFlagSet: [NSCalendarUnit] = [.Nanosecond, .Second, .Minute, .Hour, .Day, .Month, .Year, .YearForWeekOfYear, .WeekOfYear, .Weekday, .Quarter, .WeekdayOrdinal, .WeekOfMonth]
    
    /// NSCalendarUnit values used to obtain data from a date with a calendar and time zone
    ///
    internal static let componentFlags: NSCalendarUnit = [.Day, .Month, .Year, .Hour, .Minute, .Second, .Nanosecond, .TimeZone, .Calendar, .YearForWeekOfYear, .WeekOfYear, .Weekday, .Quarter, .WeekOfMonth]

    // MARK: - Instance variables

    /// NSDate value (i.e. absolute time) around which the DateInRegion evolves.
    ///
    /// - warning: Please note that the date is immutable alike NSDate.
	/// This keeps the main datemvalue of this class thread safe.
    /// If you want to assign a new value then you must assign it to a new instance of DateInRegion.
	///
    public let absoluteTime: NSDate!

    /// The region where the date lives. Use it to represent the date.
    public let region: Region

    /// Calendar to interpret date values. You can alter the calendar to
	/// adjust the representation of date to your needs.
	///
	public var calendar: NSCalendar! { return region.calendar }

    /// Time zone to interpret date values
    /// Because the time zone is part of calendar, this is a shortcut to that variable.
    /// You can alter the time zone to adjust the representation of date to your needs.
	///
	public var timeZone: NSTimeZone! { return region.timeZone }

    /// Locale to interpret date values
    /// Because the locale is part of calendar, this is a shortcut to that variable.
    /// You can alter the locale to adjust the representation of date to your needs.
    ///
	public var locale: NSLocale! { return region.locale }

    // MARK: - Initialisations

	/**
	Initialise with a date, a region and  some properties.
	This initialiser can be used to copy a date while setting certain properties.

	- parameter newDate the date to assign, `default = NSDate()` (that is the current time)
	- parameter newRegion the region to work with to assign, default = the current region

	- returns: a new instance of `DateInRegion`
	*/
    public init(absoluteTime newDate: NSDate? = nil, region newRegion: Region? = nil) {
        absoluteTime = newDate ?? NSDate()
        region = newRegion ?? Region()
    }

	/**
	Initialise a `DateInRegion` object from a set of date components.
	May returns `nil` if the components contain insufficient or contradicting information.

	- Note: This initialiser is for internal use only as we prefer the `components.dateInRegion`
 			use outside the lib.

	- parameter components date components to set

	- returns: a new instance of `DateInRegion`
	*/
    internal init(_ components: NSDateComponents) {
        let region = Region(components)
        let absoluteTime = region.calendar.dateFromComponents(components)
        self.init(absoluteTime: absoluteTime, region: region)
    }

	/**
	Initialise a `DateInRegion` object from a number of date properties.
	Parameters are kind of fuzzy; they can overlap functionality and can contradict eachother.
	In such a case the parameter highest in the parameter list below has priority.
	All parameters but `fromDate` are optional.

	- parameter fromDate reference `DateInRegion`
	- parameter era era to set (optional)
	- parameter year year number  to set (optional)
	- parameter month year number  to set (optional)
	- parameter day day number to set (optional)
	- parameter hour hour number to set (optional)
	- parameter minute minute number to set (optional)
	- parameter second second number to set (optional)
	- parameter nanosecond nanosecond number to set (optional)
	- parameter region region to set (optional)

	- returns: a new `DateInRegion` or nil if init fails
	*/
    public init?(
        fromDate: DateInRegion,
        era: Int? = nil,
        year: Int? = nil,
        month: Int? = nil,
        day: Int? = nil,
        hour: Int? = nil,
        minute: Int? = nil,
        second: Int? = nil,
        nanosecond: Int? = nil,
        region: Region? = nil) {

            let newComponents = NSDateComponents()
            newComponents.era = era ?? fromDate.era ?? 1
            newComponents.year = year ?? fromDate.year ?? 2001
            newComponents.month = month ?? fromDate.month ?? 1
            newComponents.day = day ?? fromDate.day ?? 1
            newComponents.hour = hour ?? fromDate.hour ?? 0
            newComponents.minute = minute ?? fromDate.minute ?? 0
            newComponents.second = second ?? fromDate.second ?? 0
            newComponents.nanosecond = nanosecond ?? fromDate.nanosecond ?? 0
            newComponents.calendar = region?.calendar ?? fromDate.calendar

            self.init(newComponents)
    }

   /**
   Initialise a `DateInRegion` object from a number of date properties.
   Parameters are kind of fuzzy; they can overlap functionality and can contradict eachother.
   In such a case the parameter highest in the parameter list below has priority.
   All parameters but `year`, `month` and `day` are optional.

   - Paramaters:
   - era: era to set (optional)
   - year: year number  to set
   - month: month number to set
   - day: day number to set
   - hour: hour number to set (optional)
   - minute: minute number to set (optional)
   - second: second number to set (optional)
   - nanosecond: nanosecond number to set (optional)
   - region: region to set (optional)

   - returns: a new `DateInRegion` or nil if init fails
   */
    public init?(
        era: Int? = nil,
        year: Int,
        month: Int,
        day: Int,
        hour: Int? = nil,
        minute: Int? = nil,
        second: Int? = nil,
        nanosecond: Int? = nil,
        region: Region? = nil) {

            let newComponents = NSDateComponents()
            newComponents.era = era ?? 1
            newComponents.year = year
            newComponents.month = month
            newComponents.day = day
            newComponents.hour = hour ?? 0
            newComponents.minute = minute ?? 0
            newComponents.second = second ?? 0
            newComponents.nanosecond = nanosecond ?? 0
            newComponents.calendar = region?.calendar
            newComponents.timeZone = region?.timeZone

            self.init(newComponents)
    }


    /**
     Initialise a `DateInRegion` object from a number of date properties.
     Parameters are kind of fuzzy; they can overlap functionality and can contradict eachother.
   	 In such a case the parameter highest in the parameter list below has priority.
     All parameters but `yearForWeekOfYear`, `weekOfYear` and `weekday` are optional.

     Use this initialiser if you have a source date based on week number from
     which to copy the properties.

     - Parameters:
     - era: era to set (optional)
     - yearForWeekOfYear: year number  to set
     - weekOfYear: week number to set
     - weekday: weekday number to set
     - hour: hour number to set (optional)
     - minute: minute number to set (optional)
     - second: second number to set (optional)
     - nanosecond: nanosecond number to set (optional)
     - region: region to set (optional)
     */
    public init?(
        era: Int? = nil,
        yearForWeekOfYear: Int,
        weekOfYear: Int,
        weekday: Int,
        hour: Int? = nil,
        minute: Int? = nil,
        second: Int? = nil,
        nanosecond: Int? = nil,
        region: Region? = nil) {

            let newComponents = NSDateComponents()
            newComponents.era = era ?? 1
            newComponents.yearForWeekOfYear = yearForWeekOfYear
            newComponents.weekOfYear = weekOfYear
            newComponents.weekday = weekday
            newComponents.hour = hour ?? 0
            newComponents.minute = minute ?? 0
            newComponents.second = second ?? 0
            newComponents.nanosecond = nanosecond ?? 0
            newComponents.calendar = region?.calendar
            newComponents.timeZone = region?.timeZone

            self.init(newComponents)
    }


    /**
     Initialize a new DateInRegion string from a specified date string,
		 a given format and a destination region for the date

     - parameter date: date value as string
     - parameter format: format used to parse string
     - parameter region: region of destination (date is parsed with the
   	   format specified by the string value)

     - returns: a new DateInRegion instance
     */
    public init?(
        fromString date: String,
        format: DateFormat,
        region: Region? = nil) {

			let cFormatter = sharedDateFormatter()
			let parsedDate = cFormatter.beginSessionContext { () -> (NSDate?) in
				if let region = region {
					cFormatter.timeZone = region.timeZone
					cFormatter.calendar = region.calendar
					cFormatter.locale = region.locale
				}
				let parsedDate: NSDate?

				switch format {
				case .ISO8601Date:
					cFormatter.dateFormat = "yyyy-MM-dd"
					parsedDate = cFormatter.dateFromString(date)
				case .ISO8601:
					cFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
					cFormatter.dateFormat = (ISO8601Type.Full).rawValue
					parsedDate = cFormatter.dateFromString(date)
				case .ISO8601Format(let type):
					cFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
					cFormatter.dateFormat = type!.rawValue
					parsedDate = cFormatter.dateFromString(date)
				case .AltRSS: // 09 Sep 2011 15:26:08 +0200
					var formattedString: NSString = date
					if formattedString.hasSuffix("Z") {
						formattedString = formattedString.substringToIndex(formattedString.length-1) + "UTC"
					}
					cFormatter.dateFormat = "d MMM yyyy HH:mm:ss ZZZ"
					parsedDate = cFormatter.dateFromString(formattedString as String)
				case .RSS: // Fri, 09 Sep 2011 15:26:08 +0200
					var formattedString: NSString = date
					if formattedString.hasSuffix("Z") {
						formattedString = formattedString.substringToIndex(formattedString.length-1) + "UTC"
					}
					cFormatter.dateFormat = "EEE, d MMM yyyy HH:mm:ss ZZZ"
					parsedDate = cFormatter.dateFromString(formattedString as String)
				case .Extended:
					cFormatter.dateFormat = "eee dd-MMM-yyyy GG HH:mm:ss.SSS zzz"
					parsedDate = cFormatter.dateFromString(date)
				case .Custom(let dateFormat):
					cFormatter.dateFormat = dateFormat
					parsedDate = cFormatter.dateFromString(date)
				}
				return parsedDate
			}

			guard parsedDate != nil else {
				return nil
			}
			self.init(absoluteTime: parsedDate!, region: region)
    }


  /**
   Convert self `DateInRegion`'s date in an another date allowing composition inside the library

   - parameter region new destination region for the date

   - returns: the new `DateInRegion`
   */
    public func inRegion(region: Region) -> DateInRegion {
        return DateInRegion(absoluteTime: self.absoluteTime, region: region)
    }
}

// MARK: - CustomStringConvertable delegate

extension DateInRegion: CustomDebugStringConvertible {

	/// Returns a full description of the class
	public var description: String {
		let formatter = NSDateFormatter()
		formatter.dateStyle = .MediumStyle
		formatter.timeStyle = .LongStyle
		formatter.locale = self.locale
		formatter.calendar = self.calendar
		formatter.timeZone = self.timeZone
		return formatter.stringFromDate(self.absoluteTime)
	}

	/// Returns a full debug description of the class
	public var debugDescription: String {
		var descriptor: [String] = []

		let formatter = NSDateFormatter()
		formatter.dateStyle = .LongStyle
		formatter.timeStyle = .LongStyle
		formatter.locale = self.locale
		formatter.calendar = self.calendar
		formatter.timeZone = self.timeZone
		descriptor.append(formatter.stringFromDate(self.absoluteTime))

		//formatter.timeZone = NSTimeZone(abbreviation: "UTC")
		//descriptor.append("UTC\t\(formatter.stringFromDate(self.absoluteTime))")

		descriptor.append("Calendar: \(calendar.calendarIdentifier)")
		descriptor.append("Time zone: \(timeZone.name)")
		descriptor.append("Locale: \(locale.localeIdentifier)")

		return descriptor.joinWithSeparator("\n")
	}
}

//MARK: - DateInRegion Hashable -

extension DateInRegion: Hashable {
  
	/// Allows to generate an unique hash vaalue for an instance of `DateInRegion`
	public var hashValue: Int {
		return absoluteTime.hashValue ^ region.hashValue
	}
}
