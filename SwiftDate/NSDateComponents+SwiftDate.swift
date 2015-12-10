
//
//  File.swift
//  SwiftDate
//
//  Created by Jeroen Houtzager on 08/12/15.
//  Copyright © 2015 Daniele Margutti. All rights reserved.
//

import Foundation

//MARK: - Extension of Int To Manage Operations -

public extension NSDateComponents {
    
    /**
     Create a new date from a specific date by adding self components
     
     - parameter refDate: reference date
     - parameter region: optional region to define the timezone and calendar. By default is UTC DateRegion
     
     - returns: a new NSDate instance in UTC format
     */
    public func fromDate(refDate :NSDate!, inRegion region: DateRegion = DateRegion()) -> NSDate {
        let date = region.calendar.dateByAddingComponents(self, toDate: refDate, options: NSCalendarOptions(rawValue: 0))
        return date!
    }
    
    /**
     Create a new date from a specific date by subtracting self components
     
     - parameter refDate: reference date
     - parameter region: optional region to define the timezone and calendar. By default is UTC DateRegion
     
     - returns: a new NSDate instance in UTC format
     */
    public func agoFromDate(refDate :NSDate!, inRegion region: DateRegion = DateRegion()) -> NSDate {
        for unit in DateInRegion.componentFlagSet {
            let value = self.valueForComponent(unit)
            if value != NSDateComponentUndefined {
                self.setValue((value * -1), forComponent: unit)
            }
        }
        return region.calendar.dateByAddingComponents(self, toDate: refDate, options: NSCalendarOptions(rawValue: 0))!
    }
    
    /**
     Create a new date from current date and add self components.
     So you can make something like:
     let date = 4.days.fromNow()
     
     - parameter region: optional region to define the timezone and calendar. By default is UTC DateRegion
     
     - returns: a new NSDate instance in UTC format
     */
    public func fromNow(inRegion region: DateRegion = DateRegion()) -> NSDate {
        return fromDate(NSDate(), inRegion: region)
    }
    
    /**
     Create a new date from current date and substract self components
     So you can make something like:
     let date = 5.hours.ago()
     
     - parameter region: optional region to define the timezone and calendar. By default is UTC DateRegion
     
     - returns: a new NSDate instance in UTC format
     */
    public func ago(inRegion region: DateRegion = DateRegion()) -> NSDate {
        return agoFromDate(NSDate())
    }
    
    /// The same of calling fromNow() with default UTC region
    public var fromNow : NSDate {
        get {
            return fromDate(NSDate())
        }
    }
    
    /// The same of calling ago() with default UTC region
    public var ago : NSDate {
        get {
            return agoFromDate(NSDate())
        }
    }
    
    public func inRegion(region : DateRegion? = nil) -> DateInRegion? {
        if let calendar = region?.calendar {
            self.calendar = calendar
        }
        if let timeZone = region?.timeZone {
            self.timeZone = timeZone
        }
        if let locale = region?.locale {
            self.calendar?.locale = locale
        }
        let dateInRegion = DateInRegion(self)
        return dateInRegion
    }
        
}

//MARK: - Combine NSDateComponents -

public func | (lhs: NSDateComponents, rhs :NSDateComponents) -> NSDateComponents {
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

public func + (lhs: NSDateComponents, rhs: NSDateComponents) -> NSDateComponents {
    return sumDateComponents(lhs, rhs: rhs)
}

public func - (lhs: NSDateComponents, rhs: NSDateComponents) -> NSDateComponents {
    return sumDateComponents(lhs, rhs: rhs, sum: false)
}

private func sumDateComponents(lhs :NSDateComponents, rhs :NSDateComponents, sum :Bool = true) -> NSDateComponents {
    let newComponents = NSDateComponents()
    let components = DateInRegion.componentFlagSet
    for unit in components {
        let leftValue = lhs.valueForComponent(unit)
        let rightValue = rhs.valueForComponent(unit)
        
        if leftValue == NSDateComponentUndefined && rightValue == NSDateComponentUndefined {
            continue // unit we won't touch
        }
        
        if leftValue != NSDateComponentUndefined && rightValue != NSDateComponentUndefined {
            let finalValue =  ((leftValue + rightValue) * (sum == true ? 1 : -1))
            newComponents.setValue( finalValue, forComponent: unit)
        } else {
            let finalValue = ( (leftValue != NSDateComponentUndefined ? leftValue : rightValue) * (sum == true ? 1 : -1))
            newComponents.setValue(finalValue, forComponent: unit)
        }
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
    
    /// Returns a new NSDateComponents object containing the number of nanoseconds as specified by the receiver
    ///
    public var nanoseconds: NSDateComponents {
        let dateComponents = NSDateComponents()
        dateComponents.nanosecond = self
        return dateComponents
    }
    
    /// Returns a new NSDateComponents object containing the number of seconds as specified by the receiver
    ///
    public var seconds: NSDateComponents {
        let dateComponents = NSDateComponents()
        dateComponents.second = self
        return dateComponents
    }
    
    /// Returns a new NSDateComponents object containing the number of minutes as specified by the receiver
    ///
    public var minutes: NSDateComponents {
        let dateComponents = NSDateComponents()
        dateComponents.minute = self
        return dateComponents
    }
    
    /// Returns a new NSDateComponents object containing the number of hours as specified by the receiver
    ///
    public var hours: NSDateComponents {
        let dateComponents = NSDateComponents()
        dateComponents.hour = self
        return dateComponents
    }
    
    /// Returns a new NSDateComponents object containing the number of days as specified by the receiver
    ///
    public var days: NSDateComponents {
        let dateComponents = NSDateComponents()
        dateComponents.day = self
        return dateComponents
    }
    
    /// Returns a new NSDateComponents object containing the number of weeks as specified by the receiver
    ///
    public var weeks: NSDateComponents {
        let dateComponents = NSDateComponents()
        dateComponents.weekOfYear = self
        return dateComponents
    }
    
    /// Returns a new NSDateComponents object containing the number of months as specified by the receiver
    ///
    public var months: NSDateComponents {
        let dateComponents = NSDateComponents()
        dateComponents.month = self
        return dateComponents
    }
    
    /// Returns a new NSDateComponents object containing the number of years as specified by the receiver
    ///
    public var years: NSDateComponents {
        let dateComponents = NSDateComponents()
        dateComponents.year = self
        return dateComponents
    }
}




