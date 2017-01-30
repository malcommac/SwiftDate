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

//MARK: - DateZeroBehaviour OptionSet

/// Define how the formatter must work when values contain zeroes.
public struct DateZeroBehaviour: OptionSet {
	public let rawValue: Int
	
	public init(rawValue: Int) {
		self.rawValue = rawValue
	}
	
	/// None, it does not remove components with zero values
	public static let none = DateZeroBehaviour(rawValue: 1)
	
	/// Units whose values are 0 are dropped starting at the beginning of the sequence until the
	/// first non-zero component
	public static let dropLeading = DateZeroBehaviour(rawValue: 3)

	/// Units whose values are 0 are dropped from anywhere in the middle of a sequence.
	public static let dropMiddle = DateZeroBehaviour(rawValue: 4)
	
	/// Units whose value is 0 are dropped starting at the end of the sequence back to the first
	/// non-zero component
	public static let dropTrailing = DateZeroBehaviour(rawValue: 3)

	/// This behavior drops all units whose values are 0. For example, when days, hours,
	/// minutes, and seconds are allowed, the abbreviated version of one hour is displayed as “1h”.
	public static let dropAll: DateZeroBehaviour = [.dropLeading,.dropMiddle,.dropTrailing]

}

//MARK: - DateInRegionFormatter

/// The DateFormatter class is used to get a string representation of a time interval between two
/// dates or a relative representation of a date

public class DateInRegionFormatter {
	
	/// Tell what kind of time units should be part of the output. Allowed values are a subset of
	/// `Calendar.Component` option set.
	/// By default is `[.year, .month, .day, .hour, .minute, .second]`
	public var allowedComponents: Set<Calendar.Component> = [.year, .month, .day, .hour, .minute, .second]

	private var timeOrderedComponents: [Calendar.Component] = [.year, .month, .day, .hour, .minute, .second, .nanosecond]
	
	/// How the formatter threat zero components. Default implementation drop all zero values from
	/// the output string.
	public var zeroBehavior: DateZeroBehaviour = .dropAll

	/// Number of units to print from the higher to the lower. Default is unlimited, all values
	/// could be part of the output. By default no limit is set (`nil`).
	public var maxComponentCount: Int?

	/// Described the style in which each unit will be printed out. Default is `.full`
	public var unitStyle: DateComponentsFormatter.UnitsStyle = .full
	
	/// This describe the separator string between each component when you print data in non
	/// colloquial format. Default is `,`.
	public var unitSeparator: String = ","
	
	/// Imminent interval defines the smaller time interval (expressed in minutes) under which a
	/// time difference fallback to `just now`.
	/// Set this variable to `nil` disable automatic fallback.
	/// Supported values must between `1` and `59`. Other values are ignored.
	/// By default value is set to 5: if differences between two dates is less than 5 minutes it just fallback to `just now` formatters.
	public var imminentInterval: Int? = 5
	
	// If true numbers in timeComponents() function receive a padding if necessary
	public var zeroPadding: Bool = true
	
	/// Locale to use when print the date.
	/// By default is the same locale set by receiver's `DateInRegion`.
	/// If not set default device locale is used instead.
	/// You can also customize the source by giving a path to a custom `.strings` file (via `Localization(path: <pathtofile>)`)
	public var localization = Localization(locale: nil)
	
	// number of a days in a week
	let DAYS_IN_WEEK = 7

	public init() {
	}
	
	/// String representation of an absolute interval expressed in seconds.
	/// For example "4 days" or "33s".
	///
	/// - parameter interval: interval in seconds
	///
	/// - throws: throw `.MissingRsrcBundle` if required localized string are missing from the SwiftDate bundle
	///
	/// - returns: time components string
	public func timeComponents(interval: TimeInterval) throws  -> String {
		let UTCRegion = Region(tz: TimeZoneName.gmt, cal: CalendarName.current, loc: LocaleName.current)
		let date = Date()
		let fromDate = DateInRegion(absoluteDate: date.addingTimeInterval(-interval), in: UTCRegion)
		let toDate = DateInRegion(absoluteDate: date, in: UTCRegion)
		return try self.timeComponents(from: fromDate, to: toDate)
	}
	
	
	/// String representation of the interval between two dates printed in terms of time unit components.
	/// For example "3 days" or "4d, 5h" etc.
	///
	/// - parameter from: first date
	/// - parameter to:   date to compare
	///
	/// - throws: throw `.DifferentCalendar` if dates are expressed in a different calendar, `.MissingRsrcBundle` if
	///   required localized string are missing from the SwiftDate bundle
	///
	/// - returns: time components string
	public func timeComponents(from: DateInRegion, to: DateInRegion) throws -> String {
		guard from.region.calendar == to.region.calendar else {
			throw DateError.DifferentCalendar
		}
		let cal = from.region.calendar
		
		let componentFlags: [Calendar.Component] = [.year, .month, .day, .hour, .minute, .second]
		var output: [String] = []
		var nonZeroUnitFound: Int = 0
		
		var intervalIsNegative = false

		let cmps = cal.dateComponents(allowedComponents, from: from.absoluteDate, to: to.absoluteDate)
		for component in componentFlags {
			let value = cmps.value(for: component)
			
			if value != nil && value != Int(NSDateComponentUndefined) && value! < 0 {
				intervalIsNegative = true
			}
				
			let isValueZero = (value != nil && value! == 0)
			let willDrop =	(isValueZero == true && self.zeroBehavior == .dropAll) ||
							(self.zeroBehavior == .dropLeading && nonZeroUnitFound == 0) ||
							(self.zeroBehavior == .dropMiddle)
			if willDrop == false {
				var cmp = DateComponents()
				cmp.setValue(abs(value!), for: component)
				let localizedUnit = DateComponentsFormatter.localizedString(from: cmp, unitsStyle: unitStyle)!
				output.append(localizedUnit)
			}
			
			nonZeroUnitFound += (isValueZero == false ? 1 : 0)
			// limit the number of values to show
			if maxComponentCount != nil && nonZeroUnitFound == maxComponentCount! {
				break
			}
		}
		return (intervalIsNegative ? "-" : "") + output.joined(separator: self.unitSeparator)
	}
	
	/// Print a colloquial representation of the difference between two dates.
	/// For example "1 year ago", "just now", "3s" etc.
	///
	/// - parameter fDate: date a
	/// - parameter tDate: date b
	///
	/// - throws: throw `.DifferentCalendar` if dates are expressed in a different calendar, `.MissingRsrcBundle` if
	///   required localized string are missing from the SwiftDate bundle
	///
	/// - returns: a colloquial string representing the difference between two dates
	public func colloquial(from fDate: DateInRegion, to tDate: DateInRegion) throws -> (colloquial: String, time: String?) {
		guard fDate.region.calendar == tDate.region.calendar else {
			throw DateError.DifferentCalendar
		}
		let cal = fDate.region.calendar
		let cmp = cal.dateComponents(self.allowedComponents, from: fDate.absoluteDate, to: tDate.absoluteDate)
		let isFuture = (fDate > tDate)
		
		if cmp.year != nil && (cmp.year != 0 || !hasLowerAllowedComponents(than: .year)) {
			let colloquial_time = try self.colloquial_time(forUnit: .year, withValue: cmp.year!, date: fDate)
			let colloquial_date = try self.localized(unit: .year, withValue: cmp.year!, asFuture: isFuture, args: abs(fDate.year))
			return (colloquial_date,colloquial_time)
		}
		
		if cmp.month != nil && (cmp.month != 0 || !hasLowerAllowedComponents(than: .month)) {
			let colloquial_time = try self.colloquial_time(forUnit: .month, withValue: cmp.month!, date: fDate)
			let colloquial_date = try self.localized(unit: .month, withValue: cmp.month!, asFuture: isFuture, args: abs(cmp.month!))
			return (colloquial_date,colloquial_time)
		}
		
		if cmp.day != nil {
			if abs(cmp.day!) >= DAYS_IN_WEEK {
				let colloquial_time = try self.colloquial_time(forUnit: .day, withValue: cmp.day!, date: fDate)
				let weeksNo = (abs(cmp.day!) / DAYS_IN_WEEK)
				let colloquial_date = try self.localized(unit: .weekOfYear, withValue: weeksNo, asFuture: isFuture, args: weeksNo)
				return (colloquial_date,colloquial_time)
			}
			
			if cmp.day != 0 || !hasLowerAllowedComponents(than: .day) {
				// case 1: > 0 days difference
				// case 2: same day difference and no lower time components to print (-> today)
				let colloquial_time = try self.colloquial_time(forUnit: .day, withValue: cmp.day!, date: fDate)
				let colloquial_date = try self.localized(unit: .day, withValue: cmp.day!, asFuture: isFuture, args: abs(cmp.day!))
				return (colloquial_date,colloquial_time)
			}
		}
		
		if cmp.hour != nil && (cmp.hour != 0 || !hasLowerAllowedComponents(than: .hour)) {
			let colloquial_time = try self.colloquial_time(forUnit: .hour, withValue: cmp.hour!, date: fDate)
			let colloquial_date = try self.localized(unit: .hour, withValue: cmp.hour!, asFuture: isFuture, args: abs(cmp.hour!))
			return (colloquial_date,colloquial_time)
		}
		
		if cmp.minute != nil && (cmp.minute != 0 || !hasLowerAllowedComponents(than: .minute)) {
			if let value = self.imminentInterval, (value > 1 && value < 60), (abs(cmp.minute!) < value) {
				// A valid `imminentInterval` should be set. Valid interval must be between 1 and 60 minutes (not inclueded)
				let colloquial_date = try self.stringLocalized(identifier: "colloquial_now", arguments: [])
				return (colloquial_date,nil)
			}
			// otherwise fallback to difference
			let colloquial_date = try self.localized(unit: .minute, withValue: cmp.minute!, asFuture: isFuture, args: abs(cmp.minute!))
			return (colloquial_date,nil)
		}
		
		if cmp.second != nil && (cmp.second != 0 || cmp.second == 0) { // Seconds difference
			let colloquial_date = try self.stringLocalized(identifier: "colloquial_now", arguments: [])
			return (colloquial_date,nil)
		}
		
		throw DateError.FailedToCalculate
	}
	
	
	/// Return `true` if time components lower than given `component` are part of the `allowedComponents`
	/// of the formatter.
	///
	/// - Parameter component: target components
	/// - Returns: true or false
	private func hasLowerAllowedComponents(than component: Calendar.Component) -> Bool {
		guard let fIndex = timeOrderedComponents.index(of: component) else {
			// this should happend only if calendar component is not part of allowed components
			// so, in fact, this should not never happends
			return false
		}
		guard (timeOrderedComponents.count - 1) - fIndex > 0 else {
			return false // no other lower time components to check
		}
		for idx in fIndex+1..<timeOrderedComponents.count {
			if self.allowedComponents.contains(timeOrderedComponents[idx]) == true {
				return true // there is a lower component to check
			}
		}
		return false
	}
	
	/// Return a localized representation of a value for a particular calendar component
	///
	/// - parameter unit:  calendar unit to evaluate
	/// - parameter value: value associated
	/// - parameter date:  reference date
	///
	/// - throws: throw `.MissingRsrcBundle` if required localized string are missing from the SwiftDate bundle
	///
	/// - returns: a localized representation of time interval in term of passed calendar component
	private func colloquial_time(forUnit unit: Calendar.Component, withValue value: Int, date: DateInRegion) throws -> String? {
		let unitStr = unit.localizedKey(forValue: value)
		let id_relative = "relevanttime_\(unitStr)"
		let relative_localized = self.localization.get(id_relative, default: "")
		if (relative_localized as NSString).length == 0 {
			return nil
		}
		let localeDate = DateInRegion(absoluteDate: date.absoluteDate,
		                              in: Region(tz: date.region.timeZone,
		                                         cal: date.region.calendar,
		                                         loc: self.localization.locale ?? date.region.locale))
		let relevant_time = localeDate.string(format: .custom(relative_localized))
		return relevant_time
	}
	
	
	/// Return the colloquial representation of a value for a particular calendar component
	///
	/// - parameter unit:     unit of calendar component
	/// - parameter value:    the value associated with the unit
	/// - parameter asFuture: `true` if  value referred to a future, `false` if it's a past event
	/// - parameter args:     variadic arguments to append
	///
	/// - throws: throw `.MissingRsrcBundle` if required localized string are missing from the SwiftDate bundle
	///
	/// - returns: localized colloquial string with passed unit of time
	private func localized(unit: Calendar.Component, withValue value: Int, asFuture: Bool, args: CVarArg...) throws -> String {
		let future_key = (value == 0 ? "n" : (asFuture ? "f" : "p"))

		let unitStr = unit.localizedKey(forValue: value)
		let identifier = "colloquial_\(future_key)_\(unitStr)"
		let localized_date = withVaList(args) { (pointer: CVaListPointer) -> String in
			let localized = self.localization.get(identifier, default: "")
			return NSString(format: localized, arguments: pointer) as String
		}
		return localized_date
	}
	
	/// Helper methods to print a localized string with variadic number of arguments
	///
	/// - parameter identifier: identifier of the string into localized table file
	/// - parameter arguments:  arguments to append
	///
	/// - throws: throw `.MissingRsrcBundle` if required localized string are missing from the SwiftDate bundle
	///
	/// - returns: localized string with arguments
	private func stringLocalized(identifier: String, arguments: CVarArg...) throws -> String {
		var localized_str = self.localization.get(identifier, default: "")
		localized_str = String(format: localized_str, arguments: arguments)
		return localized_str
	}
}

internal extension Calendar.Component {
	
	/// Return the localized identifier of a calendar component
	///
	/// - parameter unit:  unit
	/// - parameter value: value
	///
	/// - returns: return the plural or singular form of the time unit used to compose a valid identifier for search a localized
	///   string in resource bundle
	internal func localizedKey(forValue value: Int) -> String {
		let locKey = self.localizedKey
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
