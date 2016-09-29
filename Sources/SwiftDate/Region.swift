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
public typealias DateRegion = Region

/// Region encapsulates all objects you need when representing a date from an absolute time like
/// NSDate.
///
@available(*, introduced=2.0)
public struct Region: Equatable {

    /// Calendar to interpret date values. You can alter the calendar to adjust the representation
    /// of date to your needs.
    ///
    public let calendar: NSCalendar!

    /// Time zone to interpret date values
    /// Because the time zone is part of calendar, this is a shortcut to that variable.
    /// You can alter the time zone to adjust the representation of date to your needs.
    ///
    public var timeZone: NSTimeZone {
        return self.calendar.timeZone
    }

    /// Locale to interpret date values
    /// Because the locale is part of calendar, this is a shortcut to that variable.
    /// You can alter the locale to adjust the representation of date to your needs.
    ///
    public var locale: NSLocale {
        return self.calendar.locale!
    }

    /// Initialise with a calendar and/or a time zone
    ///
    /// - Parameters:
    ///     - calendar: the calendar to work with
    ///     - timeZone: the time zone to work with
    ///     - locale: the locale to work with
    ///
    internal init(
        calendar: NSCalendar,
        timeZone: NSTimeZone? = nil,
        locale: NSLocale? = nil) {

            self.calendar = calendar
            self.calendar.locale = locale ?? calendar.locale ?? NSLocale.currentLocale()
            self.calendar.timeZone = timeZone ?? calendar.timeZone ?? NSTimeZone.defaultTimeZone()
    }

    /// Initialise with a date components
    ///
    /// - Parameters:
    ///     - components: the date components to initialise with
    ///
    internal init(_ components: NSDateComponents) {

            let calendar = components.calendar ?? NSCalendar.currentCalendar()
            let timeZone = components.timeZone
            let locale = calendar.locale

        self.init(calendar: calendar, timeZone: timeZone, locale: locale)
    }

    /// Initialise with a calendar and/or a time zone
    ///
    /// - Parameters:
    ///     - calendarName: the calendar to work with to assign in `CalendarName` format, default =
    ///         the current calendar
    ///     - timeZoneName: the time zone to work with in `TimeZoneConvertible` format, default is
    ///             the default time zone
    ///     - localeName: the locale to work with, default is the current locale
    ///
    public init(
        calendarName: CalendarName? = nil,
        timeZoneName: TimeZoneName? = nil,
        localeName: LocaleName? = nil) {

            let calendar = calendarName?.calendar ?? NSCalendar.currentCalendar()
            let timeZone = timeZoneName?.timeZone ?? NSTimeZone.defaultTimeZone()
            let locale = localeName?.locale ?? NSLocale.currentLocale()

            self.init(calendar: calendar, timeZone: timeZone, locale: locale)
    }

    /// Today's date
    ///
    /// - Returns: the date of today at midnight (00:00) in the current calendar and default time
    ///     zone.
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

public func == (left: Region, right: Region) -> Bool {
    if left.calendar.calendarIdentifier != right.calendar.calendarIdentifier {
        return false
    }

    if left.timeZone.secondsFromGMT != right.timeZone.secondsFromGMT {
        return false
    }

    if left.locale.localeIdentifier != right.locale.localeIdentifier {
        return false
    }

    return true
}

extension Region: Hashable {
    public var hashValue: Int {
        return calendar.hashValue ^ timeZone.hashValue ^ locale.hashValue
    }
}

extension Region: CustomStringConvertible {
    public var description: String {
        let timeZoneAbbreviation = timeZone.abbreviation ?? ""
        return "\(calendar.calendarIdentifier); \(timeZone.name):\(timeZoneAbbreviation); " +
        "\(locale.localeIdentifier)"
    }
}
