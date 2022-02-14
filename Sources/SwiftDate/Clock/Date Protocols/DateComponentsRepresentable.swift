//
//  SwiftDate
//  Toolkit to parse, validate, manipulate, compare and display dates, time & timezones in Swift.
//
//  Created by Daniele Margutti
//  Email: hello@danielemargutti.com
//  Web: http://www.danielemargutti.com
//
//  Copyright ©2022 Daniele Margutti. All rights reserved.
//  Licensed under MIT License.
//

import Foundation


// MARK: - Protocol

/// This protocol describe a set of properties and functions which help you
/// to manage date objects. Both system-wide `Date` and `Clock` are conform
/// to this protocol.
///
/// For `Date` the default region used is `Region.default`.
/// `Clock` instances uses their own `region` property.
public protocol DateComponentsRepresentable {
    
    /// Associated region of the date.
    var region: Region { get }
    
    /// Get all the date components of a date.
    var dateComponents: DateComponents { get }
    
    /// Return the absolute represented date.
    var absoluteDate: Date { get }
    
    /// Represented year.
    var year: Int { get }
    
    /// Represented month.
    var month: Int { get }
    
    /// Return the formatted month name string.
    ///
    /// - Returns: String
    func monthName(style: DateSymbolFormats) -> String
    
    /// Number of the days in the receiver.
    var monthDays: Int { get }

    /// Day unit of the receiver.
    var day: Int { get }
    
    /// Day of year unit of the receiver.
    var dayOfYear: Int { get }
    
    /// The number of day in ordinal style format for the receiver in current locale.
    /// For example, in the en_US locale, the number 3 is represented as 3rd;
    /// in the fr_FR locale, the number 3 is represented as 3e.
    var ordinalDay: String { get }
    
    /// Hour unit of the receiver.
    var hour: Int { get }
    
    /// Nearest rounded hour from the date.
    var nearestHour: Int { get }
    
    /// Minute unit of the receiver.
    var minute: Int { get }
    
    /// Second unit of the receiver.
    var second: Int { get }

    /// Nanosecond unit of the receiver.
    var nanosecond: Int { get }

    /// Milliseconds in day of the receiver
    /// This field behaves exactly like a composite of all time-related fields, not including the zone fields.
    /// As such, it also reflects discontinuities of those fields on DST transition days.
    /// On a day of DST onset, it will jump forward. On a day of DST cessation, it will jump backward.
    /// This reflects the fact that is must be combined with the offset field to obtain a unique local time value.
    var msInDay: Int { get }

    /// Weekday unit of the receiver.
    /// The weekday units are the numbers 1-N (where for the Gregorian calendar N=7 and 1 is Sunday).
    var weekday: Int { get }
    
    /// Return the weekday name.
    ///
    /// - Returns: String
    func weekdayName(style: DateSymbolFormats) -> String
    
    /// Week of a year of the receiver.
    var weekOfYear: Int { get }

    /// Week of a month of the receiver.
    var weekOfMonth: Int { get }
    
    /// Ordinal position within the month unit of the corresponding weekday unit.
    /// For example, in the Gregorian calendar a weekday ordinal unit of 2 for a
    /// weekday unit 3 indicates "the second Tuesday in the month".
    var weekdayOrdinal: Int { get }
    
    /// Relative year for a week within a year calendar unit.
    var yearForWeekOfYear: Int { get }
    
    /// Quarter value of the receiver.
    var quarter: Int { get }
    
    /// Quarter name expressed in given format style.
    ///
    /// - Parameter style: style to express the value.
    /// - Returns: `String`
    func quarterName(style: DateSymbolFormats) -> String
    
    /// Era value of the receiver.
    var era: Int { get }

    /// Name of the era expressed in given format style.
    ///
    /// - Parameter style: style to express the value.
    /// - Returns: `String`
    func eraName(style: DateSymbolFormats) -> String
        
}

// MARK: - Date Conformance

extension Date: DateComponentsRepresentable {
    
    public var region: Region {
        Region.default
    }
    
    public var absoluteDate: Date {
        self
    }
    
    public var dateComponents: DateComponents {
        region.calendar.dateComponents(DateComponents.allCases, from: absoluteDate)
    }
    
}

// MARK: - Clock Conformance

extension Clock: DateComponentsRepresentable { }

// MARK: - Default Implementation

public extension DateComponentsRepresentable {
    
    var year: Int {
        dateComponents.year!
    }
    
    var month: Int {
        dateComponents.month!
    }
    
    var monthDays: Int {
        region.calendar.range(of: .day, in: .month, for: absoluteDate)!.count
    }
    
    func monthName(style: DateSymbolFormats = .default) -> String {
        let formatter = FormattersCache.shared.formatter(region: region)!
        let idx = (month - 1)
        switch style {
        case .default:
            return formatter.monthSymbols[idx]
        case .defaultStandalone:
            return formatter.standaloneMonthSymbols[idx]
        case .short:
            return formatter.shortMonthSymbols[idx]
        case .standaloneShort:
            return formatter.shortStandaloneMonthSymbols[idx]
        case .veryShort:
            return formatter.veryShortMonthSymbols[idx]
        case .standaloneVeryShort:
            return formatter.veryShortStandaloneMonthSymbols[idx]
        }
    }

    var day: Int {
        dateComponents.day!
    }

    var dayOfYear: Int {
        region.calendar.ordinality(of: .day, in: .year, for: absoluteDate)!
    }
    
    var ordinalDay: String {
        FormattersCache.shared.numberFormatter(region: region)?.string(from: day as NSNumber) ?? "\(day)"
    }
    
    var hour: Int {
        dateComponents.hour!
    }
    
    var nearestHour: Int {
        Date(timeIntervalSinceReferenceDate:
                (absoluteDate.timeIntervalSinceReferenceDate / 3600.0).rounded(.toNearestOrEven) * 3600.0).hour
    }
    
    var minute: Int {
        dateComponents.minute!
    }

    var second: Int {
        dateComponents.second!
    }

    var nanosecond: Int {
        dateComponents.nanosecond!
    }

    var msInDay: Int {
        (region.calendar.ordinality(of: .second, in: .day, for: absoluteDate)! * 1000)
    }

    var weekday: Int {
        dateComponents.weekday!
    }
    
    var weekOfYear: Int {
        dateComponents.weekOfYear!
    }

    var weekOfMonth: Int {
        dateComponents.weekOfMonth!
    }

    func weekdayName(style: DateSymbolFormats = .default) -> String {
        let formatter = FormattersCache.shared.formatter(region: region)!
        let idx = (weekday - 1)
        switch style {
        case .default:
            return formatter.weekdaySymbols[idx]
        case .defaultStandalone:
            return formatter.standaloneWeekdaySymbols[idx]
        case .short:
            return formatter.shortWeekdaySymbols[idx]
        case .standaloneShort:
            return formatter.shortStandaloneWeekdaySymbols[idx]
        case .veryShort:
            return formatter.veryShortWeekdaySymbols[idx]
        case .standaloneVeryShort:
            return formatter.veryShortStandaloneWeekdaySymbols[idx]
        }
    }
    
    var weekdayOrdinal: Int {
        return dateComponents.weekdayOrdinal!
    }

    var yearForWeekOfYear: Int {
        return dateComponents.yearForWeekOfYear!
    }

    var quarter: Int {
        let monthsInQuarter = Double(Calendar.current.monthSymbols.count) / 4.0
        return Int(ceil( Double(month) / monthsInQuarter))
    }
    
    func quarterName(style: DateSymbolFormats = .default) -> String {
        let formatter = FormattersCache.shared.formatter(region: region)!
        let idx = (quarter - 1)
        switch style {
        case .default:
            return formatter.quarterSymbols[idx]
        case .defaultStandalone:
            return formatter.standaloneQuarterSymbols[idx]
        case .short, .veryShort:
            return formatter.shortQuarterSymbols[idx]
        case .standaloneShort, .standaloneVeryShort:
            return formatter.shortStandaloneQuarterSymbols[idx]
        }
    }
    
    var era: Int {
        return dateComponents.era!
    }

    func eraName(style: DateSymbolFormats = .default) -> String {
        let formatter = FormattersCache.shared.formatter(region: region)!
        let idx = (era - 1)
        switch style {
        case .default, .defaultStandalone:
            return formatter.longEraSymbols[idx]
        case .short, .standaloneShort, .veryShort, .standaloneVeryShort:
            return formatter.eraSymbols[idx]
        }
    }
    
}
