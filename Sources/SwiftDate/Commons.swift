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


/// This define the weekdays
///
/// - sunday: sunday
/// - monday: monday
/// - tuesday: tuesday
/// - wednesday: wednesday
/// - thursday: thursday
/// - friday: friday
/// - saturday: saturday
public enum WeekDay: Int {
	case sunday		= 1
	case monday		= 2
	case tuesday	= 3
	case wednesday	= 4
	case thursday	= 5
	case friday		= 6
	case saturday	= 7
}

/// Provide a mechanism to create and return local-thread object you can share.
/// 
/// Basically you assign a key to the object and return the initializated instance in `create`
/// block. Again this code is used internally to provide a common way to create local-thread date
/// formatter as like `NSDateFormatter` (which is expensive to create) or
/// `NSDateComponentsFormatter`.
/// Instance is saved automatically into current thread own dictionary.
///
/// - parameter key:    identification string of the object
/// - parameter create: creation block. At the end of the block you need to provide the instance you
///						want to save.
///
/// - returns: the instance you have created into the current thread
internal func localThreadSingleton<T: AnyObject>(key: String, create: (Void) -> T) -> T {
	if let cachedObj = Thread.current.threadDictionary[key] as? T {
		return cachedObj
	} else {
		let newObject = create()
		Thread.current	.threadDictionary[key] = newObject
		return newObject
	}
}

/// This is the list of all possible errors you can get from the library
///
/// - FailedToParse:        Failed to parse a specific date using provided format
/// - FailedToCalculate:    Failed to calculate new date from passed parameters
/// - MissingCalTzOrLoc:    Provided components does not include a valid TimeZone or Locale
/// - DifferentCalendar:    Provided dates are expressed in different calendars and cannot be compared
/// - MissingRsrcBundle:    Missing SwiftDate resource bundle
/// - FailedToSetComponent: Failed to set a calendar com
public enum DateError: Error {
	case FailedToParse
	case FailedToCalculate
	case MissingCalTzOrLoc
	case DifferentCalendar
	case MissingRsrcBundle
	case FailedToSetComponent(Calendar.Component)
	case InvalidLocalizationFile
}


/// Available date formats used to parse strings and format date into string
///
/// - custom:   custom format expressed in Unicode tr35-31 (see http://www.unicode.org/reports/tr35/tr35-31/tr35-dates.html#Date_Format_Patterns and Apple's Date Formatting Guide). Formatter uses heuristics to guess the date if it's invalid.
///				This may end in a wrong parsed date. Use `strict` to disable heuristics parsing.
/// - strict:	strict format is like custom but does not apply heuristics to guess at the date which is intended by the string.
///				So, if you pass an invalid date (like 1999-02-31) formatter fails instead of returning guessing date (in our case
///				1999-03-03).
/// - iso8601:  iso8601 date format (see https://en.wikipedia.org/wiki/ISO_8601)
/// - extended: extended date format ("eee dd-MMM-yyyy GG HH:mm:ss.SSS zzz")
/// - rss:      RSS and AltRSS date format
/// - dotNET:   .NET date format
public enum DateFormat {
	case custom(String)
	case strict(String)
	case iso8601(options: ISO8601DateTimeFormatter.Options)
	case extended
	case rss(alt: Bool)
	case dotNET
}

/// This struct group the options you can choose to output a string which represent
/// the interval between two dates.
public struct ComponentsFormatterOptions {
	/// The default formatting behavior. When using positional units, this behavior drops leading zeroes but pads middle and trailing values with zeros as needed. For example, with hours, minutes, and seconds displayed, the value for one hour and 10 seconds is “1:00:10”. For all other unit styles, this behavior drops all units whose values are 0. For example, when days, hours, minutes, and seconds are allowed, the abbreviated version of one hour and 10 seconds is displayed as “1h 10s”.*
	public var zeroBehavior: DateComponentsFormatter.ZeroFormattingBehavior = .pad
	
	// The maximum number of time units to include in the output string.
	// By default is nil, which does not cause the elimination of any units.
	public var maxUnitCount: Int? = nil
	
	// Configures the strings to use (if any) for unit names such as days, hours, minutes, and seconds.
	// By default is `positional`.
	public var style: DateComponentsFormatter.UnitsStyle = .positional
	
	// Setting this property to true results in output strings like “30 minutes remaining”. The default value of this property is false.
	public var includeTimeRemaining: Bool = false
	
	/// The bitmask of calendrical units such as day and month to include in the output string
	/// Allowed components are: `year,month,weekOfMonth,day,hour,minute,second`.
	/// By default it's set as nil which means set automatically based upon the interval.
	public var allowedUnits: NSCalendar.Unit? = nil
	
	/// The locale to use to format the string.
	/// If `ComponentsFormatterOptions` is used from a `TimeInterval` object the default value
	/// value is set to the current device's locale.
	/// If `ComponentsFormatterOptions` is used from a `DateInRegion` object the default value
	/// is set the `DateInRegion`'s locale.
	public var locale: Locale = LocaleName.current.locale
	
	/// Initialize a new ComponentsFormatterOptions struct
	/// - parameter allowedUnits: allowed units or nil if you want to keep the default value
	/// - parameter style: units style or nil if you want to keep the default value
	/// - parameter zero: zero behavior or nil if you want to keep the default value
	public init(allowedUnits: NSCalendar.Unit? = nil, style: DateComponentsFormatter.UnitsStyle? = nil, zero: DateComponentsFormatter.ZeroFormattingBehavior? = nil) {
		if allowedUnits != nil { self.allowedUnits = allowedUnits! }
		if style != nil { self.style = style! }
		if zero != nil { self.zeroBehavior = zero! }
	}
	
	/// Evaluate the best allowed units to workaround NSException of the DateComponentsFormatter
	internal func bestAllowedUnits(forInterval interval: TimeInterval) -> NSCalendar.Unit {
		switch interval {
		case 0...(SECONDS_IN_MINUTE-1):
			return [.second]
		case SECONDS_IN_MINUTE...(SECONDS_IN_HOUR-1):
			return [.minute,.second]
		case SECONDS_IN_HOUR...(SECONDS_IN_DAY-1):
			return [.hour,.minute,.second]
		case SECONDS_IN_DAY...(SECONDS_IN_WEEK-1):
			return [.day,.hour,.minute,.second]
		default:
			return [.year,.month,.weekOfMonth,.day,.hour,.minute,.second]
		}
	}
}

private let SECONDS_IN_MINUTE: TimeInterval = 60
private let SECONDS_IN_HOUR: TimeInterval = SECONDS_IN_MINUTE * 60
private let SECONDS_IN_DAY: TimeInterval = SECONDS_IN_HOUR * 24
private let SECONDS_IN_WEEK: TimeInterval = SECONDS_IN_DAY * 7

