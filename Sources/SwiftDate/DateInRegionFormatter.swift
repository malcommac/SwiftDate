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
	static let none = DateZeroBehaviour(rawValue: 1)
	
	/// Units whose values are 0 are dropped starting at the beginning of the sequence until the
	/// first non-zero component
	static let dropLeading = DateZeroBehaviour(rawValue: 3)

	/// Units whose values are 0 are dropped from anywhere in the middle of a sequence.
	static let dropMiddle = DateZeroBehaviour(rawValue: 4)
	
	/// Units whose value is 0 are dropped starting at the end of the sequence back to the first
	/// non-zero component
	static let dropTrailing = DateZeroBehaviour(rawValue: 3)

	/// This behavior drops all units whose values are 0. For example, when days, hours,
	/// minutes, and seconds are allowed, the abbreviated version of one hour is displayed as “1h”.
	static let dropAll: DateZeroBehaviour = [.dropLeading,.dropMiddle,.dropTrailing]

}

//MARK: - DateInRegionFormatter

/// The DateFormatter class is used to get a string representation of a time interval between two
/// dates or a relative representation of a date

public class DateInRegionFormatter {
	
	/// Tell what kind of time units should be part of the output. Allowed values are a subset of
	/// `Calendar.Component` option set.
	/// By default is `[.year, .month, .day, .hour, .minute, .second]`
	public var allowedComponents: Set<Calendar.Component> = [.year, .month, .day, .hour, .minute, .second]

	
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
	
	/// For interval less than 5 minutes if this value is true the equivalent of 'just now' is
	/// printed in the output string. By default is `true`.
	public var useImminentInterval: Bool = true
	
	// If true numbers in timeComponents() function receive a padding if necessary
	public var zeroPadding: Bool = true
	
	/// Locale to use when print the date. By default is the same locale set by receiver's `DateInRegion`.
	/// If not set default device locale is used instead.
	public var locale: Locale?
	
	// number of a days in a week
	let DAYS_IN_WEEK = 7

	public init() {
	}
	
	/// Return the main bundle with resources used to localize time components
	private lazy var resourceBundle: Bundle? = {
		var framework = Bundle(for: DateInRegion.self)
		let path = NSURL(fileURLWithPath:
			framework.resourcePath!).appendingPathComponent("SwiftDate.bundle")
		let bundle = Bundle(url: path!)
		guard let _ = bundle else {
			return nil
		}
		return bundle!
	}()
	
	
	/// If you have specified a custom `Locale` this function return the localized bundle for this locale
	/// If no locale is specified it return the default system locale.
	///
	/// - returns: bundle where current localization strings are available
	private func localizedResourceBundle() -> Bundle? {
		guard let locale = self.locale else {
			return self.resourceBundle
		}
		
		let localeID = locale.collatorIdentifier
		guard let innerLanguagePath = self.resourceBundle!.path(forResource: localeID, ofType: "lproj") else {
			// fallback to english if language was not found
			let englishPath = self.resourceBundle!.path(forResource: "en", ofType: "lproj")!
			return Bundle(path: englishPath)
		}
		return Bundle(path: innerLanguagePath)
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
		
		if cmp.year != 0 {
			let colloquial_time = try self.colloquial_time(forUnit: .year, withValue: cmp.year!, date: fDate)
			let colloquial_date = try self.localized(unit: .year, withValue: cmp.year!, asFuture: isFuture, args: abs(fDate.year))
			return (colloquial_date,colloquial_time)
		}
		
		if cmp.month != 0 {
			let colloquial_time = try self.colloquial_time(forUnit: .month, withValue: cmp.month!, date: fDate)
			let colloquial_date = try self.localized(unit: .month, withValue: cmp.month!, asFuture: isFuture, args: abs(cmp.month!))
			return (colloquial_date,colloquial_time)
		}
		
		if abs(cmp.day!) >= DAYS_IN_WEEK {
			let colloquial_time = try self.colloquial_time(forUnit: .day, withValue: cmp.day!, date: fDate)
			let weeksNo = (abs(cmp.day!) / DAYS_IN_WEEK)
			let colloquial_date = try self.localized(unit: .weekOfYear, withValue: weeksNo, asFuture: isFuture, args: weeksNo)
			return (colloquial_date,colloquial_time)
		}
		
		if cmp.day != 0 {
			let colloquial_time = try self.colloquial_time(forUnit: .day, withValue: cmp.day!, date: fDate)
			let colloquial_date = try self.localized(unit: .day, withValue: cmp.day!, asFuture: isFuture, args: abs(cmp.day!))
			return (colloquial_date,colloquial_time)
		}
		
		if cmp.hour != 0 {
			let colloquial_time = try self.colloquial_time(forUnit: .hour, withValue: cmp.hour!, date: fDate)
			let colloquial_date = try self.localized(unit: .hour, withValue: cmp.hour!, asFuture: isFuture, args: abs(cmp.hour!))
			return (colloquial_date,colloquial_time)
		}
		
		if cmp.minute != 0 {
			if self.useImminentInterval && cmp.minute! < 5 {
				let colloquial_date = try self.stringLocalized(identifier: "colloquial_now", arguments: [])
				return (colloquial_date,nil)
			} else {
				let colloquial_date = try self.localized(unit: .minute, withValue: cmp.minute!, asFuture: isFuture, args: abs(cmp.minute!))
				return (colloquial_date,nil)
			}
		}
		
		if cmp.second != 0 || cmp.second == 0 { // Seconds difference
			let colloquial_date = try self.stringLocalized(identifier: "colloquial_now", arguments: [])
			return (colloquial_date,nil)
		}
		
		throw DateError.FailedToCalculate
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
		guard let bundle = self.localizedResourceBundle() else {
			throw DateError.MissingRsrcBundle
		}
		
		let unitStr = self.localized(unit: unit, value: value)
		let id_relative = "relevanttime_\(unitStr)"
		let relative_localized = NSLocalizedString(id_relative,
		                                           tableName: "SwiftDate",
		                                           bundle: bundle, value: "", comment: "")
		if (relative_localized as NSString).length == 0 {
			return nil
		}
		let relevant_time = date.string(format: .custom(relative_localized))
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
		guard let bundle = self.localizedResourceBundle() else {
			throw DateError.MissingRsrcBundle
		}

		let future_key = (asFuture ? "f" : "p")

		let unitStr = self.localized(unit: unit, value: value)
		let identifier = "colloquial_\(future_key)_\(unitStr)"
		let localized_date = withVaList(args) { (pointer: CVaListPointer) -> String in
			let localized = NSLocalizedString(identifier, tableName: "SwiftDate", bundle: bundle, value: "", comment: "")
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
		guard let bundle = self.localizedResourceBundle() else {
			throw DateError.MissingRsrcBundle
		}
		var localized_str = NSLocalizedString(identifier, tableName: "SwiftDate", bundle: bundle, comment: "")
		localized_str = String(format: localized_str, arguments: arguments)
		return localized_str
	}
	
	
	/// Return the localized identifier of a calendar component
	///
	/// - parameter unit:  unit
	/// - parameter value: value
	///
	/// - returns: return the plural or singular form of the time unit used to compose a valid identifier for search a localized
	///   string in resource bundle
	private func localized(unit: Calendar.Component, value: Int) -> String {
		let absValue = abs(value)
		switch unit {
		case .year:			return (absValue == 1 ? "y" : "yy")
		case .month:		return (absValue == 1 ? "m" : "mm")
		case .weekOfYear:	return (absValue == 1 ? "w" : "ww")
		case .day:			return (absValue == 1 ? "d" : "dd")
		case .hour:			return (absValue == 1 ? "h" : "hh")
		case .minute:		return (absValue == 1 ? "M" : "MM")
		case .second:		return (absValue == 1 ? "s" : "ss")
		default:			return ""
		}
	}
}
