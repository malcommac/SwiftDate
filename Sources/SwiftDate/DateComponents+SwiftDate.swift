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

//MARK: - Extension of Int To Manage Operations -

extension DateComponents {
    
    static var undefined: Int {
        return Int.max
    }

    /**
     Create a new date from a specific date by adding self components

     - parameter refDate: reference date
     - parameter region: optional region to define the timezone and calendar. By default is local
        region

     - returns: a new NSDate instance
     */
    public func fromDate(_ refDate: Date!, in region: Region = Region.defaultRegion) -> Date {
        let date = region.calendar.date(byAdding: self, to: refDate)
        return date!
    }

    /**
     Create a new date from a specific date by subtracting self components

     - parameter refDate: reference date
     - parameter region: optional region to define the timezone and calendar. By default is local
        region

     - returns: a new NSDate instance
     */
    public func agoFromDate(_ refDate: Date!, in region: Region = Region.defaultRegion) -> Date {
        var dc = DateComponents()
        for component in DateInRegion.componentFlagSet {
            if let value = self.value(for: component) {
                dc.setValue((value * -1), for: component)
            }
        }
        return region.calendar.date(byAdding: dc, to: refDate)!
    }

    /**
     Create a new date from current date and add self components.
     So you can make something like:
     let date = 4.days.fromNow()

     - parameter region: optional region to define the timezone and calendar. By default is local
        Region

     - returns: a new NSDate instance
     */
    public func fromNow(in region: Region = Region.defaultRegion) -> Date {
        return fromDate(Date(), in: region)
    }

    /**
     Create a new date from current date and substract self components
     So you can make something like:
     let date = 5.hours.ago()

     - parameter region: optional region to define the timezone and calendar. By default is local
            Region

     - returns: a new NSDate instance
     */
    public func ago(inRegion region: Region = Region.defaultRegion) -> Date {
        return agoFromDate(Date(), in: region)
    }

    /// The same of calling fromNow() with default local region
    public var fromNow: Date {
        get {
            return fromDate(Date())
        }
    }

    /// The same of calling ago() with default local region
    public var ago: Date {
        get {
            return agoFromDate(Date())
        }
    }

    /// The dateInRegion for the current components
    public var dateInRegion: DateInRegion? {
        return DateInRegion(self)
    }

}

//MARK: - Combine NSDateComponents -

public func | (lhs: DateComponents, rhs: DateComponents) -> DateComponents {
    var dc = DateComponents()
    for component in DateInRegion.componentFlagSet {
        if let lhs_value = lhs.value(for: component) {
            dc.setValue(lhs_value, for: component)
        }
        if let rhs_value = rhs.value(for: component) {
            dc.setValue(rhs_value, for: component)
        }
    }
    return dc
}

/// Add date components to one another
///
/// - parameters:
///     - lhs: left hand side argument
///     - rhs: right hand side argument
///
/// - returns: date components lhs + rhs
///
public func + (lhs: DateComponents, rhs: DateComponents) -> DateComponents {
    return sumDateComponents(lhs: lhs, rhs: rhs)
}

/// subtract date components from one another
///
/// - parameters:
///     - lhs: left hand side argument
///     - rhs: right hand side argument
///
/// - returns: date components lhs - rhs
///
public func - (lhs: DateComponents, rhs: DateComponents) -> DateComponents {
    return sumDateComponents(lhs: lhs, rhs: rhs, sum: false)
}

/// Helper function for date component sum * subtract
///
/// - parameters:
///     - lhs: left hand side argument
///     - rhs: right hand side argument
///     - sum: indicates whether arguments should be added or subtracted
///
/// - returns: date components lhs +/- rhs
///
internal func sumDateComponents(lhs: DateComponents, rhs: DateComponents, sum: Bool = true) ->
    DateComponents {

    var newComponents = DateComponents()
    let components = DateInRegion.componentFlagSet
    for component in components {

        guard let leftValue = lhs.value(for: component),
            let rightValue = rhs.value(for: component) else {
            continue // both are undefined, don't touch
        }

        let checkedLeftValue = leftValue != DateComponents.undefined ? leftValue : 0
        let checkedRightValue = rightValue != DateComponents.undefined ? rightValue : 0

        let finalValue =  checkedLeftValue + (sum ? checkedRightValue : -checkedRightValue)
        newComponents.setValue(finalValue, for: component)
    }
    return newComponents
}

// MARK: - Helpers to enable expressions e.g. date + 1.days - 20.seconds

extension TimeZone {

    /// Returns a new NSDateComponents object containing the time zone as specified by the receiver
    ///
    public var timeZone: DateComponents {
        return DateComponents(timeZone: self)
    }

}


extension Calendar {

    /// Returns a new NSDateComponents object containing the calendar as specified by the receiver
    ///
    public var calendar: DateComponents {
        return DateComponents(calendar: self)
    }

}


extension Int {

    /// Returns a new NSDateComponents object containing the number of nanoseconds as specified by
    /// the receiver
    ///
    public var nanoseconds: DateComponents {
        return DateComponents(nanosecond: self)
    }

    /// Returns a new NSDateComponents object containing the number of seconds as specified by the
    /// receiver
    ///
    public var seconds: DateComponents {
        return DateComponents(second: self)
    }

    /// Returns a new NSDateComponents object containing the number of minutes as specified by the
    /// receiver
    ///
    public var minutes: DateComponents {
        return DateComponents(minute: self)
    }

    /// Returns a new NSDateComponents object containing the number of hours as specified by the
    /// receiver
    ///
    public var hours: DateComponents {
        return DateComponents(hour: self)
    }

    /// Returns a new NSDateComponents object containing the number of days as specified by the
    /// receiver
    ///
    public var days: DateComponents {
        return DateComponents(day: self)
    }

    /// Returns a new NSDateComponents object containing the number of weeks as specified by the
    /// receiver
    ///
    public var weeks: DateComponents {
        return DateComponents(weekOfYear: self)
    }

    /// Returns a new NSDateComponents object containing the number of months as specified by the
    /// receiver
    ///
    public var months: DateComponents {
        return DateComponents(month: self)
    }

    /// Returns a new NSDateComponents object containing the number of years as specified by the
    /// receiver
    ///
    public var years: DateComponents {
        return DateComponents(year: self)
    }
}
