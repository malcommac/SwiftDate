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

extension DateInRegion {

    // swiftlint:disable line_length

    /// Time interval since the reference date at 1 January 2001
    ///
    /// - Returns: the number of seconds as an NSTimeInterval.
    ///
    /// - SeeAlso: [timeIntervalSinceReferenceDate](https://developer.apple.com/library/mac/documentation/Cocoa/Reference/Foundation/Classes/NSDate_Class/#//apple_ref/occ/instp/NSDate/timeIntervalSinceReferenceDate)
    ///
    public var timeIntervalSinceReferenceDate: NSTimeInterval {
        return absoluteTime.timeIntervalSinceReferenceDate
    }

    /// Creates and returns a DateInRegion object representing a date in the distant past (in terms
    /// of centuries).
    ///
    /// - Returns: A ``DateInRegion`` object representing a date in the distant past (in terms of
    ///     centuries).
    ///
    public static func distantFuture() -> DateInRegion {
        return DateInRegion(absoluteTime: NSDate.distantFuture())
    }

    /// Creates and returns a DateInRegion object representing a date in the distant future (in
    /// terms of centuries).
    ///
    /// - Returns: A ``DateInRegion`` object representing a date in the distant future (in terms of
    ///     centuries).
    ///
    public static func distantPast() -> DateInRegion {
        return DateInRegion(absoluteTime: NSDate.distantPast())
    }

    /// Returns a DateInRegion object representing a date that is the earliest from a given range
    /// of dates.
    /// The dates are compared in absolute time, i.e. time zones, locales and calendars have no
    /// effect on the comparison.
    ///
    /// - Parameters:
    ///     - dates: a number of dates to be evaluated
    ///
    /// - Returns: a ``DateInRegion`` object representing a date that is the earliest from a given
    ///     range of dates.
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

    /// Returns a DateInRegion object representing a date that is the latest from a given range of
    /// dates. The dates are compared in absolute time, i.e. time zones, locales and calendars have
    /// no effect on the comparison.
    ///
    /// - Parameters:
    ///     - dates: a number of dates to be evaluated
    ///
    /// - Returns: a ``DateInRegion`` object representing a date that is the latest from a given
    ///     range of dates.
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
