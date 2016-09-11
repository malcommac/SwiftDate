//
//	SwiftDate, an handy tool to manage date and timezones in swift
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
import Swift

/// Return the current thread's `Foundation.DateComponentsFormatter` instance. This component is used
/// internally. When using it be sure to call `beginSessionContext(create:)` method to preserve and
/// restore configuration of the object.
///
///- returns: an instance of the formatter
///
internal func sharedDateComponentsFormatter() -> DateComponentsFormatter {
	let name = "SwiftDate_\(NSStringFromClass(DateComponentsFormatter.self))"
	return threadLocalObj(key: name, create: { (Void) -> DateComponentsFormatter in
		return DateComponentsFormatter()
	})
}

/// Return the current thread's `Foundation.DateFormatter` instance. This component is used internally.
/// When using it be sure to call `beginSessionContext(create:)` method to preserve and restore
/// configuration of the object.
///
/// - returns: an instance of the formatter
///
internal func sharedDateFormatter() -> FoundationDateFormatter {
	let name = "SwiftDate_\(NSStringFromClass(FoundationDateFormatter.self))"
	return threadLocalObj(key: name, create: { (Void) -> FoundationDateFormatter in
		return FoundationDateFormatter()
	})
}

/// Provide a mechanism to create and return local-thread object you can share.
///
/// Basically you assign a key to the object and return the initializated instance in `create`
/// block. Again this code is used internally to provide a common way to create local-thread date
/// formatter as like `NSDateFormatter` (which is expensive to create) or
/// `Foundation.DateComponentsFormatter`.
/// Instance is saved automatically into current thread own dictionary.
///
/// - parameter key:    identification string of the object
/// - parameter create: creation block. At the end of the block you need to provide the instance you
///     want to save.
///
/// - returns: the instance you have created into the current thread
///
internal func threadLocalObj<T>(key: String, create: (Void) -> T) -> T {
	if let cachedObj = Thread.current.threadDictionary[key] as? T {
		return cachedObj
	} else {
		let newObject = create()
		Thread.current.threadDictionary[key] = newObject
		return newObject
	}
}


//MARK: - FormatterStyle -

/// This structure is used to encapsulate all attributes you can use to specify the formatting
/// behavior of a string or an interval of time. You need to provide it when you want to convert an
/// `Date`, `DateInRegion` or a `TimeInterval` instance into a colloquial representation.
///
public struct FormatterStyle {
	/// Configure the strings to use for unit names such as days, hours, minutes and seconds.
	/// Use this property to specify the style of abbreviations used to identify each time
    /// component. By default the value of this property is .Abbreviated; so for example, one hour
    /// and ten minutes is displayed as “1h 10m”.
	public var style: DateComponentsFormatter.UnitsStyle = .abbreviated

	/// The bitmask of calendrical components such as day and month to include in the output string.
    /// By default all available values are
	/// used; this means each component of time is part of the output string if the relative value is not
    /// zero.
    ///
	/// You can use:
	///	* `year`
	///	* `month`
	///	* `weekOfMonth`
	///	* `day`
	///	* `hour`
	///	* `minute`
	///	* `second`
	///
	/// Any other value of the `Foundation.Calendar.Component` enum will result in an exception.
	public var components: Set<Calendar.Component>

	/// This property can be used to limit the number of units displayed in the resulting string.
    /// For example if set to 2, instead of “1h 10m, 30s” the output string will be “1h 10m”. You
    /// can use it to provide a round up version of the output when you are constrained.
    ///
	public var maxComponents: Int = 0

	/// Setting the value of this property to `true` adds phrasing to output strings to reflect
    /// that the given time value is approximate and not exact.
	/// Using this property yields more correct phrasing than simply prepending the string “About”
    /// to an output string.
	/// By default is set to `false`
	public var approximate: Bool = false

	/// Setting this property to `true` results in output strings like “30 minutes remaining”.
	/// The default value of this property is `false`.
	public var approximatePast: Bool = false

	/// An example of when this property might apply is when expressing 63 seconds worth of time.
	/// When this property is set to `true`, the formatted value would be “63s”. When the value of
    /// this property is `false`,
	/// the formatted value would be “1m 3s”.
	/// By default is set to `false`
	public var collapsesLargestUnit: Bool = false

	/// This specify the behavior of the formatter when it encounter a zero value for a
    /// particular unit of time.
	public var zeroBehavior: DateComponentsFormatter.ZeroFormattingBehavior = .default

    ///	Initialize a new `FormatterStyle` struct you can use to format a `Date`,`DateInRegion` or
    /// `TimeInterval`
    ///
    ///	- parameter style: abbreviations you could use to format each time unit of the output string
    ///   (by default `.Abbreviated` form is used)
    ///	- parameter components: units you want to include in output string (by default all values are
    ///     set)
    ///	- parameter max: number of units you wan to include in ouput string (by default is `0` and
    ///     means: do not omit anything)
    ///
    public init(style: DateComponentsFormatter.UnitsStyle = .abbreviated,
        components: Set<Calendar.Component>? = nil, max: Int = 0) {

		self.style = style
		self.components = components ?? [.year, .month, .weekOfMonth, .day, .hour, .minute, .second]
		self.maxComponents = max
	}

	internal func restoreInto(formatter: DateComponentsFormatter) {
		formatter.unitsStyle = self.style
        formatter.allowedUnits = { () -> NSCalendar.Unit in
            var units = NSCalendar.Unit()
            self.components.forEach { units.insert(NSCalendar.Unit(rawValue: $0.rawValue)) }
            return units
        }()
		formatter.maximumUnitCount = self.maxComponents
		formatter.includesApproximationPhrase = self.approximate
		formatter.includesTimeRemainingPhrase = self.approximatePast
		formatter.zeroFormattingBehavior = self.zeroBehavior
		formatter.collapsesLargestUnit = self.collapsesLargestUnit
	}

	internal init(formatter: DateComponentsFormatter) {
		self.style = formatter.unitsStyle
        self.components = { () -> Set<Calendar.Component> in
            var components = Set<Calendar.Component>()
            for offset in 1...17 {
                let rawValue = UInt(1 << offset)
                if let component = Calendar.Component(rawValue: rawValue),
                    formatter.allowedUnits.contains(NSCalendar.Unit(rawValue: rawValue)) {
                    components.insert(component)
                }
            }
            return components
        }()
		self.maxComponents = formatter.maximumUnitCount
		self.approximate = formatter.includesApproximationPhrase
		self.approximatePast = formatter.includesTimeRemainingPhrase
		self.zeroBehavior = formatter.zeroFormattingBehavior
		self.collapsesLargestUnit = formatter.collapsesLargestUnit
	}
}

//MARK: - DateComponentsFormatter -

internal extension DateComponentsFormatter {


    /// This method is used to provide a session context to create and use an instance of
    /// `DateComponentsFormatter` by preserving pre-task configuration. When you start a new
    /// session the current attributes of the instance are saved automatically and restored at the
    /// end of the session. We have this function because a single `DateComponentsFormatter` is
    /// shared along a thread. *You don't need to use it externally so it's a private method *.
    ///
    ///	- parameter block: block to execute your formast operation. It could return something
    ///
    ///	- returns: the result of the operation
    ///
    func beginSessionContext<T>(block: (Void) -> (T?)) -> T? {
		let saved_cfg = FormatterStyle(formatter: self)
		let block_result = block()
		saved_cfg.restoreInto(formatter: self)
		return block_result
	}

}

//MARK: - Common Share Functions -

internal extension Foundation.DateFormatter {

    ///	This method is used to provide a session context to create and use an instance of
    /// `DateFormatter` by preserving pre-task configuration. When you start a new session the
    /// current attributes of the instance are saved automatically and restored at the end of the
    /// session. We have this function because a single `DateFormatter` is shared along a thread.
    /// *You don't need to use it externally so it's a private method *.
    ///
    ///	- parameter block: block to execute your formast operation. It could return something
    ///
    ///	- returns: the result of the operation
    ///
    func beginSessionContext<T>(block: (Void) -> (T?)) -> T? {
		let saved_cfg = DateFormatterConfig(formatter: self)
		let block_result = block()
		saved_cfg.restoreInto(formatter: self)
		return block_result
	}


    /// This is the object we use to store attributes of `Foundation.DateFormatter`. We don't need to expose
    /// it.
	///
	struct DateFormatterConfig {
		var dateFormat: String?
		var locale: Locale?
		var timeZone: TimeZone?
		var relative: Bool

		init(formatter: FoundationDateFormatter) {
			dateFormat = formatter.dateFormat
			locale = formatter.locale
			timeZone = formatter.timeZone
			relative = formatter.doesRelativeDateFormatting
		}

		func restoreInto(formatter: FoundationDateFormatter) {
			formatter.dateFormat = self.dateFormat
			formatter.locale = self.locale
			formatter.timeZone = self.timeZone
			formatter.doesRelativeDateFormatting = self.relative
		}
	}
}
