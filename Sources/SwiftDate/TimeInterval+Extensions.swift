// SwiftDate
// Manage Date/Time & Timezone in Swift
//
// Created by: Daniele Margutti
// Email: <hello@danielemargutti.com>
// Web: <http://www.danielemargutti.com>
//
// Licensed under MIT License.

import Foundation

// MARK: - TimeInterval Extension

public extension TimeInterval {
	
	/// Express given time interval in other time units.
	/// If a reference date (`fromDate`) is not specified conversion is aware of day light saving times and other possible nasty things
	/// (only `day`,`hour`,`minute`,`second` are supported as components).
	/// If a reference date is specified conversion is made using the interval from passed reference date and include calendar/date
	/// specific events.
	///
	///
	/// - Parameters:
	///   - components: components to extract
	///   - date: reference date; `nil` uses absolute conversion, valida date to set the interval from a specific date.
	///   - calendar: context calendar; `nil` uses `Date.DefaultRegion.calendar` instead
	/// - Returns: components
	public func `in`(_ components: [Calendar.Component], fromDate date: Date? = nil, of calendar: Calendar? = nil) -> [Calendar.Component : Int] {
		guard let refDate = date else {
			// Absolute conversion, not taking care of specific starting date
			let days = Int( (components.contains(.day) ? self / (60 * 60 * 24) : 0) )
			let hours = Int((components.contains(.hour) ? ((self / (60 * 60)) - (Double(days) * 24)) : 0))
			let minutes = Int( (components.contains(.minute) ? ((self / 60) - (Double(days) * 24 * 60) - (Double(hours) * 60)) : 0))
			let seconds = Int( (components.contains(.second) ? Int(self.truncatingRemainder(dividingBy: 60)) : 0))
			
			var components: [Calendar.Component : Int] = [:]
			if (days > 0) 		{ components[.day] = Int(days) }
			if (hours > 0) 		{ components[.hour] = Int(hours) }
			if (minutes > 0)	{ components[.minute] = Int(minutes) }
			if (seconds > 0)	{ components[.second] = Int(seconds) }
			return components
		}
		
		let cal = calendar ?? Date.defaultRegion.calendar
		let dateFrom: Date = refDate
		let dateTo: Date = dateFrom.addingTimeInterval(self)
		let cmps = cal.dateComponents(componentsToSet(components), from: dateFrom, to: dateTo)
		return cmps.toComponentsDict()
	}
	
	/// Express a time interval (expressed in seconds) in another time unit you choose
	///
	/// - parameter component: time unit in which you want to express the calendar component
	/// - parameter calendar:  context calendar to use. `nil` uses `Date.DefaultRegion.calendar` instead
	///
	/// - returns: the value of interval expressed in selected `Calendar.Component`
	public func `in`(_ component: Calendar.Component, fromDate date: Date? = nil, of calendar: Calendar? = nil) -> Int? {
		return self.in([component], fromDate: date, of: calendar)[component]
	}
	
	/// Represent a time interval in a string
	///
	/// - parameter options: to print the string. If not specified a new general options struct is created for you.
	/// - parameter shared: `true` if you want to use the local thread shared `DateComponentsFormatter` instance.
	///           if not strictly necessary you should avoid creating a new formatter instance at each call, so using
	///           the shared instance is a better choice. By default is `true`
	///
	/// - throws: throw an exception if output string cannot be produced
	///
	/// - returns: a string representing the time interval
	public func string(options: ComponentsFormatterOptions? = nil, shared: Bool? = true) throws -> String {
		return try self.formatComponentsIn(interval: self, shared: shared, options: options)
	}

	/// Private function to create a shared or new instance of the `DateComponentsFormatter` and set it with
	/// passed options dictionary (if not nil)
	internal func formatComponentsIn(interval: TimeInterval, shared: Bool? = true, options: ComponentsFormatterOptions? = nil) throws -> String {
		var formatter: DateComponentsFormatter? = nil
		let sharedFormatter = shared ?? true
		if sharedFormatter == true {
			let name = "SwiftDate_\(NSStringFromClass(DateIntervalFormatter.self))"
			formatter = localThreadSingleton(key: name, create: { () -> DateComponentsFormatter in
				return DateComponentsFormatter()
			})
		} else {
			formatter = DateComponentsFormatter()
		}
		if options != nil {
			formatter!.calendar!.locale = options!.locale
			formatter!.zeroFormattingBehavior = options!.zeroBehavior
			formatter!.maximumUnitCount = (options!.maxUnitCount == nil ? 0 : options!.maxUnitCount!)
			formatter!.unitsStyle = options!.style
			formatter!.includesTimeRemainingPhrase = options!.includeTimeRemaining
			formatter!.allowedUnits = options!.allowedUnits ?? options!.bestAllowedUnits(forInterval: interval)
		}
	
		guard let output = formatter!.string(from: self) else {
			throw DateError.FailedToCalculate
		}
		return output
	}
	

}

internal func componentsToSet(_ src: [Calendar.Component]) -> Set<Calendar.Component> {
	var l: Set<Calendar.Component> = []
	src.forEach { l.insert($0) }
	return l
}
