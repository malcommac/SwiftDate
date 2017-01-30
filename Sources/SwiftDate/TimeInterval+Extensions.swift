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

// MARK: - TimeInterval Extension

public extension TimeInterval {
	
	/// Express a time interval (expressed in seconds) in one or more time units you choose.
	/// For example you can express "3605" seconds in ".hours = 2, .minutes = 5".
	///
	/// - parameter components: components in which you want to express the time interval
	/// - parameter calendar:   context calendar to use
	///
	/// - returns: a `[Calendar.Component: Int]` which contains the unit in which you want to express the time interval
	public func `in`(_ components: [Calendar.Component], of calendar: CalendarName? = nil) -> [Calendar.Component : Int] {
		let cal = calendar ?? CalendarName.current
		let dateTo = Date()
		let dateFrom: Date = dateTo.addingTimeInterval(-self)
		let cmps = cal.calendar.dateComponents(componentsToSet(components), from: dateFrom, to: dateTo)
		return cmps.toComponentsDict()
	}
	
	
	/// Express a time interval (expressed in seconds) in another time unit you choose
	///
	/// - parameter component: time unit in which you want to express the calendar component
	/// - parameter calendar:  context calendar to use
	///
	/// - returns: the value of interval expressed in selected `Calendar.Component`
	public func `in`(_ component: Calendar.Component, of calendar: CalendarName? = nil) -> Int? {
		let cal = calendar ?? CalendarName.current
		let dateTo = Date()
		let dateFrom: Date = dateTo.addingTimeInterval(-self)
		let components: Set<Calendar.Component> = [component]
		let value = cal.calendar.dateComponents(components, from: dateFrom, to: dateTo).value(for: component)
		return value
	}

	/// Represent a time interval in a string
	///
	/// - parameter unitStyle: unit style of the output
	/// - parameter max:       max number of components to print
	/// - parameter zero:      how to threat wuth zero values
	/// - parameter separator: separator between components
	/// - parameter locale:    locale to use
	///
	/// - throws: throw an exception if output string cannot be produced
	///
	/// - returns: a string representing the time interval
	@available(*, deprecated: 4.0.3, message: "Use string(options:) instead")
	public func string(unitStyle: DateComponentsFormatter.UnitsStyle = .short, max: Int? = nil, zero: DateZeroBehaviour? = nil, separator: String? = nil, locale: Locale? = nil) throws -> String? {
		let formatter = DateInRegionFormatter()
		formatter.localization = Localization(locale: locale)
		formatter.maxComponentCount = max
		formatter.unitStyle = unitStyle
		formatter.zeroBehavior = zero ?? .dropAll
		formatter.unitSeparator = separator ?? ","
		return try formatter.timeComponents(interval: self)
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
			formatter = localThreadSingleton(key: name, create: { (Void) -> DateComponentsFormatter in
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
