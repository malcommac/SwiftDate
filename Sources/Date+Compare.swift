//
//	SwiftDate, Full featured Swift date library for parsing, validating, manipulating, and formatting dates and timezones.
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

// MARK: - Date Extensions to Compare

public extension Date {
	
	/// Returns a ComparisonResult value that indicates the ordering of two given dates based on
	/// their components down to a given unit granularity. Both passed `Date` objects are expressed in
	/// passed region before doing the comparison.
	///
	/// - parameter date:        date to compare
	/// - parameter region:      region in which both dates will be expressed (if nil, defaultRegion will be used instead)
	/// - parameter granularity: The smallest unit that must, along with all larger units, be equal
	///         for the given dates to be considered the same.
	///         For possible values, see “[Calendar Units](xcdoc://?url=developer.apple.com/library/prerelease/ios/documentation/Cocoa/Reference/Foundation/Classes/NSCalendar_Class/index.html#//apple_ref/c/tdef/NSCalendarUnit)”
	///
	/// - returns: `orderedSame` if the dates are the same down to the given granularity, otherwise
	///     `orderedAscending` or `orderedDescending`.
	public func compare(to date: Date, in region: Region? = nil, granularity: Calendar.Component) -> ComparisonResult {
		let srcRegion = region ?? DateDefaultRegion
		return srcRegion.calendar.compare(self, to: date, toGranularity: granularity)
	}
	
	
	/// Compares equality of two given dates based on their components down to a given unit
	/// granularity.
	/// Both passed `Date` objects are expressed in passed region before doing the comparison.
	///
	/// - parameter date:        date to compare
	/// - parameter region:      region in which both dates will be expressed (if nil, defaultRegion will be used instead)
	/// - parameter granularity: The smallest unit that must, along with all larger units, be equal for the given
	///         dates to be considered the same.
	///
	/// - returns: `true` if the dates are the same down to the given granularity, otherwise `false`
	public func isIn(date: Date, in region: Region? = nil, granularity: Calendar.Component) -> Bool {
		return (self.compare(to: date, granularity: granularity) == .orderedSame)
	}
	
	
	/// Compares whether the receiver is before/before equal `date` based on their components down to a given
	/// unit granularity.
	///
	/// - parameter date:        date to compare
	/// - parameter orEqual:     `true` to also check for equality
	/// - parameter region:      region in which both dates will be expressed (if nil, defaultRegion will be used instead)
	/// - parameter granularity: The smallest unit that must, along with all larger units, be less for the given
	///         dates.
	///
	/// - returns: `true` if the unit of the receiver is less than the unit of `date`, otherwise
	///            `false`
	public func isBefore(date: Date, orEqual: Bool = false, in region: Region? = nil, granularity: Calendar.Component) -> Bool {
		let result = self.compare(to: date, granularity: granularity)
		return (orEqual ? (result == .orderedSame || result == .orderedAscending) : result == .orderedAscending)
	}
	
	/// Compares whether the receiver is after `date` based on their components down to a given unit
	/// granularity.
	/// Both passed `Date` objects are expressed in passed region before doing the comparison.
	///
	/// - parameter date:        date to compare
	/// - parameter orEqual:     `true` to also check for equality
	/// - parameter region:      region in which both dates will be expressed (if nil, defaultRegion will be used instead)
	/// - parameter granularity: The smallest unit that must, along with all larger units, be greater
	///
	/// - returns: `true` if the unit of the receiver is greater than the unit of `date`, otherwise
	///            `false`
	public func isAfter(date: Date, orEqual: Bool = false, in region: Region? = nil, granularity: Calendar.Component) -> Bool {
		let result = self.compare(to: date, granularity: granularity)
		return (orEqual ? (result == .orderedSame || result == .orderedDescending) : result == .orderedDescending)
	}
	
}
