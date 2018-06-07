//
//  Date+Operations.swift
//  SwiftDate
//
//  Created by Daniele Margutti on 06/06/2018.
//  Copyright © 2018 SwiftDate. All rights reserved.
//

import Foundation

public extension Date {
	
	/// Return the oldest date in given list.
	///
	/// - Parameter list: list of dates
	/// - Returns: a tuple with the index of the oldest date and its instance.
	public static func oldestIn(list: [Date]) -> Date? {
		guard list.count > 0 else { return nil }
		guard list.count > 1 else { return list.first! }
		return list.min(by: {
			return $0 < $1
		})
	}
	
	/// Return the oldest date in given list.
	///
	/// - Parameter list: list of dates
	/// - Returns: a tuple with the index of the oldest date and its instance.
	public static func newestIn(list: [Date]) -> Date? {
		guard list.count > 0 else { return nil }
		guard list.count > 1 else { return list.first! }
		return list.max(by: {
			return $0 < $1
		})
	}
	
	/// Enumerate dates between two intervals by adding specified time components and return an array of dates.
	/// `startDate` interval will be the first item of the resulting array.
	/// The last item of the array is evaluated automatically and maybe not equal to `endDate`.
	///
	/// - Parameters:
	///   - start: starting date
	///   - endDate: ending date
	///   - increment: components to add
	/// - Returns: array of dates
	public static func enumerateDates(from startDate: Date, to endDate: Date, increment: DateComponents) -> [Date] {
		var dates: [Date] = []
		var currentDate = startDate
		
		while (currentDate <= endDate) {
			dates.append(currentDate)
			currentDate = (currentDate + increment)
		}
		return dates
	}
	
	/// Round a given date time to the passed style (off|up|down).
	///
	/// - Parameter style: rounding mode.
	/// - Returns: rounded date
	public func dateRoundedAt(at style: RoundDateMode) -> Date {
		return self.inDefaultRegion().dateRoundedAt(style).date
	}
	
	/// Returns a new DateInRegion that is initialized at the start of a specified unit of time.
	///
	/// - Parameter unit: time unit value.
	/// - Returns: instance at the beginning of the time unit; `self` if fails.
	public func dateAtStartOf(_ unit: Calendar.Component) -> Date {
		return self.inDefaultRegion().dateAtStartOf(unit).date
	}
	
	/// Returns a new Moment that is initialized at the end of a specified unit of time.
	///
	/// - parameter unit: A TimeUnit value.
	///
	/// - returns: A new Moment instance.
	public func dateAtEndOf(_ unit: Calendar.Component) -> Date {
		return self.inDefaultRegion().dateAtEndOf(unit).date
	}
	
	/// Create a new date by altering specified components of the receiver.
	///
	/// - Parameter components: components to alter with their new values.
	/// - Returns: new altered `DateInRegion` instance
	public func dateBySet(_ components: [Calendar.Component: Int]) -> Date? {
		return DateInRegion(self, region: SwiftDate.defaultRegion).dateBySet(components)?.date
	}
	
	/// Create a new date by altering specified time components.
	///
	/// - Parameters:
	///   - hour: hour to set (`nil` to leave it unaltered)
	///   - min: min to set (`nil` to leave it unaltered)
	///   - secs: sec to set (`nil` to leave it unaltered)
	/// - Returns: new altered `DateInRegion` instance
	public func dateBySet(hour: Int?, min: Int?, secs: Int?) -> Date? {
		return DateInRegion(self, region: SwiftDate.defaultRegion).dateBySet([.hour : hour, .minute: min, .second: secs])?.date
	}
	
	/// Creates a new instance by truncating the components
	///
	/// - Parameter components: components to truncate.
	/// - Returns: new date with truncated components.
	public func dateTruncated(_ components: [Calendar.Component]) -> Date? {
		return DateInRegion(self, region: SwiftDate.defaultRegion).dateTruncated(at: components)?.date
	}
	
	/// Creates a new instance by truncating the components starting from given components down the granurality.
	///
	/// - Parameter component: The component to be truncated from.
	/// - Returns: new date with truncated components.
	public func dateTruncated(from component: Calendar.Component) -> Date? {
		return DateInRegion(self, region: SwiftDate.defaultRegion).dateTruncated(from: component)?.date
	}
	
	/// Offset a date by n calendar components.
	/// Note: This operation can be functionally chained.
	///
	/// - Parameters:
	///   - count: value of the offset.
	///   - component: component to offset.
	/// - Returns: new altered date.
	public func dateByAdding(_ count: Int, _ component: Calendar.Component) -> DateInRegion {
		return DateInRegion(self, region: SwiftDate.defaultRegion).dateByAdding(count, component)
	}
	
	
	/// Return related date starting from the receiver attributes.
	///
	/// - Parameter type: related date to obtain.
	/// - Returns: instance of the related date.
	public func dateAt(_ type: DateRelatedType) -> Date {
		return self.inDefaultRegion().dateAt(type).date
	}
}
