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

public extension NSDateComponents {

    /**
     Create a new date from a specific date by adding self components

     - parameter refDate: reference date
     - parameter region: optional region to define the timezone and calendar. By default is local
        region

     - returns: a new NSDate instance
     */
    public func fromDate(refDate: NSDate!, inRegion region: Region = Region()) -> NSDate {
        let date = region.calendar.dateByAddingComponents(self, toDate: refDate,
            options: NSCalendarOptions(rawValue: 0))
        return date!
    }

    /**
     Create a new date from a specific date by subtracting self components

     - parameter refDate: reference date
     - parameter region: optional region to define the timezone and calendar. By default is local
        region

     - returns: a new NSDate instance
     */
    public func agoFromDate(refDate: NSDate!, inRegion region: Region = Region()) -> NSDate {
        for unit in DateInRegion.componentFlagSet {
            let value = self.valueForComponent(unit)
            if value != NSDateComponentUndefined {
                self.setValue((value * -1), forComponent: unit)
            }
        }
        return region.calendar.dateByAddingComponents(self, toDate: refDate,
            options: NSCalendarOptions(rawValue: 0))!
    }

    /**
     Create a new date from current date and add self components.
     So you can make something like:
     let date = 4.days.fromNow()

     - parameter region: optional region to define the timezone and calendar. By default is local
        Region

     - returns: a new NSDate instance
     */
    public func fromNow(inRegion region: Region = Region()) -> NSDate {
        return fromDate(NSDate(), inRegion: region)
    }

    /**
     Create a new date from current date and substract self components
     So you can make something like:
     let date = 5.hours.ago()

     - parameter region: optional region to define the timezone and calendar. By default is local
            Region

     - returns: a new NSDate instance
     */
    public func ago(inRegion region: Region = Region()) -> NSDate {
        return agoFromDate(NSDate())
    }

    /// The same of calling fromNow() with default local region
    public var fromNow: NSDate {
        get {
            return fromDate(NSDate())
        }
    }

    /// The same of calling ago() with default local region
    public var ago: NSDate {
        get {
            return agoFromDate(NSDate())
        }
    }

    /// The dateInRegion for the current components
    public var dateInRegion: DateInRegion? {
        return DateInRegion(self)
    }

}

//MARK: - Combine NSDateComponents -

public func | (lhs: NSDateComponents, rhs: NSDateComponents) -> NSDateComponents {
    let dc = NSDateComponents()
    for unit in DateInRegion.componentFlagSet {
        let lhs_value = lhs.valueForComponent(unit)
        let rhs_value = rhs.valueForComponent(unit)
        if lhs_value != NSDateComponentUndefined {
            dc.setValue(lhs_value, forComponent: unit)
        }
        if rhs_value != NSDateComponentUndefined {
            dc.setValue(rhs_value, forComponent: unit)
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
public func + (lhs: NSDateComponents, rhs: NSDateComponents) -> NSDateComponents {
    return sumDateComponents(lhs, rhs: rhs)
}

/// subtract date components from one another
///
/// - parameters:
///     - lhs: left hand side argument
///     - rhs: right hand side argument
///
/// - returns: date components lhs - rhs
///
public func - (lhs: NSDateComponents, rhs: NSDateComponents) -> NSDateComponents {
    return sumDateComponents(lhs, rhs: rhs, sum: false)
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
internal func sumDateComponents(lhs: NSDateComponents, rhs: NSDateComponents, sum: Bool = true) ->
    NSDateComponents {

    let newComponents = NSDateComponents()
    let components = DateInRegion.componentFlagSet
    for unit in components {
        let leftValue = lhs.valueForComponent(unit)
        let rightValue = rhs.valueForComponent(unit)

        guard leftValue != NSDateComponentUndefined || rightValue != NSDateComponentUndefined else {
            continue // both are undefined, don't touch
        }

        let checkedLeftValue = leftValue == NSDateComponentUndefined ? 0 : leftValue
        let checkedRightValue = rightValue == NSDateComponentUndefined ? 0 : rightValue

        let finalValue =  checkedLeftValue + (sum ? checkedRightValue : -checkedRightValue)
        newComponents.setValue(finalValue, forComponent: unit)
    }
    return newComponents
}

// MARK: - Helpers to enable expressions e.g. date + 1.days - 20.seconds

public extension NSTimeZone {

    /// Returns a new NSDateComponents object containing the time zone as specified by the receiver
    ///
    public var timeZone: NSDateComponents {
        let dateComponents = NSDateComponents()
        dateComponents.timeZone = self
        return dateComponents
    }

}


public extension NSCalendar {

    /// Returns a new NSDateComponents object containing the calendar as specified by the receiver
    ///
    public var calendar: NSDateComponents {
        let dateComponents = NSDateComponents()
        dateComponents.calendar = self
        return dateComponents
    }

}


public extension Int {

    /// Returns a new NSDateComponents object containing the number of nanoseconds as specified by
    /// the receiver
    ///
    public var nanoseconds: NSDateComponents {
        let dateComponents = NSDateComponents()
        dateComponents.nanosecond = self
        return dateComponents
    }

    /// Returns a new NSDateComponents object containing the number of seconds as specified by the
    /// receiver
    ///
    public var seconds: NSDateComponents {
        let dateComponents = NSDateComponents()
        dateComponents.second = self
        return dateComponents
    }

    /// Returns a new NSDateComponents object containing the number of minutes as specified by the
    /// receiver
    ///
    public var minutes: NSDateComponents {
        let dateComponents = NSDateComponents()
        dateComponents.minute = self
        return dateComponents
    }

    /// Returns a new NSDateComponents object containing the number of hours as specified by the
    /// receiver
    ///
    public var hours: NSDateComponents {
        let dateComponents = NSDateComponents()
        dateComponents.hour = self
        return dateComponents
    }

    /// Returns a new NSDateComponents object containing the number of days as specified by the
    /// receiver
    ///
    public var days: NSDateComponents {
        let dateComponents = NSDateComponents()
        dateComponents.day = self
        return dateComponents
    }

    /// Returns a new NSDateComponents object containing the number of weeks as specified by the
    /// receiver
    ///
    public var weeks: NSDateComponents {
        let dateComponents = NSDateComponents()
        dateComponents.weekOfYear = self
        return dateComponents
    }

    /// Returns a new NSDateComponents object containing the number of months as specified by the
    /// receiver
    ///
    public var months: NSDateComponents {
        let dateComponents = NSDateComponents()
        dateComponents.month = self
        return dateComponents
    }

    /// Returns a new NSDateComponents object containing the number of years as specified by the
    /// receiver
    ///
    public var years: NSDateComponents {
        let dateComponents = NSDateComponents()
        dateComponents.year = self
        return dateComponents
    }
}
