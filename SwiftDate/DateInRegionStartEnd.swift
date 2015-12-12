//
//  DateInRegionStartEnd.swift
//  Pods
//
//  Created by Jeroen Houtzager on 26/10/15.
//
//

import Foundation

// MARK: - start of and end of operations

public extension DateInRegion {

    /// Takes a date unit and returns a date at the start of that unit.
    /// E.g. DateInRegion().startOf(.Year) would return last New Year at midnight.
    ///
    /// - Parameters:
    ///     - unit: calendrical unit.
    ///
    /// - Returns: a date at the start of the unit
    ///
    /// - note: This value is interpreted in the context of the calendar with which it is used
    ///
    public func startOf(unit: NSCalendarUnit) -> DateInRegion? {
        let absoluteTime = calendar.rangeOfUnit(unit, forDate: self.absoluteTime)!.start
        return DateInRegion(absoluteTime: absoluteTime, region: self.region)
    }
    
    /// Takes a date unit and returns a date at the end of that unit.
    /// E.g. DateInRegion().endOf(.Year) would return 31 December of this year at 23:59:59.999.
    /// That is, if a Georgian calendar is used.
    ///
    /// - Parameters:
    ///     - unit: calendrical unit.
    ///
    /// - Returns: a date at the end of the unit
    ///
    /// - note: This value is interpreted in the context of the calendar with which it is used
    ///
    public func endOf(unit: NSCalendarUnit) -> DateInRegion? {
        // RangeOfUnit returns the start of the next unit; we will subtract one thousandth of a second
        let startOfNextUnit = calendar.rangeOfUnit(unit, forDate: self.absoluteTime)!.end
        let endOfThisUnit = NSDate(timeInterval: -0.001, sinceDate: startOfNextUnit)
        return DateInRegion(absoluteTime: endOfThisUnit, region: self.region)
    }
    
}

