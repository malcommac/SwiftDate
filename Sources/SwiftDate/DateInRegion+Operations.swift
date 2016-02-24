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

// MARK: - Operators

public extension DateInRegion {

    /// Returns, as an NSDateComponents object using specified components, the difference between
    /// the receiver and the supplied date.
    ///
    /// - Parameters:
    ///     - toDate: a date to calculate against
    ///     - unitFlags: Specifies the components for the returned NSDateComponents object
    ///
    /// - Returns: An NSDateComponents object whose components are specified by unitFlags and
    ///     calculated from the difference between the resultDate and startDate.
    ///
    /// - note: This value is calculated in the context of the calendar of the receiver
    ///
    public func difference(toDate: DateInRegion, unitFlags: NSCalendarUnit) -> NSDateComponents? {
        return calendar.components(unitFlags, fromDate: self.absoluteTime,
            toDate: toDate.absoluteTime, options: NSCalendarOptions(rawValue: 0))
    }

    public func add(years years: Int? = nil, months: Int? = nil, weeks: Int? = nil,
        days: Int? = nil, hours: Int? = nil, minutes: Int? = nil, seconds: Int? = nil,
        nanoseconds: Int? = nil) -> DateInRegion {

        let components = NSDateComponents()

        components.year = years ?? NSDateComponentUndefined
        components.month = months ?? NSDateComponentUndefined
        components.weekOfYear = weeks ?? NSDateComponentUndefined
        components.day = days ?? NSDateComponentUndefined
        components.hour = hours ?? NSDateComponentUndefined
        components.minute = minutes ?? NSDateComponentUndefined
        components.second = seconds ?? NSDateComponentUndefined
        components.nanosecond = nanoseconds ?? NSDateComponentUndefined

        let newDate = self.add(components)
        return newDate
    }

    public func add(components: NSDateComponents) -> DateInRegion {
        let absoluteTime = region.calendar.dateByAddingComponents(components,
            toDate: self.absoluteTime, options: NSCalendarOptions(rawValue: 0))!
        return DateInRegion(absoluteTime: absoluteTime, region: self.region)
    }

    public func add(components dict: [NSCalendarUnit : AnyObject]) -> DateInRegion {
        let components = dict.components()
        return self.add(components)
    }
}

/// Returns a new DateInRegion object representing a new time calculated by subtracting given right
/// hand components from the left hand date.
///
/// - Parameters:
///     - lhs: the date to subtract components from
///     - rhs: the components to subtract from the date
///
/// - Returns: A new DateInRegion object representing the time calculated by subtracting from date
/// the calendrical components specified by components.
///
/// - note: This value is calculated in the context of the calendar of the date
///
public func - (lhs: DateInRegion, rhs: NSDateComponents) -> DateInRegion {
    return lhs + (-rhs)
}

/// Returns a new DateInRegion object representing a new time calculated by adding given right hand
/// components to the left hand date.
///
/// - Parameters:
///     - lhs: the date to add the components to
///     - rhs: the components to add to the date
///
/// - Returns: A new DateInRegion object representing the time calculated by adding to date the
///   calendrical components specified by components.
///
/// - note: This value is calculated in the context of the calendar of the date
///
public func + (lhs: DateInRegion, rhs: NSDateComponents) -> DateInRegion {
    return lhs.add(rhs)
}


/// Returns a new NSDateComponents object representing the negative values of components that are
/// submitted
///
/// - Parameters:
///     - dateComponents: the components to process
///
/// - Returns: A new NSDateComponents object representing the negative values of components that
///     are submitted
///
public prefix func - (dateComponents: NSDateComponents) -> NSDateComponents {
    let result = NSDateComponents()
    for unit in DateInRegion.componentFlagSet {
        let value = dateComponents.valueForComponent(unit)
        if value != Int(NSDateComponentUndefined) {
            result.setValue(-value, forComponent: unit)
        }
    }
    return result
}
