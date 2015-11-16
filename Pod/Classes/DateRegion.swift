//
//  DateRegion.swift
//  Pods
//
//  Created by Jeroen Houtzager on 09/11/15.
//
//

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
    ///     - calendar:   the calendar to work with to assign, default = the current calendar
    ///     - timeZone:   the time zone to work with, default is the default time zone
    ///     - locale:     the locale to work with, default is the current locale
    ///     - calendarID: the calendar ID to work with to assign, default = the current calendar
    ///     - timeZoneID: the time zone ID to work with, default is the default time zone
    ///     - localeID:   the locale ID to work with, default is the current locale
    ///     - region:     a region to copy
    ///
    /// - Note: parameters higher in the list take precedence over parameters lower in the list. E.g.
    ///     `DateRegion(locale: mylocale, localeID: "en_AU", region)` will copy region and set locale to mylocale, not `en_AU`.
    ///
    public init(
        calendarID: String = "",
        timeZoneID: String = "",
        localeID: String = "",
        calendar aCalendar: NSCalendar? = nil,
        timeZone aTimeZone: NSTimeZone? = nil,
        locale aLocale: NSLocale? = nil,
        region: DateRegion? = nil) {
            calendar = aCalendar ?? NSCalendar(calendarIdentifier: calendarID) ?? region?.calendar ?? NSCalendar.currentCalendar()
            timeZone = aTimeZone ?? NSTimeZone(abbreviation: timeZoneID) ?? NSTimeZone(name: timeZoneID) ?? region?.timeZone ?? NSTimeZone.defaultTimeZone()
            locale = aLocale ?? (localeID != "" ? NSLocale(localeIdentifier: localeID) : nil) ?? region?.locale ?? aCalendar?.locale ?? NSLocale.currentLocale()

            // Assign calendar fields
            calendar.timeZone = timeZone
            calendar.locale = locale
    }
    
    /// Today's date
    ///
    /// - Returns: the date of today at midnight (00:00) in the current calendar and default time zone.
    ///
    public func today() -> DateInRegion {
        let components = calendar.components([.Era, .Year, .Month, .Day, .Calendar, .TimeZone], fromDate: NSDate())
        let date = calendar.dateFromComponents(components)!
        return DateInRegion(region: self, date: date)
    }

    /// Yesterday's date
    ///
    /// - Returns: the date of yesterday at midnight (00:00) in the current calendar and default time zone.
    ///
    public func yesterday() -> DateInRegion {
        return (today() - 1.days)!
    }

    /// Tomorrow's date
    ///
    /// - Returns: the date of tomorrow at midnight (00:00) in the current calendar and default time zone.
    ///
    public func tomorrow() -> DateInRegion {
        return (today() + 1.days)!
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

extension DateRegion : Hashable {
    public var hashValue: Int {
        return calendar.hashValue ^ timeZone.hashValue ^ locale.hashValue
    }
}

extension DateRegion : CustomStringConvertible {
    public var description: String {
        return "\(calendar.calendarIdentifier); \(timeZone.name):\(timeZone.abbreviation ?? ""); \(locale.localeIdentifier)"
    }
}