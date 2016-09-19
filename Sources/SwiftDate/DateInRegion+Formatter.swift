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

// MARK: - DateInRegion Formatter Extension -

// swiftlint:disable file_length
extension DateInRegion {

   /**
   This method produces a colloquial representation of time elapsed
   between this `DateInRegion` (`self`) and another reference `DateInRegion` (`refDate`).

   - parameters:
        - refDate: reference date to compare (if not specified current date into `self` region
            is used)
        - style: style of the output string

   - returns: formatted string or nil if representation cannot be provided
   */
	@available(*, deprecated: 3.0.9, obsoleted: 3.1, message: "Use toString(fromDate:style:)")
	public func toNaturalString(refDate: DateInRegion?, style: FormatterStyle = FormatterStyle())
        -> String? {

		let rDate = (refDate != nil ? refDate! : DateInRegion(absoluteTime: Date(),
            region: self.region))
		let formatter: DateComponentsFormatter = sharedDateComponentsFormatter()
		return formatter.beginSessionContext(block: { (Void) -> (String?) in
			style.restoreInto(formatter: formatter)
			formatter.calendar = self.calendar as Calendar?
			// NOTE: why this method still return nil?
			// let str2 = formatter.stringFromDate(refDate.absoluteTime, toDate: self.absoluteTime)
			let diff = fabs(self.absoluteTime.timeIntervalSince(rDate.absoluteTime))
			let str = formatter.string(from: diff)
			return str
		})
	}

    /**
     Return an `ISO8601` string for the date.
	 More information about this standard can be found on
     [Wikipedia/ISO8601](https://en.wikipedia.org/wiki/ISO_8601).

 	 Some examples of the formatted output are:
	* `2016-01-11T17:31:10+00:00`
	* `2016-01-11T17:31:10Z`
	* `20160111T173110Z`

     - returns: a new string or nil if `DateInRegion` does not contains any valid date
     */
	@available(*, deprecated: 3.0.2, obsoleted: 3.1, message: "Use toString(.ISO8601)")
    public func toISO8601String() -> String? {
        return self.toString(dateFormat: .iso8601)
    }

	/**
	Return a string representation of the interval between self date and a reference date.
	You can specify a style of the output: the first group (`.Positional`, `.Abbreviated`,
    `.Short`, `.Full`) will print
	single non-zero time unit components. `.Colloquial` can be used to print a more natural
    version of the difference.
	If you need to apply more control upon the formatter you can use `DateFormatter` class directly.

	- parameter fromDate: reference date (if not specified default DateRegion() is used)
	- parameter style: style of the ouput

	- returns: string representation of the difference between self and a reference date
	*/
	public func toString(fromDate rDate: DateInRegion?, style: DateFormatterComponentsStyle)
        -> String? {
		let formatter = DateFormatter(componentsStyle: style)
		let rDate = (rDate != nil ? rDate! : DateInRegion(absoluteTime: Date(), region: self.region))
		return formatter.toString(fromDate: rDate, toDate: self)
	}

    /**
     Convert a DateInRegion to a string using region's timezone, locale and calendar

     - parameter dateFormat: format of the string

     - returns: a new string or nil if DateInRegion does not contains any valid date
     */
    public func toString(dateFormat: DateFormat) -> String? {
		if case .dotNET = dateFormat {
			// Custom .NET JSON Date format
			let milliseconds = (self.absoluteTime.timeIntervalSince1970 * 1000.0)
			let tzOffsets = (self.timeZone.secondsFromGMT(for: self.absoluteTime) / 3600)
			return (NSString(format: "/Date(%.0f%+03d00)/", milliseconds,tzOffsets) as String)
		}

		// Other formatter styles
		let cachedFormatter = sharedDateFormatter()
		return cachedFormatter.beginSessionContext { (void) -> (String?) in
			let dateFormatString = dateFormat.formatString
			cachedFormatter.dateFormat = dateFormatString
			cachedFormatter.timeZone = self.region.timeZone
			cachedFormatter.calendar = self.region.calendar
			switch dateFormat {
			case .iso8601, .iso8601Format:
				cachedFormatter.locale = Locale(identifier: "en_US_POSIX")
			default:
				cachedFormatter.locale = self.region.calendar.locale
			}
			let value = cachedFormatter.string(from: self.absoluteTime)
			return value
		}
    }

    /**
     Convert a `DateInRegion` date into a date with date & time style specific format style

     - parameter style: style to format both date and time (if you specify this you don't need to
        specify dateStyle,timeStyle)
     - parameter dateStyle: style to format the date
     - parameter timeStyle: style to format the time
	 - parameter relative: `true` indicates whether the receiver uses phrases such as “today” and
        “tomorrow” for the date component.

     - returns: a new string which represent the date expressed into the current region or nil if
        region does not contain valid date
     */
	public func toString(style: FoundationDateFormatter.Style? = nil, dateStyle: FoundationDateFormatter.Style? = nil,
        timeStyle: FoundationDateFormatter.Style? = nil, relative: Bool = false) -> String? {
		let cachedFormatter = sharedDateFormatter()
		return cachedFormatter.beginSessionContext { (void) -> (String?) in
			cachedFormatter.dateStyle = style ?? dateStyle ?? .none
			cachedFormatter.timeStyle = style ?? timeStyle ?? .none
			if cachedFormatter.dateStyle == .none && cachedFormatter.timeStyle == .none {
				cachedFormatter.dateStyle = .medium
				cachedFormatter.timeStyle = .medium
			}
			cachedFormatter.locale = self.region.locale
			cachedFormatter.calendar = self.region.calendar
			cachedFormatter.timeZone = self.region.timeZone
			cachedFormatter.doesRelativeDateFormatting = relative
			let value = cachedFormatter.string(from: self.absoluteTime)

			return value
		}
    }

	/**
	Convert this `DateInRegion` date in a string representation where you have date/time in short
     form

	Example of this output is:
	`"1/1/15, 11:00 AM"`

	- parameter date: `true` to include date in output string, `false` to omit it
	- parameter time: `true` to include time in output string, `false` to omit it

	- returns: output string representation of the date represented by `self`
	*/
    public func toShortString(date: Bool = true, time: Bool = true) -> String? {
        let dateStyle = date ? FoundationDateFormatter.Style.short : FoundationDateFormatter.Style.none
        let timeStyle = time ? FoundationDateFormatter.Style.short : FoundationDateFormatter.Style.none

        return toString(dateStyle: dateStyle, timeStyle: timeStyle)
    }

	/**
	Convert this `DateInRegion` date in a string representation where you have date/time in medium
     form

	Example of this output is:
	`"Jan 1, 2015, 11:00:00 AM"`

	- parameter date: `true` to include date in output string, `false` to omit it
	- parameter time: `true` to include time in output string, `false` to omit it

	- returns: output string representation of the date represented by `self`
	*/
    public func toMediumString(date: Bool = true, time: Bool = true) -> String? {
		let dateStyle: FoundationDateFormatter.Style = date ? .medium : .none
        let timeStyle = time ? FoundationDateFormatter.Style.medium : FoundationDateFormatter.Style.none

        return toString(dateStyle: dateStyle, timeStyle: timeStyle)
    }

	/**
	Convert this `DateInRegion` date in a string representation where you have date/time in long form

	Example of this output is:
	`"January 1, 2015 at 11:00:00 AM GMT+1"`

	- parameter date: `true` to include date in output string, `false` to omit it
	- parameter time: `true` to include time in output string, `false` to omit it

	- returns: output string representation of the date represented by `self`
	*/
    public func toLongString(date: Bool = true, time: Bool = true) -> String? {
        let dateStyle = date ? FoundationDateFormatter.Style.long : FoundationDateFormatter.Style.none
        let timeStyle = time ? FoundationDateFormatter.Style.long : FoundationDateFormatter.Style.none

        return toString(dateStyle: dateStyle, timeStyle: timeStyle)
    }

}

//MARK: - DateInRegion Formatters -

extension String {

    /**
     Convert a string into `NSDate` by passing conversion format

     - parameter format: format used to parse the string

     - returns: a new `NSDate` instance or nil if something went wrong during parsing
     */
    public func toDate(format: DateFormat) -> Date? {
        return self.toDateInRegion(format: format)?.absoluteTime
    }

    /**
     Convert a string into `DateInRegion` by passing conversion format

     - parameter format: format used to parse the string

     - returns: a new `NSDate` instance or nil if something went wrong during parsing
     */
    public func toDateInRegion(format: DateFormat) -> DateInRegion? {
        return DateInRegion(fromString: self, format: format)
    }

    /**
     Convert a string which represent an `ISO8601` date into `NSDate`

     - returns: `NSDate` instance or nil if string cannot be parsed
     */
    public func toDateFromISO8601() -> Date? {
		return toDate(format: DateFormat.iso8601Format(.full))
    }

    internal var sdLocalize: String {
        return Bundle.main.localizedString(forKey: self, value: nil, table: "SwiftDate")
    }

    private func sdToCalendarUnit() -> Calendar.Component? {
        switch self {
        case "year":
            return .year
        case "month":
            return .month
        case "weekOfYear":
            return .weekOfYear
        case "day":
            return .day
        case "hour":
            return .hour
        case "minute":
            return .minute
        case "second":
            return .second
        case "nanosecond":
            return .nanosecond
        default:
            return nil
        }
    }
}


internal extension NSDate {
    private func sdCompareCalendarUnit(unit: Calendar.Component, other: Calendar.Component) ->
        ComparisonResult {

        let nUnit = sdNormalizedCalendarUnit(unit: unit)
        let nOther = sdNormalizedCalendarUnit(unit: other)

        if (nUnit == .weekOfYear) != (nOther == .weekOfYear) {
            if nUnit == .weekOfYear {
                switch nUnit {
                case .year, .month:
                    return .orderedAscending
                default:
                    return .orderedDescending
                }
            } else {
                switch nOther {
                case .year, .month:
                    return .orderedDescending
                default:
                    return .orderedAscending
                }
            }
        } else {
            if nUnit.rawValue > nOther.rawValue {
                return .orderedAscending
            } else if nUnit.rawValue < nOther.rawValue {
                return .orderedDescending
            } else {
                return .orderedSame
            }
        }
    }

    private func sdNormalizedCalendarUnit(unit: Calendar.Component) -> Calendar.Component {
        switch unit {
        case .weekOfMonth, .weekOfYear:
            return .weekOfYear
        case .weekday, .weekdayOrdinal:
            return .day
        default:
            return unit
        }
    }

    // swiftlint:disable:next cyclomatic_complexity
    private func sdLocalizeStringForValue(singular: Bool, component: Calendar.Component,
        abbreviated: Bool = false) -> String {

        var toTranslate: String = ""
        switch component {

        case .year where singular:
            toTranslate = (abbreviated ? "yr": "year")
        case .year where !singular:
            toTranslate = (abbreviated ? "yrs": "years")

        case .month where singular:
            toTranslate = (abbreviated ? "mo": "month")
        case .month where !singular:
            toTranslate = (abbreviated ? "mos": "months")

        case .weekOfYear where singular:
            toTranslate = (abbreviated ? "wk": "week")
        case .weekOfYear where !singular:
            toTranslate = (abbreviated ? "wks": "weeks")

        case .day where singular:
            toTranslate = "day"
        case .day where !singular:
            toTranslate = "days"

        case .hour where singular:
            toTranslate = (abbreviated ? "hr": "hour")
        case .hour where !singular:
            toTranslate = (abbreviated ? "hrs": "hours")

        case .minute where singular:
            toTranslate = (abbreviated ? "min": "minute")
        case .minute where !singular:
            toTranslate = (abbreviated ? "mins": "minutes")

        case .second where singular:
            toTranslate = (abbreviated ? "s": "second")
        case .second where !singular:
            toTranslate = (abbreviated ? "s": "seconds")

        case .nanosecond where singular:
            toTranslate = (abbreviated ? "ns": "nanosecond")
        case .nanosecond where !singular:
            toTranslate = (abbreviated ? "ns": "nanoseconds")

        default:
            toTranslate = ""
        }
        return toTranslate.sdLocalize
    }

    func localizedSimpleStringForComponents(components: DateComponents) -> String {
        if components.year == -1 {
            return "last year".sdLocalize
        } else if components.month == -1 && components.year == 0 {
            return "last month".sdLocalize
        } else if components.weekOfYear == -1 && components.year == 0 && components.month == 0 {
            return "last week".sdLocalize
        } else if components.day == -1 && components.year == 0 && components.month == 0 &&
            components.weekOfYear == 0 {
            return "yesterday".sdLocalize
        } else if components.year == 1 {
            return "next year".sdLocalize
        } else if components.month == 1 && components.year == 0 {
            return "next month".sdLocalize
        } else if components.weekOfYear == 1 && components.year == 0 && components.month == 0 {
            return "next week".sdLocalize
        } else if components.day == 1 && components.year == 0 && components.month == 0 &&
            components.weekOfYear == 0 {
            return "tomorrow".sdLocalize
        }
        return ""
    }
}

extension Calendar.Component {
    /// https://github.com/apple/swift-corelibs-foundation/blob/swift-DEVELOPMENT-SNAPSHOT-2016-09-10-a/CoreFoundation/Locale.subproj/CFCalendar.h#L68-L83
    internal var rawValue: UInt {
        switch self {
        case .era:               return 1 << 1
        case .year:              return 1 << 2
        case .month:             return 1 << 3
        case .day:               return 1 << 4
        case .hour:              return 1 << 5
        case .minute:            return 1 << 6
        case .second:            return 1 << 7
        case .weekday:           return 1 << 9
        case .weekdayOrdinal:    return 1 << 10
        case .quarter:           return 1 << 11
        case .weekOfMonth:       return 1 << 12
        case .weekOfYear:        return 1 << 13
        case .yearForWeekOfYear: return 1 << 14
        case .nanosecond:        return 1 << 15
        case .calendar:          return 1 << 16
        case .timeZone:          return 1 << 17
        }
    }

    internal init?(rawValue: UInt) {
        switch rawValue {
        case Calendar.Component.era.rawValue:               self = .era
        case Calendar.Component.year.rawValue:              self = .year
        case Calendar.Component.month.rawValue:             self = .month
        case Calendar.Component.day.rawValue:               self = .day
        case Calendar.Component.hour.rawValue:              self = .hour
        case Calendar.Component.minute.rawValue:            self = .minute
        case Calendar.Component.second.rawValue:            self = .second
        case Calendar.Component.weekday.rawValue:           self = .weekday
        case Calendar.Component.weekdayOrdinal.rawValue:    self = .weekdayOrdinal
        case Calendar.Component.quarter.rawValue:           self = .quarter
        case Calendar.Component.weekOfMonth.rawValue:       self = .weekOfMonth
        case Calendar.Component.weekOfYear.rawValue:        self = .weekOfYear
        case Calendar.Component.yearForWeekOfYear.rawValue: self = .yearForWeekOfYear
        case Calendar.Component.nanosecond.rawValue:        self = .nanosecond
        case Calendar.Component.calendar.rawValue:          self = .calendar
        case Calendar.Component.timeZone.rawValue:          self = .timeZone
        default: return nil
        }
    }
}
