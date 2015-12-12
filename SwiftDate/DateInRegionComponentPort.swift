//
//  DateInRegionPortFunc.swift
//  Pods
//
//  Created by Jeroen Houtzager on 26/10/15.
//
//

import Foundation


// MARK: - NSCalendar & NSDateComponent ports

public extension DateInRegion {

    /// Returns a NSDateComponents object containing a given date decomposed into components:
    ///     day, month, year, hour, minute, second, nanosecond, timeZone, calendar,
    ///     yearForWeekOfYear, weekOfYear, weekday<s>, quarter</s> and weekOfMonth.
    /// Values returned are in the context of the calendar and time zone properties.
    ///
    /// - Returns: An NSDateComponents object containing date decomposed into the components as specified.
    ///
    public var components: NSDateComponents {
        return calendar.components(DateInRegion.componentFlags, fromDate: self.absoluteTime)
    }

    /// Returns the value for an NSDateComponents object.
    /// Values returned are in the context of the calendar and time zone properties.
    ///
    /// - Parameters:
    ///     - flag: specifies the calendrical unit that should be returned
    ///
    /// - Returns: The value of the NSDateComponents object for the date.
    internal func valueForComponent(flag: NSCalendarUnit) -> Int? {
        let value = calendar.components(flag, fromDate: absoluteTime).valueForComponent(flag)
        return value == NSDateComponentUndefined ? nil: value
    }

    /// The number of era units for the receiver.
    ///
    /// - note: This value is interpreted in the context of the calendar with which it is used
    ///
    public var era: Int? {
        return valueForComponent(.Era)
    }

    /// The number of year units for the receiver.
    ///
    /// - note: This value is interpreted in the context of the calendar with which it is used
    ///
    public var year: Int? {
        return valueForComponent(.Year)
    }

    /// The number of month units for the receiver.
    ///
    /// - note: This value is interpreted in the context of the calendar with which it is used
    ///
    public var month: Int? {
        return valueForComponent(.Month)
    }

    /// The number of day units for the receiver.
    ///
    /// - note: This value is interpreted in the context of the calendar with which it is used
    ///
    public var day: Int? {
        return valueForComponent(.Day)
    }

    /// The number of hour units for the receiver.
    ///
    /// - note: This value is interpreted in the context of the calendar with which it is used
    ///
    public var hour: Int? {
        return valueForComponent(.Hour)
    }

    /// Nearest rounded hour from the date expressed in this region's timezone
    public var nearestHour :Int {
        let date = (self + 30.minutes)!
        return Int(date.hour!);
    }
    
   /// The number of minute units for the receiver.
    ///
    /// - note: This value is interpreted in the context of the calendar with which it is used
    ///
    public var minute: Int? {
        return valueForComponent(.Minute)
    }

    /// The number of second units for the receiver.
    ///
    /// - note: This value is interpreted in the context of the calendar with which it is used
    ///
    public var second: Int? {
        return valueForComponent(.Second)
    }

    /// The number of nanosecond units for the receiver.
    ///
    /// - note: This value is interpreted in the context of the calendar with which it is used
    ///
    public var nanosecond: Int? {
        return valueForComponent(.Nanosecond)
    }

    /// The ISO 8601 week-numbering year of the receiver.
    ///
    /// - note: This value is interpreted in the context of the calendar with which it is used
    ///
    public var yearForWeekOfYear: Int? {
        return valueForComponent(.YearForWeekOfYear)
    }

    /// The ISO 8601 week date of the year for the receiver.
    ///
    /// - note: This value is interpreted in the context of the calendar with which it is used
    ///
    public var weekOfYear: Int? {
        return valueForComponent(.WeekOfYear)
    }

    /// The number of weekday units for the receiver.
    /// Weekday units are the numbers 1 through n, where n is the number of days in the week.
    /// For example, in the Gregorian calendar, n is 7 and Sunday is represented by 1.
    ///
    /// - note: This value is interpreted in the context of the calendar with which it is used
    ///
    public var weekday: Int? {
        return valueForComponent(.Weekday)
    }

    /// The ordinal number of weekday units for the receiver.
    /// Weekday ordinal units represent the position of the weekday within the next larger calendar unit,
    ///     such as the month. For example, 2 is the weekday ordinal unit for the second Friday of the month.
    ///
    /// - note: This value is interpreted in the context of the calendar with which it is used
    ///
    public var weekdayOrdinal: Int? {
        return valueForComponent(.WeekdayOrdinal)
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
    
    /// Nmber of days into current's date month expressed in current region calendar and locale
    public var monthDays :Int? {
        guard let _ = absoluteTime else { return nil }
        return region.calendar.rangeOfUnit(NSCalendarUnit.Day, inUnit: NSCalendarUnit.Month, forDate: absoluteTime).length
    }
    
    /** QUARTER IS NOT INCLUDED DUE TO INCORRECT REPRESENTATION OF QUARTER IN NSCALENDAR
    /// The number of quarter units for the receiver.
    /// Weekday ordinal units represent the position of the weekday within the next larger calendar unit,
    ///     such as the month. For example, 2 is the weekday ordinal unit for the second Friday of the month.
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
    public var weekOfMonth: Int? {
        return valueForComponent(.WeekOfMonth)
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
    

    /// Boolean value that indicates whether the month is a leap month.
    /// ``YES`` if the month is a leap month, ``NO`` otherwise
    ///
    /// - note: This value is interpreted in the context of the calendar with which it is used
    ///
    public var leapMonth: Bool {
        // Library function for leap contains a bug for Gregorian calendars, implemented workaround
        if calendar.calendarIdentifier == NSCalendarIdentifierGregorian && year >= 1582 {
            let range = calendar.rangeOfUnit(NSCalendarUnit.Day, inUnit: NSCalendarUnit.Month, forDate: absoluteTime)
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
            let testDate = DateInRegion(newComponents)!
            return testDate.leapMonth
        }

        // For other calendars:
        return calendar.components([.Day, .Month, .Year], fromDate: absoluteTime).leapMonth
    }

    /// Returns two DateInRegion objects indicating the start and the end of the current weekend .
    ///
    /// - Returns: a tuple of two DateInRegion objects indicating the start and the end of the current weekend.
    ///     If this is nto a weekend, then `nil` is returned.
    ///
    public func thisWeekend() -> (startDate: DateInRegion, endDate: DateInRegion)? {
        guard calendar.isDateInWeekend(self.absoluteTime) else {
            return nil
        }
        let date = (self - 2.days)!
        return date.nextWeekend()
    }

    /// Returns two DateInRegion objects indicating the start and the end of the previous weekend before the date.
    ///
    /// - Returns: a tuple of two DateInRegion objects indicating the start and the end of the next weekend after the date.
    ///
    /// - Note: The weekend returned when the receiver is in a weekend is the previous weekend not the current one.
    ///
    public func previousWeekend() -> (startDate: DateInRegion, endDate: DateInRegion)? {
        let date = (self - 9.days)!
        return date.nextWeekend()
    }

    /// Returns two DateInRegion objects indicating the start and the end of the next weekend after the date.
    ///
    /// - Returns: a tuple of two DateInRegion objects indicating the start and the end of the next weekend after the date.
    ///
    /// - Note: The weekend returned when the receiver is in a weekend is the next weekend not the current one.
    ///
    public func nextWeekend() -> (startDate: DateInRegion, endDate: DateInRegion)? {
        var weekendStart: NSDate?
        var timeInterval: NSTimeInterval = 0
        if !calendar.nextWeekendStartDate(&weekendStart, interval: &timeInterval, options: NSCalendarOptions(rawValue: 0), afterDate: self.absoluteTime) {
            return nil
        }

        // Subtract one thousandth of a second to distinguish from Midnigth on the next Monday for the isEqualDate function of NSDate
        let weekendEnd = weekendStart!.dateByAddingTimeInterval(timeInterval - 0.001)

        let startDate = DateInRegion(absoluteTime: weekendStart!, region: region)
        let endDate = DateInRegion(absoluteTime: weekendEnd, region: region)
        return (startDate, endDate)
    }

}