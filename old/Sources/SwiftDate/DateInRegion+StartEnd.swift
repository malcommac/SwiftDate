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
    public func startOf(unit: NSCalendarUnit) -> DateInRegion {
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
    public func endOf(unit: NSCalendarUnit) -> DateInRegion {
        // RangeOfUnit returns the start of the next unit; we will subtract one thousandth of a
        // second
        let startOfNextUnit = calendar.rangeOfUnit(unit, forDate: self.absoluteTime)!.end
        let endOfThisUnit = NSDate(timeInterval: -0.001, sinceDate: startOfNextUnit)
        return DateInRegion(absoluteTime: endOfThisUnit, region: self.region)
    }

}
