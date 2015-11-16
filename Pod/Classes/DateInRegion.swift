
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
            let defaultComponents = fromDate?.components

            let newComponents = NSDateComponents()
            newComponents.era = era ?? defaultComponents?.era ?? 1
            newComponents.year = year
            newComponents.month = month
            newComponents.day = day
            newComponents.hour = hour ?? defaultComponents?.hour ?? 0
            newComponents.minute = minute ?? defaultComponents?.minute ?? 0
            newComponents.second = second ?? defaultComponents?.second ?? 0
            newComponents.nanosecond = nanosecond ?? defaultComponents?.nanosecond ?? 0
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
            let defaultComponents = fromDate?.components

            let newComponents = NSDateComponents()
            newComponents.era = era ?? defaultComponents?.era ?? 1
            newComponents.yearForWeekOfYear = yearForWeekOfYear
            newComponents.weekOfYear = weekOfYear
            newComponents.weekday = weekday
            newComponents.hour = hour ?? defaultComponents?.hour ?? 0
            newComponents.minute = minute ?? defaultComponents?.minute ?? 0
            newComponents.second = second ?? defaultComponents?.second ?? 0
            newComponents.nanosecond = nanosecond ?? defaultComponents?.nanosecond ?? 0
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
        referenceDate: NSDate = NSDate(),
        region parRegion: DateRegion? = nil) {

            // Date is today
            let newRegion = parRegion ?? fromDate?.region ?? DateRegion()
            let newComponents = newRegion.calendar.components([.Era, .Year, .Month, .Day], fromDate: NSDate())
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

    /// Initialise with a date, a region and  some properties.
    /// This initialiser can be used to copy a date while
    /// setting certain properties.
    ///
    /// - Parameters:
    ///     - components:   date components according to which the date will be set.
    ///     - dateInRegion: the date to assign, default = NSDate() (that is the current time)
    ///     - dateIn:       the NSDate to assign, default = NSDate() (that is the current time)
    ///     - region:       the date region to work with to assign, default = the current date region
    ///
    /// Date and time property parameters can be used to alter the reference date properies in the context
    /// of the date region
    ///
    /*   public init?(
    era: Int? = nil,
    year: Int = nil,
    month: Int = nil,
    day: Int = nil,
    yearForWeekOfYear: Int? = nil,
    weekOfYear: Int? = nil,
    weekday: Int? = nil,
    hour: Int? = nil,
    minute: Int? = nil,
    second: Int? = nil,
    nanosecond: Int? = nil,
    components parComponents: NSDateComponents? = nil,
    date copyDate: NSDate? = nil,
    dateRegion copyDateRegion: DateRegion? = nil,
    dateInRegion copyDateInRegion: DateInRegion? = nil) {

    // Create default objects
    let referenceDate = NSDate(timeIntervalSinceReferenceDate: 0)
    let timeZone = NSTimeZone.defaultTimeZone()
    let offset = NSTimeInterval(timeZone.secondsFromGMTForDate(referenceDate))
    var newDate = NSDate(timeIntervalSinceReferenceDate: offset)
    var newRegion = DateRegion()

    // Construct new DateinRegion object fromthe bottom of the pararmeterlist up

    if let dateInRegion = copyDateInRegion {
    newRegion = dateInRegion.region
    newDate = dateInRegion.date
    }

    if let dateRegion = copyDateRegion {
    newRegion = DateRegion(region: dateRegion)
    }

    if let date = copyDate {
    newDate = date
    }

    if let components = parComponents {
    newRegion = DateRegion(calendar: components.calendar, timeZone: components.timeZone, locale: components.calendar?.locale, region: newRegion)
    }

    let newComponents = newRegion.calendar.components(DateInRegion.componentFlags, fromDate: newDate)
    for unit in DateInRegion.componentFlagSet {
    let value = newComponents.valueForComponent(unit)
    if value != NSDateComponentUndefined {
    newComponents.setValue(value, forComponent: unit)
    }
    }
    if let newEra = era { newComponents.era = newEra }
    if let newYear = year { newComponents.year = newYear }
    if let newMonth = month { newComponents.month = newMonth }
    if let newDay = day { newComponents.day = newDay }
    if let newYearForWeekOfYear = yearForWeekOfYear { newComponents.yearForWeekOfYear = newYearForWeekOfYear }
    if let newWeekOfYear = weekOfYear { newComponents.weekOfYear = newWeekOfYear }
    if let newWeekday = weekday { newComponents.weekday = newWeekday }
    if let newHour = hour { newComponents.hour = newHour }
    if let newMinute = minute { newComponents.minute = newMinute }
    if let newSecond = second { newComponents.second = newSecond }
    if let newNanosecond = nanosecond { newComponents.nanosecond = newNanosecond }
    newComponents.calendar = newRegion.calendar
    newComponents.timeZone = newRegion.timeZone

    // determine way of conversion: year month day or year week weekday
    var ymdFactor = 0
    if newComponents.year != NSDateComponentUndefined { ymdFactor++ }
    if newComponents.month != NSDateComponentUndefined { ymdFactor++ }
    if newComponents.day != NSDateComponentUndefined { ymdFactor++ }

    var ywwFactor = 0
    if newComponents.yearForWeekOfYear != NSDateComponentUndefined { ywwFactor++ }
    if newComponents.weekOfYear != NSDateComponentUndefined { ywwFactor++ }
    if newComponents.weekday != NSDateComponentUndefined { ywwFactor++ }

    if ywwFactor > ymdFactor {
    newComponents.year = NSDateComponentUndefined
    newComponents.month = NSDateComponentUndefined
    newComponents.day = NSDateComponentUndefined
    } else if ymdFactor > 0 {
    newComponents.yearForWeekOfYear = NSDateComponentUndefined
    newComponents.weekOfYear = NSDateComponentUndefined
    newComponents.weekday = NSDateComponentUndefined
    newComponents.weekOfMonth = NSDateComponentUndefined
    }

    if let date = newRegion.calendar.dateFromComponents(newComponents) {
    newDate = date
    }

    date = newDate
    region = newRegion
    }*/


    // MARK: - helper funcs

    /// Create a default date components to use internally with the init with date components
    ///
    /// - Returns: date components that contain the reference date (1 January 2001, midnight in the current time zone)
    ///
    internal static func defaultComponents() -> NSDateComponents {
        let referenceDate = NSDate(timeIntervalSinceReferenceDate: NSTimeInterval(0))
        let thisCalendar = NSCalendar.currentCalendar()
        let UTC = NSTimeZone(forSecondsFromGMT: 0)
        thisCalendar.timeZone  = UTC
        let theseComponents = thisCalendar.components(DateInRegion.componentFlags, fromDate: referenceDate)
        theseComponents.calendar = thisCalendar
        theseComponents.timeZone = NSTimeZone.defaultTimeZone()
        return theseComponents
    }


}

