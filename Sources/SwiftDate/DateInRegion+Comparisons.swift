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

// MARK: - Comparators

extension DateInRegion {

    // swiftlint:disable line_length

    /// Returns an NSComparisonResult value that indicates the ordering of two given dates based on
    /// their components down to a given unit granularity.
    ///
    /// - Parameters:
    ///     - date: date to compare.
    ///     - component: The smallest unit that must, along with all larger units, be equal
    ///         for the given dates to be considered the same.
    ///         For possible values, see “[Calendar Units](xcdoc://?url=developer.apple.com/library/prerelease/ios/documentation/Cocoa/Reference/Foundation/Classes/NSCalendar_Class/index.html#//apple_ref/c/tdef/NSCalendarUnit)”
    ///
    /// - Returns: `.orderedSame` if the dates are the same down to the given granularity, otherwise
    ///     `orderedAscending` or `orderedDescending`.
    ///
    /// - seealso: [compareDate:toDate:toUnitGranularity:](xcdoc://?url=developer.apple.com/library/prerelease/ios/documentation/Cocoa/Reference/Foundation/Classes/NSCalendar_Class/index.html#//apple_ref/occ/instm/NSCalendar/compareDate:toDate:toUnitGranularity:)
    ///
    public func compare(date: DateInRegion, toGranularity component: Calendar.Component)
        -> ComparisonResult {

            return calendar.compare(self.absoluteTime, to: date.absoluteTime, toGranularity: component)
    }

    /// Compares equality of two given dates based on their components down to a given unit
    /// granularity.
    ///
    /// - Parameters:
    ///     - component: The smallest unit that must, along with all larger units, be equal for the given
    ///         dates to be considered the same.
    ///     - date: date to compare.
    ///
    /// - Returns: `true` if the dates are the same down to the given granularity, otherwise `false`
    ///
    /// - seealso: [compareDate:toDate:toUnitGranularity:](xcdoc://?url=developer.apple.com/library/prerelease/ios/documentation/Cocoa/Reference/Foundation/Classes/NSCalendar_Class/index.html#//apple_ref/occ/instm/NSCalendar/compareDate:toDate:toUnitGranularity:)
    ///
    public func isIn(component: Calendar.Component, of date: DateInRegion) -> Bool {
        return self.compare(date: date, toGranularity: component) == .orderedSame
    }

    /// Compares whether the receiver is before `date` based on their components down to a given
    /// unit granularity.
    ///
    /// - Parameters:
    ///     - component: The smallest unit that must, along with all larger units, be less for the given
    ///         dates.
    ///     - date: date to compare.
    ///
    /// - Returns: `true` if the unit of the receiver is less than the unit of `date`, otherwise
    ///         `false`
    ///
    /// - seealso: [compareDate:toDate:toUnitGranularity:](xcdoc://?url=developer.apple.com/library/prerelease/ios/documentation/Cocoa/Reference/Foundation/Classes/NSCalendar_Class/index.html#//apple_ref/occ/instm/NSCalendar/compareDate:toDate:toUnitGranularity:)
    ///
    public func isBefore(component: Calendar.Component, of date: DateInRegion) -> Bool {
        return self.compare(date: date, toGranularity: component) == .orderedAscending
    }

    /// Compares whether the receiver is after `date` based on their components down to a given unit
    /// granularity.
    ///
    /// - Parameters:
    ///     - component: The smallest unit that must, along with all larger units, be greater
    ///     - date: date to compare.
    ///
    /// - Returns: `true` if the unit of the receiver is greater than the unit of `date`, otherwise
    ///         `false`
    ///
    /// - seealso: [compareDate:toDate:toUnitGranularity:](xcdoc://?url=developer.apple.com/library/prerelease/ios/documentation/Cocoa/Reference/Foundation/Classes/NSCalendar_Class/index.html#//apple_ref/occ/instm/NSCalendar/compareDate:toDate:toUnitGranularity:)
    ///
    public func isAfter(component: Calendar.Component, of date: DateInRegion) -> Bool {
        return self.compare(date: date, toGranularity: component) == .orderedDescending
    }

    /// Returns whether the given date is in today.
    ///
    /// - Returns: a boolean indicating whether the receiver is in today
    ///
    /// - note: This value is interpreted in the context of the calendar of the receiver
    ///
    /// - seealso: [isDateInToday:](xcdoc://?url=developer.apple.com/library/prerelease/ios/documentation/Cocoa/Reference/Foundation/Classes/NSCalendar_Class/index.html#//apple_ref/occ/instm/NSCalendar/isDateInToday:)
    ///
    public func isInToday(  ) -> Bool {
        return calendar.isDateInToday(absoluteTime)
    }

    /// Returns whether the given date is in yesterday.
    ///
    /// - Returns: a boolean indicating whether the receiver is in yesterday
    ///
    /// - note: This value is interpreted in the context of the calendar of the receiver
    ///
    /// - seealso: [isDateInYesterday:](xcdoc://?url=developer.apple.com/library/prerelease/ios/documentation/Cocoa/Reference/Foundation/Classes/NSCalendar_Class/index.html#//apple_ref/occ/instm/NSCalendar/isDateInYesterday:)
    ///
    public func isInYesterday() -> Bool {
        return calendar.isDateInYesterday(absoluteTime)
    }

    /// Returns whether the given date is in tomorrow.
    ///
    /// - Returns: a boolean indicating whether the receiver is in tomorrow
    ///
    /// - note: This value is interpreted in the context of the calendar of the receiver
    ///
    /// - seealso: [isDateInTomorrow:](xcdoc://?url=developer.apple.com/library/prerelease/ios/documentation/Cocoa/Reference/Foundation/Classes/NSCalendar_Class/index.html#//apple_ref/occ/instm/NSCalendar/isDateInTomorrow:)
    ///
    public func isInTomorrow() -> Bool {
        return calendar.isDateInTomorrow(absoluteTime)
    }

    /// Returns whether the given date is in the weekend.
    ///
    /// - Returns: a boolean indicating whether the receiver is in the weekend
    ///
    /// - note: This value is interpreted in the context of the calendar of the receiver
    ///
    /// - seealso: [isDateInWeekend:](xcdoc://?url=developer.apple.com/library/prerelease/ios/documentation/Cocoa/Reference/Foundation/Classes/NSCalendar_Class/index.html#//apple_ref/occ/instm/NSCalendar/isDateInWeekend:)
    ///
    public func isInWeekend() -> Bool {
        return calendar.isDateInWeekend(absoluteTime)
    }

    /// Returns whether the given date is in the past.
    ///
    /// - Returns: a boolean indicating whether the receiver is in the past
    ///
    public func isInPast() -> Bool {
        return absoluteTime < Date()
    }

    /// Returns whether the given date is in the past.
    ///
    /// - Returns: a boolean indicating whether the receiver is in the past
    ///
    public func isInFuture() -> Bool {
        return absoluteTime > Date()
    }

    /// Returns whether the given date is on the same day as the receiver in the time zone and
    /// calendar of the receiver.
    ///
    /// - Parameters:
    ///     - date: a date to compare against
    ///
    /// - Returns: a boolean indicating whether the receiver is on the same day as the given date in
    ///        the time zone and calendar of the receiver.
    ///
    /// - seealso: [isDate:inSameDayAsDate:](xcdoc://?url=developer.apple.com/library/prerelease/ios/documentation/Cocoa/Reference/Foundation/Classes/NSCalendar_Class/index.html#//apple_ref/occ/instm/NSCalendar/isDate:inSameDayAsDate:)
    ///
    public func isInSameDay(as date: DateInRegion) -> Bool {
        return calendar.isDate(self.absoluteTime, inSameDayAs: date.absoluteTime)
    }

    /// Returns whether the given date is equal to the receiver.
    ///
    /// - Parameters:
    ///     - date: a date to compare against
    ///
    /// - Returns: a boolean indicating whether the receiver is equal to the given date
    ///
    /// - seealso: [isEqualToDate:](xcdoc://?url=developer.apple.com/library/prerelease/ios/documentation/Cocoa/Reference/Foundation/Classes/NSDate_Class/index.html#//apple_ref/occ/instm/NSDate/isEqualToDate:)
    ///
    public func isEqualToDate(_ right: DateInRegion) -> Bool {
        // Compare the content, first the date
        if absoluteTime != right.absoluteTime {
            return false
        }

        // Then the region
        if region != right.region {
            return false
        }

        // We have made it! They are equal!
        return true
    }
}

// MARK: - Comparable delegate


/// Instances of conforming types can be compared using relational operators, which define a strict
/// total order.
///
/// A type conforming to Comparable need only supply the < and == operators; default implementations
/// of <=, >, >=, and != are supplied by the standard library:
///
extension DateInRegion: Comparable {}

/// Returns whether the given date is later than the receiver.
/// Just the dates are compared. Calendars, time zones are irrelevant.
///
/// - Parameters:
///     - date: a date to compare against
///
/// - Returns: a boolean indicating whether the receiver is earlier than the given date
///
public func < (ldate: DateInRegion, rdate: DateInRegion) -> Bool {
    return ldate.absoluteTime.compare(rdate.absoluteTime) == .orderedAscending
}

/// Returns whether the given date is earlier than the receiver.
/// Just the dates are compared. Calendars, time zones are irrelevant.
///
/// - Parameters:
///     - date: a date to compare against
///
/// - Returns: a boolean indicating whether the receiver is later than the given date
///
public func > (ldate: DateInRegion, rdate: DateInRegion) -> Bool {
    return ldate.absoluteTime.compare(rdate.absoluteTime) == .orderedDescending
}
