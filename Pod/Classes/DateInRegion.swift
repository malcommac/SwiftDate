
//
//  NSDateComponents.swift
//  JHCalendar
//
//  Created by Jeroen Houtzager on 12/10/15.
//  Copyright © 2015 Jeroen Houtzager. All rights reserved.
//

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
    public let date: NSDate!

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
    ///     - region:       the date region to work with to assign, default = the current date region
    ///
    /// Date and time property parameters can be used to alter the reference date properies in the context
    /// of the date region
    ///
    public init(date newDate: NSDate = NSDate(), region newRegion: DateRegion = DateRegion()) {
        date = newDate
        region = newRegion
    }

    public convenience init(
        fromDate: DateInRegion,
        region newRegion: DateRegion? = nil) {
            self.init(date: fromDate.date, region: newRegion ?? fromDate.region)
    }

    public convenience init?(components newComponents: NSDateComponents) {
        let newRegion = DateRegion(calendar: newComponents.calendar, timeZone: newComponents.timeZone, locale: newComponents.calendar?.locale)
        if let newDate = newRegion.calendar.dateFromComponents(newComponents) {
            self.init(date: newDate, region: newRegion)
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
        region parRegion: DateRegion? = nil) {

            let newRegion = parRegion ?? fromDate?.region ?? DateRegion()

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

            self.init(components: newComponents)
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
        region parRegion: DateRegion? = nil) {

            let newRegion = parRegion ?? fromDate?.region ?? DateRegion()

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

            self.init(components: newComponents)
    }


    public convenience init?(
        fromDate: DateInRegion? = nil,
        hour: Int,
        minute: Int = 0,
        second: Int = 0,
        nanosecond: Int = 0,
        region parRegion: DateRegion? = nil) {

            let newRegion = parRegion ?? fromDate?.region ?? DateRegion()

            let newComponents = fromDate?.components ?? NSDateComponents()
            newComponents.hour = hour
            newComponents.minute = minute
            newComponents.second = second
            newComponents.nanosecond = nanosecond
            newComponents.calendar = newRegion.calendar
            newComponents.timeZone = newRegion.timeZone

            self.init(components: newComponents)
    }

    public func inRegion(newRegion: DateRegion) -> DateInRegion {
        return DateInRegion(fromDate: self, region: newRegion)
    }

    public func inLocalRegion() -> DateInRegion {
        return DateInRegion(fromDate: self, region: DateRegion())
    }

}

