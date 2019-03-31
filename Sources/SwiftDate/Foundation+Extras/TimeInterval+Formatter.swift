//
//  TimeInterval+Formatter.swift
//  SwiftDate
//
//  Created by Daniele Margutti on 14/06/2018.
//  Copyright © 2018 SwiftDate. All rights reserved.
//

import Foundation

public extension TimeInterval {

	struct ComponentsFormatterOptions {

		/// Fractional units may be used when a value cannot be exactly represented using the available units.
		/// For example, if minutes are not allowed, the value “1h 30m” could be formatted as “1.5h”.
		/// The default value of this property is false.
		public var allowsFractionalUnits: Bool = false

		/// Specify the units that can be used in the output.
		/// By default `[.year, .month, .weekOfMonth, .day, .hour, .minute, .second]` are used.
		public var allowedUnits: NSCalendar.Unit = [.year, .month, .weekOfMonth, .day, .hour, .minute, .second]

		/// A Boolean value indicating whether to collapse the largest unit into smaller units when a certain threshold is met.
		/// By default is `false`.
		public var collapsesLargestUnit: Bool = false

		/// The maximum number of time units to include in the output string.
		/// The default value of this property is 0, which does not cause the elimination of any units.
		public var maximumUnitCount: Int = 0

		/// The formatting style for units whose value is 0.
		/// By default is `.default`
		public var zeroFormattingBehavior: DateComponentsFormatter.ZeroFormattingBehavior = .default

		/// The preferred style for units.
		/// By default is `.abbreviated`.
		public var unitsStyle: DateComponentsFormatter.UnitsStyle = .abbreviated

		/// Locale of the formatter
		public var locale: LocaleConvertible? {
			set { calendar.locale = newValue?.toLocale() }
			get { return calendar.locale }
		}

		/// Calendar
		public var calendar = Calendar.autoupdatingCurrent

		public func apply(toFormatter formatter: DateComponentsFormatter) {
			formatter.allowsFractionalUnits = allowsFractionalUnits
			formatter.allowedUnits = allowedUnits
			formatter.collapsesLargestUnit = collapsesLargestUnit
			formatter.maximumUnitCount = maximumUnitCount
			formatter.unitsStyle = unitsStyle
			formatter.calendar = calendar
		}

		public init() {}
	}

	/// Return the local thread shared formatter for date components
	private static func sharedFormatter() -> DateComponentsFormatter {
		let name = "SwiftDate_\(NSStringFromClass(DateComponentsFormatter.self))"
		return threadSharedObject(key: name, create: {
			let formatter = DateComponentsFormatter()
			formatter.includesApproximationPhrase = false
			formatter.includesTimeRemainingPhrase = false
			return formatter
		})
	}

	//@available(*, deprecated: 5.0.13, obsoleted: 5.1, message: "Use toIntervalString function instead")
	func toString(options callback: ((inout ComponentsFormatterOptions) -> Void)? = nil) -> String {
		return self.toIntervalString(options: callback)
	}

	/// Format a time interval in a string with desidered components with passed style.
	///
	/// - Parameters:
	///   - units: units to include in string.
	///   - style: style of the units, by default is `.abbreviated`
	/// - Returns: string representation
	func toIntervalString(options callback: ((inout ComponentsFormatterOptions) -> Void)? = nil) -> String {
		let formatter = TimeInterval.sharedFormatter()
		var options = ComponentsFormatterOptions()
		callback?(&options)
		options.apply(toFormatter: formatter)
		return (formatter.string(from: self) ?? "")
	}

	/// Format a time interval in a string with desidered components with passed style.
	///
	/// - Parameter options: options for formatting.
	/// - Returns: string representation
	func toString(options: ComponentsFormatterOptions) -> String {
		let formatter = TimeInterval.sharedFormatter()
		options.apply(toFormatter: formatter)
		return (formatter.string(from: self) ?? "")
	}

	/// Return a string representation of the time interval in form of clock countdown (ie. 57:00:00)
	///
	/// - Parameter zero: behaviour with zero.
	/// - Returns: string representation
	func toClock(zero: DateComponentsFormatter.ZeroFormattingBehavior = .pad) -> String {
		return toIntervalString(options: {
			$0.unitsStyle = .positional
			$0.zeroFormattingBehavior = zero
		})
	}

	/// Extract requeste time units components from given interval.
	/// Reference date's calendar is used to make the extraction.
	///
	/// NOTE:
	///		Extraction is calendar/date based; if you specify a `refDate` calculation is made
	/// 	between the `refDate` and `refDate + interval`.
	/// 	If `refDate` is `nil` evaluation is made from `now()` and `now() + interval` in the context
	/// 	of the `SwiftDate.defaultRegion` set.
	///
	/// - Parameters:
	///   - units: units to extract
	///   - from: starting reference date, `nil` means `now()` in the context of the default region set.
	/// - Returns: dictionary with extracted components
	func toUnits(_ units: Set<Calendar.Component>, to refDate: DateInRegion? = nil) -> [Calendar.Component: Int] {
		let dateTo = (refDate ?? DateInRegion())
		let dateFrom = dateTo.addingTimeInterval(-self)
		let components = dateFrom.calendar.dateComponents(units, from: dateFrom.date, to: dateTo.date)
		return components.toDict()
	}

	/// Express a time interval (expressed in seconds) in another time unit you choose.
	/// Reference date's calendar is used to make the extraction.
	///
	/// - parameter component: time unit in which you want to express the calendar component
	/// - parameter from: starting reference date, `nil` means `now()` in the context of the default region set.
	///
	/// - returns: the value of interval expressed in selected `Calendar.Component`
	func toUnit(_ component: Calendar.Component, to refDate: DateInRegion? = nil) -> Int? {
		return toUnits([component], to: refDate)[component]
	}

}
