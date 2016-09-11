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

extension DateInRegion {

    /// Returns, as an NSDateComponents object using specified components, the difference between
    /// the receiver and the supplied date.
    ///
    /// - Parameters:
    ///     - date: a date to calculate against
    ///     - componentFlags: Specifies the components for the returned NSDateComponents object
    ///
    /// - Returns: An NSDateComponents object whose components are specified by unitFlags and
    ///     calculated from the difference between the resultDate and startDate.
    ///
    /// - note: This value is calculated in the context of the calendar of the receiver
    ///
    public func difference(to date: DateInRegion, componentFlags: Set<Calendar.Component>) -> DateComponents {
		return calendar.dateComponents(componentFlags, from: self.absoluteTime,
		                           to: date.absoluteTime)
    }

    public func add(years: Int? = nil, months: Int? = nil, weeks: Int? = nil,
        days: Int? = nil, hours: Int? = nil, minutes: Int? = nil, seconds: Int? = nil,
        nanoseconds: Int? = nil) -> DateInRegion {

        let components = DateComponents(
            year: years,
            month: months,
            day: days,
            hour: hours,
            minute: minutes,
            second: seconds,
            nanosecond: nanosecond,
            weekOfYear: weekOfYear)

        let newDate = self.add(components)
        return newDate
    }

	/**
	Add components to an existing date in region instance
	
	- parameter components: components to add
	
	- returns: return a new DateInRegion
	*/
    public func add(_ components: DateComponents) -> DateInRegion {
		let absoluteTime = region.calendar.date(byAdding: components,
		                                        to: self.absoluteTime)!
        return DateInRegion(absoluteTime: absoluteTime, region: self.region)
    }

	@available(*, deprecated: 3.0.5, message: "Use add(components) or + instead")
    public func add(components dict: [Calendar.Component : Any]) -> DateInRegion {
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
public func - (lhs: DateInRegion, rhs: DateComponents) -> DateInRegion {
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
public func + (lhs: DateInRegion, rhs: DateComponents) -> DateInRegion {
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
public prefix func - (dateComponents: DateComponents) -> DateComponents {
    var result = DateComponents()
    for component in DateInRegion.componentFlagSet {
        if let value = dateComponents.value(for: component) {
            result.setValue(-value, for: component)
        }
    }
    return result
}
