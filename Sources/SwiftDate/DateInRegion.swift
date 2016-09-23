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

    /// Set to loop throuhg all `Calendar.Component` values
    ///
    internal static let componentFlagSet: Set<Calendar.Component> = [.nanosecond, .second, .minute, .hour,
        .day, .month, .year, .yearForWeekOfYear, .weekOfYear, .weekday, .quarter, .weekdayOrdinal,
        .weekOfMonth]

    /// `Calendar.Component` values used to obtain data from a date with a calendar and time zone
    ///
    internal static let componentFlags: Set<Calendar.Component> = [.day, .month, .year, .hour, .minute,
        .second, .nanosecond, .timeZone, .calendar, .yearForWeekOfYear, .weekOfYear, .weekday,
        .quarter, .weekOfMonth]

    // MARK: - Instance variables

    /// NSDate value (i.e. absolute time) around which the DateInRegion evolves.
    ///
    /// - warning: Please note that the date is immutable alike NSDate.
	/// This keeps the main datemvalue of this class thread safe.
    /// If you want to assign a new value then you must assign it to a new instance of DateInRegion.
	///
    public let absoluteTime: Date

	/// This method return an NSDate object which contains the absolute representation of datetime
	/// in region specified timezone.
	public var localAbsoluteDate: Date {
		let seconds = self.timeZone.secondsFromGMT(for: self.absoluteTime)
		return Date(timeInterval: TimeInterval(seconds), since: self.absoluteTime)
	}

    /// The region where the date lives. Use it to represent the date.
    public let region: Region

    /// Calendar to interpret date values. You can alter the calendar to
	/// adjust the representation of date to your needs.
	///
	public var calendar: Calendar { return region.calendar }

    /// Time zone to interpret date values
    /// Because the time zone is part of calendar, this is a shortcut to that variable.
    /// You can alter the time zone to adjust the representation of date to your needs.
	///
	public var timeZone: TimeZone { return region.timeZone }

    /// Locale to interpret date values
    /// Because the locale is part of calendar, this is a shortcut to that variable.
    /// You can alter the locale to adjust the representation of date to your needs.
    ///
	public var locale: Locale { return region.locale }

    // MARK: - Initialisations


	/// Initialise with a date, a region and  some properties.
	/// This initialiser can be used to copy a date while setting certain properties.
    ///
    ///	- parameters:
    ///     - absoluteTime: the date to assign, `default = NSDate()` (that is the current
    ///     time)
    ///     - region: the region to work with to assign, default = the current region
    ///
    public init(absoluteTime newDate: Date? = nil, region newRegion: Region? = nil) {
        absoluteTime = newDate ?? Date()
        region = newRegion ?? Region.defaultRegion
    }

    /// Initialise a `DateInRegion` object from a set of date components. Default values will be
    /// used if the components are insufficient to create a date.
    ///
    /// - parameters:
    ///     - components: date components to generate the date from
    ///
    internal init(_ components: DateComponents) {
        let region = Region(components)
        let absoluteTime = region.calendar.date(from: components)
        self.init(absoluteTime: absoluteTime, region: region)
    }


    /// Initialise a `DateInRegion` object from a source date and a number of optional date
    /// properties.
    ///
    /// Please note that if a new region is specified, parameters are evaluated against that region.
    /// I.e. you might have a different absolute time generated. To use time zone conversion you
    /// should use `date.inRegion()`.
    ///
    /// - parameters:
    ///     - fromDate: reference `DateInRegion`
    ///     - era: era to set (optional)
    ///     - year: year number  to set (optional)
    ///     - month: year number  to set (optional)
    ///     - day: day number to set (optional)
    ///     - hour: hour number to set (optional)
    ///     - minute: minute number to set (optional)
    ///     - second: second number to set (optional)
    ///     - nanosecond: nanosecond number to set (optional)
    ///     - region: region to set (optional)
    ///
    public init(
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

        let newComponents = DateComponents(
            calendar: region?.calendar ?? fromDate.calendar,
            era: era ?? fromDate.era,
            year: year ?? fromDate.year,
            month: month ?? fromDate.month,
            day: day ?? fromDate.day,
            hour: hour ?? fromDate.hour,
            minute: minute ?? fromDate.minute,
            second: second ?? fromDate.second,
            nanosecond: nanosecond ?? fromDate.nanosecond)

        self.init(newComponents)
    }


    ///  Initialise a `DateInRegion` object from a number of date properties.
    ///  Parameters are kind of fuzzy; they can overlap functionality and can contradict eachother.
    ///  In such a case the parameter highest in the parameter list below has priority.
    ///  All parameters but `year`, `month` and `day` are optional.
    ///
    ///  - Parameters:
    ///   - era: era to set (optional)
    ///   - year: year number  to set
    ///   - month: month number to set
    ///   - day: day number to set
    ///   - hour: hour number to set (optional)
    ///   - minute: minute number to set (optional)
    ///   - second: second number to set (optional)
    ///   - nanosecond: nanosecond number to set (optional)
    ///   - region: region to set (optional)
    ///
    public init(
        era: Int? = nil,
        year: Int,
        month: Int,
        day: Int,
        hour: Int? = nil,
        minute: Int? = nil,
        second: Int? = nil,
        nanosecond: Int? = nil,
        region: Region? = nil) {

        let newComponents = DateComponents(
            calendar: region?.calendar,
            timeZone: region?.timeZone,
            era: era ?? 1,
            year: year,
            month: month,
            day: day,
            hour: hour ?? 0,
            minute: minute ?? 0,
            second: second ?? 0,
            nanosecond: nanosecond ?? 0)

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
    public init(
        era: Int? = nil,
        yearForWeekOfYear: Int,
        weekOfYear: Int,
        weekday: Int,
        hour: Int? = nil,
        minute: Int? = nil,
        second: Int? = nil,
        nanosecond: Int? = nil,
        region: Region? = nil) {

        let newComponents = DateComponents(
            calendar: region?.calendar,
            timeZone: region?.timeZone,
            era: era ?? 1,
            hour: hour ?? 0,
            minute: minute ?? 0,
            second: second ?? 0,
            nanosecond: nanosecond ?? 0,
            weekday: weekday,
            weekOfYear: weekOfYear,
            yearForWeekOfYear: yearForWeekOfYear)

        self.init(newComponents)
    }

    /**
     Initialise a `DateInRegion` object from a julian day.

     - Parameters:
     - fromJulianDay: the julian day from which to get the date
     - region: region to set (optional)
     */
    public init(
        fromJulianDay: Double,
        region: Region? = nil) {

        let refDate = Date(timeIntervalSinceReferenceDate: 0)
        let timeInterval = (fromJulianDay - refDate.julianDay()) * 86400.0

        self.init(absoluteTime: Date(timeIntervalSinceReferenceDate: timeInterval), region: region)
    }

    /**
     Initialise a `DateInRegion` object from a modified julian day.
     - Parameters:
     - fromModifiedJulianDay: the modified julian day from which to get the date
     - region: region to set (optional)
     */
    public init(
        fromModifiedJulianDay: Double,
        region: Region? = nil) {

        let refDate = Date(timeIntervalSinceReferenceDate: 0)
        let timeInterval = (fromModifiedJulianDay - refDate.modifiedJulianDay()) * 86400.0

        self.init(absoluteTime: Date(timeIntervalSinceReferenceDate: timeInterval), region: region)
    }


    /// Initialize a new DateInRegion string from a specified date string, a given format and a
    /// destination region for the date
    ///
    ///     - parameter fromString: date value as string
    ///     - parameter format: format used to parse string
    ///     - parameter region: region of destination (date is parsed with the
    ///   	   format specified by the string value)
    ///
    public init?(fromString dateString: String, format: DateFormat,
        region nilRegion: Region? = nil) {

            let region = nilRegion ?? Region.defaultRegion

			let cFormatter = sharedDateFormatter()
			let parsedDate = cFormatter.beginSessionContext { () -> (Date?) in
                cFormatter.timeZone = region.timeZone
                cFormatter.calendar = region.calendar
                cFormatter.locale = region.locale

                let parsedDate: Date?

				var stringWithTimeZone = dateString
				if dateString.hasSuffix("Z") == true && dateString.contains(".") == false && dateString.contains("+") == false {
                    stringWithTimeZone = dateString.substring(to: dateString.index(dateString.endIndex, offsetBy: -1)) + "+0000"
				}

				switch format {
				case .iso8601Date:
					cFormatter.dateFormat = "yyyy-MM-dd"
					parsedDate = cFormatter.date(from: stringWithTimeZone)
				case .iso8601:
					cFormatter.locale = Locale(identifier: "en_US_POSIX")
					cFormatter.dateFormat = (ISO8601Type.full).rawValue
					parsedDate = cFormatter.date(from: stringWithTimeZone)
				case .iso8601Format(let type):
					cFormatter.locale = Locale(identifier: "en_US_POSIX")
					cFormatter.dateFormat = type!.rawValue
					parsedDate = cFormatter.date(from: stringWithTimeZone)
				case .altRSS: // 09 Sep 2011 15:26:08 +0200
					cFormatter.dateFormat = "d MMM yyyy HH:mm:ss ZZZ"
					parsedDate = cFormatter.date(from: stringWithTimeZone)
				case .rss: // Fri, 09 Sep 2011 15:26:08 +0200
					cFormatter.dateFormat = "EEE, d MMM yyyy HH:mm:ss ZZZ"
					parsedDate = cFormatter.date(from: stringWithTimeZone)
				case .extended:
					cFormatter.dateFormat = "eee dd-MMM-yyyy GG HH:mm:ss.SSS zzz"
					parsedDate = cFormatter.date(from: stringWithTimeZone)
				case .custom(let dateFormat):
					cFormatter.dateFormat = dateFormat
					parsedDate = cFormatter.date(from: stringWithTimeZone)
				case .dotNET:
					guard let secondsInString = dateString.dotNet_secondsFromString() else { return nil }

					parsedDate = Date(timeIntervalSince1970: secondsInString)
				}
				return parsedDate
			}

			guard parsedDate != nil else {
				return nil
			}
			self.init(absoluteTime: parsedDate!, region: region)
    }



    /// Convert receiver to another region with the same absolute time.
    /// Typically used for regional conversions (time zone, calendar, locale)
    ///
    /// - parameters:
    ///     - region: new destination region for the date
    ///
    /// - returns: the new `DateInRegion` object with the new region
    ///
    public func inRegion(region: Region) -> DateInRegion {
        return DateInRegion(absoluteTime: self.absoluteTime, region: region)
    }
}

// MARK: - CustomStringConvertable delegate

extension DateInRegion: CustomDebugStringConvertible {

	/// Returns a full description of the class
	public var description: String {
		let formatter = FoundationDateFormatter()
		formatter.dateStyle = .medium
		formatter.timeStyle = .long
		formatter.locale = self.locale
		formatter.calendar = self.calendar
		formatter.timeZone = self.timeZone
		return formatter.string(from: self.absoluteTime)
	}

	/// Returns a full debug description of the class
	public var debugDescription: String {
		var descriptor: [String] = []

		let formatter = FoundationDateFormatter()
		formatter.dateStyle = .long
		formatter.timeStyle = .long
		formatter.locale = self.locale
		formatter.calendar = self.calendar
		formatter.timeZone = self.timeZone
		descriptor.append(formatter.string(from: self.absoluteTime))

		descriptor.append("Calendar: \(calendar.identifier)")
		descriptor.append("Time zone: \(timeZone.identifier)")
		descriptor.append("Locale: \(locale.identifier)")

		return descriptor.joined(separator: "\n")
	}
}

//MARK: - DateInRegion Hashable -

extension DateInRegion: Hashable {

	/// Allows to generate an unique hash vaalue for an instance of `DateInRegion`
	public var hashValue: Int {
		return absoluteTime.hashValue ^ region.hashValue
	}
}
