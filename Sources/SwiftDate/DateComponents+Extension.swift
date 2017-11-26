// SwiftDate
// Manage Date/Time & Timezone in Swift
//
// Created by: Daniele Margutti
// Email: <hello@danielemargutti.com>
// Web: <http://www.danielemargutti.com>
//
// Licensed under MIT License.

import Foundation

// MARK: - DateComponents Extension

/// Invert the value expressed by a `DateComponents` instance
///
/// - parameter dateComponents: instance to invert (ie. days=5 will become days=-5)
///
/// - returns: a new `DateComponents` with inverted values
public prefix func - (dateComponents: DateComponents) -> DateComponents {
	var invertedCmps = DateComponents()
	
	DateComponents.allComponents.forEach { component in
		let value = dateComponents.value(for: component)
		if value != nil && value != Int(NSDateComponentUndefined) {
			invertedCmps.setValue(-value!, for: component)
		}
	}
	return invertedCmps
}


/// Sum two date components; allows us to make `"5.days + 3.hours"` by producing a single `DateComponents`
/// where both `.days` and `.hours` are set.
///
/// - parameter lhs: first date component
/// - parameter rhs: second date component
///
/// - returns: a new `DateComponents`
public func + (lhs: DateComponents, rhs: DateComponents) -> DateComponents {
	return lhs.add(components: rhs)
}


/// Same as su but with diff
///
/// - parameter lhs: first date component
/// - parameter rhs: second date component
///
/// - returns: a new `DateComponents`
public func - (lhs: DateComponents, rhs: DateComponents) -> DateComponents {
	return lhs.add(components: rhs, multipler: -1)
}


/// Merge two DateComponents values `(ex. a=1.hour,1.day, b=2.hour, the sum is c=3.hours,1.day)`
///
/// - Parameters:
///   - lhs: left date component
///   - rhs: right date component
/// - Returns: the sum of valid components of two instances

public func && (lhs: DateComponents, rhs: DateComponents) -> DateComponents {
	var mergedComponents = DateComponents()
	let flagSet = DateComponents.allComponents
	
	flagSet.forEach { component in
		
		func sumComponent(left: Int?, right: Int?) -> Int? {
			let leftValue = (left != nil && left != Int(NSDateComponentUndefined) ? left : nil)
			let rightValue = (right != nil && right != Int(NSDateComponentUndefined) ? right : nil)
			if leftValue == nil && rightValue == nil { return nil }
			return (leftValue ?? 0) + (rightValue ?? 0)
		}
		
		let sum = sumComponent(left: lhs.value(for: component), right: rhs.value(for: component))
		if sum != nil {
			mergedComponents.setValue(sum!, for: component)
		}
	}
	return mergedComponents
}

public extension DateComponents {
	
	
	/// A shortcut to produce a `DateInRegion` instance from an instance of `DateComponents`.
	/// It's the same of `DateInRegion(components:)` init func but it may return nil (instead of throwing an exception)
	/// if a valid date cannot be produced.
	public var dateInRegion: DateInRegion? {
		return DateInRegion(components: self)
	}
	
	
	/// Internal function helper for + and - operators between two `DateComponents`
	///
	/// - parameter components: components
	/// - parameter multipler:  optional multipler for each component
	///
	/// - returns: a new `DateComponents` instance
	internal func add(components: DateComponents, multipler: Int = 1) -> DateComponents {
		let lhs = self
		let rhs = components
		
		var newCmps = DateComponents()
		let flagSet = DateComponents.allComponents
		flagSet.forEach { component in
			let left = lhs.value(for: component)
			let right = rhs.value(for: component)
			
			if left != nil && right != nil && left != Int(NSDateComponentUndefined) && right != Int(NSDateComponentUndefined) {
				let value = left! + (right! * multipler)
				newCmps.setValue(value, for: component)
			} else {
				if left != nil && left != Int(NSDateComponentUndefined) {
					newCmps.setValue(left!, for: component)
				}
				if right != nil && right != Int(NSDateComponentUndefined) {
					newCmps.setValue(right!, for: component)
				}
			}
		}
		return newCmps
	}
	
	
	/// Transform a `DateComponents` instance to a dictionary where key is the `Calendar.Component` and value is the
	/// value associated.
	///
	/// - returns: a new `[Calendar.Component : Int]` dict representing source `DateComponents` instance
	internal func toComponentsDict() -> [Calendar.Component : Int] {
		var list: [Calendar.Component : Int] = [:]
		DateComponents.allComponents.forEach { component in
			let value = self.value(for: component)
			if value != nil && value != Int(NSDateComponentUndefined) {
				list[component] = value!
			}
		}
		return list
	}
	
}

public extension DateComponents {

	
	/// Create a new `Date` in absolute time from a specific date by adding self components
	///
	/// - parameter date:   reference date
	/// - parameter region: optional region to define the timezone and calendar. If not specified, Region.GMT() will be used instead.
	///
	/// - returns: a new `Date`
	public func from(date: Date, in region: Region? = nil) -> Date? {
		let srcRegion = region ?? Region.GMT()
		return srcRegion.calendar.date(byAdding: self, to: date)
	}
	
	/// Create a new `DateInRegion` from another `DateInRegion` by adding self components
	/// Returned object has the same `Region` of the source.
	///
	/// - parameter dateInRegion: reference `DateInRegion`
	///
	/// - returns: a new `DateInRegion`
	public func from(dateInRegion: DateInRegion) -> DateInRegion? {
		guard let absDate = dateInRegion.region.calendar.date(byAdding: self, to: dateInRegion.absoluteDate) else {
			return nil
		}
		let newDateInRegion = DateInRegion(absoluteDate: absDate, in: dateInRegion.region)
		return newDateInRegion
	}
	
	/// Create a new `Date` in absolute time from a specific date by subtracting self components
	///
	/// - parameter date:   reference date
	/// - parameter region: optional region to define the timezone and calendar. If not specific, Region.GTM() will be used instead
	///
	/// - returns: a new `Date`
	public func ago(from date: Date, in region: Region? = nil) -> Date? {
		let srcRegion = region ?? Region.GMT()
		return srcRegion.calendar.date(byAdding: -self, to: date)
	}
	
	/// Create a new `DateInRegion` from another `DateInRegion` by subtracting self components
	/// Returned object has the same `Region` of the source.
	///
	/// - parameter dateInRegion: reference `DateInRegion`
	///
	/// - returns: a new `DateInRegion`
	public func ago(fromDateInRegion date: DateInRegion) -> DateInRegion? {
		guard let absDate = date.region.calendar.date(byAdding: -self, to: date.absoluteDate) else {
			return nil
		}
		let newDateInRegion = DateInRegion(absoluteDate: absDate, in: date.region)
		return newDateInRegion
	}
	
	/// Create a new `Date` in absolute time from current date by adding self components
	///
	/// - parameter region: optional region to define the timezone and calendar. If not specified, Region.GMT() will be used instead.
	///
	/// - returns: a new `Date`
	public func fromNow(in region: Region? = nil) -> Date? {
		return self.from(date: Date(), in: region)
	}
	
	/// Create a new `DateInRegion` from current by subtracting self components
	/// Returned object has the same `Region` of the source.
	///
	/// - parameter dateInRegion: reference `DateInRegion`
	///
	/// - returns: a new `DateInRegion`
	public func ago(in region: Region? = nil) -> Date? {
		return self.ago(from: Date(), in: region)
	}
	
	/// Express a DateComponents instances in another time unit you choose
	///
	/// - parameter component: time component
	/// - parameter calendar:  context calendar to use
	///
	/// - returns: the value of interval expressed in selected `Calendar.Component`
	public func `in`(_ component: Calendar.Component, of calendar: CalendarName? = nil) -> Int? {
		let cal = calendar ?? CalendarName.current
		let dateFrom = Date()
		let dateTo: Date = dateFrom.add(components: self)
		let components: Set<Calendar.Component> = [component]
		let value = cal.calendar.dateComponents(components, from: dateFrom, to: dateTo).value(for: component)
		return value
	}
}

// MARK: - DateComponents Private Extension

extension DateComponents {
	
	
	/// Define a list of all calendar components as a set
	internal static let allComponentsSet: Set<Calendar.Component> = [.nanosecond, .second, .minute, .hour,
	                                                                 .day, .month, .year, .yearForWeekOfYear, .weekOfYear, .weekday, .quarter, .weekdayOrdinal,
	                                                                 .weekOfMonth]
	
	
	/// Define a list of all calendar components as array
	internal static let allComponents: [Calendar.Component] =  [.nanosecond, .second, .minute, .hour,
	                                                            .day, .month, .year, .yearForWeekOfYear, .weekOfYear, .weekday, .quarter, .weekdayOrdinal,
	                                                            .weekOfMonth]
}
