//
//  DateInRegionNSDatePort.swift
//  Pods
//
//  Created by Jeroen Houtzager on 02/11/15.
//
//

import Foundation

extension DateInRegion {

    /// Time interval since the reference date at 1 January 2001
    ///
    /// - Returns: the number of seconds as an NSTimeInterval.
    ///
    /// - SeeAlso: [timeIntervalSinceReferenceDate](https://developer.apple.com/library/mac/documentation/Cocoa/Reference/Foundation/Classes/NSDate_Class/#//apple_ref/occ/instp/NSDate/timeIntervalSinceReferenceDate)
    ///
    public var timeIntervalSinceReferenceDate: NSTimeInterval {
        return absoluteTime.timeIntervalSinceReferenceDate
    }

    /// Creates and returns a DateInRegion object representing a date in the distant past (in terms of centuries).
    ///
    /// - Returns: A ``DateInRegion`` object representing a date in the distant past (in terms of centuries).
    ///
    public static func distantFuture() -> DateInRegion {
        return DateInRegion(absoluteTime: NSDate.distantFuture())
    }

    /// Creates and returns a DateInRegion object representing a date in the distant future (in terms of centuries).
    ///
    /// - Returns: A ``DateInRegion`` object representing a date in the distant future (in terms of centuries).
    ///
    public static func distantPast() -> DateInRegion {
        return DateInRegion(absoluteTime: NSDate.distantPast())
    }

    /// Returns a DateInRegion object representing a date that is the earliest from a given range of dates.
    /// The dates are compared in absolute time, i.e. time zones, locales and calendars have no effect
    /// on the comparison.
    ///
    /// - Parameters:
    ///     - dates: a number of dates to be evaluated
    ///
    /// - Returns: a ``DateInRegion`` object representing a date that is the earliest from a given range of dates.
    ///
    public static func earliestDate(dates: DateInRegion ...) -> DateInRegion {
        var currentMinimum = DateInRegion.distantFuture()
        for thisDate in dates {
            if currentMinimum > thisDate {
                currentMinimum = thisDate
            }
        }
        return currentMinimum
    }

    /// Returns a DateInRegion object representing a date that is the latest from a given range of dates.
    /// The dates are compared in absolute time, i.e. time zones, locales and calendars have no effect
    /// on the comparison.
    ///
    /// - Parameters:
    ///     - dates: a number of dates to be evaluated
    ///
    /// - Returns: a ``DateInRegion`` object representing a date that is the latest from a given range of dates.
    ///
    public static func latestDate(dates: DateInRegion ...) -> DateInRegion {
        var currentMaximum = DateInRegion.distantPast()
        for thisDate in dates {
            if currentMaximum < thisDate {
                currentMaximum = thisDate
            }
        }
        return currentMaximum
    }

}