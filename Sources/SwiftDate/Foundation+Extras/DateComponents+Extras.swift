//
//  SwiftDate
//  Parse, validate, manipulate, and display dates, time and timezones in Swift
//
//  Created by Daniele Margutti
//   - Web: https://www.danielemargutti.com
//   - Twitter: https://twitter.com/danielemargutti
//   - Mail: hello@danielemargutti.com
//
//  Copyright © 2019 Daniele Margutti. Licensed under MIT License.
//

import Foundation

// MARK: - Date Components Extensions

public extension Calendar.Component {

	/// Return a description of the calendar component in seconds.
	/// Note: 	Values for `era`,`weekday`,`weekdayOrdinal`, `yearForWeekOfYear`, `calendar`, `timezone` are `nil`.
	/// 		For `weekOfYear` it return the same value of `weekOfMonth`.
	var timeInterval: Double? {
		switch self {
		case .era: 						return nil
		case .year: 					return (Calendar.Component.day.timeInterval! * 365.0)
		case .month: 					return (Calendar.Component.minute.timeInterval! * 43800)
		case .day: 						return 86400
		case .hour: 					return 3600
		case .minute: 					return 60
		case .second: 					return 1
		case .quarter: 					return (Calendar.Component.day.timeInterval! * 91.25)
		case .weekOfMonth, .weekOfYear: return (Calendar.Component.day.timeInterval! * 7)
		case .nanosecond: 				return 1e-9
		default: 						return nil
		}
	}

	/// Return the localized identifier of a calendar component
	///
	/// - parameter unit:  unit
	/// - parameter value: value
	///
	/// - returns: return the plural or singular form of the time unit used to compose a valid identifier for search a localized
	///   string in resource bundle
	internal func localizedKey(forValue value: Int) -> String {
		let locKey = localizedKey
		let absValue = abs(value)
		switch absValue {
		case 0: // zero difference for this unit
			return "0\(locKey)"
		case 1: // one unit of difference
			return locKey
		default: // more than 1 unit of difference
			return "\(locKey)\(locKey)"
		}
	}

	internal var localizedKey: String {
		switch self {
		case .year:			return "y"
		case .month:		return "m"
		case .weekOfYear:	return "w"
		case .day:			return "d"
		case .hour:			return "h"
		case .minute:		return "M"
		case .second:		return "s"
		default:
			return ""
		}
	}

}

public extension DateComponents {

	/// Shortcut for 'all calendar components'.
	static var allComponentsSet: Set<Calendar.Component> {
		return [.era, .year, .month, .day, .hour, .minute,
				.second, .weekday, .weekdayOrdinal, .quarter,
				.weekOfMonth, .weekOfYear, .yearForWeekOfYear,
				.nanosecond, .calendar, .timeZone]
	}

	internal static let allComponents: [Calendar.Component] =  [.nanosecond, .second, .minute, .hour,
																.day, .month, .year, .yearForWeekOfYear,
																.weekOfYear, .weekday, .quarter, .weekdayOrdinal,
																.weekOfMonth]

	/// This function return the absolute amount of seconds described by the components of the receiver.
	/// Note: 	evaluated value maybe not strictly exact because it ignore the context (calendar/date) of
	/// 		the date components. In details:
	/// 		- The following keys are ignored: `era`,`weekday`,`weekdayOrdinal`,
	///				`weekOfYear`, `yearForWeekOfYear`, `calendar`, `timezone
	///
	/// Some other values dependant from dates are fixed. This is a complete table:
	///			- `year` is 365.0 `days`
	///			- `month` is 30.4167 `days` (or 43800 minutes)
	///			- `quarter` is 91.25 `days`
	///			- `weekOfMonth` is 7 `days`
	///			- `day` is 86400 `seconds`
	///			- `hour` is 3600 `seconds`
	///			- `minute` is 60 `seconds`
	///			- `nanosecond` is 1e-9 `seconds`
	var timeInterval: TimeInterval {
		var totalAmount: TimeInterval = 0
		DateComponents.allComponents.forEach {
			if let multipler = $0.timeInterval, let value = value(for: $0), value != Int(NSDateComponentUndefined) {
				totalAmount += (TimeInterval(value) * multipler)
			}
		}
		return totalAmount
	}

	/// Create a new `DateComponents` instance with builder pattern.
	///
	/// - Parameter builder: callback for builder
	/// - Returns: new instance
	static func create(_ builder: ((inout DateComponents) -> Void)) -> DateComponents {
		var components = DateComponents()
		builder(&components)
		return components
	}

	/// Return the current date plus the receive's interval
	/// The default calendar used is the `SwiftDate.defaultRegion`'s calendar.
	var fromNow: Date {
		return SwiftDate.defaultRegion.calendar.date(byAdding: (self as DateComponents) as DateComponents, to: Date() as Date)!
	}

	/// Returns the current date minus the receiver's interval
	/// The default calendar used is the `SwiftDate.defaultRegion`'s calendar.
	var ago: Date {
		return SwiftDate.defaultRegion.calendar.date(byAdding: -self as DateComponents, to: Date())!
	}

	/// - returns: the date that will occur once the receiver's components pass after the provide date.
	func from(_ date: DateRepresentable) -> Date? {
		return date.calendar.date(byAdding: self, to: date.date)
	}

	/// Return `true` if all interval components are zeroes
	var isZero: Bool {
		for component in DateComponents.allComponents {
			if let value = value(for: component), value != 0 {
				return false
			}
		}
		return true
	}

	/// Transform a `DateComponents` instance to a dictionary where key is the `Calendar.Component` and value is the
	/// value associated.
	///
	/// - returns: a new `[Calendar.Component : Int]` dict representing source `DateComponents` instance
	internal func toDict() -> [Calendar.Component: Int] {
		var list: [Calendar.Component: Int] = [:]
		DateComponents.allComponents.forEach { component in
			let value = self.value(for: component)
			if value != nil && value != Int(NSDateComponentUndefined) {
				list[component] = value!
			}
		}
		return list
	}

	/// Alter date components specified into passed dictionary.
	///
	/// - Parameter components: components dictionary with their values.
	internal mutating func alterComponents(_ components: [Calendar.Component: Int?]) {
		components.forEach {
			if let v = $0.value {
				setValue(v, for: $0.key)
			}
		}
	}

	/// Adds two NSDateComponents and returns their combined individual components.
	static func + (lhs: DateComponents, rhs: DateComponents) -> DateComponents {
		return combine(lhs, rhs: rhs, transform: +)
	}

	/// Subtracts two NSDateComponents and returns the relative difference between them.
	static func - (lhs: DateComponents, rhs: DateComponents) -> DateComponents {
		return lhs + (-rhs)
	}

	/// Applies the `transform` to the two `T` provided, defaulting either of them if it's
	/// `nil`
	internal static func bimap<T>(_ a: T?, _ b: T?, default: T, _ transform: (T, T) -> T) -> T? {
		if a == nil && b == nil { return nil }
		return transform(a ?? `default`, b ?? `default`)
	}

	/// - returns: a new `NSDateComponents` that represents the negative of all values within the
	/// components that are not `NSDateComponentUndefined`.
	static prefix func - (rhs: DateComponents) -> DateComponents {
		var components = DateComponents()
		components.era = rhs.era.map(-)
		components.year = rhs.year.map(-)
		components.month = rhs.month.map(-)
		components.day = rhs.day.map(-)
		components.hour = rhs.hour.map(-)
		components.minute = rhs.minute.map(-)
		components.second = rhs.second.map(-)
		components.nanosecond = rhs.nanosecond.map(-)
		components.weekday = rhs.weekday.map(-)
		components.weekdayOrdinal = rhs.weekdayOrdinal.map(-)
		components.quarter = rhs.quarter.map(-)
		components.weekOfMonth = rhs.weekOfMonth.map(-)
		components.weekOfYear = rhs.weekOfYear.map(-)
		components.yearForWeekOfYear = rhs.yearForWeekOfYear.map(-)
		return components
	}

	/// Combines two date components using the provided `transform` on all
	/// values within the components that are not `NSDateComponentUndefined`.
	private static func combine(_ lhs: DateComponents, rhs: DateComponents, transform: (Int, Int) -> Int) -> DateComponents {
		var components = DateComponents()
		components.era = bimap(lhs.era, rhs.era, default: 0, transform)
		components.year = bimap(lhs.year, rhs.year, default: 0, transform)
		components.month = bimap(lhs.month, rhs.month, default: 0, transform)
		components.day = bimap(lhs.day, rhs.day, default: 0, transform)
		components.hour = bimap(lhs.hour, rhs.hour, default: 0, transform)
		components.minute = bimap(lhs.minute, rhs.minute, default: 0, transform)
		components.second = bimap(lhs.second, rhs.second, default: 0, transform)
		components.nanosecond = bimap(lhs.nanosecond, rhs.nanosecond, default: 0, transform)
		components.weekday = bimap(lhs.weekday, rhs.weekday, default: 0, transform)
		components.weekdayOrdinal = bimap(lhs.weekdayOrdinal, rhs.weekdayOrdinal, default: 0, transform)
		components.quarter = bimap(lhs.quarter, rhs.quarter, default: 0, transform)
		components.weekOfMonth = bimap(lhs.weekOfMonth, rhs.weekOfMonth, default: 0, transform)
		components.weekOfYear = bimap(lhs.weekOfYear, rhs.weekOfYear, default: 0, transform)
		components.yearForWeekOfYear = bimap(lhs.yearForWeekOfYear, rhs.yearForWeekOfYear, default: 0, transform)
		return components
	}

	/// Subscription support for `DateComponents` instances.
	/// ie. `cmps[.day] = 5`
	///
	/// Note: This does not take into account any built-in errors, `Int.max` returned instead of `nil`.
	///
	/// - Parameter component: component to get
	subscript(component: Calendar.Component) -> Int? {
		switch component {
		case .era: 					return era
		case .year: 				return year
		case .month: 				return month
		case .day: 					return day
		case .hour: 				return hour
		case .minute: 				return minute
		case .second: 				return second
		case .weekday: 				return weekday
		case .weekdayOrdinal: 		return weekdayOrdinal
		case .quarter: 				return quarter
		case .weekOfMonth: 			return weekOfMonth
		case .weekOfYear:	 		return weekOfYear
		case .yearForWeekOfYear: 	return yearForWeekOfYear
		case .nanosecond: 			return nanosecond
		default: 					return nil // `calendar` and `timezone` are ignored in this context
		}
	}

	/// Express a `DateComponents` instance in another time unit you choose.
	///
	/// - parameter component: time component
	/// - parameter calendar:  context calendar to use
	///
	/// - returns: the value of interval expressed in selected `Calendar.Component`
	func `in`(_ component: Calendar.Component, of calendar: CalendarConvertible? = nil) -> Int? {
		let cal = (calendar?.toCalendar() ?? SwiftDate.defaultRegion.calendar)
		let dateFrom = Date()
		let dateTo = (dateFrom + self)
		let components: Set<Calendar.Component> = [component]
		let value = cal.dateComponents(components, from: dateFrom, to: dateTo).value(for: component)
		return value
	}

	/// Express a `DateComponents` instance in a set of time units you choose.
	///
	/// - Parameters:
	///   - component: time component
	///   - calendar: context calendar to use
	/// - Returns: a dictionary of extract values.
	func `in`(_ components: Set<Calendar.Component>, of calendar: CalendarConvertible? = nil) -> [Calendar.Component: Int] {
		let cal = (calendar?.toCalendar() ?? SwiftDate.defaultRegion.calendar)
		let dateFrom = Date()
		let dateTo = (dateFrom + self)
		let extractedCmps = cal.dateComponents(components, from: dateFrom, to: dateTo)
		return extractedCmps.toDict()
	}
}
