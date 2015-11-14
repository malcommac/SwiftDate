//
//  DateInRegionOperations.swift
//  Pods
//
//  Created by Jeroen Houtzager on 26/10/15.
//
//

import Foundation

// MARK: - Operators

public extension DateInRegion {

    /// Returns, as an NSDateComponents object using specified components, the difference between the receiver and the supplied date.
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
        return calendar.components(unitFlags, fromDate: self.date, toDate: toDate.date, options: NSCalendarOptions(rawValue: 0))
    }

    /// Returns a new DateInRegion object representing the absolute time calculated by adding given components to the receiver.
    ///
    /// - Parameters:
    ///     - components: the components to add to the receiver
    ///
    /// - Returns: A new DateInRegion object representing the absolute time calculated by adding to date the calendrical components specified by components.
    ///
    /// - note: This value is calculated in the context of the calendar of the receiver
    ///
    internal func addComponents(components: NSDateComponents) -> DateInRegion? {
        let newDate = calendar.dateByAddingComponents(components, toDate: self.date, options: NSCalendarOptions(rawValue: 0))
        guard newDate != nil else {
            return nil
        }
        return DateInRegion(date: newDate!, region: region)
    }
}

/// Returns a new DateInRegion object representing a new time calculated by subtracting given right hand components from the left hand date.
///
/// - Parameters:
///     - lhs: the date to subtract components from
///     - rhs: the components to subtract from the date
///
/// - Returns: A new DateInRegion object representing the time calculated by subtracting from date the calendrical components specified by components.
///
/// - note: This value is calculated in the context of the calendar of the date
///
public func - (lhs: DateInRegion, rhs: NSDateComponents) -> DateInRegion? {
    return lhs + (-rhs)
}

/// Returns a new DateInRegion object representing a new time calculated by adding given right hand components to the left hand date.
///
/// - Parameters:
///     - lhs: the date to add the components to
///     - rhs: the components to add to the date
///
/// - Returns: A new DateInRegion object representing the time calculated by adding to date the calendrical components specified by components.
///
/// - note: This value is calculated in the context of the calendar of the date
///
public func + (lhs: DateInRegion, rhs: NSDateComponents) -> DateInRegion? {
    return lhs.addComponents(rhs)
}


/// Returns a new NSDateComponents object representing the negative values of components that are submitted
///
/// - Parameters:
///     - dateComponents: the components to process
///
/// - Returns: A new NSDateComponents object representing the negative values of components that are submitted
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

// MARK: - Helpers to enable expressions e.g. date + 1.days - 20.seconds

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


