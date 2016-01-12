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

// Backward compatibility resolves issue https://github.com/malcommac/SwiftDate/issues/121
//
@available(*, renamed="DateRegion")
public typealias Region = DateRegion

/// DateRegion encapsulates all objects you need when representing a date ffrom an absolute time like NSDate.
///
@available(*, introduced=2.1)
public class DateRegion: Equatable {
    
    /// Calendar to interpret date values. You can alter the calendar to adjust the representation of date to your needs.
    ///
    public let calendar: NSCalendar!

    /// Time zone to interpret date values
    /// Because the time zone is part of calendar, this is a shortcut to that variable.
    /// You can alter the time zone to adjust the representation of date to your needs.
    ///
    public let timeZone: NSTimeZone!

    /// Locale to interpret date values
    /// Because the locale is part of calendar, this is a shortcut to that variable.
    /// You can alter the locale to adjust the representation of date to your needs.
    ///
    public let locale: NSLocale!
    
    /// Initialise with a calendar and/or a time zone
    ///
    /// - Parameters:
    ///     - calendarID: the calendar identifier to work with to assign, default = the current calendar
    ///     - timeZoneID: the time zone identifier or -name to work with, default is the default time zone
    ///     - localeID: the locale ID to work with, default is the current locale
    ///     - calendarType: the calendar to work with to assign in `CalendarType` format, default = the current calendar
    ///     - timeZoneRegion: the time zone to work with in `TimeZoneConvertible` format, default is the default time zone
    ///     - calendar: the calendar to work with to assign, default = the current calendar
    ///     - timeZone: the time zone to work with, default is the default time zone
    ///     - locale: the locale to work with, default is the current locale
    ///     - region: a region to copy
    ///
    /// - Note: parameters higher in the list take precedence over parameters lower in the list. E.g.
    ///     `DateRegion(locale: mylocale, localeID: "en_AU", region)` will copy region and set locale to mylocale, not `en_AU`.
    ///
    public init(
        calendarID: String = "",
        timeZoneID: String = "",
        localeID: String = "",
        calType: CalendarType? = nil, // Deprecate in SwiftDate v2.2
        tzName: TimeZoneConvertible? = nil, // Deprecate in SwiftDate v2.2
        calendarType: CalendarType? = nil,
        timeZoneRegion: TimeZoneConvertible? = nil,
        calendar aCalendar: NSCalendar? = nil,
        timeZone aTimeZone: NSTimeZone? = nil,
        locale aLocale: NSLocale? = nil,
        region: DateRegion? = nil) {
            calendar = aCalendar ?? calType?.toCalendar() ?? calendarType?.toCalendar() ?? NSCalendar(calendarIdentifier: calendarID) ?? region?.calendar ?? NSCalendar.currentCalendar()
            timeZone = aTimeZone ?? tzName?.timeZone ?? timeZoneRegion?.timeZone ?? NSTimeZone(abbreviation: timeZoneID) ?? NSTimeZone(name: timeZoneID) ?? region?.timeZone ?? NSTimeZone.defaultTimeZone()
            locale = aLocale ?? (localeID != "" ? NSLocale(localeIdentifier: localeID): nil) ?? region?.locale ?? aCalendar?.locale ?? NSLocale.currentLocale()
            
            // Assign calendar fields
            calendar.timeZone = timeZone
            calendar.locale = locale
    }
    
    /// Initialise with components (calendar, time zone, locale in calendar
    ///
    /// - Parameters:
    ///     - components: the date components that should contain the calendar and time zone, default = the current 
    ///         calendar and default time zone
    ///
    public convenience init(_ components: NSDateComponents) {
        self.init(calendar: components.calendar, timeZone: components.timeZone, locale: components.calendar?.locale)
    }
    
    /// Today's date
    ///
    /// - Returns: the date of today at midnight (00:00) in the current calendar and default time zone.
    ///
    public func today() -> DateInRegion {
        return DateInRegion(region: self).startOf(.Day)
    }

    /// Yesterday's date
    ///
    /// - Returns: the date of yesterday at midnight (00:00)
    ///
    public func yesterday() -> DateInRegion {
        return today() - 1.days
    }

    /// Tomorrow's date
    ///
    /// - Returns: the date of tomorrow at midnight (00:00)
    ///
    public func tomorrow() -> DateInRegion {
        return today() + 1.days
    }

}

public func ==(left: DateRegion, right: DateRegion) -> Bool {
    if left.calendar.calendarIdentifier != right.calendar.calendarIdentifier {
        return false
    }

    if left.timeZone.secondsFromGMT != right.timeZone.secondsFromGMT {
        return false
    }

    if left.locale.localeIdentifier != right.locale.localeIdentifier  {
        return false
    }

    return true
}

extension DateRegion: Hashable {
    public var hashValue: Int {
        return calendar.hashValue ^ timeZone.hashValue ^ locale.hashValue
    }
}

extension DateRegion: CustomStringConvertible {
    public var description: String {
        let timeZoneAbbreviation = timeZone.abbreviation ?? ""
        return "\(calendar.calendarIdentifier); \(timeZone.name):\(timeZoneAbbreviation); \(locale.localeIdentifier)"
    }
}