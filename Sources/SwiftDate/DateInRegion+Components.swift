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


// MARK: - NSCalendar & NSDateComponent ports

public extension DateInRegion {

    /// Returns a NSDateComponents object containing a given date decomposed into components:
    ///     day, month, year, hour, minute, second, nanosecond, timeZone, calendar,
    ///     yearForWeekOfYear, weekOfYear, weekday<s>, quarter</s> and weekOfMonth.
    /// Values returned are in the context of the calendar and time zone properties.
    ///
    /// - Returns: An NSDateComponents object containing date decomposed
	///   into the components as specified.
    ///
    public var components: NSDateComponents {
        return calendar.components(DateInRegion.componentFlags, fromDate: self.absoluteTime)
    }

    /// Returns the value for an NSDateComponents object.
    /// Values returned are in the context of the calendar and time zone properties.
    ///
    /// - Parameters:
    ///     - flag: specifies the calendrical unit that should be returned
    /// - Returns: The value of the NSDateComponents object for the date.
    /// - remark: asserts that no calendar or time zone flags are specified.
    ///   If one of these is present, an assertion fails and execution will halt.
    ///
    internal func valueForComponent(flag: NSCalendarUnit) -> Int {
        assert(!flag.contains(.Calendar))
        assert(!flag.contains(.TimeZone))

        let components = calendar.components(flag, fromDate: absoluteTime)
        let value = components.valueForComponent(flag)
        return value
    }

    /// The number of era units for the receiver.
    ///
    /// - note: This value is interpreted in the context of the calendar with which it is used
    ///
    public var era: Int {
        return valueForComponent(.Era)
    }

    /// The number of year units for the receiver.
    ///
    /// - note: This value is interpreted in the context of the calendar with which it is used
    ///
    public var year: Int {
        return valueForComponent(.Year)
    }

    /// The number of month units for the receiver.
    ///
    /// - note: This value is interpreted in the context of the calendar with which it is used
    ///
    public var month: Int {
        return valueForComponent(.Month)
    }

    /// The number of day units for the receiver.
    ///
    /// - note: This value is interpreted in the context of the calendar with which it is used
    ///
    public var day: Int {
        return valueForComponent(.Day)
    }

    /// The number of hour units for the receiver.
    ///
    /// - note: This value is interpreted in the context of the calendar with which it is used
    ///
    public var hour: Int {
        return valueForComponent(.Hour)
    }

    /// Nearest rounded hour from the date expressed in this region's timezone
    public var nearestHour: Int {
        let date = self + 30.minutes
        return Int(date.hour)
    }

    /// The number of minute units for the receiver.
    ///
    /// - note: This value is interpreted in the context of the calendar with which it is used
    ///
    public var minute: Int {
        return valueForComponent(.Minute)
    }

    /// The number of second units for the receiver.
    ///
    /// - note: This value is interpreted in the context of the calendar with which it is used
    ///
    public var second: Int {
        return valueForComponent(.Second)
    }

    /// The number of nanosecond units for the receiver.
    ///
    /// - note: This value is interpreted in the context of the calendar with which it is used
    ///
    public var nanosecond: Int {
        return valueForComponent(.Nanosecond)
    }

    /// The week-numbering year of the receiver.
    ///
    /// - note: This value is interpreted in the context of the calendar with which it is used
    ///
    public var yearForWeekOfYear: Int {
        return valueForComponent(.YearForWeekOfYear)
    }

    /// The week date of the year for the receiver.
    ///
    /// - note: This value is interpreted in the context of the calendar with which it is used
    ///
    public var weekOfYear: Int {
        return valueForComponent(.WeekOfYear)
    }

    /// The number of weekday units for the receiver.
    /// Weekday units are the numbers 1 through n, where n is the number of days in the week.
    /// For example, in the Gregorian calendar, n is 7 and Sunday is represented by 1.
    ///
    /// - note: This value is interpreted in the context of the calendar with which it is used
    ///
    public var weekday: Int {
        return valueForComponent(.Weekday)
    }

    /// The ordinal number of weekday units for the receiver.
    /// Weekday ordinal units represent the position of the weekday within
 	/// the next larger calendar unit, such as the month.
	/// For example, 2 is the weekday ordinal unit for the second Friday of the month.
    ///
    /// - note: This value is interpreted in the context of the calendar with which it is used
    ///
    public var weekdayOrdinal: Int {
        return valueForComponent(.WeekdayOrdinal)
    }

    /// Week day name of the date expressed in this region's locale
    public var weekdayName: String {

        let cachedFormatter = sharedDateFormatter()
		return cachedFormatter.beginSessionContext { () -> (String) in
			cachedFormatter.dateFormat = "EEEE"
			cachedFormatter.locale = self.region.locale
			let value = cachedFormatter.stringFromDate(self.absoluteTime)
			return value
		}!
    }

    /// Nmber of days into current's date month expressed in current region calendar and locale
    public var monthDays: Int {
        return region.calendar.rangeOfUnit(.Day, inUnit: .Month, forDate: absoluteTime).length
    }

    /** QUARTER IS NOT INCLUDED DUE TO INCORRECT REPRESENTATION OF QUARTER IN NSCALENDAR
    /// The number of quarter units for the receiver.
    /// Weekday ordinal units represent the position of the weekday within the next larger
	/// calendar unit, such as the month. For example, 2 is the weekday
	/// ordinal unit for the second Friday of the month.
    ///
    /// - note: This value is interpreted in the context of the calendar with which it is used
    ///
    public var quarter: Int? {
        return valueForComponent(.Quarter)
    }
    **/

    /// The week number in the month for the receiver.
    ///
    /// - note: This value is interpreted in the context of the calendar with which it is used
    ///
    public var weekOfMonth: Int {
        return valueForComponent(.WeekOfMonth)
    }

    /// Month name of the date expressed in this region's timezone using region's locale
    public var monthName: String {
		let cachedFormatter = sharedDateFormatter()
		return cachedFormatter.beginSessionContext { () -> (String) in
			cachedFormatter.locale = self.region.locale
			let value = cachedFormatter.monthSymbols[self.month - 1] as String
			return value
		}!
    }


    /// Boolean value that indicates whether the month is a leap month.
    /// ``YES`` if the month is a leap month, ``NO`` otherwise
    ///
    /// - note: This value is interpreted in the context of the calendar with which it is used
    ///
    public var leapMonth: Bool {
        // Library function for leap contains a bug for Gregorian calendars, implemented workaround
        if calendar.calendarIdentifier == NSCalendarIdentifierGregorian && year >= 1582 {
            let range = calendar.rangeOfUnit(.Day, inUnit: .Month, forDate: absoluteTime)
            return range.length == 29
        }

        // For other calendars:
        return calendar.components([.Day, .Month, .Year], fromDate: absoluteTime).leapMonth
    }

    /// Boolean value that indicates whether the year is a leap year.
    /// ``YES`` if the year is a leap year, ``NO`` otherwise
    ///
    /// - note: This value is interpreted in the context of the calendar with which it is used
    ///
    public var leapYear: Bool {
        // Library function for leap contains a bug for Gregorian calendars, implemented workaround
        if calendar.calendarIdentifier == NSCalendarIdentifierGregorian {
            let newComponents = components
            newComponents.month = 2
            newComponents.day = 10
            let testDate = newComponents.dateInRegion!
            return testDate.leapMonth
        }

        // For other calendars:
        return calendar.components([.Day, .Month, .Year], fromDate: absoluteTime).leapMonth
    }
    
    /// The julian day corresponding to the current civil date. Note that it is often called Julian Date.
    /// But we prefer Jean Meeus reference textboox where he explains the julian day isn't a Date, but rather a Day.
    /// The formula can be found in http://scienceworld.wolfram.com/astronomy/JulianDate.html 
    /// It is valid between 1901 and 2099.
    ///
    /// - Returns the Julian Day of the date.
    ///
    public func julianDay() -> Double {
        let utc = self.inRegion(DateRegion(calendarName: .Gregorian, timeZoneName: .Gmt, localeName: .English))
        
        let year = Double(utc.year)
        let month = Double(utc.month)
        let day = Double(utc.day)
        let hour = Double(utc.hour) + Double(utc.minute)/60.0 + (Double(utc.second)+Double(utc.nanosecond)/1e9)/3600.0
        
        var jd = 367.0*year - floor( 7.0*( year+floor((month+9.0)/12.0))/4.0 )
        jd -= floor( 3.0*(floor( (year+(month-9.0)/7.0)/100.0 ) + 1.0)/4.0 )
        jd += floor(275.0*month/9.0) + day + 1721028.5 + hour/24.0
        
        return jd
    }
    
    /// Most popular variant of JD.
    ///
    /// - Returns the Modified Julain Day of the date.
    ///
    public func modifiedJulianDay() -> Double {
        return self.julianDay() - 2400000.5
    }

    /// Returns two DateInRegion objects indicating the start and the end of the current weekend .
    ///
    /// - Returns: a tuple of two DateInRegion objects indicating the start and the end of
	///   the current weekend. If this is unto a weekend, then `nil` is returned.
    ///
    public func thisWeekend() -> (startDate: DateInRegion, endDate: DateInRegion)? {
        guard calendar.isDateInWeekend(self.absoluteTime) else {
            return nil
        }
        let date = self - 2.days
        return date.nextWeekend()
    }

    /// Returns two DateInRegion objects indicating the start and the end of
	/// the previous weekend before the date.
    ///
    /// - Returns: a tuple of two DateInRegion objects indicating the start
	///   and the end of the next weekend after the date.
    ///
    /// - Note: The weekend returned when the receiver is in a weekend is
	///   the previous weekend not the current one.
    ///
    public func previousWeekend() -> (startDate: DateInRegion, endDate: DateInRegion)? {
        let date = self - 9.days
        return date.nextWeekend()
    }

    /// Returns two DateInRegion objects indicating the start and the end
	/// of the next weekend after the date.
    ///
    /// - Returns: a tuple of two DateInRegion objects indicating the
	///   start and the end of the next weekend after the date.
    ///
    /// - Note: The weekend returned when the receiver is in a weekend
	///   is the next weekend not the current one.
    ///
    public func nextWeekend() -> (startDate: DateInRegion, endDate: DateInRegion)? {
        var wkStart: NSDate?
        var tInt: NSTimeInterval = 0
		let opt = NSCalendarOptions(rawValue: 0)
		let d = self.absoluteTime
        if !calendar.nextWeekendStartDate(&wkStart, interval: &tInt, options: opt, afterDate: d) {
            return nil
        }

        // Subtract one thousandth of a second to distinguish from Midnigth
		// on the next Monday for the isEqualDate function of NSDate
        let wkEnd = wkStart!.dateByAddingTimeInterval(tInt - 0.001)

        let startDate = DateInRegion(absoluteTime: wkStart!, region: region)
        let endDate = DateInRegion(absoluteTime: wkEnd, region: region)
        return (startDate, endDate)
    }

}
