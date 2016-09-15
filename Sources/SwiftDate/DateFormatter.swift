//
//  SwiftDate, an handy tool to manage date and timezones in swift
//  Created by: Daniele Margutti
//  Main contributors: Jeroen Houtzager
//
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import Foundation

// MARK: - DateFormatter Supporting Data -

// swiftlint:disable file_length

/**
 Constants for specifying how to spell out unit names.

 - Positional   A style that uses the position of a unit to identify its value and
 commonly used for time values where components are separated by colons (“1:10:00”)
 - Abbreviated  The abbreviated style represents the shortest spelling for unit values
 (ie. “1h 10m”)
 - Short            A style that uses the short spelling for units (ie. “1hr 10min”)
 - Full             A style that spells out the units fully (ie. “1 hour, 10 minutes”)
 - Colloquial   For some relevant intervals this style print out a more colloquial string
 representation (ie last moth
 */
public enum DateFormatterComponentsStyle {
    case positional
    case abbreviated
    case short
    case full
    case colloquial

    public var localizedCode: String {
        switch self {
        case .positional: 	return "positional"
        case .abbreviated: 	return "abbreviated"
        case .short: 		return "short"
        case .full: 		return "full"
        case .colloquial: 	return "colloquial"
        }
    }

	internal func toNSDateFormatterStyle() -> DateComponentsFormatter.UnitsStyle? {
		switch self {
		case .positional: 	return .positional
		case .abbreviated: 	return .abbreviated
		case .short: 		return .short
		case .full: 		return .full
		case .colloquial: 	return nil
		}
	}
}

/**
 *  Define how the formatter must work when values contain zeroes.
 */
public struct DateZeroBehavior: OptionSet {
    public let rawValue: Int
    public init(rawValue: Int) { self.rawValue = rawValue }

    // None, it does not remove components with zero values
    static let none = DateZeroBehavior(rawValue:1)

    // Units whose values are 0 are dropped starting at the beginning of the sequence until the
    // first non-zero component
    static var dropLeading = DateZeroBehavior(rawValue:3)

    // Units whose values are 0 are dropped from anywhere in the middle of a sequence.
    static var dropMiddle = DateZeroBehavior(rawValue:4)

    // Units whose value is 0 are dropped starting at the end of the sequence back to the first
    // non-zero component
    static var dropTrailing = DateZeroBehavior(rawValue:5)

    // This behavior drops all units whose values are 0. For example, when days, hours,
    // minutes, and seconds are allowed, the abbreviated version of one hour is displayed as “1h”.
    static var dropAll: DateZeroBehavior = [dropLeading, dropMiddle, dropTrailing]
}

//MARK: - DateFormatter Class -

/// The DateFormatter class is used to get a string representation of a time interval between two
/// dates or a relative representation of a date
public class DateFormatter {

    /// Described the style in which each component will be printed out. Default is `.full`
    public var componentsStyle: DateFormatterComponentsStyle = .full

	/// This describe the separator string between each component when you print data in non
    /// colloquial format. Default is `,`
	public var componentsSeparator: String = ","

    /// Tell what kind of time units should be part of the output. Allowed values are a subset of
    /// the `Calendar.Component` mask
    /// .year, .month, .day, .hour, .minute, .second are supported (default values enable all of
    /// them)
    public var allowedComponents: Set<Calendar.Component> = [.year, .month, .day, .hour, .minute, .second]

    /// Number of components to print from the higher to the lower. Default is unlimited, all values
    /// could be part of the output
    public var maxComponentCount: Int?

    /// How the formatter threat zero components. Default implementation drop all zero values from
    /// the output string
    public var zeroBehavior: DateZeroBehavior = .dropAll

    /// If .unitStyle is .Colloquial you can include relevant date/time formatting to append after
    /// the colloquial representation
    /// For years it may print the month, for weeks or days it may print the hour:minute of the
    /// date. Default is false.
    public var includeRelevantTime: Bool = false

    /// For interval less than 5 minutes if this value is true the equivalent of 'just now' is
    /// printed in the output string
    public var fallbackToNow: Bool = false

    /// This is the bundle where the localized data is placed
    private lazy var bundle: Bundle? = {
        var frameworkBundle = Bundle(for: DateFormatter.self)
		if frameworkBundle == nil { frameworkBundle = Bundle.main }
		if frameworkBundle == nil { return nil }
		let path = NSURL(fileURLWithPath:
            frameworkBundle.resourcePath!).appendingPathComponent("SwiftDate.bundle")
        let bundle = Bundle(url: path!)
        return bundle
    }()

	public init(componentsStyle style: DateFormatterComponentsStyle = .full) {
		self.componentsStyle = style
    }

    /**
     Print the string representation of the interval amount (in seconds) since/to now. It supports
     both negative and positive values.

     - parameter interval: interval of time in seconds

     - returns: output string representation of the interval
     */
    public func toString(interval: TimeInterval) -> String? {
        let region_utc = Region(timeZoneName: TimeZoneName.gmt)
        let fromDate = DateInRegion(absoluteTime: Date(timeIntervalSinceNow: -interval),
                                    region: region_utc)
        let toDate = DateInRegion(absoluteTime: Date(), region: region_utc)
        return self.toString(fromDate: fromDate, toDate: toDate)
    }

    /**
     Print the representation of the interval between two dates.

     - parameter fromDate: source date
     - parameter toDate: end date

     - returns: output string representation of the interval
     */
    public func toString(fromDate: DateInRegion, toDate: DateInRegion) -> String? {
        guard fromDate.calendar.identifier == toDate.calendar.identifier else {
            return nil
        }
        if componentsStyle == .colloquial {
            return toColloquialString(from: fromDate, to: toDate)
        } else {
            return toComponentsString(from: fromDate, to: toDate)
        }
    }

    //MARK: Private Methods

    /**
     This method output the colloquial representation of the interval between two dates. You will
     not call it from the extern.

     - parameter fromDate: source date
     - parameter toDate: end date

     - returns: output string representation of the interval
     */
    // swiftlint:disable:next function_body_length
    private func toColloquialString(from fromDate: DateInRegion, to toDate: DateInRegion)
        -> String? {

            // Get the components of the date. Date must have the same parent calendar type in
            // order to be compared
            let cal = fromDate.calendar
            let components = cal.dateComponents(allowedComponents, from: fromDate.absoluteTime, to: toDate.absoluteTime)
            let isFuture = fromDate > toDate

            if components.year != 0 { // Years difference
                let value = Int(abs(Int32(components.year!)))
                let relevant_str = relevantTimeForUnit(unit: .year, date: fromDate, value: value)
				return colloquialString(unit: .year, isFuture: isFuture,
                                               value: value, relevantStr: relevant_str,
                                                             args: fromDate.year)
            }

            if components.month != 0 { // Months difference
				let value = Int(abs(Int32(components.month!)))
                let relevant_str = relevantTimeForUnit(unit: .month, date: fromDate, value: value)
                return colloquialString(unit: .month, isFuture: isFuture,
                                                value: value,
                                                relevantStr: relevant_str, args: value)
            }

            // Weeks difference
			let daysInWeek = fromDate.calendar.range(of: .day, in: .weekOfMonth,
			                                         for: fromDate.absoluteTime)!.count
            if (components.day)! >= daysInWeek {
                let weeksNumber = abs((components.day)! / daysInWeek)
                let relevant_str = relevantTimeForUnit(unit: .weekOfYear, date: fromDate,
                                                                    value: weeksNumber)
                return colloquialString(unit: .weekOfYear, isFuture: isFuture,
                                                     value: weeksNumber,
                                                     relevantStr: relevant_str, args: weeksNumber)
            }

            if components.day != 0 { // Days difference
				let value = Int(abs(Int32(components.day!)))
                let relevant_str = relevantTimeForUnit(unit: .day, date: fromDate, value: Int(value))
                return colloquialString(unit: .day, isFuture: isFuture,
                                              value: value, relevantStr: relevant_str, args: value)
            }

            if components.hour != 0 { // Hours difference
				let value = Int(abs(Int32(components.hour!)))
                let relevant_str = relevantTimeForUnit(unit: .hour, date: fromDate, value: Int(value))
				return colloquialString(unit: .hour, isFuture: isFuture,
                                               value: value, relevantStr: relevant_str, args: value)
            }

            if components.minute != 0 { // Minutes difference
				let value = Int(abs(Int32(components.minute!)))
                let relevant_str = relevantTimeForUnit(unit: .minute, date: fromDate, value: Int(value))
                if self.fallbackToNow == true && (components.minute)! < 5 {
                    // Less than 5 minutes ago is 'just now'
					return sd_localizedString(identifier: "colloquial_now", arguments: [])
                }
				return colloquialString(unit: .minute, isFuture: isFuture,
                                                 value: value, relevantStr: relevant_str,
                                                               args: value)
            }

            if components.second != 0 { // Seconds difference
				return sd_localizedString(identifier: "colloquial_now", arguments: [])
            }

            // Fallback to components output
            return self.toComponentsString(from: fromDate, to: toDate)
    }

    /**
     String representation between two dates by printing difference in term of each time unit
     component

     - parameter fDate: from date
     - parameter tDate: to date

     - returns: representation string
     */
	private func toComponentsString(from fDate: DateInRegion, to tDate: DateInRegion)
        -> String? {
		let cal = fDate.calendar
			let cmps = cal.dateComponents(allowedComponents, from: fDate.absoluteTime,
			                              to: tDate.absoluteTime)

		let componentFlags: [Calendar.Component] = [.year, .month, .day, .hour, .minute, .second]
		var outputUnits: [String] = []
		var nonZeroUnitFound: Int = 0
		var isNegative: Bool? = nil

		for component in componentFlags {
			let componentValue = cmps.value(for: component)!

			if isNegative == nil && componentValue < 0 {
				isNegative = true
			}

			// Drop zero (all, leading, middle)
			let shouldDropZero = (componentValue == 0 && (zeroBehavior == .dropAll
                || zeroBehavior == .dropLeading && nonZeroUnitFound == 0
                || zeroBehavior == .dropMiddle))
			if shouldDropZero == false {
				var cmp = DateComponents()
				cmp.setValue( abs(componentValue), for: component)
				let str = DateComponentsFormatter.localizedString(from: cmp,
                    unitsStyle: componentsStyle.toNSDateFormatterStyle()!)!
				outputUnits.append(str)
			}

			nonZeroUnitFound += (componentValue != 0 ? 1 : 0)
			// limit the number of values to show
			if maxComponentCount != nil && nonZeroUnitFound == maxComponentCount! {
				break
			}
		}

		return (isNegative == true ? "-" : "") + outputUnits.joined(separator: self.componentsSeparator)
	}

        /**
     Return the colloquial string representation of a time unit

     - parameters:
        - unit: unit of time
        - fromDate: target date to use
        - value: value of the unit
        - relevantStr: relevant time string to append at the end of the ouput
        - args: arguments to add into output string placeholders

     - returns: value
     */
    private func colloquialString(unit: Calendar.Component, isFuture: Bool, value: Int,
                 relevantStr: String?, args: CVarArg...) -> String {
        guard let bundle = self.bundle else { return "" }
        let unit_id = unit.localizedCode(value: value)
        let locale_time_id = (isFuture ? "f" : "p")
        let identifier = "colloquial_\(locale_time_id)_\(unit_id)"

        let localized_date = withVaList(args) { (pointer: CVaListPointer) -> NSString in
            let localized = NSLocalizedString(identifier, tableName: "SwiftDate", bundle: bundle,
                                                        value: "", comment: "")
            return NSString(format: localized, arguments: pointer)
        }

        return (relevantStr != nil ? "\(localized_date) \(relevantStr!)" : localized_date as String) as String
    }

    /**
     Get the relevant time string to append for a specified time unit difference

     - parameter unit: unit of time
     - parameter date: target date
     - parameter value: value of the unit

     - returns: relevant time string
     */
    private func relevantTimeForUnit(unit: Calendar.Component, date: DateInRegion,
                 value: Int) -> String? {

        if !self.includeRelevantTime {
            return nil
        }
        guard let bundle = self.bundle else {
            return String()
        }

        let unit_id = unit.localizedCode(value: value)
        let id_relative = "relevanttime_\(unit_id)"
        let relative_localized = NSLocalizedString(id_relative,
                                                   tableName: "SwiftDate",
                                                   bundle: bundle, value: "", comment: "")
        if (relative_localized as NSString).length == 0 {
            return nil
        }
        let relevant_time = date.toString(dateFormat: DateFormat.custom(relative_localized))
        return relevant_time
    }

    /**
     Get the localized string for a specified identifier string

     - parameter identifier: string to search in localized bundles
     - parameter arguments: arguments to add (or [] if no arguments are needed)

     - returns: localized string with optional arguments values filled
     */
    private func sd_localizedString(identifier: String, arguments: CVarArg...) -> String {
        guard let frameworkBundle = Bundle(identifier: "com.danielemagutti.SwiftDate") else {
            return ""
        }
        let path = NSURL(fileURLWithPath: frameworkBundle.resourcePath!)
            .appendingPathComponent("SwiftDate.bundle")
        guard let bundle = Bundle(url: path!) else {
            return ""
        }
        var localized_str = NSLocalizedString(identifier, tableName: "SwiftDate",
                                                bundle: bundle, comment: "")
        localized_str = String(format: localized_str, arguments: arguments)
        return localized_str
    }

}

//MARK: - Foundation.Calendar.Component Extension -

extension Calendar.Component {

    /**
     Return the localized symbols for each time unit. Singular form is 'X', plural variant is 'XX'

     - parameter value: value of the unit unit (used to get the singular/plural variant)

     - returns: code in localization table
     */
    public func localizedCode(value: Int) -> String {
        switch self {
        case .year: return (value == 1 ? "y" : "yy")
        case .month: return (value == 1 ? "m" : "mm")
        case .weekOfYear: return (value == 1 ? "w" : "ww")
        case .day: return (value == 1 ? "d" : "dd")
        case .hour: return (value == 1 ? "h" : "hh")
        case .minute: return (value == 1 ? "M" : "MM")
        case .second: return (value == 1 ? "s" : "ss")
        default: return ""
        }
    }

}

//MARK: - Supporting Structures -

/**
 * This struct encapulate the information about the difference between two dates for a specified
 * unit of time.
 */
private struct DateFormatterValue: CustomStringConvertible {
    private var name: String
    private var value: Int
    private var separator: String

    fileprivate var description: String {
        return "\(value)\(separator)\(name)"
    }
}
