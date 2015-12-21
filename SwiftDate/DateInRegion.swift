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

/// DateInRegion is a wrapper around NSDate that exposes the properties of NSDateComponents. Thus offering date functions with a flexibility that I was looking for:
///    - Use the object as an NSDate. I.e. as an absolute time.
///    - Contains a date (NSDate), a calendar (NSCalendar) and a timeZone (NSTimeZone) property
///    - Offers all NSDate & NSDateComponent vars & methods
///    - Initialise a date with any combination of components
///    - Use default values for initialisation if desired
///    - Calendar & time zone can be changed, properties change along
///    - Default date is `NSDate()`
///    - Default calendar is `NSCalendar.currentCalendar()`
///    - Default time zone is `NSTimeZone.localTimeZone()`
///    - Implements the Comparable protocol betwen dates with operators. E.g. `==, !=, <, >, <=, >=`
///    - implements date addition and subtraction operators with date components. E.g. `date + 2.days`

import Foundation

// MARK: - Initialisations

public class DateInRegion {
    
    /// Set to loop throuhg all NSCalendarUnit values
    ///
    internal static let componentFlagSet: [NSCalendarUnit] = [.Day, .Month, .Year, .Hour, .Minute, .Second, .Nanosecond, .YearForWeekOfYear, .WeekOfYear, .Weekday, .Quarter, .WeekdayOrdinal, .WeekOfMonth]
    
    /// NSCalendarUnit values used to obtain data from a date with a calendar and time zone
    ///
    internal static let componentFlags: NSCalendarUnit = [.Day, .Month, .Year, .Hour, .Minute, .Second, .Nanosecond, .TimeZone, .Calendar, .YearForWeekOfYear, .WeekOfYear, .Weekday, .Quarter, .WeekOfMonth]
    
    
    /// NSDate value (i.e. absolute time) around which the DateInRegion evolves.
    ///
    /// - warning: Please note that the date is immutable alike NSDate. This keeps the main datemvalue of this class thread safe.
    ///     If you want to assign a new value then you must assign it to a new instance of DateInRegion.
    ///
    public let absoluteTime: NSDate!
    
    /// The date region where the date lives. Use it to represent the date.
    public let region: DateRegion
    
    /// Calendar to interpret date values. You can alter the calendar to adjust the representation of date to your needs.
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
    
    /// Initialise with a date, a region and  some properties.
    /// This initialiser can be used to copy a date while
    /// setting certain properties.
    ///
    /// - Parameters:
    ///     - dateInRegion: the date to assign, default = NSDate() (that is the current time)
    ///     - region: the date region to work with to assign, default = the current date region
    ///
    /// Date and time property parameters can be used to alter the reference date properies in the context
    /// of the date region
    ///
    public init(absoluteTime newDate: NSDate = NSDate(), region newRegion: DateRegion = DateRegion()) {
        absoluteTime = newDate
        region = newRegion
    }
    
    public convenience init(
        fromDate: DateInRegion,
        region newRegion: DateRegion? = nil) {
            self.init(absoluteTime: fromDate.absoluteTime, region: newRegion ?? fromDate.region)
    }
    
    public convenience init?(_ newComponents: NSDateComponents) {
        let newRegion = DateRegion(calendar: newComponents.calendar, timeZone: newComponents.timeZone, locale: newComponents.calendar?.locale)
        if let newDate = newRegion.calendar.dateFromComponents(newComponents) {
            self.init(absoluteTime: newDate, region: newRegion)
        } else {
            return nil
        }
    }
    
    public convenience init?(
        fromDate: DateInRegion? = nil,
        era: Int? = nil,
        year: Int,
        month: Int,
        day: Int,
        hour: Int? = nil,
        minute: Int? = nil,
        second: Int? = nil,
        nanosecond: Int? = nil,
        calendarID: String = "",
        timeZoneID: String = "",
        localeID: String = "",
        calendarType: CalendarType? = nil,
        timeZoneRegion: TimeZoneConvertible? = nil,
        calendar aCalendar: NSCalendar? = nil,
        timeZone aTimeZone: NSTimeZone? = nil,
        locale aLocale: NSLocale? = nil,
        region aRegion: DateRegion? = nil) {
            
            let newRegion = DateRegion(calendarID: calendarID, timeZoneID: timeZoneID, localeID: localeID, calendarType: calendarType, timeZoneRegion: timeZoneRegion, calendar: aCalendar, timeZone: aTimeZone, locale: aLocale, region: aRegion ?? fromDate?.region)
            
            let newComponents = NSDateComponents()
            newComponents.era = era ?? fromDate?.era ?? 1
            newComponents.year = year
            newComponents.month = month
            newComponents.day = day
            newComponents.hour = hour ?? fromDate?.hour ?? 0
            newComponents.minute = minute ?? fromDate?.minute ?? 0
            newComponents.second = second ?? fromDate?.second ?? 0
            newComponents.nanosecond = nanosecond ?? fromDate?.nanosecond ?? 0
            newComponents.calendar = newRegion.calendar
            newComponents.timeZone = newRegion.timeZone
            
            self.init(newComponents)
    }
    
    
    public convenience init?(
        fromDate: DateInRegion? = nil,
        era: Int? = nil,
        yearForWeekOfYear: Int,
        weekOfYear: Int,
        weekday: Int,
        hour: Int? = nil,
        minute: Int? = nil,
        second: Int? = nil,
        nanosecond: Int? = nil,
        calendarID: String = "",
        timeZoneID: String = "",
        localeID: String = "",
        calendarType: CalendarType? = nil,
        timeZoneRegion: TimeZoneConvertible? = nil,
        calendar aCalendar: NSCalendar? = nil,
        timeZone aTimeZone: NSTimeZone? = nil,
        locale aLocale: NSLocale? = nil,
        region aRegion: DateRegion? = nil) {
            
            let newRegion = DateRegion(calendarID: calendarID, timeZoneID: timeZoneID, localeID: localeID, calendarType: calendarType, timeZoneRegion: timeZoneRegion, calendar: aCalendar, timeZone: aTimeZone, locale: aLocale, region: aRegion ?? fromDate?.region)
            
            let newComponents = NSDateComponents()
            newComponents.era = era ?? fromDate?.era ?? 1
            newComponents.yearForWeekOfYear = yearForWeekOfYear
            newComponents.weekOfYear = weekOfYear
            newComponents.weekday = weekday
            newComponents.hour = hour ?? fromDate?.hour ?? 0
            newComponents.minute = minute ?? fromDate?.minute ?? 0
            newComponents.second = second ?? fromDate?.second ?? 0
            newComponents.nanosecond = nanosecond ?? fromDate?.nanosecond ?? 0
            newComponents.calendar = newRegion.calendar
            newComponents.timeZone = newRegion.timeZone
            
            self.init(newComponents)
    }
    
    
    public convenience init?(
        fromDate: DateInRegion? = nil,
        hour: Int,
        minute: Int = 0,
        second: Int = 0,
        nanosecond: Int = 0,
        calendarID: String = "",
        timeZoneID: String = "",
        localeID: String = "",
        calendarType: CalendarType? = nil,
        timeZoneRegion: TimeZoneConvertible? = nil,
        calendar aCalendar: NSCalendar? = nil,
        timeZone aTimeZone: NSTimeZone? = nil,
        locale aLocale: NSLocale? = nil,
        region aRegion: DateRegion? = nil) {
            
            let newRegion = DateRegion(calendarID: calendarID, timeZoneID: timeZoneID, localeID: localeID, calendarType: calendarType, timeZoneRegion: timeZoneRegion, calendar: aCalendar, timeZone: aTimeZone, locale: aLocale, region: aRegion ?? fromDate?.region)
            
            let newComponents = fromDate?.components ?? NSDateComponents()
            newComponents.hour = hour
            newComponents.minute = minute
            newComponents.second = second
            newComponents.nanosecond = nanosecond
            newComponents.calendar = newRegion.calendar
            newComponents.timeZone = newRegion.timeZone
            
            self.init(newComponents)
    }
    
    /**
     Initialize a new DateInRegion string from a specified date string, a given format and a destination region for the date
     
     - parameter date: date value as string
     - parameter format: format used to parse string
     - parameter region: region of destination (date is parsed with the format specified by the string value)
     
     - returns: a new DateInRegion instance
     */
    public convenience init?(
        fromString date: String,
        format: DateFormat,
        calendarID: String = "",
        timeZoneID: String = "",
        localeID: String = "",
        calendarType: CalendarType? = nil,
        timeZoneRegion: TimeZoneConvertible? = nil,
        calendar aCalendar: NSCalendar? = nil,
        timeZone aTimeZone: NSTimeZone? = nil,
        locale aLocale: NSLocale? = nil,
        region aRegion: DateRegion? = nil) {
            
            let newRegion = DateRegion(calendarID: calendarID, timeZoneID: timeZoneID, localeID: localeID, calendarType: calendarType, timeZoneRegion: timeZoneRegion, calendar: aCalendar, timeZone: aTimeZone, locale: aLocale, region: aRegion)
            
            let cachedFormatter = NSDateFormatter.cachedFormatter().saveState()
            cachedFormatter.formatter.timeZone = newRegion.timeZone
            cachedFormatter.formatter.calendar = newRegion.calendar
            cachedFormatter.formatter.locale = newRegion.locale
            let parsedDate: NSDate?
            
            switch format {
            case .ISO8601: // 1972-07-16T08:15:30-05:00
                cachedFormatter.formatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
                cachedFormatter.formatter.dateFormat = String.ISO8601Formatter(fromString: date)
                parsedDate = cachedFormatter.formatter.dateFromString(date)
            case .ISO8601Date:
                cachedFormatter.formatter.dateFormat = "yyyy-MM-dd"
                parsedDate = cachedFormatter.formatter.dateFromString(date)
            case .AltRSS: // 09 Sep 2011 15:26:08 +0200
                var formattedString: NSString = date
                if formattedString.hasSuffix("Z") {
                    formattedString = formattedString.substringToIndex(formattedString.length-1) + "UTC"
                }
                cachedFormatter.formatter.dateFormat = "d MMM yyyy HH:mm:ss ZZZ"
                parsedDate = cachedFormatter.formatter.dateFromString(formattedString as String)
            case .RSS: // Fri, 09 Sep 2011 15:26:08 +0200
                var formattedString: NSString = date
                if formattedString.hasSuffix("Z") {
                    formattedString = formattedString.substringToIndex(formattedString.length-1) + "UTC"
                }
                cachedFormatter.formatter.dateFormat = "EEE, d MMM yyyy HH:mm:ss ZZZ"
                parsedDate = cachedFormatter.formatter.dateFromString(formattedString as String)
            case .Extended:
                cachedFormatter.formatter.dateFormat = "eee dd-MMM-yyyy GG HH:mm:ss.SSS zzz"
                parsedDate = cachedFormatter.formatter.dateFromString(date)
            case .Custom(let dateFormat):
                cachedFormatter.formatter.dateFormat = dateFormat
                parsedDate = cachedFormatter.formatter.dateFromString(date)
            }
            guard let _ = parsedDate else {
                return nil
            }
            self.init(absoluteTime: parsedDate!, region: newRegion)
            cachedFormatter.restoreState()
    }
    
    func inRegion(region: DateRegion) -> DateInRegion {
        return DateInRegion(absoluteTime: self.absoluteTime, region: region)
    }
    
}


