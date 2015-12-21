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

// MARK: - Equations

extension DateInRegion: Equatable {}


/// Returns true when the given date is equal to the receiver.
/// Just the dates are compared. Calendars, time zones are irrelevant.
///
/// - Parameters:
///     - date: a date to compare against
///
/// - Returns: a boolean indicating whether the receiver is equal to the given date
///
public func ==(left: DateInRegion, right: DateInRegion) -> Bool {

    // Compare the content, first the date
    guard left.absoluteTime.isEqualToDate(right.absoluteTime) else {
        return false
    }

    // Then the calendar
    guard left.calendar.calendarIdentifier == right.calendar.calendarIdentifier else {
        return false
    }

    // Then the time zone
    guard left.timeZone.secondsFromGMTForDate(left.absoluteTime) == right.timeZone.secondsFromGMTForDate(right.absoluteTime) else {
        return false
    }

    // Then the locale
    guard left.locale.localeIdentifier == right.locale.localeIdentifier else {
        return false
    }

    // We have made it! They are equal!
    return true
}

extension DateInRegion {

    /// Returns whether the given date is on the same day as the receiver in the time zone and calendar of the receiver.
    ///
    /// - Parameters:
    ///     - date: a date to compare against
    ///
    /// - Returns: a boolean indicating whether the receiver is on the same day as the given date in the time zone and calendar of the receiver.
    ///
    /// - seealso: [isDate:inSameDayAsDate:](xcdoc://?url=developer.apple.com/library/prerelease/ios/documentation/Cocoa/Reference/Foundation/Classes/NSCalendar_Class/index.html#//apple_ref/occ/instm/NSCalendar/isDate:inSameDayAsDate:)
    ///
    public func isInSameDayAsDate(date: DateInRegion) -> Bool {
        return calendar.isDate(self.absoluteTime, inSameDayAsDate: date.absoluteTime)
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
    public func isEqualToDate(right: DateInRegion) -> Bool {
        return absoluteTime.isEqualToDate(right.absoluteTime)
    }
    
}

